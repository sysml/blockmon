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

#ifndef _MESSAGES_PAIRMSG_HPP_
#define _MESSAGES_PAIRMSG_HPP_

#include <type_traits>

#include <Msg.hpp>
#include <ClassId.hpp>

namespace blockmon
{

  /**
   * Carries a key-value pair where both key and value are arbitrary types.
   */
    template<typename K, typename V>
    class PairMsg: public Msg
    {
    public:

        /** Forbids move constructor (copying allowed).
	 */
        PairMsg(const PairMsg&&)=delete;

        /** Forbids copy and move assignment.
	 */
        PairMsg& operator=(const PairMsg&)=delete; 

        /**
          message constructor that takes key and value by copy
          this version can work with the batch allocator 
          */
        PairMsg(K key, V val, mutable_buffer<char> b = mutable_buffer<char>(), bool ownership = false)
        : Msg(type_to_id<PairMsg<K,V> >::id(), b, ownership)
        , m_key(std::move(key))
        , m_val(std::move(val))
        {}

        PairMsg(PairMsg const &other)
        : Msg(other)        
        , m_key(other.m_key)
        , m_val(other.m_val)
        {}


        /**
          message destructor 
          */
        virtual ~PairMsg() 
        {}

        /**
          returns the key 
          */
        const K& key() const
        {
            return m_key;
        }

        /**
          returns the value 
          */
        const V& val() const
        {
            return m_val;
        }

        /**
          returns a copy of the message
          */
         
        virtual std::shared_ptr<Msg> clone() const
        {
            return std::make_shared<PairMsg>(*this);
        }    

    private:
        
        K m_key;
        V m_val;
    };

}

#endif // _MESSAGES_PAIRMSG_HPP_
