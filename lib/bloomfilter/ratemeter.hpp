
/*
 * @file    ratemeter.hpp
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
 * WITThis class represents a topk element, used for mantain a list of
 * k top element inserted. It use a counting bloom filter for mantain
 * the counters and an array of struct to mantain the top k.
 * The struct, named flow, contain the value of counter, the name of the flow,
 * and the length of this name.HOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details at
 * http://www.gnu.org/copyleft/gpl.html
 *
 * @section DESCRIPTION
 *
 * This class  represent a rate meter element. it can estimate the rate
 * usig a particulare implementation of a floating point cbf.
 * it also have a smoothing parameter alpha.
 *
 */


#ifndef RATEMETER_H_
#define RATEMETER_H_

#include"hash/khash.hpp"
#include"hash/sha1.hpp"
#include<cstdio>
#include<cstdlib>
#include<cassert>
#include<cmath>


namespace bm {

class RATEMETER {

    public:

		/*
		 * this constructor create a RATEMETER object.
		 * @param _nhash number of hash functions to use
		 * @param _shash size of hash digest (e.g.: 6 means 2^6 = 64)
		 * @param alpha smoothing parameter
		 */
		RATEMETER(uint _nhash, uint _shash, double _alpha);

		/*
		 * copy constructor
		 */
		RATEMETER(const RATEMETER& t);

		RATEMETER& operator=(const RATEMETER&);

		/*
		 * destructor
		 */
		~RATEMETER();

		/*
		 * this method clears the rate meter, setting all the value to 0
		 */
		void clear();

		/*
		 * this method set parameter alpha
		 */
		void set_alpha(double a);

		/*
		 * this method add the quantity specified to element in,using water
		 * filling procedure
		 * @param in element to add
		 * @param len length of in
		 * @param quantity amount to add to in
		 * @param slot_perc percentage of the current slot
		 * @return new value of the couter
		 */
		double add(unsigned char *in, int len, double quantity, double slot_perc);

		/*
		 * this method update the rate meter, updating the values with
		 * percentage alpha and setting news and olds values to same value,
		 * initializing a new temporal slot
		 */
		void step();

		/*
		 * this method is similar to add(). return the value of the counter
		 * without updating it
		 * @param in element to add
		 * @param len length of in
		 * @param slot_perc percentage of the current slot
		 * @return value of the couNter
		 */
		double check(unsigned char *in, int len, double slot_perc);

    private:
		unsigned int nhash;		//number of hash function to use
		unsigned int hashsize;	//size (bit) of each hash function
		unsigned int counters;	//number of counters
		double	alpha;			// smoothing parameter
		double*	c_new;			// being updated counter array
		double*	c_old;			// last sampled counter array
		SHA1* sha;				//pointer to sha function
		KHASH* khash;			//pointer to khash object
};

}

#endif /* RATEMETER_H_ */
