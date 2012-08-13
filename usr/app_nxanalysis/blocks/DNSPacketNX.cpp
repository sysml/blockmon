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
 * <blockinfo type="DNSPacketNX" scheduling_type="passive" thread_exclusive="False">
 *   <humandesc>
 *     Identify Communities of infected users 
 *     The block takes as input the DNS errors (NXDOMAIN answers)
 *     The block sends the the IP adresses of the communities of the infected users
 *   </humandesc>
 *
 *   <shortdesc>Identify communities of infected users  </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="inpkt" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="outpkt" msg_type="Alert" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element correlation_timeout {
 *        attribute value {xsd:integer}
 *      }
 *      element communities_threshold {
 *        attribute value {xsd:integer}
 *      }
 *      element minimum_requests {
 *        attribute value {xsd:integer}
 *      }
 *      element proxy_fillrate {
 *        attribute value {xsd:float}
 *      }
 *      element merge_threshold {
 *        attribute value {xsd:float}
 *      }
 *      element buffer_size {
 *        attribute value {xsd:integer}
 *      }
 *      element number_hash {
 *        attribute value {xsd:integer}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <correlation_timeout value="60">
 *        <communities_threshold value="10">
 *        <minimum_requests value="7">
 *        <proxy_fillrate value="0.7">
 *        <merge_threshold value="0.8">
 *        <buffer_size value="800">
 *        <number_hash value="2">
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="pktcnt" human_desc="integer" access="read"/>
 *     <variable name="comcnt" human_desc="integer" access="read"/>
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
#include <iomanip>
#include <string>
#include <cstring>
#include <vector>
#include <Alert.hpp>
#include "NetTypes.hpp"
#include "ClientList.hpp"
#include "dnsh.h"

using namespace std;

#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is no more compliant with NewPacket class
//       TO BE REWRITTEN!


using namespace NXAnalyzer;
namespace blockmon
{

    /**
     * Implements a block that logs the number of messages it has received every
     * 0.5 seconds.
     */
    class DNSPacketNX: public Block
    {
        unsigned long long  m_count; // number of packets
        unsigned long long  m_cor_count; // count the number nxdomain answers 
		unsigned long long  m_count_communities; // number of detected communities
		unsigned int m_interval_correlation;
		int m_thres_communities; // minimum number of member to form a community
		int m_min_thres; 
		float f_proxy_fillrate;
		float f_merge_thres;
		int bufferSize;
		int numHash;
        int m_ingate_id;
		int m_out_gate_id;
        unsigned int m_reset;
		ClientList* listlist;
		ClientList* nxClients;
		ClientList* proxyClients;
		ClientList* templist;
		typedef boost::unordered_map<string , string> unordered_map;
		unordered_map mapp;
		inline void packet_passed(std::shared_ptr<const Msg>&& m)
        {
				send_out_through(std::move(m),m_out_gate_id);
		}
    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        DNSPacketNX(const std::string &name, invocation_type invocation) 
        : Block(name, invocation_type::Indirect), 
        m_count(0), 
		m_cor_count(0),
		m_count_communities(0),
		m_interval_correlation(60),
		m_thres_communities(8),
		m_min_thres(7),
		f_proxy_fillrate(0.7),
		f_merge_thres(0.8),
		bufferSize(800),
		numHash(2),
        m_ingate_id(register_input_gate("inpkt")),
		m_out_gate_id(register_output_gate("outpkt")),
        m_reset(0)
        {
            register_variable("pktcnt",make_rd_var(no_mutex_t(), m_count));
			register_variable("comcnt",make_rd_var(no_mutex_t(), m_count_communities));
            register_variable("reset",make_wr_var(no_mutex_t(), m_reset));
			listlist =  new ClientList();
			nxClients = new ClientList();
			proxyClients = new ClientList();
			templist = new ClientList(bufferSize, numHash);
			initTld();

        }
		DNSPacketNX(const DNSPacketNX &)=delete;
        DNSPacketNX& operator=(const DNSPacketNX &) = delete;
        DNSPacketNX(DNSPacketNX &&)=delete;
        DNSPacketNX& operator=(DNSPacketNX &&) = delete;

        /**
         * @brief Destructor
         */
        ~DNSPacketNX()  {
			delete listlist;
			delete nxClients;
			delete proxyClients;
			delete templist;
		}
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
         * @brief initialis the list of valid tld
         */
		void initTld(){
			
			for (unsigned int i=0; i< validTLD.size() ; i++)
			{
				mapp.insert(unordered_map::value_type(validTLD[i], validTLD[i]));
			}
			
		}
		
		/**
         * @brief see if a tld is valid or not
		 * @param dnsqname a pointer to the domain name
		 * @param len length of the domain name
		 * @param ntld the length of tld		 
		 * @return true if it is a valid atld, false otherwise
         */	
		bool validTld(unsigned char* dnsqname, int len, int ntld){
			const char* ctld = (const char *)(dnsqname + (len -ntld));
			unordered_map::iterator map_it;
			map_it = mapp.find(ctld);
			if (map_it == mapp.end()){
				return false;
			} else{
				return true;
			}
			}
		
		
		/**
         * @brief correlate the different bloom filters to detect communities of infected users
         */	
		void correlate(){
			Client* client, *client2;
			for (int i=0; i < nxClients->size(); i++) {
				client = nxClients->getclient(i);
				if(client->getSmartCounter() < m_min_thres){
					nxClients->removeClient(client);
					--i;
					continue;
				}
				
				if(proxyClients->contains(client)){
					nxClients->removeClient(client);
					--i;
					continue;
				}
				
				if(client->bloomfilter->fillrate() > f_proxy_fillrate){
					proxyClients->putClient(client);
					nxClients->removeClient(client);
					--i;
					continue;
				}
			}
			for (int i=0; i < nxClients->size(); i++) {
				client = nxClients->getclient(i);
				if(client == NULL)
					continue;
				templist->putClient(client);
				templist->bloomFilter->copyBloom(client->bloomfilter);
				for(int j=i+1; j < nxClients->size(); j++){
					client2 = nxClients->getclient(j);
					
					if(client2->bloomfilter->compare(templist->bloomFilter) > f_merge_thres){ //merge
						if(client2 == NULL)
							continue;
						templist->putClient(client2);
						templist->bloomFilter->merge(client2->bloomfilter);
						nxClients->removeClient(client2);
						--j;
					}
				}
				
				if(templist->size() > m_thres_communities){
					m_count_communities++;
					std::vector<Alert::Node> community_members;
					for (int k = 0; k < templist->size(); k++) {
						community_members.push_back(Alert::Node(templist->getclient(k)->getName()));
					}
					std::shared_ptr<Alert> alert = std::make_shared<Alert>(get_name(), m_count_communities, "COMMUNITY DETECTED");
					alert.get()->set_targets(community_members);
					packet_passed(std::move(alert));
				}
				templist->clear();

			} 
			nxClients->clear();
			
			
		}


		
        /**
         * @brief Configures the block, in this case the export time is hard-coded
         * to 0.5 seconds
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n ) 
        {

	
			pugi::xml_node correlation_timeout = n.child("correlation_timeout");
            if(correlation_timeout)
            {
                if(correlation_timeout.attribute("value"))
                    m_interval_correlation = correlation_timeout.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed correlation timer");
            }
           pugi::xml_node communities_threshold = n.child("communities_threshold");
            if(communities_threshold)
            {
                if(communities_threshold.attribute("value"))
                    m_thres_communities = communities_threshold.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed minimum community threshold");
            }

			pugi::xml_node minimum_requests = n.child("minimum_requests");
            if(minimum_requests)
            {
                if(minimum_requests.attribute("value"))
                    m_min_thres = minimum_requests.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed minimum number of requests");
            }
			
			pugi::xml_node proxy_fillrate = n.child("proxy_fillrate");
            if(proxy_fillrate)
            {
                if(proxy_fillrate.attribute("value"))
                    f_proxy_fillrate = proxy_fillrate.attribute("value").as_float();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed proxy bloom filter fillrate threshold");
            }
			pugi::xml_node merge_threshold = n.child("merge_threshold");
            if(merge_threshold)
            {
                if(merge_threshold.attribute("value"))
                    f_merge_thres = merge_threshold.attribute("value").as_float();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed merge threshold");
            }
           pugi::xml_node buffer_size = n.child("buffer_size");
			if(buffer_size)
            {
                if(buffer_size.attribute("value"))
                    bufferSize = buffer_size.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed buffer size");
            }
			pugi::xml_node number_hash = n.child("number_hash");
			if(number_hash)
            {
                if(number_hash.attribute("value"))
                    numHash = number_hash.attribute("value").as_uint();
                else
                    throw std::runtime_error("DNSPacketNX: Malformed number of hash function");
            }
            set_periodic_timer( m_interval_correlation * 1000000,"correlation_timeout",0);
        }

		


        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type()!=MSG_ID(Packet))
            {
                throw std::runtime_error("wrong message type in pkt counter");
            }
            if(m_reset==1)
            {
                m_count = 0;
                m_reset=0;
				m_cor_count=0;
            }
			int len;
			int ntld;
            const Packet* packet = static_cast<const Packet*>(m.get());
			m_count++;
			m_cor_count++;
			const uint8_t *bufpacket = packet->base();
			const ip4hdr* iphdr = reinterpret_cast<const ip4hdr*>(bufpacket + sizeof(ethhdr));
			unsigned char *m_dnsqname =(unsigned char*)(bufpacket + sizeof(ethhdr) +sizeof(ip4hdr) + sizeof(udphdr) + sizeof(dnshdr));
			unsigned char *m_dnsqname2;
			m_dnsqname2 = getName(m_dnsqname, len, ntld);
			if ((m_dnsqname2 == NULL)||(len < 6)){
				return;
			}
			if (!validTld(m_dnsqname2, len, ntld)){
				return ;
			}
			Client* client;
			client = listlist->retrive(iphdr->dip4, packet->timestamp_s());
			if (client == NULL){
				client =  new Client(iphdr->dip4, packet->timestamp_s(), bufferSize, numHash);
				listlist->putClient(client);
				nxClients->putClient(client);
			} else {
				if(!nxClients->contains(client))
					nxClients->putClient(client);
			}
			client->hit(m_dnsqname2, len);

		}
		void _handle_timer(std::shared_ptr<Timer>&& ){

			m_cor_count=0;
			correlate();
        
		}
    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(DNSPacketNX,"DNSPacketNX");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon

#endif
