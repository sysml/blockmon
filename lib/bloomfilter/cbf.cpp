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

#include "cbf.hpp"

namespace bm {

/*
 * CONSTUCTOR
 */
CBF::CBF(unsigned int _counters, unsigned int _nhash):
		countset(new unsigned int[_counters]),nhash(_nhash),
		hashsize(log2(_counters)),counters(_counters),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{
	//check if sizes are positives
	assert((_counters > 0) && (_nhash > 0));

	//check if _counters is 2^k for some k
	assert(!(_counters >> (hashsize + 1)));

	//set all the counters to 0
	reset();
}

/*
 * COPY CONSTRUCTOR
 */
CBF::CBF(const CBF& copy):
		countset(new unsigned int[copy.counters]),nhash(copy.nhash),
		hashsize(copy.hashsize),counters(copy.counters),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{
	for(unsigned int i=0;i<counters;i++)
		countset[i] = copy.countset[i];
}

CBF& CBF::operator=(const CBF& copy)
{
	if (this!=&copy)
	{
		countset = new unsigned int[copy.counters];
		nhash=copy.nhash;
		hashsize=copy.hashsize;
		counters=copy.counters;
		sha = new SHA1();
		khash = new KHASH(sha,nhash,hashsize,false);
	}

	for(unsigned int i=0;i<counters;i++)
		countset[i] = copy.countset[i];

	return *this;
}

/*
 * DESTRUCTOR
 */
CBF::~CBF() {
	delete []countset;
	delete sha;
	delete khash;
}

/*
 * SET ALL THE COUNTERS TO 0
 */
void CBF::reset() {
	for(unsigned int i=0;i<counters;i++)
		countset[i] = 0;
}

/*
 * NORMAL ADDING OF AN ELEMENT
 */
unsigned int CBF::add_normal(unsigned char *in, int len) {
	//compute the hash function
	khash->compute(in,len);

	//for each hash function, increment the corresponding counter
	unsigned int  x=UINT_MAX;
	unsigned int k;
	bool exc = false;
	for(unsigned int i=0; i<nhash; i++) {
		k = khash->H(i);
		//if counter has already max value throw exception
		if(countset[k] == UINT_MAX) {
			exc = true;
		}
		else {
			//increment counter and check if it is the min
			countset[k]++;
			if(countset[k] < x)
				x=countset[k];
		}
	}
	//return the min value of the counters or excpetion if overflow
	if(exc)
		throw UINT_MAX;
	else
		return x;

}

/*
 * NORMAL ADDING OF AN ELEMENT WITH A SPECIFIED AMOUNT
 */
unsigned int CBF::add_normal(unsigned char *in, int len,unsigned int amount) {
	//compute the hash function
	khash->compute(in,len);

	//for each hash function, increment the corresponding counter
	unsigned int  x=UINT_MAX;
	unsigned int k;
	bool exc = false;
	for(unsigned int i=0; i<nhash; i++) {
		k = khash->H(i);
		//if counter has already max value throw exception
		if(UINT_MAX - countset[k] < amount) {
			countset[k] = UINT_MAX;
			exc = true;
		}
		else {
			//increment counter and check if it is the min
			countset[k] += amount;
			if(countset[k] < x)
				x=countset[k];
		}
	}
	//return the min value of the counters or exception if overflow
	if(exc)
		throw UINT_MAX;
	else
		return x;

}
/*
 * CONSERVATIVE ADDING OF AN ELEMENT
 */
unsigned int CBF::add_conservative(unsigned char *in, int len) {
	//compute the hash function
	khash->compute(in,len);

	//search the min value for the counters
	unsigned int x = UINT_MAX;
	for(unsigned int i=0; i<nhash; i++)
		if (countset[khash->H(i)]<x)
			x=countset[khash->H(i)];

	//if the min counters has max value throw excpetion
	if (x==UINT_MAX)
		throw UINT_MAX;

	//increment all the counters which have min value
	for(unsigned int i=0; i<nhash; i++)
		if (countset[khash->H(i)]==x)
			countset[khash->H(i)]++;

	//return new value of the counter
	return x+1;
}

/*
 * ADD AN ELEMENT WITH THE WATER FILLING
 */
unsigned int CBF::fill(unsigned char *in, int len, unsigned int amount) {
	//compute the hash function
	khash->compute(in,len);

	//search the min value for the counters
	unsigned int x = UINT_MAX;
	for(unsigned int i=0; i<nhash; i++)
		if (countset[khash->H(i)]<x)
			x=countset[khash->H(i)];

	//increment of amount the min value and set it in every counter
	//that is < of that amount. if amount exceed limit throw exception
	bool exc = false;
	if(UINT_MAX-x >= amount)
		x+=amount;
	else {
		x=UINT_MAX;
		exc=true;
	}
	for(unsigned int i=0; i<nhash; i++)
		if (countset[khash->H(i)]<x)
			countset[khash->H(i)]=x;

	//return new value of the counter
	if(exc)
		throw UINT_MAX;
	else
		return x;
}

/*
 * GET THE COUNTER FOR THE ELEMENT (MIN VALUE)
 */
unsigned int CBF::get_count(unsigned char *in, int len) {
	//compute the hash function
	khash->compute(in,len);

	//search the counter with the min value
	unsigned int x = UINT_MAX;
	for(unsigned int i=0; i<nhash; i++)
		if (countset[khash->H(i)] < x)
			x = countset[khash->H(i)];

	//return the value of the counter
	return x;
}

/*
 * DECREMENT ALL THE COUNTERS OF A SPECIFIC AMOUNT
 */
void CBF::decrement(unsigned int amount) {
	//check if amount is in correct range [0,MAX]
	assert((amount>0)&&(amount<=UINT_MAX));

	// special case -1 done as separate one for efficiency
	if (amount==1) {
		for(unsigned int i=0; i<counters; i++)
			if (countset[i]>0)
				countset[i]--;
	}
	else {
		for(unsigned int i=0; i<counters; i++) {
			if (countset[i]<=amount)
				countset[i]=0;
			else
				countset[i] -= amount;
		}
	}
}

/*
 * THIS MEHTOD COMPUTE THE LOG2(N)
 */
unsigned int CBF::log2(unsigned int n)
{
        unsigned int i=0;
        while(!(n & unsigned(1)) && n)
        {
            n = n >> 1;
            ++i;
        }
        return i;
}

}
