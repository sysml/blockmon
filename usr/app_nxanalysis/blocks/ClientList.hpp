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

#ifndef _USR_APP_NXANALYSIS_BLOCKS_CLIENTLIST_HPP_
#define _USR_APP_NXANALYSIS_BLOCKS_CLIENTLIST_HPP_
/**
 * @file
 * @author Hachem
 * Will use the map provided by the boost library
 */

#include "Client.hpp"
#include "BloomFilter.hpp"
#include <unordered_map>
#include <boost/unordered_map.hpp>
#include <iostream>
#include<netinet/in.h>


namespace NXAnalyzer{

class ClientList
{
	int number_clients;
	typedef boost::unordered_map<uint32_t, Client*> unordered_map;
	unordered_map map;
    
	public:
		
        /** The constructor of the client list
         */
        ClientList();
		
		/**
		 * Constructor 
		 *@param the sizeof the bloom filter
		 *@param number of hash function
		 */
		ClientList(int bufferSize, int numHash);
        /** Second constructor of the clientlist
         * @param the client to construct the list with
         */
        ClientList(Client* client);
		
		/**
		 * Destructor
		 */
		~ClientList();

        /** Retrive the client object associated to an ip address
         * If the client doesn't exist, create it before
         * @param IP address of the client
         * @param timestamp of the creation of the client object
         * @return Client
         */
		Client* retrive(uint32_t sip4, uint64_t timestamp);


        /** add a new client in the list
         * @param client ot insert
         */
        void putClient(Client* client);




        /** Remove a client object from the list
         * @param client to remove
         * @return removed client, null if the object doesn't exist
         */
        Client* removeClient(Client* client);

        /** test if the client is contained in the list
         * @param client
         * @return true if it contains, false otherwise
         */
        bool contains(Client* client);



        /** test if the client is contained in the list
         * @param IP address
         * @return true if it contains, false otherwise
         */
        bool contains(uint32_t IP);

        /** retrieve a client object associated with an IP addresse
         * @param IP address of the client
         * @return the client object, null if it doesn't exist
         */
        Client* get(uint32_t IP);

        /** get the current size of the client list
         * @return the number of clients in the list
         */
        int size();

        /** get the client i in the client list
		 * @param the position of the client in the list
         * @return the client 
         */
		Client* getclient(int i);

        /** clear the list from clients
         *
         */
        void clear();

        BloomFilter* bloomFilter;



};

}
#endif // _USR_APP_NXANALYSIS_BLOCKS_CLIENTLIST_HPP_
