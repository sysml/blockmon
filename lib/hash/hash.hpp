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
 * @file    hash.hpp
 * @author  Fabrizio Nuccilli 
 * @version 1.0
 *
 * @section LICENSE
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details at
 * http://www.gnu.org/copyleft/gpl.html
 *
 * @section DESCRIPTION
 *
 * The class represents an abstract hash function
 * 
 */


#ifndef HASH_HPP
#define	HASH_HPP

namespace blockmon {

class HASH {

public:

    /*
     * this constructor can not be called because HASH is an abstract class
     * but it is used by sub-classes
     * @param m is the message digest lenght of the hash
     */
    HASH(unsigned int m):msgdigestlen(m){}
    virtual ~HASH(){};
    
    /*
     * a simple get method
     * @return the digest length
     */
    unsigned int getDigestLength(){return msgdigestlen;}
    
    /*
     * this method compute the digest of a key
     * @param key is the key that is to be hashed
     * @param len is the key length
     * @param output is the array where the message digest is stored 
     */
    virtual void compute(const unsigned char key[], int len, unsigned char output[])=0;
    
    /*
     * this method hashes a file
     * @param filepath the file path
     * @param output is the array where the message digest is stored 
     */
    virtual void computeFile(const char *filepath, unsigned char output[])=0;
    
    /*
     * HMAC
     * this method implements a message authentication code (MAC) 
     * involving an hash function in combination with a secret key
     * @param key is the key 
     * @param keylen is the key length
     * @param input is the original message
     * @param ilen is the length of the original message
     * @param output is the array where the message digest is stored 
     */
    virtual void compute(const unsigned char *key, int keylen, const unsigned char *input, int ilen,
                unsigned char output[])=0;

private:
    unsigned int msgdigestlen;

};

}
#endif	/* HASH_HPP */

