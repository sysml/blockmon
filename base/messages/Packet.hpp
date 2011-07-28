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

#ifndef _PACKET_HPP_
#define _PACKET_HPP_ 

#include <Msg.hpp>
#include <Buffer.hpp>
#include <MemoryBlock.hpp>

#include <cstring>
#include <cassert>
#include<ctime>



#include<RawPacket.hpp>
#include<ClassId.hpp>
#include<five_tuple.hpp>


namespace bm
{


    class Packet: public RawPacket
    {
    public:
        
        Packet( const const_buffer<char> &buff,timespec ts=timespec(),size_t len=0):RawPacket(buff,MSG_ID(Packet),ts,len),  m_tuple()
        {
            parse_buffer(buff,m_tuple);
        }

        // this constructor (to be used with placement-new) requires the memory associated for the m_buffer 
        // belongs to the given MemoryBlock and that is contiguously allocated to this object. Nicola
        //

        Packet(const const_buffer<char> &buff, MemoryBlock *block,timespec ts=timespec(),size_t len=0):RawPacket(buff,block,MSG_ID(Packet),ts,len),m_tuple()
        {
            parse_buffer(buff,m_tuple);
        }


        Packet(RawPacket&& rp): RawPacket(std::move(rp)),m_tuple()
        {
            parse_buffer(m_buffer,m_tuple);
        }


        struct pod_struct
        {
            size_t caplen;
            size_t len;
            timespec ts;
            const char* buffer;
            five_tuple tuple;
        }; 




         virtual void to_pod(const mutable_buffer<char>& buff ) const
         {
             if(buff.len()<sizeof(Packet::pod_struct))
                 throw std::runtime_error(std::string(__PRETTY_FUNCTION__)+std::string(" : not enough space for struct"));
             pod_struct* s=(pod_struct*) buff.addr();
             s->caplen=m_buffer.len();
             s->len=m_orig_len;
             s->ts=m_tstamp;
             s->buffer=m_buffer.addr();
             s->tuple=m_tuple;
         }

        virtual ~Packet()
        {
        }

        ////////////////////////////////
        virtual std::shared_ptr<Msg> clone() const
        {
            return std::make_shared<Packet>(m_buffer,m_tstamp,m_orig_len);
        }


        Packet(const Packet &) = delete;
        Packet& operator=(const Packet &) = delete;
    private:
        five_tuple m_tuple;

    };

}

#endif /* _PACKET_HPP_ */
