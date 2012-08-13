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

#ifndef _CORE_DISSECTORS_ETHERNET_HPP_
#define _CORE_DISSECTORS_ETHERNET_HPP_

#include <cstdint>
#include <string>
#include <stdexcept>

#include <arpa/inet.h>
#include <net/ethernet.h>
#include <netinet/ether.h>

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace net {

    /*
     * 802.1q VLAN extended header 
     */

    struct h8021q_t {
        uint16_t    tpid;
        union {
            uint16_t tci;
            struct {
                uint16_t pcp:3,
                         cf1:1,
                         vid:12;
            };
        };
    };

    /*
     *	This is an Ethernet frame header.
     */

    struct ethernet : public ether_header {  // struct ether_header

        // u_int8_t  ether_dhost[ETH_ALEN];	/* destination eth addr	*/
        // u_int8_t  ether_shost[ETH_ALEN];	/* source ether addr	*/
        // u_int16_t ether_type;		    /* packet type ID field	*/

        std::string
        ether_dhost_() const
        {
            char buf[20];
            ether_ntoa_r(reinterpret_cast<struct ether_addr const *>(ether_dhost), buf);
            return buf;  
        }

        std::string
        ether_shost_() const
        {
            char buf[20];
            ether_ntoa_r(reinterpret_cast<struct ether_addr const *>(ether_shost), buf);
            return buf;  
        }

        uint16_t 
        ether_type_() const
        {
            return ntohs(ether_type);
        }

        const h8021q_t *
        get_8021q_() const
        {
            if (ntohs(ether_type) != ETHERTYPE_VLAN)
                return NULL;
            return reinterpret_cast<h8021q_t const *>(&ether_type);
        }

        // size_of and proto member functions:
        //
        
        size_t size_of() const
        {
            if (ntohs(ether_type) == ETHERTYPE_VLAN)
                return sizeof(ether_header) + sizeof(h8021q_t);
            else
                return sizeof(ether_header);
        }

        uint16_t proto() const
        {
            return ether_type_();
        }

    };

}  // namespace net

#endif // _CORE_DISSECTORS_ETHERNET_HPP_
