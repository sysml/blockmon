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
 * <blockinfo type="TstatAnalyzer" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
 *   Computes statistics on flows by means of the Tstat library.
 *   Inputs are:
 * 	- attribute name of element config: path to tstat config file
 * 	- attribute name of element logdir: path to tstat log folder
 * </humandesc>
 * <shortdesc>Computes statistics on flows by means of the Tstat library.</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *          element config {
 *           attribute name {text}
 *           }
 *          element logdir {
 *           attribute name {text}
 *           }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *           <config name="tstat.conf"/>
 *           <logdir name="/tmp/log"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#ifdef _USE_TSTAT

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <arpa/inet.h>
#include <Packet.hpp>

#include <sys/time.h>
#include <chrono>
#include<libtstat.h>

#define MAXIP 65535

using namespace pugi;

namespace blockmon
{

	 class TstatAnalyzer: public Block
	 {
	 private:

		 int m_in_gate;
		 int m_out_gate;
         int m_msg_recv;
         int m_msg_sent;
         tstat_report report;

	 public:

		 /*
		  * constructor
		  */
		 TstatAnalyzer(const std::string &name, invocation_type invocation) :
			 Block(name, invocation),
			 m_in_gate(register_input_gate("in_pkt")),
			 m_out_gate(register_output_gate("out_pkt")),
             m_msg_recv(0),
             m_msg_sent(0)
		 {
		 }

		 TstatAnalyzer(const TstatAnalyzer &)=delete;
		 TstatAnalyzer& operator=(const TstatAnalyzer &) = delete;
		 TstatAnalyzer(TstatAnalyzer &&)=delete;
		 TstatAnalyzer& operator=(TstatAnalyzer &&) = delete;

		 /*
		  * destructor
		  */
		 virtual ~TstatAnalyzer()
		 {
            tstat_close(&report);
            std::cout << "Removing TstatAnalyzer" << std::endl;
         }

		 /**
		   * configures the filter
		   * @param n the xml subtree
		   */
		 virtual void _configure(const xml_node&  n )
		 {
		     xml_node config = n.child("config");
		     xml_node log = n.child("logdir");
		     if(!config or !log)
	                 throw std::runtime_error("TstatAnalyzer: missing parameter");
             std::string cname=config.attribute("name").value();
		     tstat_init((char*)cname.c_str());
             std::string lname=config.attribute("name").value();
		     struct timeval cur_time;
		     gettimeofday(&cur_time,NULL);
		     tstat_new_logdir((char*)lname.c_str(), &cur_time);
		 }

		 /**
		   * the actual filtering function
		   * Expects Packet messages, otherwise it throws
		   * @param m the message to be checked
		  */
		 virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
		 {
			 if(m->type() != MSG_ID(Packet))
			 {
				 throw std::runtime_error("PacketFiler: wrong message type");
			 }

             m_msg_recv++;
/*
             if(m_msg_recv % 100000 == 0)
             	std::cout << "Received pkt no." << m_msg_recv << std::endl;
*/
             const Packet* packet = static_cast<const Packet* > (m.get());
             struct timeval tval;
             tval.tv_sec = packet->timestamp_s();
             tval.tv_usec = packet->timestamp().tv_nsec / 1000;


             if(m_msg_recv % 100000 == 0)
             {
                 auto now = std::chrono::system_clock::now();
                 auto duration = now.time_since_epoch();
                 auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();
             	std::cout << "Received pkt no." << m_msg_recv
                    << " at time [ms] " << millis << std::endl;
             }

             int plen = std::min((int)packet->caplen(),MAXIP);
             //const uint8_t* pkt_last = packet->iphdr() + packet->ip_length() +2 -1;
             const uint8_t* pkt_last = packet->base() + packet->caplen() - 1;

            /*
             printf("[%d;%d] buf=%x plen=%d\n",tval.tv_sec,tval.tv_usec,pkt_last-packet->iphdr(),plen);

             const uint8_t* pp = packet->iphdr();
             printf("%x %x %x\n", *pp,*(pp+1), *(pp+2));
             pp = pkt_last;
             printf("%x %x %x\n", *pp,*(pp-1), *(pp-2));
             */

             tstat_next_pckt(&tval, (struct ip*)packet->iphdr(), (uint8_t*)pkt_last, (int)plen, 0);

             send_out_through(std::move(m), m_out_gate);
             m_msg_sent++;

             //if(m_msg_recv == 33725814) // 01
             //if(m_msg_recv == 29388596) //02
             //if(m_msg_recv == 36850357) //00
             //   tstat_close(&report);

		 }
	 };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(TstatAnalyzer,"TstatAnalyzer");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}
#endif
