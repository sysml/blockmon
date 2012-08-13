/* Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale 
 * Interuniversitario per le Telecomunicazioni, Institut 
 * Telecom/Telecom Bretagne, ETH Zürich, INVEA-TECH a.s. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd, Consorzio Nazionale 
 *      Interuniversitario per le Telecomunicazioni, Institut Telecom/Telecom 
 *      Bretagne, ETH Zürich, INVEA-TECH a.s. nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software 
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT 
 * HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
 * PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 */

#include "Flow.hpp"

namespace blockmon {

  size_t Flow::get_payload(uint8_t* buffer, size_t offset, size_t nbytes) {
    if (m_flow_packets.empty())
      return 0;
    
      /* Doing TCP stream reassembly by sorting the list on the
       * sequence number does not work if those sequence numbers wrap
       * around.  It also does not work in the presence of adversaries
       * who do funky stuff in order to make TCP reassembly difficult
       * on purpose.
       *
       * The problem is that we have too little information about the
       * flow.  For example, we don't know the receiver's window size,
       * only the sender's.  So what we do is this:
       *
       * 1. Go through the list and find the (one) packet with a SYN.
       *    Let its sequence number be s_syn.
       * 2. Build a second list (because we can't modify the original
       *    packets) consisting of pairs (i, s), where s is the
       *    sequence number of packet i, minus s_syn.
       * 3. Sort that second list on the modified sequence number.
       *
       * If it is possible that the original packets do not contain a
       * SYN, the following algorithm will also work, but isn't as
       * neat:
       *
       * 1. Sort the list by TCP sequence number.
       * 2. Go through the list.  If the list has exactly one "hole"
       *    in it, and one that would be expected by a TCP sequence
       *    number wraparound, we swap the twp list pieces that are
       *    "around" that hole.
       *
       * For example, let's say the TCP sequence numbers and packet
       * lengths after sorting are (50, 50), (100, 100), (200, 100),
       * (2^32-200, 100), (2^32-100, 150).  Then there's a big hole
       * between 200 and 2^32-200, and one that we would expect from a
       * sequence number wraparound, from which we conclude that the
       * correct sequence of packets must have the sequence numbers
       * 2^32-200, 2^32-100, 0, 100, 200, in that order.
       *
       * At the same time, we could build a list of offsets that will
       * be nice to have later on.  Consider the above example again.
       * In this case, the offset list would be o = <0, 150, 200, 300,
       * 400>, and o[i] would give the offset in the TCP payload where
       * this packet's payload starts.
       */
      enum { packets_tcp, packets_udp, packets_unknown } packet_type = packets_unknown;
      auto syn = m_flow_packets.end();
      if (!m_list_sorted) {
	bool first = true;

	for (auto i = m_flow_packets.begin();
	     i != m_flow_packets.end();
	     ++i) {
	  const Packet* packet = i->get();
	  
	  if (!packet->is_tcp() && !packet->is_udp())
	    throw std::runtime_error("FlowMeter: can get flow payload "
				   "only for TCP or UDP flows at "
				   "the moment");;
	  if (packet_type == packets_unknown)
	    packet_type = (packet->is_tcp() ? packets_tcp : packets_udp);
	  else if ((packet_type == packets_udp && packet->is_tcp() )
		   || (packet_type == packets_tcp && packet->is_udp()))
	    throw std::runtime_error("FlowMeter: flow contains both TCP"
				     " and UDP packets");
	  else if (packet_type == packets_udp && !first)
	    throw std::runtime_error("FlowMeter: flow contains more than"
				     " one UDP packet");
	  else if (packet_type == packets_tcp && packet->tcp_has_syn())
	    syn = i;
	  first = false;
	}
	if (packet_type == packets_tcp) {
	  m_flow_packets.sort([](const std::shared_ptr<const Packet> a,
				 const std::shared_ptr<const Packet> b) {
				return a->tcp_seq() < b->tcp_seq(); 
			      });

	  /* You may ask yourself, is the SYN variable, containing an
	   * iterator to the packet with a SYN, still valid after the
	   * call to sort()?  Well, here's what the C++ standard says
	   * in N3242 in Section 23.2.1, clause 10:
	   *
	   * "Unless otherwise specified (either explicitly or by
	   * defining a function in terms of other functions),
	   * invoking a container member function or passing a
	   * container as an argument to a library function shall not
	   * invalidate iterators to, or change the values of, objects
	   * within that container."
	   *
	   * And the documentation for std::list::sort() (Section
	   * 23.3.5.5, clause 25) contains no such explicit
	   * specification or definition in terms of another
	   * function.
	   */
	  if (syn != m_flow_packets.begin()) {
	    /* Not already sorted.  This would also work if the list
	     * is in fact already sorted, but it would do it with a
	     * fairly expensive no-op. */
	    std::list<std::shared_ptr<const Packet>> last_part;
	    last_part.splice(last_part.begin(), // before this point,
			     m_flow_packets,    // move items from this list
			     m_flow_packets.begin(), // starting here
			     syn);              // and ending just before here
	    // Now append LAST_PART to M_FLOW_PACKETS
	    m_flow_packets.splice(m_flow_packets.end(), last_part);
	  }
      }
      m_list_sorted = true;
    }

    
    size_t effective_offset = offset;
    size_t bytes_skipped = 0;
    size_t bytes_copied = 0;
    uint8_t *p = buffer; /* The invariant is bytes_skipped +
			    bytes_copied = p - buffer */
    size_t bytes_remaining = nbytes;
    uint32_t expected_sequence_number = 0;
    bool first = true;
    bool more = true;
    
    for (auto i = m_flow_packets.begin(); 
	 i != m_flow_packets.end() && more && bytes_remaining > 0;
	 ++i) {
      const Packet* packet = i->get();
      size_t payload_length = 0;
      if (first) {
	if (packet->is_udp()) {
	  effective_offset = 0;
	} else if (packet->is_tcp()) {
	  if (packet->tcp_has_syn()) {
	    expected_sequence_number = packet->tcp_seq();
	  } else // Flow starts with a hole: abort, abort!
	    more = false;
	} else
	  throw std::runtime_error("FlowMeter: can get flow payload "
				   "only for TCP or UDP flows at "
				   "the moment");;
	first = false;
      }

      if (packet->is_tcp())
	payload_length = packet->ip_length() - packet->ip_header_length() 
	  - packet->tcp_header_length();
      else if (packet->is_udp())
	payload_length = packet->udp_length() - sizeof(udphdr);
      else
	throw std::runtime_error("FlowMeter: subsequent packet in flow "
				 "neither TCP nor UDP");;
      
      if (more) {
	if (bytes_skipped + bytes_copied + payload_length > effective_offset) {
	  size_t bytes_to_copy = std::min<size_t>(bytes_remaining,
						  payload_length);
	  size_t payload_offset = 
	    bytes_skipped + bytes_copied == 0 ? effective_offset : 0;
	  std::memcpy(p, packet->payload() + payload_offset, bytes_to_copy);
	  bytes_copied += bytes_to_copy;
	  bytes_remaining -= bytes_to_copy;
	  p += bytes_to_copy;
	  bytes_skipped = offset;
	} else
	  bytes_skipped += payload_length;

	if (packet->is_tcp()) {
	  if (packet->tcp_seq() == expected_sequence_number)
	    /* Unsigned arithmetic is modulo arithmetic, so this
	     * addition will produce the correct wraparound effect. */
	    expected_sequence_number += payload_length + 1;
	  else // Hole
	    more = false;
	} else if (packet->is_udp())
	  /* Can only be one packet. */
	  more = false;
	else
	  throw std::runtime_error("FlowMeter: subsequent packet in flow "
				   "neither TCP nor UDP (can't happen, "
				   "but apparently did)");
      }
    }
    return bytes_copied;
  }

  void Flow::add_packet(std::shared_ptr<const Packet> p) {
    m_flow_packets.push_back(p);
  }
}
