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

#include <IpAnon.hpp>
#include <crypto/panonymizer.h>

using namespace std;

namespace bm
{
	void anonBuf(const char* payload, char* anon_payload, int offset,unsigned char* anon_key)
	{
        unsigned int raw_addr, anonymized_addr;

        PAnonymizer my_anonymizer(anon_key);
		for (int i = 3; i >= 0; i--) {
			raw_addr = payload[offset+i] << 8*i;
		//	cout << "octet no. " << i << ":" << payload[offset+i] << endl;
		}
		anonymized_addr = my_anonymizer.anonymize(raw_addr);
		for (int i = 3; i >= 0; i--) {
			anon_payload[offset+i] = (anonymized_addr << 8*i) >> 24;
		}
		//cout << "anonymizing " << raw_addr << "to" << anonymized_addr << endl;

	}

	IpAnon::IpAnon(const std::string &name, bool active, bool thread_safe)
    : Block(name, "ip_displayer", active, thread_safe),
      m_in_gate_id(register_input_gate("in_pkt")),
      m_out_gate_id(register_output_gate("out_pkt")),
      anon_src(false),
      anon_dst(false)
    {}


    void IpAnon::_configure(const xml_node& n)
	        {
	            xml_node source=n.child("anon");
	            if(!source)
	                throw std::runtime_error("Anonymizer: missing parameter anon");
	            std::string src=source.attribute("src").value();
	            std::string dst=source.attribute("dst").value();
	            if((src.length()==0)||(dst.length()==0))
	                throw std::runtime_error("IpAnon: missing attribute");
	            if(src.compare("True")==0)
	                anon_src=true;
	            if(dst.compare("True")==0)
	            	anon_dst=true;
	       }

    int IpAnon::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        // Get the raw packet
        if(m->type() != RAW_PACKET_CODE) throw std::runtime_error("ip_displayer: unexpected msg type");
        const RawPacket* packet = static_cast<const RawPacket*>(m.get());
        const_buffer<char> buffer = packet->get_buffer();
        const char* payload = buffer.addr();
        int payload_len = buffer.len();

        // Tuple fields

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

        char* anon_payload = new char[payload_len+1];
        strcpy(anon_payload, payload);

        //dummy IP anonimization method

        unsigned char anon_key[32] =
        {21,34,23,141,51,164,207,128,19,10,91,22,73,144,125,16,
         216,152,143,131,121,121,101,39,98,87,76,45,42,132,34,2};



        if (anon_src == true) {
            int src_ip_address_offset = ip_offset + 12;
        	anonBuf(payload, anon_payload, src_ip_address_offset, anon_key);
        }

        if (anon_dst == true) {
            int dst_ip_address_offset = ip_offset + 16;
          	anonBuf(payload, anon_payload, dst_ip_address_offset, anon_key);
        }

        // Send the tuple packet
        send_out_through(std::shared_ptr<Msg> (new RawPacket(const_buffer<char>(reinterpret_cast<const char *>(anon_payload),payload_len))), m_out_gate_id);
        return 0;
    }
}
