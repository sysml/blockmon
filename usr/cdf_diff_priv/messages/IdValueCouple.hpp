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
 * Message that represents a couple (id, value).
 */
#ifndef _TUPLE_PACK_
#define _TUPLE_PACK_

#include <Msg.hpp>
#include <cstring>

#include <memory>


namespace bm
{

    static const int ID_VALUE_CODE = 0xace01; 

    class IdValueCouple: public Msg
    {
        int id;
        int value;

    public:
        /**
         * Constructor
         *
         * @param id 		the identifier
         * @param value 	the associated value
         */
        IdValueCouple(int _id, int _value) 
        : Msg(ID_VALUE_CODE), id(_id), value(_value)
        {
        }

        /**
         * IdValueCouple is not copyable by default 
         */
         
        IdValueCouple(const IdValueCouple &) = delete;
        IdValueCouple& operator=(const IdValueCouple &) = delete;

        /**
         * Access the pair
         *
         * @return a pair with id and value
         */
        std::pair<int, int> get_pair() const
        {
            return std::pair<int, int> (id, value);
        }

        /**
         * Access the id
         *
         * @return the id
         */
        int get_id() const
        {
            return id;
        }

        /**
         * Access the value
         *
         * @return the value
         */
        int get_value() const
        {
            return value;
        }

        std::shared_ptr<Msg> 
        clone() const
        {
            return std::make_shared<IdValueCouple>(id, value);
        }

    };

}


#endif

