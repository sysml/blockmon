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

#ifndef _USR_APP_NXANALYSIS_BLOCKS_CLIENT_HPP_
#define _USR_APP_NXANALYSIS_BLOCKS_CLIENT_HPP_
/**
 * @file
 * @author Hachem
 */


#include "BloomFilter.hpp"
#include <stdlib.h>
#include<cstdio>
#include<netinet/in.h>
#include "NetTypes.hpp"
#include <iostream>
#include <chrono>

namespace NXAnalyzer{

class Client
{
        uint32_t name;
		int smartCounter;
        int requestCounter;
        uint64_t time_stamp;
        int uid;
        static int clientCounter;

    public:
		
		/** constructor of the Client class
         *
         *@param the ip address of the client
         *@param the timestamp of the creation of the object
         */
        Client(uint32_t sip4, uint64_t timestamp);

		/** Constructor
         *
         *@param the ip address of the client
         *@param the timestamp of the creation of the object
		 *@param the size of the bloom filter buffer in bits
		 *@param the number of hash function to use
         */
		Client(uint32_t sip4,uint64_t timestamp, int bufferSize, int numHash);

		/**
		 * Destructor
		 */
        ~Client();

        /** insert the requested domain names in the client's bloom filter
         * @param domain names
         */
        void hit(unsigned char* domain, int len);


        /** clear the different elements of the client
         */
        void clear();

        /** get the current the timestamp of the client
         * @return the client timestamp
        */
        uint64_t getTimestamp();

        /** to initialize the different fields of the client
         */
        void initClient();

        /** get the approximate value of the nuber of different domain names in the bloom filter
         * @return number of requested domain name
         */
        int getSmartCounter();

        /** get the ip address of the client
         * @return IP address of the client
         */
        uint32_t getName();





        BloomFilter* bloomfilter;




};
}
#endif // _USR_APP_NXANALYSIS_BLOCKS_CLIENT_HPP_
