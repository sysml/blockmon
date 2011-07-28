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
 * @file    bloomfilter.hpp
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
 * The class represents a bloom filter, implementing all the
 * functions for adding and checking if an element is
 * present in the set.
 * it assumes that true value means bit is set to 1 and false is 0
 */


#ifndef BLOOMFILTER_HPP
#define BLOOMFILTER_HPP

#include "hash/khash.hpp"
#include "hash/sha1.hpp"
#include <vector>
#include <cassert>

namespace bm {

class BLOOMFILTER {

	public:

		/*
		 * this constructor creata a bloom filter which can store a set of bits
		 * addressable with n hash functions, mapping all the set
		 * or a portion
		 * @param _size size (bit) of the bloom filter
		 * @param _nshash number of hash functions to use
		 * @param divide bool flag: if true hash functions map a portion of bitset
		 * 							if false map all the bloomfilter
		 *
		 * 	 _size must be 2^k for some k and
		 * 	 if divide is true also _nhash must be 2^k for some k
		 */
		BLOOMFILTER(unsigned int _size, unsigned int _nhash, bool divide);

		/*
		 * this constructor call the general constructor setting divide to
		 * default value false
		 * @param _size size (bit) of the bloom filter
		 * @param _nshash number of hash functions to use
		 *
		 * _size must be 2^k for some k
		 */
		BLOOMFILTER(unsigned int _size, unsigned int _nhash);

		/*
		 * copy constructor
		 */
		BLOOMFILTER(const BLOOMFILTER& copy);

		BLOOMFILTER& operator=(const BLOOMFILTER&);

		/*
		 * destructor
		 */
		~BLOOMFILTER();

		/*
		 * this method reset the bloom filter (set all the bit to 0)
		 */
		void reset();

		/*
		 * this method insert an element into the bloom filter
		 * @param element pointer to the element to insert
		 * @param len element length
		 */
		void insert(unsigned char* element, int len);

		/*
		 * this method check if an element is present in the bloom filter
		 * @param element pointer to element to check
		 * @param len element length
		 */
		bool isPresent(unsigned char* element, int len);

	private:
		std::vector<bool> bitset;    	//vector of the bits
		unsigned int nhash;				//number of hash function to use
		unsigned int hashsize;			//size (bit) of each hash function
		bool div;						//if true hash maps equal portion of bitset
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
		 * if n=2^k this method returns k
		 */
		unsigned int log2(unsigned int n);

};

}

#endif /* BLOOMFILTER_H_ */
