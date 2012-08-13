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

#include "DNSPacket.hpp"
#include "NetTypes.hpp"
#include <netinet/in.h>
 
#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this UHPacket class is no more compliant with NewPacket class
//       TO BE REWRITTEN!

// loads 2B in Big endian into uint_16t
#define load_BE_u16(A) (((*(A)) << 8) + *((A) + 1))

// loads 4B in Big endian into uint_16t
#define load_BE_u32(B) (((load_BE_u16(B)) << 16) + (load_BE_u16(B + 2)))

namespace blockmon
{
	/* Recursive read of DNS name following the rules of DNS name compression */
	std::string* DNSPacket::read_dns_name(uint16_t* consumed, const uint8_t * data, const uint8_t * dns_start) {

		unsigned int i = 0;
		uint8_t j = 0;
		std::string *tmp;
		std::string *ret = new std::string();
		uint16_t fake = 0;
		uint16_t jump;

		if (*data < 0xC0) { // check if the DNS name is stored here or linked somewhere else in packet
			ret = new std::string();
			j = *(data + i);
			while (j != 0 && j < 0xC0) {
				i++;
				if (i != 1)
					*ret += "."; // put dot before each domain except the first one
				tmp = new std::string((const char*)(data + i) , j); // parse j symbols
				*ret += *tmp;
				i += tmp->length();
				j = *(data + i); // load new start of domain
			}
			if (j != 0) {
				jump = load_BE_u16(data + i) & 0x3FFF;
				*consumed += i + 2; // increase number of consumed bytes
				// we are no longer consuming packet bytes, so &fake is used
				tmp = (read_dns_name(&fake, dns_start + jump, dns_start));
//				std::cout<< "jump " << jump << " tmp " << *tmp << std::endl;
				*ret += ".";
				*ret += *tmp;
				return (ret);
			}
			else
				*consumed += i + 1; // consume the ending zero
		}
		else { // we hit the link so jump somewher else in the packet
			jump = (load_BE_u16(data + i) & 0x3FFF);
			ret = read_dns_name(&fake, dns_start + jump, dns_start);
			*consumed += 2;
		}

		return ret;

	}
	
	/* Parsing of the DNS fields. Header first and then queries and answers. Authoritative and Additional sections
	 * are not being parsed at the moment.
	 */
	int DNSPacket::parse_dns()
	{
		uint8_t dns_offset = payload() - m_buffer;

		transaction_id = load_BE_u16(m_buffer + dns_offset);

		QR_flag = *(m_buffer + dns_offset + 2) >> 0x7;
		op_code = (*(m_buffer + dns_offset + 2) >> 3) & 0xF;
		AA_flag = (*(m_buffer + dns_offset + 2)  >> 2) & 0x1;
		TC_flag = (*(m_buffer + dns_offset + 2)  >> 1) & 0x1;
		RD_flag = (*(m_buffer + dns_offset + 2) & 0x1);
		RA_flag = (*(m_buffer + dns_offset + 3) >> 0x7);
		AD_flag = (*(m_buffer + dns_offset + 3) >> 0x5) & 0x1;
		ND_flag = (*(m_buffer + dns_offset + 3) >> 0x4) & 0x1;
		re_code = *(m_buffer + dns_offset + 3) & 0xF;

		n_questions = load_BE_u16(m_buffer + dns_offset + 4);
		n_answer = load_BE_u16(m_buffer + dns_offset + 6);
		n_ns = load_BE_u16(m_buffer + dns_offset + 8);
		n_additional = load_BE_u16(m_buffer + dns_offset + 10);

		struct q_record * q_r;

		uint16_t q_offset = dns_offset + 12;
		uint16_t q_size = 0;
		uint16_t consumed = 0;

		for (int i = 0; i < n_questions; i++) { // parse questions
			q_r = new struct q_record;
			consumed = 0;
			q_r->qname = read_dns_name(&consumed, m_buffer + q_offset + q_size, m_buffer + dns_offset);
			q_size += consumed; //initial length + ending zero
			q_r->rtype = load_BE_u16(m_buffer + q_offset + q_size);
			q_size += 2; // rtype
			q_r->dclass = load_BE_u16(m_buffer + q_offset + q_size);
			q_size += 2; // class
			queries.push_back(*q_r);
		}

		uint16_t a_offset = q_offset + q_size;
		uint16_t a_size = 0;
		uint16_t type;
		uint16_t dclass;
		uint32_t ttl;
//		uint16_t len;
		std::string * tmp;

		struct cname_record* cn_r;
		struct a_record* a_r;

		for (int i = 0; i < n_answer; i++) { // parse answers
			consumed = 0;
			tmp = read_dns_name(&consumed, m_buffer + a_offset + a_size, m_buffer + dns_offset);
			a_size += consumed;
			type = load_BE_u16(m_buffer + a_offset + a_size);
			a_size += 2;
			dclass = load_BE_u16(m_buffer + a_offset + a_size);
			a_size += 2;
			ttl = load_BE_u32(m_buffer + a_offset + a_size);
			a_size += 4;
//			len = load_BE_u16(m_buffer + a_offset + a_size);
			a_size += 2;

			switch (type) {
				case 1: // RR type address
					a_r = new struct a_record;
					a_r->ttl = ttl;
					a_r->rtype = type;
					a_r->dclass = dclass;
					a_r->qname = tmp;
					a_r->ip_addr = load_BE_u32(m_buffer + a_offset + a_size);
					a_size += 4;

					a_recs.push_back(*a_r);
					break;
				case 5: // RR type canonical name
					cn_r = new struct cname_record;
					cn_r->ttl = ttl;
					cn_r->rtype = type;
					cn_r->dclass = dclass;
					cn_r->qname = tmp;
					consumed = 0;
					cn_r->cname = read_dns_name(&consumed, m_buffer + a_offset + a_size, m_buffer + dns_offset);
					a_size += consumed;
					c_names.push_back(*cn_r);
					break;

				default:
					break;
			}
		}

		return 0;
	}

	/* Helper printing function for DNS question */
	void DNSPacket::print_DNS_question(struct q_record rec) {
		std::cout << "Question: Type " << rec.rtype;
		std::cout << "  Class " << rec.dclass;
		std::cout << "\tName " << rec.qname->c_str() << std::endl;
	}

	/* Helper printing function for CNAME question */
	void DNSPacket::print_DNS_cname(struct cname_record rec) {
		std::cout << "CNAME: Type " << rec.rtype;
		std::cout << "  Class " << rec.dclass;
		std::cout << "  TTL " << rec.ttl;
		std::cout << "\tName " << rec.qname->c_str();
		std::cout << "\tPrimaryName " << rec.cname->c_str() << std::endl;
	}

	/* Helper printing function for A RECORD question */
	void DNSPacket::print_DNS_arec(struct a_record rec) {
		std::cout << "ARecord: Type " << rec.rtype;
		std::cout << "  Class " << rec.dclass;
		std::cout << "  TTL " << rec.ttl;
		std::cout << "\tName " << rec.qname->c_str();
		std::cout << "\tIP " << (rec.ip_addr >> 24) << "." << ((rec.ip_addr >> 16) & 0xFF) << ".";
		std::cout << ((rec.ip_addr >> 8) & 0xFF) << "." << (rec.ip_addr & 0xFF) << std::endl;
	}

	/* Main printing function for DNS packet */
	void DNSPacket::print() {
		static int seq = 1;
		std::cout << "==== DNS Header ==== "	 << seq++ << std::endl;
		std::cout << "Transaction ID \t\t0x"		 << std::hex << (int) transaction_id << std::dec << "\t";
		std::cout << "Query[0]/Response[1] \t"	 << (int) QR_flag << std::endl;
		std::cout << "Operation code \t\t"		 << (int) op_code << "\t";
		std::cout << "Authoritative answer \t"	 << (int) AA_flag << std::endl;
		std::cout << "Truncated message \t"		 << (int) TC_flag << "\t";
		std::cout << "Recursion desired \t"		 << (int) RD_flag << std::endl;
		std::cout << "Recursion available \t"	 << (int) RA_flag << "\t";
		std::cout << "Answer authenticated \t"	 << (int) AD_flag << std::endl;
		std::cout << "Non-authenticated data\t"	 << (int) ND_flag << "\t";
		std::cout << "Reply code\t\t" 			 << (int) re_code << std::endl;

		std::cout << "==== DNS Sections ==== "	 <<  std::endl;
		std::cout << "Questions " << n_questions << "\t\t\tAnswers " << n_answer <<  std::endl;
		std::cout << "Authority " << n_ns << "\t\t\tAdditional " << n_additional <<  std::endl;

		std::cout << "==== DNS Questions ==== "	 <<  std::endl;
		for (unsigned int i = 0; i < queries.size(); i++)
			print_DNS_question(queries[i]);

		std::cout << "==== DNS Answers ==== "	 <<  std::endl;
		for (unsigned int i = 0; i < c_names.size(); i++)
			print_DNS_cname(c_names[i]);
		for (unsigned int i = 0; i < a_recs.size(); i++)
			print_DNS_arec(a_recs[i]);

		std::cout << std::endl;
	}
}

#endif
