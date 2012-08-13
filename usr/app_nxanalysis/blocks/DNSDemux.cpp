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
 * <blockinfo type="DNSDemux" scheduling_type="passive" thread_exclusive="False">
 *   <humandesc>
 *     Demux DNS answers (NOERROR, NXDOMAIN)
 *     The block takes as input packets
 *     The block sends DNS NOERROR to the "NX Analysis" Block and the NOERROR packets to "NOERROR Analysis" blocks
 *   </humandesc>
 *
 *   <shortdesc>Demux DNS answers </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pktnr" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pktnx" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *   </paramsschema>
 *
 *   <paramsexample>
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="pktcnt" human_desc="integer" access="read"/>
 *     <variable name="nxcount" human_desc="integer" access="read"/>
 *     <variable name="nrcount" human_desc="integer" access="read"/>
 *     <variable name="reset" human_desc="write 1 to reset" access="write"/>
 *   </variables>
 *
 * </blockinfo>
 */

#include<Block.hpp>
#include<Packet.hpp>
#include<BlockFactory.hpp>
#include<cstdio>
#include<netinet/in.h>
#include <iostream>
#include <ctime>
#include <chrono>
#include <iomanip>
#include "NetTypes.hpp"
#include "dnsh.h"

using namespace NXAnalyzer;
using namespace std;


#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is no more compliant with NewPacket class
//       Reason: the packet is no more linear in memory.
//       TO BE REWRITTEN!

namespace blockmon
{

    /**
     * Implements a block that reads DNS packets and sends the NOERROR and NXDOMAIN answers to other blocks
     * 0.5 seconds.
     */
    class DNSDemux: public Block
    {
        unsigned long long  m_count; // the number of packets
		unsigned long long m_dns_nx_count; // number of nxdomain answers
		unsigned long long m_dns_nr_count; // number of noerror answers
        int m_ingate_id;
		int m_outgate1;
		int m_outgate2;
        unsigned int m_reset;

		
		inline void packet_passed(std::shared_ptr<const Msg>&& m, int i)
        {
			if(i==0)
				send_out_through(std::move(m),m_outgate1);
			else
				send_out_through(std::move(m),m_outgate2);

        }


		
	
    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        DNSDemux(const std::string &name, invocation_type invocation) 
        : Block(name, invocation), 
        m_count(0), 
		m_dns_nx_count(0),
		m_dns_nr_count(0),
        m_ingate_id(register_input_gate("in_pkt")),
		m_outgate1(register_output_gate("out_pktnr")),
		m_outgate2(register_output_gate("out_pktnx")),
        m_reset(0)
        {
            register_variable("pktcnt",make_rd_var(no_mutex_t(), m_count));
            register_variable("nxcount",make_rd_var(no_mutex_t(), m_dns_nx_count));
			register_variable("nrcount",make_rd_var(no_mutex_t(), m_dns_nr_count));
            register_variable("reset",make_wr_var(no_mutex_t(), m_reset));

        }

		DNSDemux(const DNSDemux &)=delete;
        DNSDemux& operator=(const DNSDemux &) = delete;
        DNSDemux(DNSDemux &&)=delete;
        DNSDemux& operator=(DNSDemux &&) = delete;
        /**
         * @brief Destructor
         */
        ~DNSDemux()  {}

        /**
         * @brief Configures the block, in this case the export time is hard-coded
         * to 0.5 seconds
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n ) 
        {
          
        }



        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type()!=MSG_ID(Packet))
            {
                throw std::runtime_error("wrong message type in pkt counter");
            }
			
            if(m_reset==1)
            {
                m_count = 0;
                m_reset=0;
				m_dns_nx_count=0;
				m_dns_nr_count=0;
            }
			
            const Packet* packet = static_cast<const Packet*>(m.get());
			m_count++;
			
			const uint8_t *bufpacket = packet->base();
			const ethhdr *eh = reinterpret_cast<const ethhdr*>(bufpacket);
        
			uint16_t m_pkttype = ntohs(eh->ethertype);
			if(m_pkttype != Packet::kPktTypeIP4){
				return;
			}
			
			const ip4hdr* iphdr = reinterpret_cast<const ip4hdr*>(bufpacket + sizeof(ethhdr));
						
			if(iphdr->proto != Packet::kUDP){
				return;
			}
			int hlength = (iphdr->hlv & 0x0F);
			if(hlength != 5){
				return;
			}
			
			const udphdr* uphdr = reinterpret_cast<const udphdr*>(bufpacket + sizeof(ethhdr) + sizeof(ip4hdr));
			if(ntohs(uphdr->sp) != kDNS){
				return;
			}
			   			
			const dnshdr* dnsh = reinterpret_cast<const dnshdr*>(bufpacket + sizeof(ethhdr) +sizeof(ip4hdr) + sizeof(udphdr));
			
			int i_rcode;
			i_rcode = ntohs(dnsh->flags);
			i_rcode = i_rcode & 0x000F;


			if(i_rcode == 0){
				m_dns_nr_count++;
				packet_passed(std::move(m),0);
			} else if(i_rcode == 3){
				m_dns_nx_count++;
				packet_passed(std::move(m),1);
			} else  {
				return;
			}
        }
        

    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(DNSDemux,"DNSDemux");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon

#endif
