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

#ifndef _RAWPACKET_HPP_
#define _RAWPACKET_HPP_ 

#include <Msg.hpp>
#include <Buffer.hpp>
#include <MarshFactory.hpp>
#include <MemoryBlock.hpp>

#include <cstring>
#include <cassert>
#include<ctime>

#include<ClassId.hpp>

#define RAW_PACKET_CODE MSG_ID(RawPacket)

namespace bm
{

    class RawPacket: public Msg
    {

    public:
		class Marshall: public BaseMarshall
		{
			public:
			Marshall()
			{}

			virtual int marshall(const Msg& inm, mutable_buffer<char> inb) const
			{
				const RawPacket& rp=static_cast<const RawPacket&>(inm);
				if(inb.len()<rp.m_buffer.len())
					throw std::runtime_error("RawPacket:: buffer is too short for marshalling");
				memcpy(inb.addr(),rp.m_buffer.addr(),rp.m_buffer.len());
				return rp.m_buffer.len();
			}


			virtual std::shared_ptr<const Msg> unmarshall(const_buffer<char>inb) const
			{
				return std::shared_ptr<const Msg> (static_cast<const Msg*> (new RawPacket(inb)));
			}

		};

        struct deleter
        {
            void operator()(const void *addr) const
            { /*
                assert(static_cast<const RawPacket *>(addr)->m_block);
                const_cast<RawPacket*>(static_cast<const RawPacket *>(addr))->m_block->release();*/
            }
        };

        /////////////////////////////////////////
    public:
        
        RawPacket(const const_buffer<char> &buff, int msg_id=MSG_ID(RawPacket),timespec ts=timespec(),size_t len=0)
        :Msg(msg_id), m_buffer(new char[buff.len()], buff.len()), m_block(NULL),m_tstamp(ts),m_orig_len(len)
        {
            if(!len)
                m_orig_len=buff.len();
            memcpy(m_buffer.addr(), buff.addr(), buff.len());
        }

        // this constructor (to be used with placement-new) requires the memory associated for the m_buffer 
        // belongs to the given MemoryBlock and that is contiguously allocated to this object. Nicola
        //

        RawPacket(const const_buffer<char> &buff, MemoryBlock *block,int msg_id=MSG_ID(RawPacket),timespec ts=timespec(),size_t len=0)
        :Msg(msg_id), m_buffer(reinterpret_cast<char *>(this+1), buff.len()), m_block(block), m_tstamp(ts),m_orig_len(len)
        {
            if (block == NULL)
                throw std::runtime_error("RawPacket: MemoryBlock is NULL!");
            if(!len)
                m_orig_len=buff.len();

            memcpy(m_buffer.addr(), buff.addr(), buff.len());
        }

        RawPacket(RawPacket&& rp): Msg(MSG_ID(RawPacket)), m_buffer(NULL,0),m_block(NULL), m_tstamp(rp.m_tstamp),m_orig_len(rp.m_orig_len)
        {
            if(!rp.m_block)
            {
                m_buffer.change_buff(rp.m_buffer.addr(),rp.m_buffer.len());
                rp.m_buffer.change_buff(NULL,0);//safe to delete
            }
            else
            {
                char* newbuf=new char[rp.m_buffer.len()];
                memcpy(newbuf,rp.m_buffer.addr(),rp.m_buffer.len());
                m_buffer.change_buff(newbuf,rp.m_buffer.len());
            }
        }


               

        struct pod_struct
        {
            size_t caplen;
            size_t len;
            timespec ts;
            const char* buffer;
        } ;


         virtual void to_pod(const mutable_buffer<char>& buff ) const
         {
             if(buff.len()<sizeof(pod_struct))
                 throw std::runtime_error(std::string(__PRETTY_FUNCTION__)+" : not enough space for struct");
             pod_struct* s=(pod_struct*) buff.addr();
             s->caplen=m_buffer.len();
             s->len=m_orig_len;
             s->ts=m_tstamp;
             s->buffer=m_buffer.addr();
         }

        virtual ~RawPacket()
        {
            if (!m_block)
                delete m_buffer.addr();
        
            // otherwise the responsibility to delete the block is 
            // in charge of the shared_ptr deleter which invokes the MemoryBlock::release method.
        }

        ////////////////////////////////

        RawPacket(const RawPacket &) = delete;
        RawPacket& operator=(const RawPacket &) = delete;

        // RawPacket(const RawPacket &other)
        // : Msg(MSG_ID(RawPacket)), m_buffer(new char[other.m_buffer.len()], other.m_buffer.len())
        // {
        //     memcpy(m_buffer.addr(), other.m_buffer.addr(), other.m_buffer.len());
        // }

        // canonical operator= (also known as universal assignment operator)
        // RawPacket& operator=(RawPacket other)
        // {
        //     other.swap(*this);
        //     return *this;    
        // }
            
        // void swap(RawPacket &other)
        // {
        //     // swap the base first...
        //     static_cast<Msg &>(*this).swap(other);
        //     std::swap(m_buffer, other.m_buffer);
        // }




        const timespec& 
        get_ts() const
        {
            return m_tstamp;
        }

        size_t
        get_orig_len()
        {
            return m_orig_len;
        }

        const_buffer<char>
        get_buffer() const
        {
            return m_buffer;
        }

        std::shared_ptr<Msg> 
        clone() const
        {
            return std::make_shared<RawPacket>(m_buffer);
        }

    protected:
        mutable_buffer<char> m_buffer;
        MemoryBlock *m_block;
        timespec m_tstamp;
        size_t m_orig_len;
    };

REGISTER_MARSHALLING_MODULE(RawPacket::Marshall, RawPacket)
}



#endif /* _RAWPACKET_HPP_ */
