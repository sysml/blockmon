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

#include "ClientList.hpp"

namespace NXAnalyzer{




ClientList::ClientList():
 number_clients(0){
	bloomFilter = new BloomFilter();
}

ClientList::ClientList(Client* client):
number_clients(1){
	bloomFilter = new BloomFilter();
    map.insert(unordered_map::value_type(client->getName(), client));
    bloomFilter->copyBloom(client->bloomfilter);
}

ClientList::ClientList(int bufferSize, int numHash):
 number_clients(0){
	bloomFilter = new BloomFilter(bufferSize, numHash);
 }

Client* ClientList::retrive(uint32_t sip4, uint64_t timestamp){
	unordered_map::iterator map_it;
	map_it = map.find(sip4);
    Client* client;
    if (map_it == map.end()){
        return NULL;
    }
	client = map_it->second;
	return client;

}



void ClientList::putClient(Client* client){
    map.insert(std::make_pair(client->getName(), client));
	
    number_clients++;
}


Client* ClientList::removeClient(Client* client){
    map.erase(client->getName());
    return client;
}

bool ClientList::contains(Client* client){
    if(map.find(client->getName()) == map.end()){
        return false;
    }
    return true;
}


bool ClientList::contains(uint32_t IP){
  if(map.find(IP) == map.end()){
        return false;
    }
    return true;
}

Client* ClientList::get(uint32_t IP){
    if(map.find(IP) == map.end()){
        return NULL;
    }
    return map.find(IP)->second;
}

int ClientList::size(){
    return (int)map.size();

}

void ClientList::clear(){

    map.clear();
	bloomFilter->initBloom();
}

Client* ClientList::getclient(int i){
	if((i < 0)||(i>=(int)map.size()))
		return NULL;
	unordered_map::iterator map_it;

	for(map_it=map.begin(); map_it != map.end(); map_it++){
		if (i==0)
			return map_it->second;
		
		i--;
	}
	return NULL;
}

ClientList::~ClientList()
{
    map.clear();
	delete bloomFilter;
}
}
