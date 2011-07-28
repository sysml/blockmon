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

#ifdef D_LEFT_HPP


#include "hash/khash.hpp"

namespace bm
{

template<typename T,typename S>
S* D_LEFT<T,S>::get(Key& key)
{
    khash.compute(key.keyvalue,key.keylength);
    S* state=NULL;
    for (unsigned int i = 0; i < nhash; ++i)
        if ((state = table->get(khash.H(i) + blocksize*i,key))!=NULL)
            break;
    return state;
}

template<typename T,typename S>
UpdateStatus D_LEFT<T,S>::update(Key& key, S state)
{
    khash.compute(key.keyvalue,key.keylength);
    unsigned int minsizenode = khash.H(0);
    unsigned int minsize = table->size(khash.H(0));
    for (unsigned int i = 0; i < nhash; ++i)
    {        
        unsigned int indexnode = khash.H(i) + blocksize*i;
        unsigned int size=table->size(indexnode);
        if (size != 0 && table->update(indexnode,key,state))
            return UPDATED;
        else if (size<minsize)
        {
            minsize=size;
            minsizenode=indexnode;
        }
    }
    if(table->add(minsizenode,key,state))
        return ADDED;
    return NOTFREESPACE;
}

template<typename T,typename S>
bool D_LEFT<T,S>::check(Key& key)
{
    khash.compute(key.keyvalue,key.keylength);
    for (unsigned int i = 0; i < nhash; ++i)
        if (table->check(khash.H(i) + blocksize*i,key))
            return true;
    return false;
}

template<typename T,typename S>
bool D_LEFT<T,S>::remove(Key& key)
{
    khash.compute(key.keyvalue,key.keylength);
    for (unsigned int i = 0; i < nhash; ++i)
        if (table->remove(khash.H(i) + blocksize*i,key))
            return true;
    return false;
}


}

#endif