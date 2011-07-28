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

/*
 * @file    DEL_BF.hpp
 * @author  Tiziano Campili
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
 * The class represents a counting bloom filter, implementing all the
 * functions for adding, removing and checking if an element is
 * present in the set.
 * it assumes that true value means bit is set to 1 and false is 0
 */



#ifndef DEL_BF_HPP
#define DEL_BF_HPP

#include "hash/khash.hpp"
#include "hash/sha1.hpp"
#include <vector>
#include <cassert>

namespace bm {

class DEL_BF {

	public:

	 	 /*
		 * this constructor create a DEL_BF object which can store a set of counters
		 * addressable with n hash functions
		 * @param _counters number of counters to store
		 * @parma _size number of bits of each counters
		 * @param _nhash number of hash functions to use
		 *
		 * _counters must be 2^k for some k
		 */
		DEL_BF(unsigned int _counters, unsigned int _size, unsigned int _nhash);

		/*
		 *copy constructor
		 */
		DEL_BF(const DEL_BF& b);

		DEL_BF& operator=(const DEL_BF&);

		/*
		 * destructor
		 */
		~DEL_BF();

		/*
		 * this method returns the max value that can contain a counter
		 */
		unsigned int maxcount();

		/*
		 * this method reset the DEL_BF (set all the counters to 0)
		 */
		void reset();

		/*
		 * this method insert an element into the DEL_BF
		 * @param element pointer to the element to insert
		 * @param len element length
		 *
		 * throw an exception of type int containing the max value
		 * of the counters (2^cntsize)-1
		 * if a counter has max value before incrementing it(overflow)
		 */
		void insert(unsigned char* element, int len);

		/*
		 * this method remove an element from the DEL_BF
		 * @param element pointer to the element to remove
		 * @param len element length
		 *
		 * throw an exception of type int containing 0
		 * if a counter has value 0 before decrementing it
		 */
		void remove(unsigned char* element, int len);

		/*
		 * this method check if an element is present in the DEL_BF
		 * @param element pointer to element to check
		 * @param len element length
		 */
		bool isPresent(unsigned char* element, int len);

	private:
		std::vector<bool> bitset;		//vector of bits
		unsigned int nhash;				//number of hash function to use
		unsigned int hashsize;			//size (bit) of each hash function
		unsigned int counters;			//number of counters
		unsigned int cntsize;			//size (bit) of each counter
		SHA1* sha;						//pointer to sha function
		KHASH* khash;					//pointer to khash object

		/*
		 * set the bit (=1)
		 * @param pos bit to set
		 */
		inline void set(unsigned int pos) {
			assert(pos<bitset.size());
			bitset[pos] = true;
		}

		/*
		 * clear the bit (=0)
		 * @param pos bit to clear
		 */
		inline void clear(unsigned int pos) {
			assert(pos<bitset.size());
			bitset[pos] = false;
		}

		/*
		 * check if a bit is set (if it has value true)
		 * @param pos bit to check
		 */
		inline bool isSet(unsigned int pos) const {
			assert(pos<bitset.size());
			return bitset[pos];
		}

		/*
		 * this method increment a counter
		 * @param cnt counter to increment
		 */
		void increment(unsigned int cnt) {
			unsigned int i=0;
			bool over = true;
			while(over && i<cntsize) {
				if(!isSet(cnt*cntsize +i))
					over = false;
				else
					i++;
			}
			if(!over) {
				for(i=0; i<cntsize;i++) {
					if(isSet(cnt*cntsize +i))
						clear(cnt*cntsize +i);
					else {
						set(cnt*cntsize +i);
						break;
					}
				}
			}
			else
				throw maxcount();
		}

		/*
		 * this method decrement a counter
		 * @param cnt counter to decrement
		 */
		void decrement(unsigned int cnt) {
			unsigned int i=0;
			bool over = true;
			while(over && i<cntsize) {
				if(isSet(cnt*cntsize +i))
					over = false;
				else
					i++;
			}
			if(!over) {
				for(unsigned int i=0; i<cntsize;i++) {
					if(!isSet(cnt*cntsize +i))
						set(cnt*cntsize +i);
					else {
						clear(cnt*cntsize +i);
						break;
					}
				}
			}
			else throw 0;
		}

		/*
		 * check if a counter is > 0
		 * @param cnt counter to check
		 */
		bool isCounted(unsigned int cnt) {
			bool present = false;
			for(unsigned int i=0;i<cntsize;i++) {
				if(isSet(cnt*cntsize +i)) {
					present = true;
					break;
				}
			}
			return present;
		}

        /*
         * if n=2^k this method returns k
         */
		unsigned int log2(unsigned int n);

};

}


#endif /* DEL_BF_H_ */
