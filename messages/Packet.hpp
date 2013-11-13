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

#ifndef _MESSAGES_PACKET_HPP_
#define _MESSAGES_PACKET_HPP_
// FIXME brian Redocument this; change the API
// FIXME add on-demand parsing of IP header, ports, and TCP header fields
// don't use five-tuple anymore
// add IPv6 support (FUTURE)

/**
 * @file 
 *
 * This message represents a Packet.
 */
 
// FIXME determine whether timespec is the right way to go

#include "Msg.hpp"
#include "Buffer.hpp"
#include "MemoryBatch.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"
#include <cstring>
#include <cassert>
#include <ctime>

#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)

#include "NewPacket.hpp"    // FIXME added temporary
                                                    
#else 

// compatibility with NewPacket
namespace blockmon
{

    static const int kEthernet = 1;
    static const int kRawIP = 2;


    /**
     * BlockMon Message representing a Packet. Packet contains a raw packet
     * captured from the wire, and automatically parses ethernet, IP, TCP,
     * and UDP headers on demand to provide access to its fields.
     *
     * Packets may be sent to IPFIXExporter; at present, ethernet headers
     * will be removed and timestamps clamped to millisecond precision
     * to provide compatibility with capfix.
     */

    class Packet : public Msg
    {
      
      
    public:

        /**
        *  Create a new Packet, copying the packet content from an existing 
        *  buffer to an internal buffer owned by the Packet.
        *
        *  The Packet's layer 2, 3, and 4 headers will be parsed on demand.
        *
        *  FIXME consider replacing the packet buffer here with a slab
        *        allocator.
        *
        *  @param  buf       const_buffer pointing to length and bounds of the 
        *                    buffer to copy the packet from.
        *  @param  timestamp time at which packet was captured. 
        *                    Optional; if omitted, use the current system time.
        *  @param  len       Total length of the packet. Optional, if omitted or
        *                    0, uses the length of the buffer.
        *  @param  mac_type  Encapsulation of the packet; Optional, 
        *                    default is kEthernet
        *  @param  msg_id    BlockMon message identifier; optional, defaults
        *                    to the message ID for the Packet class. Used
        *                    by derived classes of Packet; see the MSG_ID 
        *                    macro in ClassID.hpp.
        */        
        Packet(const const_buffer<uint8_t> &buf,
               timespec                   timestamp = timespec(), 
               size_t                     len =       0,
               int                        mac_type =  kEthernet,
               int                        msg_id =    0)
        : Msg((!msg_id)? MSG_ID(Packet): msg_id), 
          m_buffer_owned(true),
          m_buffer(new uint8_t[buf.len()]),
          m_caplen(buf.len()),
          m_length(len),
          m_tstamp(timestamp),
          m_mactype(mac_type),
          m_iphdr_ptr(NULL),
          m_l4hdr_ptr(NULL),
          m_l4payload_ptr(NULL),
          m_machdr_parsed(false),
          m_iphdr_parsed(false),
          m_ports_parsed(false),
          m_l4hdr_parsed(false),
          m_payload_len(0)
        {
            if (!m_length) m_length = buf.len();
                memcpy(const_cast<uint8_t*>(m_buffer) , buf.addr(), buf.len());
        }

        /**
        * Create a new Packet, using an external buffer allocated from 
        * within a MemoryBatch for the packet content storage. This
        * constructor must be used with placement-new, and requires the
        * memory in m_buffer to be contiguously allocated with this object.
        *
        * This constructor is used by alloc_msg_from_buffer() in 
        * MemoryBatch.hpp; Blocks should use that interface instead.
        *
        * FIXME Nicola: what about alignment?
        * 
        *  The Packet's layer 2, 3, and 4 headers will be parsed on demand.
        *
        *  @param  buf_displace offset from *this to the first byte of 
        *                    the packet buffer (should be sizeof(Packet)), unless
        *                    called from a derived class
        *  @param  buf       const_buffer pointing to length and bounds of the 
        *                    buffer to copy the packet from.
        *  @param  timestamp time at which packet was captured. 
        *                    Optional; if omitted, use the current system time.
        *  @param  len       Total length of the packet. Optional, if omitted or
        *                    0, uses the length of the buffer.
        *  @param  mac_type  Encapsulation of the packet; Optional, 
        *                    default is kEthernet
        *  @param  msg_id    BlockMon message identifier; optional, defaults
        *                    to the message ID for the Packet class. Used
        *                    by derived classes of Packet; see the MSG_ID 
        *                    macro in ClassID.hpp.
        * 
        */        
        Packet(memory_not_owned_t,
               size_t                     buf_displace,
               const const_buffer<uint8_t> &buf,
               timespec                   timestamp = timespec(), 
               size_t                     len =       0,
               int                        mac_type =  kEthernet,
               int                        msg_id = 0   )
        : Msg((!msg_id)? MSG_ID(Packet): msg_id), 
          m_buffer_owned(false),
          m_buffer(reinterpret_cast<uint8_t *>(this) + buf_displace), 
          m_caplen(buf.len()),
          m_length(len),
          m_tstamp(timestamp),
          m_mactype(mac_type),
          m_iphdr_ptr(NULL),
          m_l4hdr_ptr(NULL),
          m_l4payload_ptr(NULL),
          m_machdr_parsed(false),
          m_iphdr_parsed(false),
          m_ports_parsed(false),
          m_l4hdr_parsed(false),
          m_payload_len(0)
        {
            if (!m_length) m_length = buf.len();
            memcpy(const_cast<uint8_t*>(m_buffer), buf.addr(), buf.len());
        }

        /** Forbids copy and move constructors.
	 */
        Packet(const Packet &) = delete;
        
        /** Forbids copy and move assignment.
	 */
        Packet& operator=(const Packet &) = delete;

        /**
        * No move constructor: Packets are not movable.
        */
        Packet(Packet &&) = delete;
        
        /**
        * No move assignment operator: Packets are not movable.
        */
        Packet& operator=(Packet &&) = delete;

        /**
        * Destroy this Packet. Frees the packet buffer if owned.
        */
        virtual ~Packet() 
        {
            if (m_buffer_owned) {
              delete m_buffer;
            }
        }

        /**
         * Clone this message; the new Packet will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        virtual std::shared_ptr<Msg> clone() const
        {
            return std::make_shared<Packet>(
                const_buffer<uint8_t>(m_buffer, m_caplen), 
                m_tstamp, m_length, m_mactype);
        }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Parsers (currently under construction)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    public:
        /** Runt packet missing full layer 2 header */
        static const uint16_t  kPktTypeRuntL2 = 0xFFF2;
        /** Runt IP packet missing full layer 3 header */
        static const uint16_t  kPktTypeRuntL3 = 0xFFF3;
        /** Runt IP packet missing full layer 4 header */
        static const uint16_t  kPktTypeRuntL4 = 0xFFF4;
        
        /** IPv4 packet */
        static const uint16_t  kPktTypeIP4 = 0x0800;
        /** 802.1q packet; temporary packet type used during MAC parsing */        
        static const uint16_t  kPktType1q  = 0x8100;
        /** IPv6 packet. Not yet supported. */
        static const uint16_t  kPktTypeIP6 = 0x86FF;

        static const uint8_t   kUDP = 17;
        static const uint8_t   kTCP = 6;

        static const uint8_t   kFIN = 0x01;
        static const uint8_t   kSYN = 0x02;
        static const uint8_t   kRST = 0x04;
        static const uint8_t   kPSH = 0x08;
        static const uint8_t   kACK = 0x10;
        static const uint8_t   kURG = 0x20;
        static const uint8_t   kECE = 0x40;
        static const uint8_t   kCWR = 0x80;


    private:

        void parse_mac() const;
        void parse_iphdr() const;
        void parse_ports() const;
        void parse_tcphdr() const;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Standard accessors
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

public:

        /** Get the packet's timestamp as a timespec */
        const timespec& timestamp() const {
            return m_tstamp;
        }
        
        uint64_t timestamp_s() const {
            return m_tstamp.tv_sec;
        }

        uint64_t timestamp_ms() const {
            return timespec_to_us(m_tstamp) / 1000;
        }

        uint64_t timestamp_us() const {
            return timespec_to_us(m_tstamp);
        }

        /** Get the total length of the packet captured from the wire */
        size_t caplen() const {
            return m_length;
        }

        /** Backwards compatibility */
		size_t length() const {
			return caplen();
		}

        /** Get a pointer to the start of the packet */
        const uint8_t *base() const {
            return m_buffer;
        }

        /** Get a pointer to the start of the IP header;
         *  returns NULL for non-IP packets */
        const uint8_t *iphdr() const {
            parse_mac();
            return m_iphdr_ptr;
        }

        /** Get a pointer to the start of the L4 header;
         *  returns NULL for non-IP packets */
        const uint8_t *l4hdr() const {
            parse_iphdr();
            return m_l4hdr_ptr;
        }

        /** Get a pointer to the start of the L4 payload;
         *  returns NULL for non-TCP/UDP packets */
        const uint8_t *payload() const {
            if (is_tcp()) {
                parse_tcphdr();
            } else {
                parse_ports();
            }
            return m_l4payload_ptr;
        }
        
        /** return the l4 (TCP/UDP) playload length or 0 if there is no such payload */
        const size_t payload_len() const{
        	payload();// make sure payload is parsed
        	return m_payload_len;
        }
        
        /** Get the MAC type of the packet; 
         *  presently supports ethernet and raw IP */
        int mac_type() const {
           return m_mactype;
        }
	//FIXME provisional by Andrea	
	uint16_t  l3_protocol() const
	{
	    parse_mac();
	    return m_pkttype;
	}

       
        uint32_t ip_src() const {
           parse_iphdr();
           return m_key.src_ip4;
        }
   
        uint32_t ip_dst() const {
           parse_iphdr();
           return m_key.dst_ip4;
        }

        uint16_t src_port() const {
           parse_ports();
           return m_key.src_port;
        }

        uint16_t dst_port() const {
           parse_ports();
           return m_key.dst_port;
        }

        uint8_t  l4_protocol() const {
           parse_iphdr();
           return m_key.proto;
        }
        
        const FlowKey& key() const {
            parse_ports();
            return m_key;
        }

        bool is_tcp() const {
           return l4_protocol() == kTCP;
        }

        bool is_udp() const {
            return l4_protocol() == kUDP;
        }

        uint8_t  ip_tos() const {
           parse_iphdr();
           return m_iptos;
        }

        uint8_t  ip_ttl() const {
           parse_iphdr();
           return m_ipttl;
        }

        uint16_t ip_length() const {
	    parse_iphdr();
	    return m_iplen;
        }

        uint8_t ip_header_length() const {
	    parse_iphdr();
	    return m_iphlen;
        }

        uint8_t tcp_flags() const {
           parse_tcphdr();
           return m_tcpflags;
        }

        bool tcp_has_syn() const {
           return tcp_flags() & kSYN;
        }

        bool tcp_has_ack() const {
                  return tcp_flags() & kACK;
        }

        bool tcp_has_fin() const {
           return tcp_flags() & kFIN;
        }

        bool tcp_has_rst() const {
           return tcp_flags() & kRST;
        }

        bool tcp_has_psh() const {
           return tcp_flags() & kPSH;
        }

        bool tcp_ack(uint32_t& tcpack) const {
           if (tcp_flags() & kACK) {
               tcpack = m_tcpack;
               return true;
           } else {
               return false;
           }
        }

        bool tcp_urg(uint8_t& tcpurg) const {
           if (tcp_flags() & kURG) {
               tcpurg = m_tcpurg;
               return true;
           } else {
               return false;
           }
        }

        uint32_t tcp_seq() const {
          parse_tcphdr();
          return m_tcpseq;
        }

        uint32_t tcp_win() const {
          parse_tcphdr();
          return m_tcpwin;
        }

        uint8_t tcp_header_length() const {
	  parse_tcphdr();
	  return m_tcphlen;
        }

       uint16_t udp_length() const {
	  parse_ports();
	  return m_udplen;
        }


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Conversions to string for print out, debug
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
       
    private:
       static
       void ip_str(char *buf, const uint32_t ip) 
       {
         char tmp[4];
         tmp[0] = ip >> 24;
         tmp[1] = ip >> 16;
         tmp[2] = ip >> 8;
         tmp[3] = ip;
         sprintf(buf, "%d.%d.%d.%d", tmp[0], tmp[1], tmp[2], tmp[3]);
       }

    public:
       std::string
       ip_src_str() const
       {
            char buf[16];
            ip_str(buf, this->ip_src());
            return buf;
       }
       
       std::string
       ip_dst_str() const
       {
            char buf[16];
            ip_str(buf, this->ip_dst());
            return buf;
       }       

    protected:
        bool                  m_buffer_owned;
        const uint8_t*        m_buffer;
        size_t                m_caplen;
        size_t                m_length;
        timespec              m_tstamp;
        int                   m_mactype;
        
        mutable const uint8_t* m_iphdr_ptr;
        mutable const uint8_t* m_l4hdr_ptr;
        mutable const uint8_t* m_l4payload_ptr;

        mutable bool          m_machdr_parsed;
        mutable bool          m_iphdr_parsed;
        mutable bool          m_ports_parsed;
        mutable bool          m_l4hdr_parsed;
        
        /** Packet type: mixture of ethertype and internal kPktType* 
            constants to signal what kind of packet we're dealing with */
        mutable uint16_t      m_pkttype;

        mutable FlowKey       m_key;
                              
        mutable uint8_t       m_iptos;
        mutable uint8_t       m_ipttl; 
        mutable uint16_t      m_iplen;
        mutable uint8_t       m_iphlen;
                             
        mutable uint8_t       m_tcpflags;
        mutable uint32_t      m_tcpseq;
        mutable uint32_t      m_tcpack;
        mutable uint32_t      m_tcpurg;
        mutable uint32_t      m_tcpwin;
        mutable uint8_t       m_tcphlen;

        mutable uint16_t      m_udplen;
        mutable size_t 	      m_payload_len;
    };

}

#endif

#endif // _MESSAGES_PACKET_HPP_
