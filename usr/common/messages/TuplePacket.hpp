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
 * @file
 * Message that represents a raw packet and its parsed tuple.
 */
#ifndef _TUPLE_PACK_
#define _TUPLE_PACK_

#include <Msg.hpp>
#include <Tuple.hpp>
#include <cstring>

#include <memory>
#include<MemoryBlock.hpp>

namespace bm
{

    static const int TUPLE_PACKET_CODE = 0xcaccb;

    class TuplePacket: public Msg
    {
        char * m_payload;
        const int m_len;
        const int m_ip_head_offset;
        const int m_trans_head_offset;
        const Tuple m_tuple;

    public:
        /**
         * Constructor
         *
         * @param content Raw content of the packet
         * @param size Size of the raw content (in bytes)
         * @param ip_head_offset Offset (in bytes) to reach the IP header
         * @param trans_head_offset Offset (in bytes) to reach the transport layer header
         * @param src_ip The source IP
         * @param dst_ip The destination IP
         * @param src_port The source port for UDP or TCP (put 0 otherwise)
         * @param dst_port The destination port for UDP or TCP (put 0 otherwise)
         * @param protocol The underlying protocol number as defined by the IP protocol
         */
        TuplePacket(const char* content, int size, int ip_head_offset, int trans_head_offset, unsigned int src_ip, unsigned int dst_ip, unsigned short src_port, unsigned short dst_port, unsigned char protocol) 
        : Msg(TUPLE_PACKET_CODE), m_payload(new char[size]), m_len(size), m_ip_head_offset(ip_head_offset), m_trans_head_offset(trans_head_offset), m_tuple(src_ip, dst_ip, src_port, dst_port, protocol)
        {
            memcpy(m_payload, content, size);
        }

        TuplePacket(const char* content, int size, int ip_head_offset, int trans_head_offset, unsigned int src_ip, unsigned int dst_ip, unsigned short src_port, unsigned short dst_port, unsigned char protocol, const MemoryBlock&) 
        : Msg(TUPLE_PACKET_CODE), m_payload((char*)(this+1)), m_len(size), m_ip_head_offset(ip_head_offset), m_trans_head_offset(trans_head_offset), m_tuple(src_ip, dst_ip, src_port, dst_port, protocol)
        {
            memcpy(m_payload, content, size);
        }
        /**
         * TuplePacket is not copyable by default 
         */
         
        TuplePacket(const TuplePacket &) = delete;
        TuplePacket& operator=(const TuplePacket &) = delete;

        /**
         * Access to the link layer raw packet
         *
         * @return a pair with the payload and its size
         */
        std::pair<const char*, int> get_buffer() const
        {
            return std::pair<const char*, int> (m_payload, m_len);
        }

        /**
         * Access to the IP raw packet
         *
         * @return a pair with the payload and its size
         */
        std::pair<const char*, int> get_ip_buffer() const
        {
            return std::pair<const char*, int> (m_payload + m_ip_head_offset, m_len - m_ip_head_offset);
        }

        /**
         * Access to the transport layer raw packet
         *
         * @return a pair with the payload and its size
         */
        std::pair<const char*, int> get_trans_buffer() const
        {
            return std::pair<const char*, int> (m_payload + m_trans_head_offset, m_len - m_trans_head_offset);
        }

        /**
         * Access to the tuple
         *
         * @return the tuple of the packet
         */
        Tuple get_tuple() const
        {
            return m_tuple;
        }

        std::shared_ptr<Msg> 
        clone() const
        {
            return std::make_shared<TuplePacket>(m_payload, m_len, m_ip_head_offset, m_trans_head_offset, m_tuple.get_src_ip(), m_tuple.get_dst_ip(), m_tuple.get_src_port(), m_tuple.get_dst_port(), m_tuple.get_protocol());
        }

        ~TuplePacket()
        {
            delete m_payload;
        }
    };

}


#endif

