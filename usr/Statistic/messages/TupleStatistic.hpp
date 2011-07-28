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
 * File:   TupleStatistic.hpp
 * Author: fabrizio
 *
 * Created on 26 aprile 2011, 14.38
 */

#ifndef TUPLESTATISTIC_HPP
#define	TUPLESTATISTIC_HPP

#include <Msg.hpp>
#include <Tuple.hpp>
#include <cstring>

#include <memory>


namespace bm
{

    static const int TUPLE_STATISTIC_CODE = 0xcaccd;

    class TupleStatistic: public Msg
    {
        const Tuple m_tuple;
        unsigned int bytes;
        unsigned int packets;

    public:

        TupleStatistic(unsigned int src_ip, unsigned int dst_ip, unsigned short src_port, unsigned short dst_port, unsigned char protocol, unsigned int b, unsigned int p)
        : Msg(TUPLE_STATISTIC_CODE), m_tuple(src_ip, dst_ip, src_port, dst_port, protocol),bytes(b),packets(p)
        {}

        /**
         * TupleStatistic is not copyable by default
         */

        TupleStatistic(const TupleStatistic &) = delete;
        TupleStatistic& operator=(const TupleStatistic &) = delete;

        unsigned int get_bytes() const
        {
            return bytes;
        }

        unsigned int get_packets() const
        {
            return packets;
        }

        

        Tuple get_tuple() const
        {
            return m_tuple;
        }

        std::shared_ptr<Msg>
        clone() const
        {
            return std::make_shared<TupleStatistic>(m_tuple.get_src_ip(), m_tuple.get_dst_ip(), m_tuple.get_src_port(), m_tuple.get_dst_port(), m_tuple.get_protocol(),bytes,packets);
        }

        ~TupleStatistic()
        {

        }
    };

}


#endif	/* TUPLESTATISTIC_HPP */

