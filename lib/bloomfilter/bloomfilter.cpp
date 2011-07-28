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

#include "bloomfilter.hpp"

namespace bm {

/*
 * CONSTRUCTOR
 */
BLOOMFILTER::BLOOMFILTER(unsigned int _size, unsigned int _nhash, bool divide):
	bitset(std::vector<bool>(_size, false)),nhash(_nhash),
	hashsize(log2(_size)),div(divide),sha(new SHA1())
{
	//Ensure that sizes passed are positive
	assert((_size>0) && (_nhash>0));

	//check if _size is 2^k for some k
	assert(!(_size >> (hashsize + 1)));

	//if div is true check if _nhash is 2^k for some k

	if(div) {
		unsigned int j = log2(_nhash);
		assert(!(_nhash >> (j + 1)));
		hashsize -=j;
	}

	khash = new KHASH(sha, nhash, hashsize, false);
}

/*
 * CONSTRUCTOR WITH TWO PARAMETERS: SET DIVIDE TO FALSE
 */
BLOOMFILTER::BLOOMFILTER(unsigned int _size, unsigned int _nhash):
	bitset(std::vector<bool>(_size, false)),nhash(_nhash),
	hashsize(log2(_size)),div(false),sha(new SHA1()),
	khash(new KHASH(sha,nhash,hashsize,false))
{
	//Ensure that sizes passed are positive
	assert((_size>0) && (_nhash>0));

	//check if _size is 2^k for some k
	assert(!(_size >> (hashsize + 1)));
}
/*
 * COPY CONSTRUCTOR
 */
BLOOMFILTER::BLOOMFILTER(const BLOOMFILTER& copy):
		bitset(copy.bitset),nhash(copy.nhash),hashsize(copy.hashsize),
		div(copy.div),sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{

}

BLOOMFILTER& BLOOMFILTER::operator=(const BLOOMFILTER& copy)
{
	if (this!=&copy)
	    {
			bitset = copy.bitset;
	        nhash=copy.nhash;
	        hashsize=copy.hashsize;
	        div=copy.div;
	        sha = new SHA1();
	        khash = new KHASH(sha,nhash,hashsize,false);
	    }
	    return *this;
}

/*
 * DESTRUCTOR
 */
BLOOMFILTER::~BLOOMFILTER() {
	delete sha;
	delete khash;
}

/*
 * RESET THE BLOOM FILTER
 */
void BLOOMFILTER::reset() {
	//clear each element of the bitset
	for(unsigned int i=0; i<bitset.size(); i++)
		clear(i);
}

/*
 * INSERT AN ELEMENT INTO THE BLOOM FILTER
 */
void BLOOMFILTER::insert(unsigned char* element, int len) {
	//compute the hash function
	khash->compute(element, len);

	//for each hash function, set the corresponding bit
	if(div)
		for(unsigned int i=0; i<nhash; i++)
			set(i*(1 << hashsize) + khash->H(i));
	else
		for(unsigned int i=0; i<nhash; i++)
			set(khash->H(i));
}

/*
 * CHECK IF AN ELEMENT IS PRESENT INTO THE BLOOM FILTER
 */
bool BLOOMFILTER::isPresent(unsigned char* element, int len) {
	//compute the hash function
	khash->compute(element, len);
	bool present = true;

	//check if element is present
	if(div)
		for(unsigned int i=0; i<nhash; i++) {
			//if one of the bits is not set, element is not present
			if(!isSet(i*(1 << hashsize) + khash->H(i))) {
				present = false;
				break;
			}
		}
	else
		for(unsigned int i=0; i<nhash; i++) {
			if(!isSet(khash->H(i))) {
				present = false;
				break;
			}
		}

	return present;
}

/*
 * THIS MEHTOD COMPUTE THE LOG2(N)
 */
unsigned int BLOOMFILTER::log2(unsigned int n)
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
