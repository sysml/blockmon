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

#ifndef _MESSAGES_SCATTEREDPACKET_HPP_
#define _MESSAGES_SCATTEREDPACKET_HPP_
#include <dissectors/packet.hpp>
#include <slice_allocator.hpp>

#include "Msg.hpp"
#include "ClassId.hpp"

/* FIXME: TO BE REMOVED */

namespace bm { 
    
    class ScatteredPacket : public Msg
    {
    public:
        ScatteredPacket(net::packet_slice const &s, int msg_id = 0)
        : Msg(msg_id ? msg_id : MSG_ID(ScatteredPacket)),
          slice_(s)
        {}

        ~ScatteredPacket() 
        {}

        /** Forbids copy and move constructors.
	 */
        ScatteredPacket(ScatteredPacket const &) = delete;

        /** Forbids copy and move assignment.
	 */
        ScatteredPacket& operator=(ScatteredPacket const &) = delete;

        std::shared_ptr<Msg> clone() const 
        {
            throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        // DELETEME
        // void pod_copy(mutable_buffer<uint8_t> buf) const 
        // {
        //     throw std::runtime_error(__PRETTY_FUNCTION__);
        // }
        // 
        // size_t pod_size() const 
        // {
        //     throw std::runtime_error(__PRETTY_FUNCTION__);
        // }

        template <typename Tp>
        Tp & get() 
        {
            return bm::get<Tp>(slice_);
        }
        template <typename Tp>
        Tp const & get() const
        {
            return bm::get<Tp>(slice_);
        }

        // predicates
        //
        bool is_tcp() const 
        {
            return bm::get<net::ipv4>(slice_).protocol_() == IPPROTO_TCP;
        }

        bool is_udp() const 
        {
            return bm::get<net::ipv4>(slice_).protocol_() == IPPROTO_UDP;
        }
        
        // helper functions...
        //
        size_t length() const
        {
            return bm::get<net::packet_info>(slice_).len_();
        }        

        uint32_t 
        tstamp_sec() const
        {
            return bm::get<net::packet_info>(slice_).sec_();
        }

        uint32_t 
        tstamp_usec() const
        {
            return bm::get<net::packet_info>(slice_).usec_();
        }

        
        uint16_t caplen() const
        {
            return bm::get<net::packet_info>(slice_).caplen_();
        }
        
        uint16_t len() const
        {
            return bm::get<net::packet_info>(slice_).len_();
        }

        uint16_t src_port() const
        {
            return bm::get<net::packet_info>(slice_).src_port_();
        }

        uint16_t dst_port() const
        {
            return bm::get<net::packet_info>(slice_).dst_port_();
        }

    private:
        net::packet_slice     slice_;
    };

} // namespace bm


#endif // _MESSAGES_SCATTEREDPACKET_HPP_
