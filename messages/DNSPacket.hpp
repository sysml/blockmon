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

#ifndef _MESSAGES_DNSPACKET_HPP_
#define _MESSAGES_DNSPACKET_HPP_
/**
 * @file 
 *
 * This message represents a DNSPacket.
 */

#include "Packet.hpp"
#include "Buffer.hpp"
#include "MemoryBatch.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"
#include <cstring>
#include <string>
#include <cassert>
#include <ctime>
 

#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is no more compliant with NewPacket class.
//       TO BE REWRITTEN!

namespace blockmon
{

	/**
	 * BlockMon Message representing a DNS packet with parsed information.
	 */

	class DNSPacket : public Packet
	{

		public:

			/**
			 * Create a new DNSPacket from Packet. This is not performance optimal,
			 * but it is expected that the parsing will be performed on a prefiltered
			 * packets. 
			 *
			 * @param p		original Packet
			 */        
			DNSPacket(const Packet &p)
				: Packet(const_buffer<uint8_t>(p.base(), p.length()))
			{
					parse_dns();
			}

			/**
			 * Print parsed DNSPacket info.
			 */
			void print();

			/* DNS Packet fields */
			
			uint16_t transaction_id;
			uint8_t QR_flag;
			uint8_t op_code;
			uint8_t AA_flag;
			uint8_t TC_flag;
			uint8_t RD_flag;
			uint8_t RA_flag;
			uint8_t AD_flag;
			uint8_t ND_flag;
			uint8_t re_code;

			uint16_t n_questions;
			uint16_t n_answer;
			uint16_t n_ns;
			uint16_t n_additional;

			struct q_record {
				uint16_t rtype;
				uint16_t dclass;
				std::string* qname;
			};


			struct cname_record {
				uint32_t ttl;
				uint16_t rtype;
				uint16_t dclass;
				std::string* qname;
				std::string* cname;
			};

			struct a_record {
				uint32_t ttl;
				uint16_t rtype;
				uint16_t dclass;
				uint32_t ip_addr;
				std::string* qname;
			};


			std::vector<struct q_record> queries;
			std::vector<struct a_record> a_recs;
			std::vector<struct cname_record> c_names;

		private:

			std::string* read_dns_name(uint16_t* consumed, const uint8_t * , const uint8_t * );
			int parse_dns();

			void print_DNS_question(struct q_record);
			void print_DNS_cname(struct cname_record);
			void print_DNS_arec(struct a_record); 
	};

}

#endif

#endif // _MESSAGES_DNSPACKET_HPP_
