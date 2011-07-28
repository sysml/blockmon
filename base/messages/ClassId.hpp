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

#ifndef __CLASSID_H__
#define __CLASSID_H__


#include<string>
#include <cxxabi.h>
#include <typeinfo>
#include<memory>
#include<stdexcept>


template<typename T>
struct nullstruct {};


static unsigned int hash(const char* b,size_t s)
{
    int remaining_length=s;
    unsigned int hash=0x66B566B5;
    const char* it = b;
    while(remaining_length >= 2)
    {
        hash ^=    (hash <<  7) ^  (*it++) * (hash >> 3);
        hash ^= (~((hash << 11) + ((*it++) ^ (hash >> 5))));
        remaining_length -= 2;
    }
    if (remaining_length)
    {
        hash ^= (hash <<  7) ^ (*it) * (hash >> 3);
    }
    return hash;
}


template<typename T> 
static int compute_id()
{
    std::string name(typeid(nullstruct<T>()).name());
    int status;
    std::shared_ptr<char> ret(abi::__cxa_demangle(name.c_str(),0,0, &status), ::free);
    if(status<0)
        throw std::runtime_error(__PRETTY_FUNCTION__);
    std::string demangled (ret.get());
    return (static_cast<int>(hash(demangled.c_str(),demangled.length())));
}





template<typename T>
struct  type_to_id
{
    static int id()
    {
        static int id=compute_id<T>();
        return id;
    }
};

#define MSG_ID(msgtype)\
type_to_id<msgtype>::id()




#endif
