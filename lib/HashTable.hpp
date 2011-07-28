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
 * @file    HashTable.hpp
 * @author  Fabrizio Nuccilli 
 * @version 1.0
 *
 * @section LICENSE
 *
 *
 * @section DESCRIPTION
 *
 * This class provide an interface for a standard hash table
 * (not the hash functions, only the table)
 * which can be used in objects like the d-left.
 * there is also a template for a generic node and a generic key
 * to hash
 * 
 */

#ifndef HASHTABLE_HPP
#define	HASHTABLE_HPP

#include<cstring>




namespace bm
{

    enum UpdateStatus {NOTFREESPACE,ADDED,UPDATED};

    struct Key {
        /*
         * array key length
         */
        unsigned int keylength;
        /*
         * array where is stored the key
         */
        unsigned char keyvalue[50];
        /*
         * constuctor
         */
        Key():keylength(0)
        {}
        /*
         * constuctor
         * @param val an array with the key
         * @param len array val length
         */
        Key(int len,unsigned char val[]):keylength(len)
        {
            assert(len<50);
            memcpy(keyvalue,val,len);
        }
        /*
         * constuctor
         * @param val an array with the key
         * @param len array val length
         */
        Key(int len,const char*val):keylength(len)
        {assert(len<50);memcpy(keyvalue,val,len);}

        /*
         * copy constructor
         */
        Key(const Key & copy):keylength(copy.keylength)
        {
            memcpy(keyvalue,copy.keyvalue,copy.keylength);
        }

        /*
         * assignment operator
         */
        Key& operator = (const Key & copy)
        {
            
            keylength= copy.keylength;
            
            memcpy(keyvalue,copy.keyvalue,copy.keylength);
            return *this;
        }

        /*
         * equality operator
         */
        inline bool operator==(Key& sec)
        {
            return !memcmp(keyvalue,sec.keyvalue,keylength);
        
        }

    };


template <typename T>
class HashNode
{
    
public:
    
    /*
     * constructor
     * @param up the function to update a state
     * @param cl the function to reset a state
     */
    HashNode(void (*up)(T&,T&)=NULL, void (*cl)(T&)=NULL):key(Key()),state (T()),update(up),clear(cl){}
    
    /*
     * constructor
     * @param k the key of the node
     * @param s the state of the node
     * @param up the function to update a state
     * @param cl the function to reset a state
     */
    HashNode(Key k, T s, void (*up)(T&,T&), void (*cl)(T&)):key(k),state(s),update(up),clear(cl) {}

    /*
     * copy constructor
     */
    HashNode(const HashNode<T>& copy):key(copy.key),state(copy.state),update(copy.update),clear(copy.clear){}

    /*
     * destructor
     */
    ~HashNode()
    {reset();}

    /*
     * assignment operator
     */
    HashNode<T>& operator = (const HashNode<T> & copy)
    {
        key=copy.key;
        state=copy.state;
        update=copy.update;
        clear=copy.clear;
        return *this;
    }
    
    /*
     * @return the node key 
     */
    Key& getKey()
    {
        return key;
    }

    /*
     * @return the state node
     */
    T& getState()
    {
        return state;
    }

    /*
     * @param s is the new state of the node
     */
    void setState(T s)
    {
        state=s;
    }

    /*
     * the new state will be up(oldstate, s)
     * @param s the state to merge with the oldstate
     */
    void updateState(T s)
    {
        update(state,s);
    }

    /*
     * @param n is the new key of the state
     */
    void setKey(Key& n)
    {
        key=n;
    }

    /*
     * reset the node
     */
    void reset()
    {
        key.keylength=0;
        clear(state);
    }

    /*
     * @return true if there is a state and a key associaed with this node
     */
    bool isSet()
    {
        if(key.keylength==0)
            return false;
        return true;
    }
    
private:
    Key key;
    T state;
    void (*update) (T&,T&);
    void (*clear) (T&);

};

    template < typename T>
class HashTable
{
    
protected:
    
    unsigned int hashsize;
    HashTable(unsigned int s):hashsize(s){}
    

public:

    virtual ~HashTable(){}
    
    virtual T* get(unsigned int i,Key& key)=0;

    virtual UpdateStatus update_add(unsigned int i,Key& key,T s)=0;

    virtual bool update(unsigned int i,Key& key,T s)=0;

    virtual bool add(unsigned int i,Key& key,T s)=0;

    virtual bool remove(unsigned int i, Key& key)=0;

    virtual bool check(unsigned int i, Key& key)=0;
    
    virtual unsigned int size(unsigned int i )=0;
    
    virtual void print()=0;

    unsigned int size()
    { return size;}


};



}


#endif	/* HASHTABLE_HPP */

