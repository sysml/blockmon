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

#ifndef _CORE_DISSECTORS_UDP_HPP_
#define _CORE_DISSECTORS_UDP_HPP_

#include <cstdint>
#include <stdexcept>
#include <string>

#include <arpa/inet.h>
#include <netinet/udp.h>

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace net { 

    struct udp : public udphdr {

        //   u_int16_t source;
        //   u_int16_t dest;
        //   u_int16_t len;
        //   u_int16_t check;
        
        uint16_t 
        source_() const
        {
            return ntohs(source);
        }

        uint16_t 
        dest_() const
        {
            return ntohs(dest);
        }

        uint32_t len_() const 
        {
            return ntohs(len);
        }

        uint32_t check_() const
        {
            return ntohs(check);
        }

        // size_of and proto member functions:
        //
        
        size_t size_of() const
        {
            return sizeof(udphdr);
        }
        
        uint16_t proto() const
        {
            return 0; // no meaning for udp
        }

    };

} // namespace net

#endif // _CORE_DISSECTORS_UDP_HPP_
