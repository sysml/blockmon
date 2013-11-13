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

#include "Packet.hpp"
#include "NetTypes.hpp"
#include <netinet/in.h>
#include <iomanip>

#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is to be replaced by NewPacket class

namespace blockmon {

/* Decode IP header HLV field into version and header length */
static size_t decode_hlv(uint8_t hlv, uint8_t& version) {
    version = (hlv & 0xf0) >> 4;
    return (hlv & 0x0f) << 2;
}

/* Decode TCP header payload offset field */
static size_t decode_payoff(uint8_t payoff) {
    return (payoff & 0xf0) >> 2;
}

/* Parses MAC header, populates m_pkttype, m_ipbuffer if IP */
void Packet::parse_mac() const {
    // shortcut valid ethertype
    if (m_machdr_parsed) return;
    m_machdr_parsed = true;

    const uint8_t *macbuf = m_buffer;

    if (m_mactype == kEthernet) {
        // Shortcut further parsing on runt packet
        if (m_caplen < sizeof(ethhdr)) {
            m_pkttype = kPktTypeRuntL2;
            m_iphdr_parsed = true;
            m_ports_parsed = true;
            m_l4hdr_parsed = true;
            return;
        }

        // get packet type 
        const ethhdr *eh = reinterpret_cast<const ethhdr*>(m_buffer);
        m_pkttype = ntohs(eh->ethertype);
        macbuf += sizeof(ethhdr);

        while (m_pkttype == kPktType1q) {
            if ((m_caplen - (macbuf - m_buffer)) < sizeof(ethhdr)) {
                m_pkttype = kPktTypeRuntL2;
                m_iphdr_parsed = true;
                m_ports_parsed = true;
                m_l4hdr_parsed = true;
                return;
            }

            // 802.1q header; parse and try again
            const eth1qhdr *e1qh = reinterpret_cast<const eth1qhdr*>(macbuf);
            m_pkttype = ntohs(e1qh->ethertype);
            macbuf += sizeof(eth1qhdr);
        }        
    } else if (m_mactype == kRawIP) {
        m_pkttype = kPktTypeIP4;
    }

    if (m_pkttype == kPktTypeIP4) {
        // Store pointer to IP header
        m_iphdr_ptr = macbuf;
    } else {
        // Shortcut further parsing if not IP
        m_iphdr_parsed = true;
        m_ports_parsed = true;
        m_l4hdr_parsed = true;
    }
}

/* parses IP header, populates m_ip*, m_sip, m_dip, m_key.proto */
void Packet::parse_iphdr() const {
    // shortcut valid iphdr
    if (m_iphdr_parsed) return;
    m_iphdr_parsed = true;

    // make sure we've parsed the mac header
    parse_mac();

    // verify we have enough valid IP header
    if (m_iphdr_ptr) {
        size_t iphoff = m_iphdr_ptr - m_buffer;
        if ((m_caplen - iphoff) >= sizeof(ip4hdr)) {
            // Yep. Parse header.
            const ip4hdr *iph = reinterpret_cast<const ip4hdr*>(m_iphdr_ptr);
            m_key.src_ip4 = ntohl(iph->sip4);
            m_key.dst_ip4 = ntohl(iph->dip4);
            m_key.proto = iph->proto;
            m_iptos = iph->tos;
            m_ipttl = iph->ttl;
	    m_iplen = ntohs(iph->len);
            
            // get header length
            uint8_t version;
            m_iphlen = decode_hlv(iph->hlv, version);

            // find layer 4 header
            if ((m_caplen - iphoff) >= m_iphlen) {
                // we may even have a valid layer 4 header, store it
                m_l4hdr_ptr = m_iphdr_ptr + m_iphlen;
            }
        } else {
            // Shortcut further parsing on runt IP
            m_pkttype = kPktTypeRuntL3;
            m_ports_parsed = true;
            m_l4hdr_parsed = true;
        }            
    }
}

/* if protocol is UDP or TCP, populates m_key.src_port and m_key.dst_port; 
   also finds payload for UDP */
void Packet::parse_ports() const {
    // shortcut valid ports
    if (m_ports_parsed) return;
    m_ports_parsed = true;
    
    // make sure we've parsed the IP header
    parse_iphdr();

    // verify we have valid ports
    if (m_l4hdr_ptr && ((m_key.proto == kTCP) || (m_key.proto == kUDP))) {
        size_t l4hoff = m_l4hdr_ptr - m_buffer;
        if ((m_caplen - l4hoff) >= sizeof(porthdr)) {
            const porthdr *ph = reinterpret_cast<const porthdr*>(m_l4hdr_ptr);
            m_key.src_port = ntohs(ph->sp);
            m_key.dst_port = ntohs(ph->dp);
            
            //  go ahead and skip the rest of the UDP header
            if ((m_key.proto == kUDP) && ((m_caplen - l4hoff) >= sizeof(udphdr))) {
	        const udphdr* uh = reinterpret_cast<const udphdr*>(m_l4hdr_ptr);
		m_udplen = ntohs(uh->len);
                m_l4payload_ptr = m_l4hdr_ptr + sizeof(udphdr);
                m_payload_len = m_iplen - m_iphlen - sizeof(udphdr);
            }
        } else {
            // Shortcut further parsing on runt ports
            m_pkttype = kPktTypeRuntL4;
            m_l4hdr_parsed = true;
        }
    }
}

   /* if protocol is TCP, m_tcp* */

void Packet::parse_tcphdr() const {
    // shortcut valid ports
    if (m_l4hdr_parsed) return;
    m_l4hdr_parsed = true;
    
    // insure IP parsed
    parse_iphdr();

    // look for a valid TCP header
    if (m_l4hdr_ptr && (m_key.proto == kTCP)) {
        size_t tcphoff = m_l4hdr_ptr - m_buffer;
        if ((m_caplen - tcphoff) >= sizeof(tcphdr)) {
            // Yep. Parse header.
            const tcphdr *tcph = reinterpret_cast<const tcphdr*>(m_l4hdr_ptr);
            m_key.src_port = ntohs(tcph->sp);
            m_key.dst_port = ntohs(tcph->dp);
            m_tcpflags = tcph->flags;
            m_tcpseq = ntohl(tcph->seqnum);
            m_tcpack = ntohl(tcph->acknum);
            m_tcpurg = tcph->urgent;
            m_tcpwin = tcph->window;
            
            // get header length
            m_tcphlen = decode_payoff(tcph->payoff);

            // FIXME parse options

            // find payload
            if ((m_caplen - tcphoff) >= m_tcphlen) {
                // we may even have a valid layer 4 payload, store it
                m_l4payload_ptr = m_l4hdr_ptr + m_tcphlen;
                m_payload_len = m_iplen - m_iphlen - m_tcphlen;
            }
        } else {
            // Mark runt packet
            m_pkttype = kPktTypeRuntL4;
        }
    }
}

}

#endif
