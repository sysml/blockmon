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
#include "bloom.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

using namespace std;

//
// CONSTRUCTOR
//
bloomfilter::bloomfilter(int _nhash, int _shash, int _norep) : 
khash(_nhash, _shash, _norep) {

    assert((shash>=1)&&(shash<=31)); 

	// parameters settings
    mmax     = 0x00000001 << shash;
    mmax_arr = (shash<3) ? 1 : 0x00000001 << (shash-3);
    
	// bit array allocation
    m = new unsigned char[mmax_arr];
    clear();
    }


//
// DESTRUCTOR
//
bloomfilter::~bloomfilter() {
    delete [] m;
    }


//
// CLEAR
//
void bloomfilter::clear() {
    for(unsigned i=0; i<mmax_arr; i++) m[i]=0;
    num_zeros=mmax;
    }


//
// MAIN FUNCTIONS:
//	- INSERT
//	- CHECK
//
bool bloomfilter::insert(unsigned char *in, int len) {
    compute(in,len);
    int extra_ones = 0;
    for(int i=1; i<=nhash; i++) {
	unsigned b = H(i) >> 3;
	assert(b<mmax_arr);
	unsigned char t = (unsigned char)(H(i) & bitmask(3));
	assert(t<8);
	unsigned char bit = 0x01 << t;
	if ((m[b] & bit) == 0) {
	    extra_ones++;
	    m[b] = m[b] | bit;
	    }
	}
    if (extra_ones==0) return 0;
    num_zeros-=extra_ones;
    return 1;
    }

bool bloomfilter::check(unsigned char *in, int len) {
    compute(in,len);
    for(int i=1; i<=nhash; i++) {
	unsigned b = H(i) >> 3;
	assert(b<mmax_arr);
	unsigned char t = (unsigned char)(H(i) & bitmask(3));
	assert(t<8);
	unsigned char bit = 0x01 << t;
	if ((m[b] & bit) == 0) return 0;
	}
    return 1;
    }


void bloomfilter::print(FILE* fp) {
    fprintf(fp,"BF status: %d zeros;",num_zeros);
    for(unsigned i=0; i<mmax_arr; i++) {
	if (i%8 == 0) fprintf(fp,"\n");
	bitprint(m[i], fp);
	}
    fprintf(fp,"\n");
    }
	
    
/***************************************************************************
		TESTING FUNCTION - FEEL FREE TO DELETE ALL THIS
 ***************************************************************************/

void test_bloomfilter2() {
    bloomfilter B(2, 3, 1);
    B.print();

    char* in1 = "abc";
    B.insert((unsigned char*)in1,3);
    B.print();

    char* in2 = "def";
    B.insert((unsigned char*)in2,3);
    B.print();

    int x = B.check((unsigned char*)in2,3);
    printf("check: %d\n", x);
    }

void test_bloomfilter() {
    bloomfilter B(4, 4, 1);
    B.print();

    char* in1 = "abc";
    B.insert((unsigned char*)in1,3);
    B.print();

    char* in2 = "def";
    B.insert((unsigned char*)in2,3);
    B.print();

    int x = B.check((unsigned char*)in2,3);
    printf("check: %d\n", x);
    }

