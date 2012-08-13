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

#ifndef _MESSAGES_UHPACKET_HPP_
#define _MESSAGES_UHPACKET_HPP_

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

#include "Packet.hpp"
#include "Buffer.hpp"
#include "MemoryBatch.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"
#include <cstring>
#include <cassert>
#include <ctime>
 
#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this UHPacket class is no more compliant with NewPacket class
//       TO BE REWRITTEN!

namespace blockmon
{

    /**
     * BlockMon Message representing a packet with unified header. 
     * This header contains basic information about packet,
     * that determines flow.
     * TODO: Specification of UH
     *
     * UHPacket does not contains any payload data.
     */

    class UHPacket : public Packet
    {
      
    public:

        /**
        *  Create a new UHPacket, copying the packet content from an existing 
        *  buffer to an internal buffer owned by the UHPacket.
        *
        *  FIXME consider replacing the packet buffer here with a slab
        *        allocator.
        *
        *  @param  uh_buf    const_buffer pointing to length and bounds of the 
        *                    buffer to copy the packet from.
        *  @param  uh_id     Version of UH packet
        *                    
        */        
        UHPacket(const const_buffer<uint8_t> &uh_buf,
               int                           uh_id)
        : Packet(const_buffer<uint8_t>(), timespec(), 0, 0, MSG_ID(Packet))
        {
			parse_uh(uh_buf);
        }

        /**
        * Create a new UHPacket, using an external buffer allocated from 
        * within a MemoryBatch for the packet content storage. This
        * constructor must be used with placement-new, and requires the
        * memory in m_buffer to be contiguously allocated with this object.
        *
        * This constructor is used by alloc_msg_from_buffer() in 
        * MemoryBatch.hpp; Blocks should use that interface instead.
        *
        *  The Packet's layer 2, 3, and 4 headers will be parsed on demand.
        *
        *  @param  buf_displace offset from *this to the first byte of 
        *                    the packet buffer (should be sizeof(Packet)), unless
        *                    called from a derived class
        *  @param  uh_buf    const_buffer pointing to length and bounds of the 
        *                    buffer to copy the packet from.
        *  @param  uh_id     Version of UH packet
        */        
        UHPacket(memory_not_owned_t,
               size_t                       buf_displace,
               const const_buffer<uint8_t>  &uh_buf,
               int                          uh_id)
        : Packet(memory_not_owned, sizeof(Packet), const_buffer<uint8_t>(), timespec(), 0, 0, MSG_ID(Packet))
		{
			parse_uh(uh_buf);
        }

        /** Forbids copy and move constructors.
	 */
        UHPacket(const UHPacket &) = delete;
        
        /** Forbids copy and move assignment.
	 */
        UHPacket& operator=(const UHPacket &) = delete;


        /**
        * Destroy this UHPacket. Frees the packet buffer if owned.
        */
        ~UHPacket() 
        {
            if (m_buffer_owned) {
              delete m_buffer;
            }
        }

        /**
         * Clone this message; the new UHPacket will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        std::shared_ptr<Msg> clone() const 
        {
            return std::make_shared<UHPacket>(
                const_buffer<uint8_t>(m_buffer, m_caplen), 
                m_length);
        }


    private:
		void parse_uh(const const_buffer<uint8_t> & uh_buf);

    };

}

#endif
#endif // _MESSAGES_UHPACKET_HPP_
