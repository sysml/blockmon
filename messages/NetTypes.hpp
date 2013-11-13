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

#ifndef _MESSAGES_NETTYPES_HPP_
#define _MESSAGES_NETTYPES_HPP_

#include <ctime>
#include <string>
#include <stdint.h>

#include <sys/time.h>

namespace blockmon
{
    struct ethhdr {
        uint8_t     smac[6];
        uint8_t     dmac[6];
        uint16_t    ethertype;
    } __attribute__((packed));

    struct eth1qhdr {
        uint16_t        vlantag;
        uint16_t        ethertype;
    } __attribute__((packed));

    struct ip4hdr {
        uint8_t         hlv;
        uint8_t         tos;
        uint16_t        len;
        uint16_t        fragid;
        uint16_t        fragoff;
        uint8_t         ttl;
        uint8_t         proto;
        uint16_t        cksum;
        uint32_t        sip4;
        uint32_t        dip4;
    } __attribute__((packed));

    struct porthdr {
        uint16_t        sp;
        uint16_t        dp;
    } __attribute__((packed));

    struct tcphdr {
        uint16_t        sp;
        uint16_t        dp;
        uint32_t        seqnum;
        uint32_t        acknum;
        uint8_t         payoff;
        uint8_t         flags;
        uint8_t         window;
        uint8_t         cksum;
        uint8_t         urgent;
    } __attribute__((packed));

    struct udphdr {
        uint16_t        sp;
        uint16_t        dp;
        uint16_t        len;
        uint16_t        cksum;
    } __attribute__((packed));


    struct FlowKey {
        
        uint32_t    src_ip4;
        uint32_t    dst_ip4;
        uint16_t    src_port;
        uint16_t    dst_port;
        uint8_t     proto;   

        FlowKey()
        : src_ip4()
        , dst_ip4()
        , src_port()
        , dst_port()
        , proto() 
        {}

        FlowKey(uint32_t _src_ip,
                uint32_t _dst_ip,
                uint16_t _src_port,
                uint16_t _dst_port,
                uint8_t  _proto)
        : src_ip4(_src_ip)
        , dst_ip4(_dst_ip)
        , src_port(_src_port)
        , dst_port(_dst_port)
        , proto(_proto)
        {}

        FlowKey(const FlowKey& rhs) = default;
        
        // src_ip4(rhs.src_ip4),
        // dst_ip4(rhs.dst_ip4),
        // src_port(rhs.src_port),
        // dst_port(rhs.dst_port),
        // proto(rhs.proto) {}

        FlowKey& operator=(const FlowKey &rhs) = default;

        //     if (this != &rhs) {
        //         src_ip4 = rhs.src_ip4;
        //         dst_ip4 = rhs.dst_ip4;
        //         src_port = rhs.src_port;
        //         dst_port = rhs.dst_port;
        //         proto = rhs.proto;
        //     }
        //     return *this;
        // }

        bool operator==(const FlowKey& rhs) const 
        {
            if ((src_ip4 == rhs.src_ip4) &&
                (dst_ip4 == rhs.dst_ip4) &&
                (src_port == rhs.src_port) &&
                (dst_port == rhs.dst_port) &&
                (proto == rhs.proto)) {
                return true;
            } 
            return false;
        }

        bool operator!= (const FlowKey& rhs) 
        {
            return !(*this == rhs);
        } 

        explicit operator bool() const
        {
            return src_ip4 != 0;
        }
    };

    /** ustime_t is a timestamp in UNIX epoch milliseconds */
    typedef uint64_t ustime_t;

    /** ntptime_t is an NTP timestamp, in seconds since the NTP epoch, and fractional seconds */
    struct ntptime {
        uint32_t  sec;
        uint32_t  frac;
    };


    /** Converts a timespec to a microsecond epoch.
     * 
     * @param ts the timespec to convert
     * @return the microsecond epoch corresponding to the timespec
     */
    ustime_t timespec_to_us(const timespec& ts);

    /** Converts a microsecond epoch to a timespec.
     * 
     * @param us the microsecond epoch to convert
     * @return the timespec corresponding to the timespec
     */
    const timespec us_to_timespec (ustime_t us);

    /** Converts a timeval to a microsecond epoch.
     * 
     * @param tv the timeval to convert
     * @return the microsecond epoch corresponding to the timeval
     */
    ustime_t timeval_to_us(const timeval& tv);

    /** Converts an NTP time to a microsecond epoch.
     * 
     * @param nt the NTP time to convert
     * @return the microsecond epoch corresponding to the NTP time
     */
    ustime_t ntp_to_us (const ntptime& nt);

    /** Converts microsecond epoch to an NTP time.
     * 
     * @param us the microsecond epoch to convert
     * @return the NTP time corresponding to the microsecond epoch
     */
    const ntptime us_to_ntp (ustime_t us);

    /** Converts an NTP time to a timespec.
     * 
     * @param nt the NTP time to convert
     * @return the timespec corresponding to the NTP time
     */
    const timespec ntp_to_timespec(const ntptime& nt);

    /** Converts timespec to an NTP time.
     * 
     * @param ts the timespec to convert
     * @return the NTP time corresponding to the timespec
     */
    const ntptime timespec_to_ntp (const timespec& ts);

    /** Portably prints an IPv4 address to a std::string
    */
    const std::string ipv4_to_string(uint32_t ipv4);

    const uint32_t string_to_ipv4(std::string str);


}

#endif // _MESSAGES_NETTYPES_HPP_
