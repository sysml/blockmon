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

/*
 * <blockinfo type="SynthSource" invocation="indirect" thread_exclusive="True">
 *   <humandesc>
 *   Generates TCP/IP packets with random IP addresses and ports.
 *   The number of packets per second can be tuned as a configuration parameter.
 *   </humandesc>
 *   <shortdesc>Generates synthetic traffic with random addresses and ports</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="out_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element rate {
 *        attribute pps {xsd:integer}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <rate pps="10000"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <netinet/in.h> 
#include <Block.hpp>
#include <Packet.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <NetTypes.hpp>

using namespace pugi;
   
#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is no more compliant with NewPacket class.
//       TO BE REWRITTEN!


namespace blockmon
{
    class SynthSource: public Block
    {
        int m_gate_id;
        char m_packet[1500];
        std::shared_ptr<MemoryBatch> m_mem_block;        
        ethhdr* m_ethhd;
        ip4hdr* m_iphdr;
        tcphdr* m_tcphdr;
        std::chrono::nanoseconds m_period;

    public:

        SynthSource(const std::string &name, invocation_type invocation)
        :Block(name, invocation_type::Async), //ignore options, must be indirect
        m_gate_id(register_output_gate("out_pkt")), 
        m_mem_block(new MemoryBatch(4096*4)),
        m_period(std::chrono::milliseconds(1))
        {
            if (invocation != invocation_type::Async) {
                blocklog("SynthSource must be Async, ignoring configuration", log_warning);
            }
            memset(m_packet, 0x0, 1500);
            ethhdr* m_ethhdr = (ethhdr*) m_packet;
            m_ethhdr->ethertype = htons(Packet::kPktTypeIP4);
            ip4hdr* m_iphdr = (ip4hdr*) (m_packet + sizeof(ethhdr));
            m_iphdr->hlv = 4;
            m_iphdr->len = htons(5);
            m_iphdr->sip4 = rand();
            m_iphdr->dip4 = rand();
            m_iphdr->proto = Packet::kTCP;
            m_tcphdr = (tcphdr*)(m_packet + sizeof(ethhdr) + sizeof(ip4hdr));
            m_tcphdr->sp = rand();
            m_tcphdr->dp = rand();


        }

        void _configure(const pugi::xml_node& n) 
        {
           pugi::xml_node source=n.child("rate");
            if(!source) 
                throw std::runtime_error("packetgenerator: missing parameter rate");
            unsigned int rate=source.attribute("pps").as_uint();
            unsigned int nanosecs=(unsigned int)((1.0/(double) rate)*1000000000.0);
            m_period=std::chrono::nanoseconds(nanosecs);

        }
        
        void _do_async()
        {
		    for (int i=0; i<1000; ++i) {
                send_out_through(alloc_msg_from_buffer<Packet>(m_mem_block, 64, const_buffer<unsigned char>((unsigned char*)m_packet, 64) ), m_gate_id);
			    std::this_thread::sleep_for(m_period);
		    }
        }

    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(SynthSource,"SynthSource");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

#endif
