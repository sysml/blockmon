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

#include "sha1.h"
#include "khash.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

using namespace std;

//
// CONSTRUCTOR
//
khash::khash(int _nhash, int _shash, int _norep) {

	// obvious asserts
    assert(_nhash>=1);
    assert(_shash>=1);
    assert((_norep==0)||(_norep==1));


	// for simplicity, using unsigned as maximum digest size
	// consequence: no more than 31 bits
    assert(_shash<32);

	// assign constants
    nhash = _nhash;
    shash = _shash;
    norep = _norep;
    digest = 0x00000001 << shash;

	// assert that infinite cycle because of insufficient number 
	// of hash will not occur
   assert((norep==1)?(unsigned(nhash) <= (unsigned(1) << shash)):1);

	// allocate output vector - result in [1:nhash]
    res   = new unsigned[nhash+1];
    }





//
// DESTRUCTOR
//
khash::~khash() {
    delete [] res;
    }






//
// MAIN FUNCTION: COMPUTE K DIGEST
//
void khash::compute(unsigned char *in, int len) {
    assert(len>0);
    unsigned    msgdig[5];

	// compute first SHA hash; should be all needed most of the time;
	// more SHA are always needed when shash*nhash>160; more SHA MAY be 
	// needed when no repetition is required... in this case this 
	// depends on the input
    sha.Reset();
    sha.Input(in, len);
    bool outcome = sha.Result(msgdig);
    assert(outcome);

	// copy sha message digest into cache; frequently not needed 
	// and can be optimized out by checking whether this copy 
	// will be needed or not;
    unsigned char md[20];
    copy_sha(msgdig,md);

#ifdef _KHASH_DEBUG 
    fprintf(stderr, "\nDEBUG PRINT - original SHA1\n");
    for(int b=0; b<5; b++) {
	bitprint(msgdig[b], stderr);
    	fprintf(stderr,"\n");
	}
    fprintf(stderr, "            - and its cache copy\n");
    for(int b=1; b<=20; b++) {
	bitprint(md[b-1], stderr);
    	if (b%4==0) fprintf(stderr,"\n");
	}
#endif

	// now cycle on digest to extract khash bits from SHA digest
    int ptr = 0;		
    int k=1;
    while (k<=nhash) {
	int s_blk = ptr / 32;
	int s_bit = ptr % 32;
	res[k] = (msgdig[s_blk] >> s_bit) & bitmask(shash);
	int carry = s_bit + shash - 32;

#ifdef _KHASH_DEBUG 
fprintf(stderr, "DDD k=%d: blk=%d bit=%d carry=%d ",k,s_blk,s_bit,carry);
bitprint(res[k],shash,stderr);
fprintf(stderr, "\n");
#endif

		// compute next sha if needed. Note that this is done 
		// also if carry=0 for subtle reason a bit long to explain
	if ((carry>=0)&&(s_blk==4)) { 
    	    sha.Reset();
    	    sha.Input(md, 20);
    	    bool outcome = sha.Result(msgdig);
    	    assert(outcome);
	    copy_sha(msgdig,md);
	    ptr -= 160; 	// trick to make it fit with what follows
	    s_blk=-1;  		// trick to make it fit with what follows
	    }

		// now conclude computation for res, in the case 
		// computation spans over two digest unsigned blocks
	if (carry>0) {
	    s_blk++;
	    res[k]=res[k]|((msgdig[s_blk] & bitmask(carry)) << (shash-carry));
	    }

		// more forward in the SHA digest domain
	ptr += shash;
	assert((ptr>=0)&&(ptr<=160));

		// finally, if norep flag is set, move to the next res 
		// only if this computed value is NOT repeated;
		// otherwise start next iteration with the same 
		// value k (indeed k-- cancels the next k++)
	if (norep)
	    for(int i=1; i<k; i++) if (res[i]==res[k]) k--;
	k++;
	}
		
		
#ifdef _KHASH_DEBUG 
    fprintf(stderr,"\nDEBUG PRINT - resulting short digests\n");
    for(int k=1; k<=nhash; k++) {
	bitprint(res[k],shash,stderr);
	fprintf(stderr,"\n");
	}
#endif

    }



//
// private function; it receives as input a message digest organized into 
// a vector of 5 unsigned , and copies it into a vector of 20 unsigned char
//
void khash::copy_sha(unsigned* vin, unsigned char* vout) {
	int blk_in=0;
	int blk_out=0;
	unsigned char c;
	while(blk_in<5) {
	    c = (unsigned char)((vin[blk_in] >> (blk_out%4)*8) & 0x000000FF);
	    vout[blk_out] = c;
	    blk_out++;
	    if (blk_out%4 == 0) blk_in++;
	    }
	assert(blk_in==5);
	assert(blk_out == 20);
	}



void khash::bitprint(unsigned t, int upto, FILE* fp) {
	assert((upto>=1) && (upto<=32));
	for(int n=0; n<upto; n++) {
	    if ((n>0)&&(n%8==0)) fprintf(fp," ");
	    if (t&0x00000001) fprintf(fp,"1"); else fprintf(fp,"0");
	    t = t >> 1;
	    }
	fprintf(stderr," ");
	}

void khash::bitprint(unsigned char t, FILE* fp) {
	for(int n=0; n<8; n++) {
	    if (t&0x00000001) fprintf(fp,"1"); else fprintf(fp,"0");
	    t = t >> 1;
	    }
	fprintf(stderr," ");
	}

