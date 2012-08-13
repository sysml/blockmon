/* Copyright (c) 2011, Consorzio Nazionale Interuniversitario 
 * per le Telecomunicazioni. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the name of Interuniversitario per le Telecomunicazioni nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
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

#ifndef _CORE_DISSECTORS_IPV4_HPP_
#define _CORE_DISSECTORS_IPV4_HPP_

#include <stdexcept>
#include <string>
#include <cstdint>

#include <arpa/inet.h>
#include <netinet/ip.h>

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace net { 

    struct ipv4 : public iphdr { // struct iphdr

        //  #if __BYTE_ORDER == __LITTLE_ENDIAN
        //      unsigned int ihl:4;
        //      unsigned int version:4;
        //  #elif __BYTE_ORDER == __BIG_ENDIAN
        //      unsigned int version:4;
        //      unsigned int ihl:4;
        //  #endif
        //      u_int8_t tos;
        //      u_int16_t tot_len;
        //      u_int16_t id;
        //      u_int16_t frag_off;
        //      u_int8_t ttl;
        //      u_int8_t protocol;
        //      u_int16_t check;
        //      u_int32_t saddr;
        //      u_int32_t daddr;

        unsigned int 
        ihl_() const
        {
            return ihl;
        }
        
        unsigned int
        version_() const
        {
            return version;
        }

        uint8_t tos_() const
        {
            return tos;
        }

        uint16_t tot_len_() const
        {
            return ntohs(tot_len);
        }

        uint16_t id_() const
        {
            return ntohs(id);
        }

        uint16_t frag_off_() const
        {
            return ntohs(frag_off);
        }

        uint8_t ttl_() const
        {
            return ttl;
        }

        uint8_t protocol_() const
        {
            return protocol;
        }

        uint16_t check_() const
        {
            return ntohs(check);
        }

        std::string
        saddr_() const
        {
            char buf[16];
            inet_ntop(AF_INET, &saddr, buf, sizeof(buf));
            return buf;
        }

        std::string
        daddr_() const
        {
            char buf[16];
            inet_ntop(AF_INET, &daddr, buf, sizeof(buf));
            return buf;
        }            
        
        // size_of and proto member functions:
        //
        
        size_t size_of() const
        {
            return ihl << 2;            
        }

        uint16_t proto() const
        {
            return protocol_();
        }
        
    };

} // namespace net

#endif // _CORE_DISSECTORS_IPV4_HPP_
