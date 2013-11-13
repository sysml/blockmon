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
 * <blockinfo type="PacketCounter" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
 *     Keeps packet and byte counts of traffic going through it and logs,
 *     every 0.5 seconds, the packet rate.
 *     An xml parameter can be used in order to disable the timer mechanism.
 *   </humandesc>
 *
 *   <shortdesc>Keeps packet and byte counts of traffic going through it.</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element notimer {text}?
 *      }
 *
 *   </paramsschema>
 *
 *    <paramsexample>
 *        <params>
 *              <notimer/>
 *          </params>
 *       
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="pktcnt" human_desc="integer" access="read"/>
 *     <variable name="bytecnt" human_desc="integer" access="read"/>
 *     <variable name="byterate" human_desc="integer" access="read"/>
 *     <variable name="pktrate" human_desc="integer" access="read"/>
 *     <variable name="reset" human_desc="write 1 to reset packet and byte counts" access="write"/>
 *   </variables>
 *
 * </blockinfo>
 */
#include <PacketCounter.hpp>

namespace blockmon
{
    void PacketCounter::_handle_timer(std::shared_ptr<Timer>&& )
    {
        std::chrono::system_clock::time_point n= std::chrono::system_clock::now(); 
        std::chrono::microseconds d = n - m_last_t;

        unsigned long long tmp_pkt_cnt = m_pkt_cnt;
        unsigned long long tmp_byte_cnt = m_byte_cnt;

        m_pkt_rate = (double)(tmp_pkt_cnt - m_pkt_cnt_prev) / ((double)d.count() / 1000000.0);
        m_byte_rate = (double)(tmp_byte_cnt - m_byte_cnt_prev) / ((double)d.count() / 1000000.0);
	m_pkt_cnt_prev = m_pkt_cnt;
	m_byte_cnt_prev = m_byte_cnt;
        m_last_t = n;	  
    }
} // namespace blockmon
