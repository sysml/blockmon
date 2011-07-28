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

#include <TupleDemux.hpp>

namespace bm
{
    TupleDemux::TupleDemux(const std::string &name, bool active, bool thread_safe) 
    : Block(name, "tuple_demux", active, thread_safe),
        m_gate_udp_active  (true),
        m_gate_tcp_active  (true),
        m_gate_other_active(true),
        m_out_udp_gate_id  (register_output_gate("out_pkt_udp")),
        m_out_tcp_gate_id  (register_output_gate("out_pkt_tcp")),
        m_out_other_gate_id(register_output_gate("out_pkt_other")),
        m_in_gate_id       (register_input_gate("in_pkt"))
    {}

    void TupleDemux::_configure(const xml_node& n)
    {
        xml_node gate_tcp = n.child("gate_tcp");
        if (gate_tcp)
            m_gate_tcp_active = std::string(gate_tcp.attribute("state").value()).compare("on") == 0;
        xml_node gate_udp = n.child("gate_udp");
        if (gate_udp)
            m_gate_udp_active = std::string(gate_udp.attribute("state").value()).compare("on") == 0;
        xml_node gate_other = n.child("gate_other");
        if (gate_other)
            m_gate_other_active = std::string(gate_other.attribute("state").value()).compare("on") == 0;
    }

    int TupleDemux::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        // Get the tuple packet
        if(m->type() != TUPLE_PACKET_CODE) throw std::runtime_error("counter_cms: unexpected msg type");
        const TuplePacket* packet = static_cast<const TuplePacket*>(m.get());
        // Send the tuple packet
        const unsigned char protocol = packet->get_tuple().get_protocol();
        if (protocol == IP_PROTO_TCP)
        {
            if (m_gate_tcp_active)
                send_out_through(std::move(m), m_out_tcp_gate_id);
        }
        else if (protocol == IP_PROTO_UDP)
        {
            if (m_gate_udp_active)
                send_out_through(std::move(m), m_out_udp_gate_id);
        }
        else
        {
            if (m_gate_other_active)
                send_out_through(std::move(m), m_out_other_gate_id);
        }
        return 0;
    }
}
