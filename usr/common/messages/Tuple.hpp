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
 * Message that represents the tuple of a packet:
 * (source IP, dest. IP, source port, dest. port, protocol).
 * The ports may not be present depending on the underlying protocol.
 */

#ifndef _TUPLE_
#define _TUPLE_

#include <string>
#include <sstream>

#include<Msg.hpp>

#define TUPLE_CODE   0xcaccc
#define IP_PROTO_UDP 0x11
#define IP_PROTO_TCP 0x6

namespace bm
{

    class Tuple: public Msg
    {
    public:
        const unsigned int m_src_ip;
        const unsigned int m_dst_ip;
        const unsigned short m_src_port;
        const unsigned short m_dst_port;
        const unsigned char m_protocol;

        /**
         * Constructor
         *
         * @param src_ip The source IP
         * @param dst_ip The destination IP
         * @param src_port The source port for UDP or TCP (put 0 otherwise)
         * @param dst_port The destination port for UDP or TCP (put 0 otherwise)
         * @param protocol The underlying protocol number as defined by the IP protocol
         */

        Tuple() 
        : Msg(TUPLE_CODE), m_src_ip(0), m_dst_ip(0), m_src_port(0), m_dst_port(0), m_protocol(0)
        {
            
        }

        Tuple(unsigned int src_ip, unsigned int dst_ip, unsigned short src_port, unsigned short dst_port, unsigned char protocol) 
        : Msg(TUPLE_CODE), m_src_ip(src_ip), m_dst_ip(dst_ip), m_src_port(src_port), m_dst_port(dst_port), m_protocol(protocol)
        {
        }


        Tuple(const Tuple& t)
        : Msg(TUPLE_CODE), m_src_ip(t.m_src_ip), m_dst_ip(t.m_dst_ip), m_src_port(t.m_src_port), m_dst_port(t.m_dst_port), m_protocol(t.m_protocol)
        {}

        Tuple(Tuple&& t)
        : Msg(TUPLE_CODE), m_src_ip(t.m_src_ip), m_dst_ip(t.m_dst_ip), m_src_port(t.m_src_port), m_dst_port(t.m_dst_port), m_protocol(t.m_protocol)
        {
             
        }
        /**
         * Access to the source IP
         *
         * @return the source IP
         */
        unsigned int get_src_ip() const
        {
            return m_src_ip;
        }

        /**
         * Access to the destination IP
         *
         * @return the destination IP
         */
        unsigned int get_dst_ip() const
        {
            return m_dst_ip;
        }

        /**
         * Access to the source port
         *
         * @return the source port for TCP or UDP, 0 otherwise
         */
        unsigned int get_src_port() const
        {
            return m_src_port;
        }

        /**
         * Access to the destination port
         *
         * @return  the destination port for TCP or UDP, 0 otherwise
         */
        unsigned int get_dst_port() const
        {
            return m_dst_port;
        }

        /**
         * Access to the protocol number
         *
         * @return the underlying protocol number as defined by the IP protocol
         */
        unsigned char get_protocol() const
        {
            return m_protocol;
        }

        /**
         * String representation of the tuple
         */
        std::string to_string() const
        {
            unsigned char* src_ip_ptr = (unsigned char*) &m_src_ip;
            unsigned char* dst_ip_ptr = (unsigned char*) &m_dst_ip;
            std::ostringstream rep;
            rep << (unsigned int) *(src_ip_ptr+3);
            rep << "." << (unsigned int) *(src_ip_ptr+2);
            rep << "." << (unsigned int) *(src_ip_ptr+1);
            rep << "." << (unsigned int) *src_ip_ptr;
            if (m_src_port > 0)
                rep << ":" << m_src_port;
            rep << " --> " << (unsigned int) *(dst_ip_ptr+3);
            rep << "." << (unsigned int) *(dst_ip_ptr+2);
            rep << "." << (unsigned int) *(dst_ip_ptr+1);
            rep << "." << (unsigned int) *dst_ip_ptr;
            if (m_dst_port > 0)
                rep << ":" << m_dst_port;
            return rep.str();
        }

        std::shared_ptr<Msg> clone() const
        {
            return std::make_shared<Tuple>(m_src_ip, m_dst_ip, m_src_port, m_dst_port, m_protocol);
        }

        ~Tuple()
        {}

    };

}


#endif

