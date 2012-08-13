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

#include "UHPacket.hpp"
#include "NetTypes.hpp"
#include <netinet/in.h>
 
#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this UHPacket class is no more compliant with NewPacket class
//       TO BE REWRITTEN!

namespace blockmon
{
	void UHPacket::parse_uh(const const_buffer<uint8_t> & uh_buf)
	{

		const uint8_t  * buf = uh_buf.addr();
		
		m_key.proto = *(buf + 0x0A);
		m_key.src_port = ntohs(*((uint16_t*)(buf + 0x1C)));
		m_key.dst_port = ntohs(*((uint16_t*)(buf + 0x1E)));
		m_key.src_ip4  = ntohl(*((uint32_t*)(buf + 0x2C)));
		m_key.dst_ip4  = ntohl(*((uint32_t*)(buf + 0x3C)));

		//m_tstamp = ntohl(*((uint32_t*)(buf + 0x10)));	// FIXME: retype
		m_length = ntohs(*((uint16_t*)(buf + 0x0B)));
		m_caplen = 0;

		switch(*(buf + 0x08))
		{
		case 0x40:
			m_pkttype = Packet::kPktTypeIP4;
			break;
		case 0x60:
			m_pkttype = Packet::kPktTypeIP6;
			break;
		default:
			m_pkttype = 0;
			break;
		}
		m_iptos = *(buf + 0x1A);
		m_ipttl = *(buf + 0x1B);	

		m_machdr_parsed = true;
		m_iphdr_parsed = true;
		m_ports_parsed = true;
		m_l4hdr_parsed = true;
	}
}

#endif
