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

#include "khash.h"
#include "tewma.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <assert.h>
#include <memory.h>
using namespace std;


/************************************************************************
	CONSTRUCTOR, DESTRUCTOR, ELEMENTARY FUNCTIONS
 ************************************************************************/
TEWMA::TEWMA(int _nhash, int _shash, double _beta, double _w) 
: khash(_nhash, _shash, 1) {
		c = new double[maxdigest()];
		t = new time_t[maxdigest()];
		assert(_w>0);
		W=_w;
		set_beta(_beta);
		clear(0);
    }

TEWMA::~TEWMA() {
    delete [] c;
    delete [] t;
    }

void TEWMA::clear(time_t timestamp_start) {
	memset(c, 0, maxdigest()*sizeof(double));
	for(uint i=0; i<maxdigest(); i++) {
    	t[i]=timestamp_start;
	}
}

void TEWMA::set_beta(double b) {
    assert((b>0)&&(b<1));
    beta=b;
    logbeta = -log(beta);
    }


/************************************************************************
	CORE FUNCTIONS
 ************************************************************************/

double TEWMA::add(unsigned char *in, int len, double quantity, time_t timestamp) {

	// first compute the hash functions via khash
    compute(in,len);

	// computes the new counter decayed value
    double minctr=c[H(1)];
    double deltat;
    for(int i=1; i<=nhash; i++) {
	deltat = difftime(timestamp, t[H(i)])/W;
	t[H(i)] = timestamp;
	assert(deltat>=0);
	c[H(i)] *= pow(beta, deltat);
	if (c[H(i)]<minctr) minctr=c[H(i)];
	}

	// now compute the new value including the insertion and update 
	// the filter by waterfilling the new counter array bins
    double newctr=minctr+quantity*logbeta;
    assert(newctr<=1.0e99);
    for(int i=1; i<=nhash; i++) if (c[H(i)]<newctr) c[H(i)]=newctr;

	// finally return value. 
    return newctr;
    }


double TEWMA::check(unsigned char *in, int len, time_t timestamp) {

	// Same steps as in add, but without insertion
	// first compute the hash functions via khash
    compute(in,len);

	// now computes the old accumulated value and the new one before this insertion
    double minctr=c[H(1)];
    double deltat;
    for(int i=1; i<=nhash; i++) {
	deltat = difftime(timestamp, t[H(i)])/W;
	t[H(i)] = timestamp;
	assert(deltat>=0);
	c[H(i)] *= pow(beta, deltat);
	if (c[H(i)]<minctr) minctr=c[H(i)];
	}

	// finally return value. 
    return minctr;
    }

