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

#include "del_bf.hpp"

namespace bm {

/*
 * CONSTUCTOR
 */
DEL_BF::DEL_BF(unsigned int _counters, unsigned int _size, unsigned int _nhash):
		bitset(std::vector<bool>(_counters*_size, false)),nhash(_nhash),
		hashsize(log2(_counters)),counters(_counters),cntsize(_size),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{
	//ensure that the sizes are positive
	assert((_size>0) && (_nhash>0) && (_counters>0));

	//check if _counters is 2^k for some k
	assert(!(_counters >> (hashsize + 1)));
}

/*
 * COPY CONSTRUCTOR
 */

DEL_BF::DEL_BF(const DEL_BF& copy):
		bitset(copy.bitset),nhash(copy.nhash),hashsize(copy.hashsize),
		counters(copy.counters),cntsize(copy.cntsize),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{

}

DEL_BF& DEL_BF::operator=(const DEL_BF& copy)
{
	if (this!=&copy)
	    {
			bitset = copy.bitset;
	        nhash=copy.nhash;
	        hashsize=copy.hashsize;
	        counters=copy.counters;
	        cntsize=copy.cntsize;
	        sha = new SHA1();
	        khash = new KHASH(sha,nhash,hashsize,false);
	    }
	    return *this;
}

/*
 * DESTRUCTOR
 */
DEL_BF::~DEL_BF() {
	delete sha;
	delete khash;
}

/*
 * GET THE MAX VALUE COUNTABLE
 */
unsigned int DEL_BF::maxcount() {
	return (1<<cntsize)-1;
}

/*
 * RESET THE DEL_BF
 */

void DEL_BF::reset() {
	//clear each element of the bitset
	for(unsigned int i=0; i<bitset.size(); i++)
		clear(i);
}

/*
 * INSERT ELEMENT INTO THE DEL_BF
 */

void DEL_BF::insert(unsigned char* element, int len) {
	//compute the hash function
	khash->compute(element, len);

	//for each hash function, increment the corresponding counter
	for(unsigned int i=0; i<nhash; i++)
		increment(khash->H(i));
}

/*
 * REMOVE AN ELEMENT FROM THE DEL_BF
 */

void DEL_BF::remove(unsigned char* element, int len) {
	//compute the hash function
	khash->compute(element, len);

	//for each hash function, decrement the corresponding counter
	for(unsigned int i=0; i<nhash; i++)
		decrement(khash->H(i));
}

/*
 * CHECK IF AN ELEMENT IS PRESENT INTO THE DEL_BF
 */
bool DEL_BF::isPresent(unsigned char* element, int len) {
	//compute the hash function
	khash->compute(element, len);
	bool present = true;

	//check if element is present
	for(unsigned int i=0; i<nhash; i++) {
		//if one of the counters is not set, element is not present
		if(!isCounted(khash->H(i))) {
			present = false;
			break;
		}
	}
	return present;
}

/*
 * THIS MEHTOD COMPUTE THE LOG2(N)
 */
unsigned int DEL_BF::log2(unsigned int n)
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
