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


/**
 * <blockinfo type="IPDumbAnonymizer" invocation="both" thread_exclusive="False">
 *   <humandesc>
 *   This block can anonymize the source address and/or the destination
 *   address of an IP packet (this can be set as config param). Notice that, as
 *   this operation needs to modify the packet contents, the message is cloned
 *   before being modified.
 *   </humandesc>
 *
 *   <shortdesc>Anonymizes ip addresses in a Packet message</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element anon {
 *        attribute src {"True" | "False"}?
 *        attribute dst {"True" | "False"}?
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <anon src="True"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */



#include <IPDumbAnonymizer.hpp>
#include <crypto/panonymizer.h>
#include <NetTypes.hpp>

using namespace std;

namespace blockmon
{
	static void anonBuf(const char* payload, char* anon_payload, int offset,unsigned char* anon_key)
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

	IPDumbAnonymizer::IPDumbAnonymizer(const std::string &name, invocation_type invocation)
    : Block(name, invocation),
      m_in_gate_id(register_input_gate("in_pkt")),
      m_out_gate_id(register_output_gate("out_pkt")),
      anon_src(false),
      anon_dst(false)
    {}


    void IPDumbAnonymizer::_configure(const pugi::xml_node& n)
	        {
	           pugi::xml_node source=n.child("anon");
	            if(!source)
	                throw std::runtime_error("Anonymizer: missing parameter anon");
	            std::string src=source.attribute("src").value();
	            std::string dst=source.attribute("dst").value();
	            if((src.length()==0)||(dst.length()==0))
	                throw std::runtime_error("IPDumbAnonymizer: missing attribute");
	            if(src.compare("True")==0)
	                anon_src=true;
	            if(dst.compare("True")==0)
	            	anon_dst=true;
	       }

    // FIXME handle error returns
    void IPDumbAnonymizer::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        // Get the raw packet
        if(m->type() != MSG_ID(Packet) ) throw std::runtime_error("dumbanonimizer: unexpected msg type");
        auto cloned_packet = m->clone();
        m.reset(); //the source packet is not needed any longer
        const Packet* packet = static_cast<const Packet*>(cloned_packet.get());
        const ip4hdr* iphdr = reinterpret_cast<const ip4hdr*>(packet->iphdr());

        

        //dummy IP anonimization method

        unsigned char anon_key[32] =
        {21,34,23,141,51,164,207,128,19,10,91,22,73,144,125,16,
         216,152,143,131,121,121,101,39,98,87,76,45,42,132,34,2};

        if (anon_src == true) {
        	anonBuf(reinterpret_cast<const char*>(&iphdr->sip4), const_cast<char*> (reinterpret_cast<const char*>( &iphdr->sip4)), 0 , anon_key);
        }

        if (anon_dst == true) {
        	anonBuf(reinterpret_cast<const char*>(&iphdr->dip4), const_cast<char*> (reinterpret_cast<const char*>(&iphdr->dip4)) , 0 , anon_key);
        }

        send_out_through(std::move(cloned_packet), m_out_gate_id);
    }
}
