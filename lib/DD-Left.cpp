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

#ifdef DD_LEFT_HPP


#include "hash/khash.hpp"
#include "DD-Left.hpp"

namespace bm
{

template<typename T,typename S>
S* DD_LEFT<T,S>::get(Key& key)
{
    
    this->khash.compute(key.keyvalue,key.keylength);
    S* state=NULL;
    for (unsigned int i = 0; i < this->nhash; ++i)
        if ((state = this->table->get(this->khash.H(i) + this->blocksize*i,key))!=NULL)
            break;

    return state;
}

template<typename T,typename S>
UpdateStatus DD_LEFT<T,S>::update(Key& key, S state)
{
    //this->table->print();
    this->khash.compute(key.keyvalue,key.keylength);
    unsigned int minsizenode = this->khash.H(0);
    unsigned int minsize = this->table->size(this->khash.H(0));
    for (unsigned int i = 0; i < this->nhash; ++i)
    {        
        unsigned int indexnode = this->khash.H(i) + this->blocksize*i;
        unsigned int size=this->table->size(indexnode);
        if (size != 0 && this->table->update(indexnode,key,state))
            return UPDATED;
        else if (size<minsize)
        {
            minsize=size;
            minsizenode=indexnode;
        }
    }
    if(this->table->add(minsizenode,key,state))
    {
        if(minsizenode/this->blocksize >= this->nhash-blockadded)
        {
            elperblock[minsizenode/this->blocksize + blockadded - this->nhash]++;
        }
        return ADDED;
    }
    this->table->grow(this->blocksize);
    this->tablesize+=this->blocksize;
    this->nhash++;
    this->khash.inc_nhash();
    this->khash.compute(key.keyvalue,key.keylength);
    blockadded++;
    elperblock.push_back(0);
    if(this->table->add(this->khash.H(this->nhash-1) + this->blocksize*(this->nhash-1),key,state))
    {
        elperblock[blockadded-1]++;
        return ADDED;
    }
    return NOTFREESPACE;
    
}

template<typename T,typename S>
bool DD_LEFT<T,S>::check(Key& key)
{
    
    this->khash.compute(key.keyvalue,key.keylength);
    for (unsigned int i = 0; i < this->nhash; ++i)
        if (this->table->check(this->khash.H(i) + this->blocksize*i,key))
            return true;
    return false;
}

template<typename T,typename S>
bool DD_LEFT<T,S>::remove(Key& key)
{
    //this->table->print();
    this->khash.compute(key.keyvalue,key.keylength);
    for (unsigned int i = 0; i < this->nhash; ++i)
        if (this->table->remove(this->khash.H(i) + this->blocksize*i,key))
        {
            unsigned int tosize; 
            unsigned int freespace;
            unsigned int khash=this->khash.H(i);
            if(i >= this->nhash-blockadded)
                elperblock[i+blockadded-this->nhash]--;
            if(blockadded && i!=this->nhash-1)
            {
                
                unsigned int j = this->khash.H(i) + this->blocksize*i;
                tosize = this->table->size(j);
                freespace=this->table->freespace(j);
                if(tosize==0)
                {
                    for(j=this->blocksize*(this->nhash-1);j<this->tablesize && freespace;j++)
                    {
                        std::vector<Key*> keys=this->table->get(j);
                        for(unsigned int k=0; k<keys.size() && freespace; k++)
                        {
                            this->khash.compute(keys[k]->keyvalue,keys[k]->keylength);
                            if(khash==this->khash.H(i))
                            {
                                this->table->move(j,khash + this->blocksize*i,keys[k]);
                                freespace--;
                                elperblock[blockadded-1]--;
                                if(i >= this->nhash-blockadded)
                                    elperblock[i+blockadded-this->nhash]++;
                            }
                        }
                    }
                    if(elperblock[blockadded-1]==0)
                    {
                        this->table->reduce(this->blocksize);
                        this->tablesize-=this->blocksize;
                        this->khash.dec_nhash();
                        this->nhash--;
                        this->khash.compute(key.keyvalue,key.keylength);
                        blockadded--;
                        elperblock.pop_back();
                    }
                }                                        
            }
            return true;
        }
            
    return false;
}


}

#endif
