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
 * <blockinfo type="DNSPacketNR" scheduling_type="passive" thread_exclusive="False">
 *   <humandesc>
 *     Identify Malicious domain names 
 *     The block takes as input DNS NORREROR answers packets and the ip adresses of the communities of the infected users
 *     The block sends the malicious domain name 
 *   </humandesc>
 *
 *   <shortdesc>Identify Malicious domain names  </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="inpkt" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="input" name="inalert" msg_type="Alert" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element infection_threshold {
 *        attribute value {xsd:float}
 *      }
 *      element Buffer_Size {
 *        attribute value {xsd:integer}
 *      }
 *      element number_Hash {
 *        attribute value {xsd:integer}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *        <infection_threshold value="0.8">
 *        <Buffer_Size value="1200">
 *        <number_Hash value="2">
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="pktcnt" human_desc="integer" access="read"/>
 *     <variable name="detected" human_desc="integer" access="read"/>
 *     <variable name="reset" human_desc="write 1 to reset" access="write"/>
 *   </variables>
 *
 * </blockinfo>
 */
#include<Block.hpp>
#include<BlockFactory.hpp>
#include<cstdio>
#include<Packet.hpp>
#include<netinet/in.h>
#include <iostream>
#include <string>
#include <cstring>
#include <iomanip>
#include <vector>
#include <Alert.hpp>


#include "NetTypes.hpp"
#include "ClientList.hpp"
#include "dnsh.h"

using namespace std;

#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is no more compliant with NewPacket class
//       Reason: the packet is no more linear in memory.
//       TO BE REWRITTEN!


using namespace NXAnalyzer;
namespace blockmon
{

    /**
     * Implements a block that receives noerror dns answers and the ipdresses of communities of infected users
	 * to detect the domain name of a milicious domain name
     */
    class DNSPacketNR: public Block
    {
        unsigned long long  m_count;
		unsigned int m_detected;
		float f_infected_thres;
		int m_listcount;
		int bufferSize;
		int numHash;
        int m_ingate_id;
		int m_ingate_id2;
        unsigned int m_reset;
		ClientList* infectedList;
		typedef boost::unordered_map<uint32_t , int> unordered_map;
		unordered_map map;
		typedef boost::unordered_map<int , ClientList*> unordered_mapp;
		unordered_mapp mapp;
		typedef boost::unordered_map<string , string> unordered_map3;
		unordered_map3 map_detected;


    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        DNSPacketNR(const std::string &name, invocation_type invocation) 
        : Block(name, invocation), 
		m_count(0), 
		m_detected(0),
		f_infected_thres(0.7),
		m_listcount(0),
		bufferSize(1600),
		numHash(2),
        m_ingate_id(register_input_gate("inpkt")),
        m_ingate_id2(register_input_gate("inalert")),
        m_reset(0)
        {
            register_variable("pktcnt",make_rd_var(no_mutex_t(), m_count));
            register_variable("detected",make_rd_var(no_mutex_t(), m_detected));
            register_variable("reset",make_wr_var(no_mutex_t(), m_reset));
			infectedList = new ClientList();
        }
		DNSPacketNR(const DNSPacketNR &)=delete;
        DNSPacketNR& operator=(const DNSPacketNR &) = delete;
        DNSPacketNR(DNSPacketNR &&)=delete;
        DNSPacketNR& operator=(DNSPacketNR &&) = delete;

        /**
         * @brief Destructor
         */
        ~DNSPacketNR()  {
			delete infectedList;
		}
		
		/**
         * @brief reads the domain name
		 * @param dnsqname a pointer to QNAME
		 * @param length of the domain name
		 * @return a pointer to the domain name
         */
		/**
         * @brief reads the domain name
		 * @param dnsqname a pointer to QNAME
		 * @param len length of the domain name
		 * @param ntld the length of tld		 
		 * @return the domain name with lowercase 
         */			
		unsigned char * getName(unsigned char* dnsqname, int& len, int& ntld){
			unsigned char *current;
			unsigned int i=0, j;
			bool begin=false;
			unsigned char counter;
			while(dnsqname[i] != 0){ 
				i+=dnsqname[i]+1;
			}
			len=i-1;
			ntld = i-1;
			current = new unsigned char[i];
			counter = dnsqname[0];
			for(j=1; j< i; j++){
				if(begin){
					begin = false;
					current[j-1] = '.';
					counter = dnsqname[j];
					ntld = counter;
				}else{
					if(dnsqname[j] < 40){
						return NULL;
					}
					if((dnsqname[j] < 91)&&(dnsqname[j] > 64)){
						current[j-1] = dnsqname[j] + 32;
					} else {
						current[j-1] = dnsqname[j];
					}
					counter--;
					if(counter == 0)
						begin=true;
				}

			}
			current[j-1] = '\0';
			return current;
		}		

		
        /**
         * @brief Configures the block, in this case the export time is hard-coded
         * to 0.5 seconds
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n ) 
        {

        	pugi::xml_node infection_threshold = n.child("infection_threshold");
            if(infection_threshold)
            {
                if(infection_threshold.attribute("value"))
                    f_infected_thres = infection_threshold.attribute("value").as_float();
                else
                    throw std::runtime_error("DNSPacketNR: Malformed infection threshold");
            }
           pugi::xml_node Buffer_Size = n.child("Buffer_Size");
            if(Buffer_Size)
            {
                if(Buffer_Size.attribute("value"))
                    bufferSize = Buffer_Size.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNR: Malformed buffer size");
            }

			pugi::xml_node number_Hash = n.child("number_Hash");
            if(number_Hash)
            {
                if(number_Hash.attribute("value"))
                    numHash = number_Hash.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNR: number of hash functions");
            }
			
        }
		
        /**
         * If the message received is of type RawPacket and from an identified infected IP adress treat it
         * If the message received is of type Alert collect the ip addresses
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
			
			
        if(m->type()==MSG_ID(Packet))
        {
			int len, ntld, community_number, counter;
            const Packet* packet = static_cast<const Packet*>(m.get());
			++m_count;
			const uint8_t *bufpacket = packet->base();
			const ip4hdr* iphdr = reinterpret_cast<const ip4hdr*>(bufpacket + sizeof(ethhdr));
			unsigned char *m_dnsqname =(unsigned char*)(bufpacket + sizeof(ethhdr) +sizeof(ip4hdr) + sizeof(udphdr) + sizeof(dnshdr));
			unsigned char *m_dnsqname2;
			m_dnsqname2 = getName(m_dnsqname, len, ntld);
			if ((m_dnsqname2 == NULL)||(len <= 0)){
				return;
			}
			
			if(map.find(iphdr->dip4) == map.end()){
				return;
			} 
			community_number = map.find(iphdr->dip4)->second;
			Client* client;
			ClientList* listlist;
			client = infectedList->retrive(iphdr->dip4, packet->timestamp_s());
			if (client == NULL){
				return;
			}
			client->hit(m_dnsqname2, len);
			
			if(mapp.find(community_number) == mapp.end()){
				return;
			}
			listlist = mapp.find(community_number)->second;
			
			counter=0;
			for(int i=0; i<listlist->size(); i++){
				if(listlist->getclient(i) == NULL)
					continue;
				if(listlist->getclient(i)->bloomfilter->contains(m_dnsqname2, len))
					counter++;
			}
			
			if(counter > f_infected_thres*listlist->size()){
				string malicious = (char *)m_dnsqname2;
				
				if(map_detected.find(malicious) != map_detected.end()){ // already detected;
					return;
				}
				m_detected++;
				map_detected.insert(unordered_map3::value_type(malicious, malicious));

			}
		
			
			return;
		} else if(m->type()==MSG_ID(Alert)){
			const Alert* alert = static_cast<const Alert*>(m.get());
			ClientList* listlist = new ClientList();
			Client* client;
			vector<Alert::Node> community_members = *(alert->get_sources());
			for (unsigned int i=0; i< community_members.size() ; i++)
			{
				client = infectedList->retrive(community_members[i].get_ipv4(), 0);
				if (client == NULL){	
					client =  new Client(community_members[i].get_ipv4(), 0, bufferSize, numHash);
					infectedList->putClient(client);
					map.insert(std::make_pair(community_members[i].get_ipv4(), m_listcount));
				} else {
					map.find(community_members[i].get_ipv4())->second = m_listcount;
				}
				listlist->putClient(client);
				mapp.insert(std::make_pair(m_listcount, listlist));
			}
			m_listcount++;

		} else {
	        throw std::runtime_error("wrong message type in pkt counter");

		}
		}


    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(DNSPacketNR,"DNSPacketNR");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon

#endif
