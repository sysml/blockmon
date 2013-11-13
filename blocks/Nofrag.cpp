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

#include <NetTypes.hpp>
#include <Packet.hpp>
#include <Utility.hpp>

#include <netinet/in.h>

#include "Nofrag.hpp"

namespace blockmon {
  Nofrag::Nofrag(const std::string &name,
		 invocation_type invocation)
    : Block(name, invocation),
      in_gate(register_input_gate("in_packet")),
      out_gate(register_output_gate("out_unfragged_packet")) {
  }

#define IPHDR_RE 0x2000
#define IPHDR_DF 0x4000
#define IPHDR_MF 0x8000
#define IPHDR_FRAGOFF(u16) (u16 & 0x1000)

  void
  Nofrag::_receive_msg(std::shared_ptr<const Msg>&& m,
		       int /* index */) {
    if (unlikely(m->type() != MSG_ID(Packet)))
      std::runtime_error("Nofrag: wrong message type, "
                         "I only accept Packets");
    const Packet* packet = static_cast<const Packet*>(m.get());
    const ip4hdr* iphdr = reinterpret_cast<const ip4hdr*>(packet->iphdr());
    const uint16_t fragoff = ntohs(iphdr->fragoff);

    if (likely(((fragoff & IPHDR_MF) == 0)
	       && (IPHDR_FRAGOFF(fragoff) == 0)))
      send_out_through(std::move(m), out_gate);
  }

  void Nofrag::_configure(const pugi::xml_node& xmlnode) {
  }


} // blockmon
