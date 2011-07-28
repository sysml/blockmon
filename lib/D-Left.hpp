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
 * @file    D-Left.hpp
 * @author  Fabrizio Nuccilli 
 * @version 1.0
 *
 * @section LICENSE
 *
 *
 * @section DESCRIPTION
 *
 * The class represents a d-left implementation
 * It works with all the hash tables providing the inferface
 * defined in HashTable.hpp
 * It is a template with two parameters:
 * the first is the hash table type
 * the second is the type of the states that will be saved in the table
 * 
 */

#ifndef D_LEFT_HPP
#define	D_LEFT_HPP

#include "hash/khash.hpp"
#include <HashTable.hpp>
#include "hash/sha1.hpp"

#include "hash/bob.hpp"
#include <cassert>

namespace bm
{

 /*
 * this function calculate the logarithm base 2
 * only for powers of 2
 * @param n the number to apply the logarithm
 * @return the result of logarithm
 *
 */
unsigned int log2(unsigned int n)
{
        unsigned int i=0;
        while(!(n & unsigned(1)) && n)
        {
            n = n >> 1;
            ++i;
        }
        return i;
}

template<typename Table,typename State>
class D_LEFT
{
    
public:

    /*
     * this is the constructor of a D_LEFT object
     * @param nh the number of hash functions used in the d-left
     * @param tablelen the size of the hash table to use
     * @param tab the hash table to use
     * 
     */
    D_LEFT(unsigned int nh, unsigned int tablelen, Table* tab):
        table(tab),tablesize(tablelen),nhash(nh),blocksize(tablelen/nh),khash(KHASH(new BOB(),nh,log2(blocksize))) {assert(!(blocksize >> (log2(blocksize) + 1)));}

    /*
     * the copy constructor
     */
    D_LEFT(const D_LEFT<Table,State> & copy):
        table(copy.table),tablesize(copy.tablesize),nhash(copy.nhash),blocksize(copy.blocksize),khash(KHASH(new SHA1(),nhash,blocksize)) {}

    /*
     * destructor
     */
    virtual ~D_LEFT(){}
    
    /*
     * the assignment operator
     */
    D_LEFT & operator = (const D_LEFT<Table,State> & copy)
    {
        khash=copy.khash;
        delete table;
        table=copy.table;
        tablesize=copy.tablesize;
        nhash=copy.nhash;
    }

    /*
     * check the presence of a key
     * @param key the key to find
     * @return true if the key is present, false otherwise
     */
    virtual bool check(Key& key);

    /*
     * update, add or do anything if the key is present, if it is not present
     * but there is free space and if is not present and 
     * there is not free space, respectively.
     * @param key key to update/add
     * @param state state to set if new or to add to a present one
     * @return ADDED,UPDATED or NOTFREESPACE
     */
    virtual UpdateStatus update(Key& key, State state);
    
    /*
     * remove a particular key
     * @param key key to remove
     * @return true if the key was present and was just removed, false otherwise
     */
    virtual bool remove(Key& key);

    /*
     * get the state associated with a key
     * @param key the key to find
     * @return a pointer to the state if the key is present, NULL otherwise
     */
    virtual State* get(Key& key);
    
    /*
     * Print on the standard out the hash table
     */
    void print_table()
    { this->table->print();}

protected:
    Table* table;
    unsigned int tablesize;
    unsigned int nhash;
    unsigned int blocksize;
    KHASH khash;

};


}

#include <D-Left.cpp>

#endif	/* D_LEFT_HPP */

