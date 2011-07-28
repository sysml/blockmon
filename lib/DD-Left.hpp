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
 * @file    DD-Left.hpp
 * @author  Fabrizio Nuccilli 
 * @version 1.0
 *
 * @section LICENSE
 *
 *
 * @section DESCRIPTION
 *
 * The class represents a particular d-left implementation
 * It is designed as a d-left can use an hash table which can modify its size dinamically
 * This hash table is implemented in the DynamicHashTable.hpp file
 * but indeed can be used every table that provide all the methods of this last.
 * It is a template with two parameters:
 * the first is the hash table type
 * the second is the type of the states that will be saved in the table
 * 
 */

#ifndef DD_LEFT_HPP
#define	DD_LEFT_HPP

#include <hash/khash.hpp>
#include <HashTable.hpp>
#include "hash/sha1.hpp"
#include <D-Left.hpp>
#include <cassert>

namespace bm
{




template<typename Table,typename State>
class DD_LEFT: public D_LEFT<Table,State>
{
    

public:

    /*
     * this is the constructor of a DD_LEFT object
     * @param nh the number of hash functions used in the d-left
     * @param tablelen the size of the hash table to use
     * @param tab the hash table to use
     * 
     */
    DD_LEFT(unsigned int nh, unsigned int tablelen, Table* tab):
        D_LEFT<Table,State>(nh,tablelen,tab),blockadded(0),elperblock(std::vector<unsigned int>()){}

    /*
     * the copy constructor
     */
    DD_LEFT(const DD_LEFT<Table,State> & copy):
        D_LEFT<Table,State>(copy),blockadded(copy.blockadded),elperblock(copy.elperblock) {}
    

    /*
     * the assignment operator
     */
    DD_LEFT & operator = (const DD_LEFT<Table,State> & copy)
    {
        this->khash=copy.khash;
        delete this->table;
        this->table=copy.table;
        this->tablesize=copy.tablesize;
        this->nhash=copy.nhash;
        this->blocksize=copy.blocksize;
        blockadded=copy.blockadded;
        elperblock=copy.elperblock;
    }

    /*
     * check the presence of a key
     * @param key the key to find
     * @return true if the key is present, false otherwise
     */
    bool check(Key& key);

    /*
     * update or add if the key is present or if it is not present, respectively.
     * in the second case if there is freespace the key is simply added,
     * otherwise it is called a particular method of the table that alloc new space
     * and is made a second attempt
     * @param key key to update/add
     * @param state state to set if new or to add to a present one
     * @return UPDATED,ADDED or NOTFREESPACE (this last if the table can't allocate new space) 
     */
    UpdateStatus update(Key& key, State);
    
    /*
     * remove a particular key
     * @param key key to remove
     * @return true if the key was present and was just removed, false otherwise
     */
    bool remove(Key& key);

    /*
     * get the state associated with a key
     * @param key the key to find
     * @return a pointer to the state if the key is present, NULL otherwise
     */
    State* get(Key& key);
    
    

private:
    
    
    unsigned int blockadded;
    std::vector<unsigned int> elperblock;
    
};


}

#include <DD-Left.cpp>


#endif	/* DD_LEFT_HPP */

