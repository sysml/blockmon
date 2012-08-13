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

#ifndef _TEWMA_H
#define _TEWMA_H
#include "khash.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

/***********************************************************************************

	TEWMA: implements a smoothed rate meter using a CBF and a timestamp array
	it follows the TEWMA rules
	Time is measured according to a window reference passed in the constructor:
	use _w=1 if you wish to stick to seconds.

	Constructor:
		_nhash		: number of filter hash
		_shash		: digest log size for cbf (e.g.: 6 means 2^6 = 64)
		_beta		: smoothing parameter

 ***********************************************************************************/


class TEWMA : public khash {

	// specific variables for the rmeterfp class
    time_t*	t;		// timestamp array
    double*	c;		// counter array

	// smoothing parameter
    double	beta;
    double	logbeta;

	// time unit (in seconds)
    double	W;

	// variables inherited from khash
	//     	nhash;
	//	shash;


    public:
			// basic functions (constructor, destructor, etc)
		TEWMA(int _nhash, int _shash, double _beta, double _w);
	virtual ~TEWMA();
	void	clear(time_t timestamp_start);
	void	set_beta(double b);

			// core functions: add, check, step
	double 	add(unsigned char *in, int len, double quantity, time_t timestamp);
	double 	check(unsigned char *in, int len, time_t timestamp);

    };

#endif
