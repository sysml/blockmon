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

#ifndef __TUPLE_MSG_H__
#define __TUPLE_MSG_H__
#include<Msg.hpp>
#include<ClassId.hpp>

namespace bm
{

    template<typename K, typename V>
    class PairMsg: public Msg
    {

        PairMsg(const PairMsg&&)=delete;
        PairMsg& operator=(const PairMsg&&)=delete;


    public:
        PairMsg(const PairMsg& other): Msg(type_to_id< PairMsg<K,V> >::id()),m_key(other.m_key),m_val(other.m_val)
        { }

        PairMsg& operator=(const PairMsg& other) 
        { 
            m_key=other.m_key;
            m_val=other.m_val;
        }



        PairMsg(const K& key, const V& val): Msg(type_to_id<PairMsg<K,V> >::id()), m_key(key), m_val(val)
        {}

        PairMsg(K&& key,  V&& val): Msg(type_to_id<PairMsg<K,V> >::id()), m_key(std::move(key)), m_val(std::move(val))
        {}

        const K& key()
        {
            return m_key;
        }

        const V& val()
        {
            return m_val;
        }

        struct pod_struct
        {
            K key;
            V val;
        };

        virtual int to_pod(const mutable_buffer<char>& mb)
        {
            if(mb.len()<sizeof(pod_struct))
                throw std::runtime_error(__PRETTY_FUNCTION__);
            pod_struct* p= ( pod_struct*) mb.addr();
            p->key=m_key;
            p->val=m_val;
            return sizeof(pod_struct);
        }

        std::shared_ptr<Msg> clone() const
        {
            return std::shared_ptr<Msg>(static_cast<Msg*>(new PairMsg(*this)));
        }


        ~PairMsg()
        {}

    private:
        K m_key;
        V m_val;


    };

}




#endif //__TUPLE_H__
