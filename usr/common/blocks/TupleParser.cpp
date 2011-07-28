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

#include <TupleParser.hpp>

namespace bm
{
    TupleParser::TupleParser(const std::string &name, bool active, bool thread_safe) 
    : Block(name, "tuple_parser", active, thread_safe),
      m_in_gate_id(register_input_gate("in_pkt")),
      m_out_gate_id(register_output_gate("out_pkt")),
      m_mem_block(new MemoryBlock(4096*64))
    {}

    int TupleParser::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        // Get the raw packet
        if(m->type() != RAW_PACKET_CODE) throw std::runtime_error("tuple_parser: unexpected msg type");
        const RawPacket* packet = static_cast<const RawPacket*>(m.get());
        const_buffer<char> buffer = packet->get_buffer();
        const char* payload = buffer.addr();
        int payload_len = buffer.len();
        // Tuple fields
        unsigned int src_ip = 0;
        unsigned int dst_ip = 0;
        unsigned short src_port = 0;
        unsigned short dst_port = 0;
        unsigned char protocol = 0;
        // VLAN tag?
        int ip_offset = 14;
        unsigned short l2proto = 0x8100;
        ip_offset-= 4;
        while (l2proto == 0x8100 && ip_offset < payload_len)
        {
            ip_offset+= 4;
            l2proto = (payload[ip_offset-2] << 8) | (payload[ip_offset-1] & 0xFF);
        }
        // Only IPv4 is supported
        if (l2proto != ETH_PROTO_IP4)
            return -1;
        // Parse the IP header
        unsigned char header_length = 0x0F & payload[ip_offset];
        int transport_offset = ip_offset + header_length * 4;
        protocol = payload[ip_offset + 9];
        src_ip = (payload[ip_offset + 12] & 0xFF) << 24;
        src_ip|= (payload[ip_offset + 13] & 0xFF) << 16;
        src_ip|= (payload[ip_offset + 14] & 0xFF) << 8;
        src_ip|= (payload[ip_offset + 15] & 0xFF);
        dst_ip = (payload[ip_offset + 16] & 0xFF) << 24;
        dst_ip|= (payload[ip_offset + 17] & 0xFF) << 16;
        dst_ip|= (payload[ip_offset + 18] & 0xFF) << 8;
        dst_ip|= (payload[ip_offset + 19] & 0xFF);
        if (protocol == IP_PROTO_UDP || protocol == IP_PROTO_TCP)
        {
            src_port = (payload[transport_offset] << 8) | (payload[transport_offset+1] & 0xFF);
            dst_port = (payload[transport_offset+2] << 8) | (payload[transport_offset+3] & 0xFF);
        }
        // Send the tuple packet
        //send_out_through(std::shared_ptr<const Msg>(new TuplePacket(payload, payload_len, ip_offset, transport_offset, src_ip, dst_ip, src_port, dst_port, protocol)), m_out_gate_id);
        send_out_through(alloc_from_big_buffer<TuplePacket>(m_mem_block,payload_len, payload, payload_len, ip_offset, transport_offset, src_ip, dst_ip, src_port, dst_port, protocol,*m_mem_block), m_out_gate_id);
        return 0;
    }
}
