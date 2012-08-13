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

#ifndef _USR_APP_NXANALYSIS_BLOCKS_BLOOMFILTER_HPP_
#define _USR_APP_NXANALYSIS_BLOCKS_BLOOMFILTER_HPP_
/**
 * @file
 * @author Hachem
 *

*/

#include<cstring>
#include<stdlib.h>
#include "bloom/sha1.h"

namespace NXAnalyzer{

class BloomFilter
{

        int            			bufferSize;
        int             		numberHash;
        int             		m_numberOnes;
        int             		compareCount;
		int 					arraySize;
        unsigned char *         buffer;
    	SHA1					sha;


    public:
        /**
        * The Constructor of the Bloom filter
        * More to come
        */
        BloomFilter();

        /**
         * Constructor of the bloom filter
         * We get the size and the number of hash function from the XML files
         * @param the size of the bloom filter
         * @param the number of hash functions to use
         */
        BloomFilter(int bS, int nH);

		/**
		 * Destructor
		 */
	    ~BloomFilter();

        /**
         * A function to test if a string belongs to the bloom filter
         * @param the domain name
         * @return true if the bloom filter contains the string, false otherwise
         */
         bool contains(unsigned char *name, int len);

        /**
         * Add a string to the bloom filter
         * @param the domain name
         * @return true if the domain exist, false otherwise
         */
        bool addDomain(unsigned char *name, int len);

        /**
         * The hashing function
         * it is Dumb in this stage
         * will use crypto hashing functions in the future
         * @param the domain name
         * @param the number of the hashing function
         * @return the value of the hashing function
         */
        unsigned*  hashFunction(unsigned char *name, int len);


        /**
         * Compare between two bloom filters
         * @param a pointer to the second bloom filter
         * @return the degree of resemblance between the two bloom filter
         */
        float compare(BloomFilter* bloomFilter);

        /**
         * the fill rate of the bloom filter
         * used to compare between two bloom filters
         * or to test
         * @return the fill rate of the current bloom filter
         */
        float fillrate();

        /**
         * the number of ones in the bloom filter
         * compute it from the buffer directly
         * Usefull in the comparaison and in the computing
         * @return number of ones in the bloom filter
         */
         int numberOnes();

        /**
          * Initialize the bloom filter
          * init the vector and all the integers used different counting operations
          */
        void initBloom();


        /**
         * Get the buffer
         *@return the memory space reserved for the bloom filter
         */
        unsigned char * getBuffer() const; // will probably not be used


        /**
         * Get the number of ones
         * Use onle the integer count
         * @return the value of the count numberOnes
         */
        int getNumberOnes();

        /**
         * The number of ones in the comparaison
         * The compared number of count
         * @return the value of the compute value
         */
        int getNumberComp();
        /** copy bloom filters
         * @param bloom filter to copy
         */
        void copyBloom(BloomFilter* bf);

		/**
		 * merge two bloom filters according to our NX detection
		 * 
		*/
		void merge(BloomFilter* bf);

		/** The defaut size of the bloom filter */
		static const int BUFFER_SIZE = 800;

		/** The Defaut number of the hash functions */
		static const int NUMBER_HASH = 2;
		



};
   

}
#endif // _USR_APP_NXANALYSIS_BLOCKS_BLOOMFILTER_HPP_
