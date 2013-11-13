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

#ifndef _MESSAGES_FLOW_HPP_
#define _MESSAGES_FLOW_HPP_

#include <list>

#include "Msg.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"
#include "Packet.hpp"

#include <ctime>
#include <cstring>

namespace blockmon
{

  /**
   * Provides a the information regarding a flow.
   *
   * this includes start and end time, packets and bytes count, the
   * flow five-tuple as well as a buffer with reassembled data
   */
    class Flow: public Msg {
    public:

        /**
         * regular constructor          
         */
        Flow(const FlowKey& key):
        Msg(MSG_ID(Flow)),
        m_stime(),
        m_etime(),
        m_key(key),
        m_bytes(0),
        m_packets(0),
        m_flow_packets(),
        m_list_sorted(false)
        {}

        Flow(const FlowKey& key, ustime_t stime, ustime_t etime, uint64_t bytes, uint64_t packets):
        Msg(MSG_ID(Flow)),
        m_stime(stime),
        m_etime(etime),
        m_key(key),
        m_bytes(bytes),
        m_packets(packets),
        m_flow_packets(),
        m_list_sorted(false)
        {}

      Flow(const FlowKey& key,
	   ustime_t stime,
	   ustime_t etime,
	   uint64_t bytes,
	   uint64_t packets,
	   std::list<std::shared_ptr<const Packet> >  packet_list,
	   bool list_sorted):
        Msg(MSG_ID(Flow)),
        m_stime(stime),
        m_etime(etime),
        m_key(key),
        m_bytes(bytes),
        m_packets(packets),
	m_flow_packets(packet_list),
	m_list_sorted(list_sorted)
        {}

        const FlowKey& key() const {
            return m_key;
        }

        ustime_t start_time() const
        {
            return m_stime;
        }
        
        ustime_t end_time() const
        {
            return m_etime;
        }
        
        void expand_interval(ustime_t us) {
            if (m_stime == 0 || m_stime > us) m_stime = us;
            if (m_stime == 0 || m_etime < us) m_etime = us;
        }

        uint64_t bytes() const
        {
            return m_bytes;
        }

        void increment_bytes(uint64_t val) {
            m_bytes += val;
        }

        uint64_t packets() const
        {
            return m_packets;
        }

        void increment_packets(uint64_t val) {
            m_packets += val;
        }
          
        bool matches(const Packet& p) {
            return m_key == p.key();
        }
        
        bool matches(const Flow& f) {
            return m_key == f.key();
        }
        
        /*
         * destructor
         */
        virtual ~Flow() 
        {}


        /**
          *returns a copy of the message (which always owns its buffer)
          */

        virtual std::shared_ptr<Msg> clone() const
        {
            Flow* new_flow = new Flow(m_key);
            new_flow->m_etime = m_etime;
            new_flow->m_stime = m_stime;
            new_flow->m_bytes = m_bytes;
            new_flow->m_packets = m_packets;
	        new_flow->m_flow_packets = m_flow_packets;
	        new_flow->m_list_sorted = m_list_sorted;
            return std::shared_ptr<Msg>(new_flow);
        }

        void reset()
        {
            m_etime = 0;
            m_stime = 0;
            m_bytes = 0;
            m_packets = 0;
	    m_flow_packets.clear();
	    m_list_sorted = false;
        }

      /** Gets the payload from this flow.
       *
       * Copies the payload contained in the packets in this flow into
       * @a buffer, starting at byte offset @a offset and continuing
       * for @a size bytes.
       *
       * This method does not deal with fragmented packets, so it is
       * strongly advised that if you plan to call this method on a
       * flow, you put a Nodefrag block before the input gate, or
       * perhaps a block (not written at this time) that does packet
       * defragmentation.
       *
       * The normal case is when this flow is a TCP flow that contains
       * all packets.  In this case, the result is as if
       *
       * - the packets constituting this flow had been sorted into
       *   increasing TCP sequence number;
       * - the payloads of the packets in the sorted list laid end to
       *   end in a buffer @a p of length @l; and 
       * - if @a offset + @a length <= @a l, bytes @a p + @a offset
       *   through @a p + @a nbytes - 1 will be copied, otherwise
       *   bytes @a p + @a offset through @a p + @l - 1 will be copied,
       *   and the number of bytes copies will be zero if @a offset >=
       *   @a l.
       *
       * In case that not all packets constituting a TCP flow have
       * actually been added to the flow (i.e., if the flow has
       * "holes"), copying is as before but stops just before the
       * first "hole" byte.  This may lead to no bytes being copied at
       * all.
       *
       * In case of a UDP flow packet, copying always starts at offset
       * zero, no matter what the value of @a offset is.
       *
       * @param buffer the buffer in which to copy the payload
       * @param offset the offset in the payload from where to start
       *        copying
       * @param nbytes the maximum number of payload bytes to copy
       *
       * @return the number of bytes copied.  This will always be less
       *         than or equal to @a length.
       */
      size_t get_payload(uint8_t* buffer, size_t offset, size_t nbytes);

      /** Adds the packet to the flow.
       *
       * This can later be used for get_payload().
       *
       * @param p the packet to add
       */
      void add_packet(std::shared_ptr<const Packet> p);
    protected:
        ustime_t m_stime;
        ustime_t m_etime;
        FlowKey  m_key;
        uint64_t m_bytes;
        uint64_t m_packets;
        std::list<std::shared_ptr<const Packet>> m_flow_packets;
        bool m_list_sorted;
    };
            
    // DELETEME removed old IPFIX code
    // REGISTER_MESSAGE_CLASS(Flow, Flow::Descriptor)
}

#endif // _MESSAGES_FLOW_HPP_
