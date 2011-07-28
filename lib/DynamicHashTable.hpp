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
 * @file    DynamicHashTable.hpp
 * @author  Fabrizio Nuccilli 
 * @version 1.0
 *
 * @section LICENSE
 *
 *
 * @section DESCRIPTION
 *
 * This class is a particular type of hash table, the number of rows can
 * be increased or decreased calling some special methods. 
 * The other methods are like the static hash.
 * The template parameter is the state type.
 * the state is the object to store in the table
 * 
 */

#ifndef DYNAMICHASHTABLE_HPP
#define	DYNAMICHASHTABLE_HPP

#include "HashTable.hpp"
#include "SimpleOp.hpp"
#include <vector>



namespace bm
{
    




template<typename T>
class DynamicHashTable: public HashTable<T>
{


public:

    /*
     * constructor
     * @param rows table rows
     * @param columns table columns
     * @param maxr the max number of table rows 
     * @param Update a pointer to the function that update a state
     * @param Clear a pointer to the function that reset a state
     */
    DynamicHashTable(unsigned int rows, unsigned int columns, unsigned int maxr, void (*Update) (T&,T&)=sop::sum<T>, void (*Clear)(T&)=sop::null<T>):
        HashTable<T>(rows),columnsize(columns),maxrows(maxr),realcolumnsize(std::vector<unsigned int>(rows,0)),
        nodes(std::vector<HashNode<T> *> (rows,NULL))
        {
            for (unsigned int i=0; i < rows; ++i)
            {
                realcolumnsize[i]=0;
                nodes[i]=new HashNode<T> [columns];
                HashNode<T> standardnode=HashNode<T>(Update,Clear);
                for (unsigned int j = 0; j < columns; ++j)
                    nodes[i][j]=standardnode;
            }
            
        }

    /*
     * copy constructor
     */    
    DynamicHashTable(const DynamicHashTable<T> & copy):
        HashTable<T>(copy.hashsize),columnsize(copy.realcolumnsize),maxrows(copy.maxrows),realcolumnsize(new unsigned int [copy.hashsize]),
        nodes( new std::vector<HashNode<T> *> (copy.hashsize,NULL))
    {
        for (unsigned int i=0; i < this->hashsize; ++i)
        {
            realcolumnsize[i]=copy.realcolumnsize[i];
            nodes[i]= new HashNode<T>[columnsize];
            for (unsigned int j = 0; j < columnsize; ++j)
                nodes[i][j]=copy.nodes[i][j];
        }

    }

    /*
     * destructor
     */
    ~DynamicHashTable()
    {
        for(unsigned int i = 0; i < this->hashsize; ++i)
            delete[] nodes[i];
        nodes.clear();
    }

    /*
     * assignment operator
     */
    DynamicHashTable<T> & operator = (DynamicHashTable<T> & copy)
    {
        for(unsigned int i = 0; i < this->hashsize; ++i)
            delete[] nodes[i];
        nodes.clear();
        HashTable<T>(copy.hashsize);
        columnsize=copy.columnsize;
        maxrows=copy.maxrows;
        realcolumnsize=new unsigned int [this->hashsize];
        for (unsigned int i=0; i < this->hashsize; ++i)
        {
            nodes.push_back(new HashNode<T>[columnsize]);
            realcolumnsize[i]=copy.realcolumnsize[i];
            for (unsigned int j = 0; j < realcolumnsize[i]; ++j)
                nodes[i][j]=copy.nodes[i][j];
        }
        return *this;
    }

    /*
     * get the state associated with the key if present in i-th row
     * @param i the row where search
     * @param key the key to search
     * @return the state found, otherwise NULL
     */
    T* get(unsigned int i,Key& key);
    
    /*
     * get all the key in a row
     * @param i the row where search
     * @return a vector with a pointer to each key in the row
     */
    std::vector<Key*> get(unsigned int i);

    /*
     * updates a key if present, adds it otherwise
     * @param key the key to add/update
     * @param i the row where update or add the key
     * @param s the state to set or to add to the already present
     * @return ADDED or UPDATED if the key is added or updated and NOTFREESPACE
     * if the row was full and anything was done
     * 
     */
    UpdateStatus update_add(unsigned int i,Key& key,T s);

    /*
     * updates a key if present, do nothing otherwise
     * @param key the key to update
     * @param i the row where search the key
     * @param s the state to add to the already present
     * @return true if the key is updated, otherwise false
     */
    bool update(unsigned int i,Key& key,T s);

    /*
     * add a key in a particular row
     * @param key the key to add
     * @param i the row where add the key
     * @param s the state to set
     * @return true if the key is added, otherwise false 
     */
    bool add(unsigned int i,Key& key,T s);

    /*
     * check the presence of a key in a particular row
     * @param key key to check
     * @param i the row where check
     * @return true if the key is present, otherwise false 
     */
    bool check(unsigned int i, Key& key);

    /*
     * remove a key in a particular row
     * @param key key to remove
     * @param i the row where remove the key
     * @return true if the key was removed, otherwise false 
     */
    bool remove(unsigned int i, Key& key);
   
    /*
     * add n rows to the table
     * @param rowstoadd the number of rows to add
     * @return true if new rows were succesfully allocated, otherwise false
     */
    bool grow(unsigned int rowstoadd);
    
    /*
     * remove n rows to the table
     * @param rowstoadd the number of rows to remove
     * @return true if new rows were succesfully removed, otherwise false
     */
    bool reduce(unsigned int rowtorem);
    
    
    /* 
     * move a node with a particular key from one row to another
     * @param from the source row
     * @param to the destination row
     * @param key the key to move
     * @return true if the key has been moved successfully
     */
    bool move(unsigned int from, unsigned int to, Key* key);

    /*
     * get the number of elements in a row
     * @param i the row
     * @return the number of elements
     */
    unsigned int size(unsigned int i )
    { return realcolumnsize[i]; }
    
    /*
     * return the number of free slots in a row
     * @param i the row to be examinated
     * @return number of free slots in the i-th row
     */
    unsigned int freespace(unsigned int i )
    { return columnsize-realcolumnsize[i]; }

    /*
     * print on the standard output all the table
     */
    void print();
    
private:
    unsigned int columnsize;
    unsigned int maxrows;
    std::vector< unsigned int>realcolumnsize;
    std::vector< HashNode<T> *>  nodes;
    

    
};

}

#include<DynamicHashTable.cpp>


#endif	/* DYNAMICHASHTABLE_HPP */

