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

#include <cassert>

#include <arpa/inet.h>

#include <boost/lexical_cast.hpp>

#include <Flow.hpp>
#include <Observation.hpp>
#include <Packet.hpp>

#include "PacketOrFlowToObservation.hpp"

namespace blockmon {
  PacketOrFlowToObservation::PacketOrFlowToObservation(
        const std::string &name,
        invocation_type invocation)
    : Block(name, invocation_type::Direct),
      in_gate(register_input_gate("in_packet_or_flow")),
      out_gate(register_output_gate("out_observation")) {
  }

  std::string
  PacketOrFlowToObservation::proto_label(const Packet* p) {
    uint32_t ack;
    uint8_t urg;

    if (p->is_udp()) {
      return "UDP";
    } else if (p->is_tcp()) {
      return std::string("TCP:")
        + (p->tcp_has_fin() ? "F" : "-")
        + (p->tcp_has_syn() ? "S" : "-")
        + (p->tcp_has_rst() ? "R" : "-")
        + (p->tcp_has_psh() ? "P" : "-")
        + (p->tcp_ack(ack) ? "A" : "-")
        + (p->tcp_urg(urg) ? "U" : "-");
    } else {
      return "???";
    }
  }

  void
  PacketOrFlowToObservation::send_record(std::shared_ptr<const Msg>&& msg) {
      send_out_through(std::move(msg), out_gate);
  }

  void
  PacketOrFlowToObservation::_receive_msg(std::shared_ptr<const Msg>&& m,
                                          int /* index */) {
    if (m->type() != MSG_ID(Packet) && m->type() != MSG_ID(Flow))
      std::runtime_error("PacketOrFlowToObservation: wrong message type, "
                         "can only be either Packet or Flow");

    ustime_t otime;
    std::string label;
    uint64_t value;

    if (m->type() == MSG_ID(Packet)) {
      const Packet* packet = static_cast<const Packet*>(m.get());
      otime = packet->timestamp_us();

      uint32_t src_ip4 = packet->ip_src();
      char src_str[INET_ADDRSTRLEN];
      inet_ntop(AF_INET, &src_ip4, src_str, sizeof(src_str));

      uint32_t dst_ip4 = packet->ip_dst();
      char dst_str[INET_ADDRSTRLEN];
      inet_ntop(AF_INET, &dst_ip4, dst_str, sizeof(dst_str));

      label =
        std::string(src_str)
                    + ":" + boost::lexical_cast<std::string>(packet->src_port())
                    + " > " + dst_str
                    + ":" + boost::lexical_cast<std::string>(packet->dst_port())
                    + " " + proto_label(packet);
      value = 0;
    } else {
      assert(m->type() == MSG_ID(Flow));
      const Flow* flow = static_cast<const Flow*>(m.get());
      const FlowKey& key = flow->key();
      otime = flow->start_time();

      uint32_t src_ip4 = key.src_ip4;
      char src_str[INET_ADDRSTRLEN];
      inet_ntop(AF_INET, &src_ip4, src_str, sizeof(src_str));

      uint32_t dst_ip4 = key.dst_ip4;
      char dst_str[INET_ADDRSTRLEN];
      inet_ntop(AF_INET, &dst_ip4, dst_str, sizeof(dst_str));

      label =
        std::string(src_str)
                    + ":" + boost::lexical_cast<std::string>(key.src_port)
                    + " > " + dst_str
                    + ":" + boost::lexical_cast<std::string>(key.dst_port);
      value = flow->bytes();
    }
    
    send_record(std::make_shared<Observation>(otime, label, value));
  }
} /* namespace blockmon */
