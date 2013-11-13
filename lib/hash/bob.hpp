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
 * @file    bob.hpp
 * @author  Fabrizio Nuccilli
 * @version 1.0
 *
 * @section LICENSE
 *
 *
 * @section DESCRIPTION
 *
 * The class represents the BOB function
 *
 */


#ifndef BOB_HPP
#define	BOB_HPP
#define dgstlenbob 4
#define INITNUMB 0xf1ea5eed //ratio init number

#include"hash.hpp"


namespace blockmon {

class BOB : public HASH
{
    

public:

    BOB():HASH(dgstlenbob){}

    ~BOB(){}

    /*
     * this method compute the digest of a key
     * @param key is the key that is to be hashed
     * @param len is the key length
     * @param output is the array where the message digest is stored
     */
    void compute(const unsigned char key[], int len, unsigned char output[]) ;

    /*
     * this method hashes a file
     * @param filepath the file path
     * @param output is the array where the message digest is stored
     */
    void computeFile(const char *filepath, unsigned char output[]) ;

    /*
     * this method implements a simple way to hash a key and a message
     * output = H(KEY||MESSAGE) with || concatenation
     * Attention: this is not implemented as HMAC because BOB
     * is not a cryptographic hash function
     * @param key is the key
     * @param keylen is the key length
     * @param input is the original message
     * @param ilen is the length of the original message
     * @param output is the array where the message digest is stored
     */
    void compute(const unsigned char *key, int keylen, const unsigned char *input, int ilen,
                unsigned char output[]) ;

};

}


#endif	/* BOB_HPP */

