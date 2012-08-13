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

#include "bloompair.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

using namespace std;

//
// CONSTRUCTOR
//
BloomPair::BloomPair(int _nhash, int _shash) {
	
	// contruct the two bloom filters
    B_learning = new bloomfilter(_nhash, _shash, 1);
    B_detecting = new bloomfilter(_nhash, _shash, 1);

	// and set the basic parameters and initial threshold
    m = B_learning->maxdigest();
    assert(m==B_learning->get_nzero());
    threshold = double(m)/sqrt(2.0);
    }

BloomPair::~BloomPair() {
    delete B_learning;
    delete B_detecting;
    }


void BloomPair::clear() {
    B_learning->clear();
    B_detecting->clear();
    threshold = double(m)/sqrt(2.0);
    }
	

bool BloomPair::add(unsigned char *in, int len) {
	// update filters
    bool res_l = B_learning->insert(in, len);
    bool res_d = B_detecting->insert(in, len);
    assert((res_d==false)||((res_d==true)&&(res_l==true)));
    double dd = double(B_detecting->get_nzero());
    double dl = double(B_learning->get_nzero());

	// eventually swap
    if (dl<threshold) { 
	bloomfilter *b;
        b = B_detecting;
        B_detecting = B_learning;
        B_learning = b;
	B_learning->clear();
	threshold = threshold * sqrt(double(m)/2/dd);
	}

	// debug / plot print
/*
    fprintf(fp,"%.0f ", dl);
    fprintf(fp,"%.0f ", dd);
    fprintf(fp,"%.0f ", threshold);
    char t = in[0];
    if (t=='R') fprintf(fp, "%d ", (res_d==true)?10:0);
    if (t=='V') fprintf(fp, "%d ", (res_d==false)?-10:0);
    fprintf(fp,"%s ", in);
    //fprintf(fp,"%s ", (res_l==true)?"LRN-Y":"LRN-N");
    //fprintf(fp,"%s ", (res_d==true)?"DET-Y":"DET-N");
    fprintf(fp,"\n");
*/

    return res_d;
    }
