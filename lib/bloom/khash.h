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

#ifndef _KHASH_H
#define _KHASH_H
#include "sha1.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string>

using namespace std;

/*****************************************************************************

			C L A S S   K H A S H

 specifies a generic multiple hash computator, using SHA1 as underlying hash
 function.

 khash uses, and exports to derived classes, the following parameters:
	
	int		nhash: 	number of hash functions, 1+, integer

	int		shash: 	size in bit of each hash digest, 1-31

	unsigned int 	digest:	size of each digest, being digest = 2^shash

 *****************************************************************************/
 

class khash {

    protected:
    	int 		nhash;		// number of hash functions
    	int 		shash;		// size (bit) of each hash digest
    	unsigned int 	digest;		// size of the digest: 1..digest

    private:
    	unsigned*	res;		// output vector of digests [1:nhash]
    	int		norep;		// flag: 1= repeat digest NOT possible
    	SHA1		sha;

    public:	// public methods

		    khash(int _nhash, int _shash, int _norep = 0);

		    ~khash();

	void	    compute(unsigned char *in, int len);
	void	    compute(string s);

	unsigned    H(int k) {
			assert((k>=1)&&(k<=nhash)); 
			return res[k]; 
			};

	unsigned int maxdigest() {return digest;}

    

    protected: 	// protected methods

	unsigned    bitmask(int bit) {
    			assert((bit>=0)&&(bit<=32));
			if (bit==0) return 0x00000000;
			else if (bit==32) return 0xFFFFFFFF;
			else return ((unsigned(1) << bit) - 1) & 0xFFFFFFFF;
    			};


	void	    bitprint(unsigned char t, FILE* fp = stderr);

    private: 	// private methods

	void	    copy_sha(unsigned *vin, unsigned char* vous);

	void	    bitprint(unsigned t, int upto, FILE* fp = stderr);

	void	    bitprint(unsigned t, FILE* fp = stderr) {
				bitprint(t, 32,fp);
			   	}

    };

#endif
