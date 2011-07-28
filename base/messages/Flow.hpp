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
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

#ifndef __FLOW_H_
#define __FLOW_H_


#include<Msg.hpp>
#include<ctime>
#include<cstring>
#include<five_tuple.hpp>
#include<Buffer.hpp>
#include<ClassId.hpp>

namespace bm
{

    class Flow: public Msg
    {
        five_tuple m_tuple;
        timespec m_stime;
        timespec m_etime;
        const_buffer<char> m_buffer;
        uint64_t m_bytes;
        uint64_t m_packets;
        uint64_t m_accumulator;
    public:
        Flow(const five_tuple& tuple):Msg(MSG_ID(Flow)),m_tuple(tuple),m_stime(),m_etime(),m_buffer(NULL,0),m_bytes(0),m_packets(0),m_accumulator(0)
        {   }

        Flow(const Flow& other): Msg(MSG_ID(Flow)),m_tuple(other.m_tuple),m_stime(other.m_stime),m_etime(other.m_etime),m_buffer((other.m_buffer.len()!=0)? (new char [other.m_buffer.len()]):NULL,other.m_buffer.len()),m_bytes(other.m_bytes),m_packets(other.m_packets),m_accumulator(other.m_accumulator)
        {
            memcpy(const_cast<char*>(m_buffer.addr()),other.m_buffer.addr(),m_buffer.len());
        }

        Flow(Flow&& other): Msg(MSG_ID(Flow)),m_tuple(other.m_tuple),m_stime(other.m_stime),m_etime(other.m_etime),m_buffer(other.m_buffer.addr(),other.m_buffer.len()),m_bytes(other.m_bytes),m_packets(other.m_packets),m_accumulator(other.m_accumulator)
        {
            other.m_buffer.change_buff(NULL,0);
        }

        timespec& s_time()
        {
            return m_stime;
        }

        const timespec& s_time() const
        {
            return m_stime;
        }

        
        timespec& e_time()
        {
            return m_etime;
        }

        const timespec& e_time() const
        {
            return m_etime;
        }

        const const_buffer<char>& buff() const
        {
            return m_buffer;
        }


        const_buffer<char>& buff() 
        {
            return m_buffer;
        }

        const five_tuple& tuple() const
        {
            return m_tuple;
        }

        uint64_t bytes() const
        {
            return m_bytes;
        }


        uint64_t& bytes() 
        {
            return m_bytes;
        }


        uint64_t packets() const
        {
            return m_packets;
        }

        uint64_t& packets() 
        {
            return m_packets;
        }


        uint64_t accumulator() const
        {
            return m_accumulator;
        }

        uint64_t& accumulator() 
        {
            return m_accumulator;
        }

        virtual ~Flow()
        {
            delete m_buffer.addr();
        }

        struct pod_struct
        {
            five_tuple tuple;
            timespec stime;
            timespec etime;
            const char* buffer;
            size_t buf_len;
            uint64_t bytes;
            uint64_t packets;
        };


        virtual int to_pod(const mutable_buffer<char>& inb)
        {
            pod_struct* p=(pod_struct*) inb.addr();
            p->tuple=m_tuple;
            p->stime=m_stime;
            p->etime=m_etime;
            p->buffer=m_buffer.addr();
            p->buf_len=m_buffer.len();
            p->bytes=m_bytes;
            p->packets=m_packets;
            return sizeof(pod_struct);
        }


        virtual std::shared_ptr<Msg> clone() const
        {
            return std::shared_ptr<Msg>(new Flow(*this));
        }

            





    };
}











#endif// __FLOW_H_
