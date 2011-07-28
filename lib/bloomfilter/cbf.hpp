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
 * @file    cbf.hpp
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


#ifndef CBF_HPP
#define CBF_HPP

#include "hash/khash.hpp"
#include "hash/sha1.hpp"
#include <cassert>
#include <climits>

namespace bm {

class CBF {

	public:

		/*
		 * this constructor create a CBF object which can store a set of
		 * unsigned int counters addressable with n hash functions
		 * @param _counters number of counters to store
		 * @param _nhash number of hash functions to use
		 *
		 * _counters must be 2^k for some k
		 */
		CBF(unsigned int _counters, unsigned int _nhash);

		/*
		 * copy constructor
		 */
		CBF(const CBF& b);

		CBF& operator=(const CBF&);

		/*
		 * destructor
		 */
		~CBF();

		/*
		 * this method reset tha CBF setting all counters to 0
		 */
		void reset();

		/*
		 * this method add the element incrementing all the counters
		 * addressed by the hash function
		 * @param in element to add
		 * @param len length of the element to insert
		 *
		 * throw an exception of type unsigned int containing the max value
		 * of the counters UINT_MAX
		 * if a counter has this value before incrementing it
		 * other counters are normally incremented
		 */
		unsigned int add_normal(unsigned char *in, int len);

		/*
		 * this method add amount to the element adding to all
		 * the counters addressed by the hash function
		 * @param in element to add
		 * @param len length of the element to insert
		 * @param amount amount to add
		 *
		 * throw an exception of type unsigned int containing the max value
		 * of the counters UINT_MAX
		 * if a counter has this value before incrementing it
		 * other counters are normally incremented
		 */
		unsigned int add_normal(unsigned char *in, int len,unsigned int amount);

		/*
		 * this method add the element by incrementing only the counter
		 * with min value. if multiple counters has this min value all of these
		 * are incremented
		 * @param in element to add
		 * @param len length of the element to insert
		 *
		 * throw an exception of type unsigned int containing the max value
		 * of the counters UINT_MAX
		 * if the min counter has already this value before incrementing it
		 */
		unsigned int add_conservative(unsigned char *in, int len);

		/*
		 * this method add the element whit "water filling". add amount only
		 * to min counter(obtaining x) and then set the other counters to x only
		 * if they are < x
		 * @param in element to add
		 * @param len length of element to insert
		 * @param amount amount to add to counter
		 *
		 * throw an exception if the amount added cause overflow in the counters
		 * excpetion is type unsigned int containing UINT_MAX
		 * counters are setted to UINT_MAX value
		 */
		unsigned int fill(unsigned char *in, int len, unsigned int amount);

		/*
		 * this method return the min value of the counters indexed by
		 * the element
		 * @param in element to check
		 * @param len length of the element
		 */
		unsigned int get_count(unsigned char *in, int len);

		/*
		 * this method decremnt all the counters. if a counter has
		 * value<amount it is set to 0
		 * @param amount amount of decrement
		 */
		void decrement(unsigned int amount);

	private:
		unsigned int* countset;			//vector of positive values
		unsigned int nhash;				//number of hash function to use
		unsigned int hashsize;			//size (bit) of each hash function
		unsigned int counters;			//number of counters
		SHA1* sha;						//pointer to sha function
		KHASH* khash;					//pointer to khash object

		/*
		 * if n=2^k this method returns k
		 */
		unsigned int log2(unsigned int n);
};

}

#endif /* CBF_H_ */
