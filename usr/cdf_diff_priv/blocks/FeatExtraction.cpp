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

#include <FeatExtraction.hpp>

namespace bm
{
    // Pkt fields
    unsigned int src_ip = 0;
    unsigned int dst_ip = 0;
    unsigned short src_port = 0;
    unsigned short dst_port = 0;
    unsigned char protocol = 0;
    unsigned short pkt_size = 0;   //pkt_size is the feature we are sending

    FeatExtraction::FeatExtraction(const std::string &name, bool active, bool thread_safe) 
    : Block(name, "feat_extraction", active, thread_safe),
      m_in_gate_id(register_input_gate("in_pkt")),
      m_out_gate_id(register_output_gate("out_feat"))
    {}

    int FeatExtraction::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        // Get the raw packet
        if(m->type() != RAW_PACKET_CODE) throw std::runtime_error("feat_extraction: unexpected msg type");
        const RawPacket* packet = static_cast<const RawPacket*>(m.get());
        const_buffer<char> buffer = packet->get_buffer();
        const char* payload = buffer.addr();
        int payload_len = buffer.len();

        // VLAN tag?
        int ip_offset = ETHER_HDR_LEN-4;
        unsigned short l2proto = ETHERTYPE_VLAN;
        while (l2proto == ETHERTYPE_VLAN && ip_offset+4 < payload_len){
            ip_offset+= 4;
            l2proto = (payload[ip_offset-2] << 8) | (payload[ip_offset-1] & 0xFF);
        }

        // Only IPv4 is supported
        if (l2proto != ETHERTYPE_IP)
            return -1;


        // Parse the IP header        
        unsigned char header_length = 0x0F & payload[ip_offset];
        int transport_offset = ip_offset + header_length * 4;
        pkt_size = (payload[ip_offset + 2] & 0xFF) << 8;
        pkt_size |= (payload[ip_offset + 3] & 0xFF);
        protocol = payload[ip_offset + 9];
        src_ip = (payload[ip_offset + 12] & 0xFF);
        src_ip|= (payload[ip_offset + 13] & 0xFF) << 8;
        src_ip|= (payload[ip_offset + 14] & 0xFF) << 16;
        src_ip|= (payload[ip_offset + 15] & 0xFF) << 24;
        dst_ip = (payload[ip_offset + 16] & 0xFF);
        dst_ip|= (payload[ip_offset + 17] & 0xFF) << 8;
        dst_ip|= (payload[ip_offset + 18] & 0xFF) << 16;
        dst_ip|= (payload[ip_offset + 19] & 0xFF) << 24;
        if (protocol == IPPROTO_UDP || protocol == IPPROTO_TCP){
            src_port = (payload[transport_offset] << 8) | (payload[transport_offset+1] & 0xFF);
            dst_port = (payload[transport_offset+2] << 8) | (payload[transport_offset+3] & 0xFF);
        }

        // Send the tuple packet
        IdValueCouple *feat = new IdValueCouple(src_ip, pkt_size);
        send_out_through(std::shared_ptr<Msg> (feat), m_out_gate_id);
        return 0;
    }
}
