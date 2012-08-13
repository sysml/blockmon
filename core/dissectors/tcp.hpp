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

#ifndef _CORE_DISSECTORS_TCP_HPP_
#define _CORE_DISSECTORS_TCP_HPP_

#include <cstdint>
#include <stdexcept>
#include <string>

#include <arpa/inet.h>
#include <netinet/tcp.h>
 
/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace net { 

    struct tcp : public tcphdr {

        //     u_int16_t source;
        //     u_int16_t dest;
        //     u_int32_t seq;
        //     u_int32_t ack_seq;
        // #  if __BYTE_ORDER == __LITTLE_ENDIAN
        //     u_int16_t res1:4;
        //     u_int16_t doff:4;
        //     u_int16_t fin:1;
        //     u_int16_t syn:1;
        //     u_int16_t rst:1;
        //     u_int16_t psh:1;
        //     u_int16_t ack:1;
        //     u_int16_t urg:1;
        //     u_int16_t res2:2;
        // #  elif __BYTE_ORDER == __BIG_ENDIAN
        //     u_int16_t doff:4;
        //     u_int16_t res1:4;
        //     u_int16_t res2:2;
        //     u_int16_t urg:1;
        //     u_int16_t ack:1;
        //     u_int16_t psh:1;
        //     u_int16_t rst:1;
        //     u_int16_t syn:1;
        //     u_int16_t fin:1;
        // #  else
        // #   error "Adjust your <bits/endian.h> defines"
        // #  endif
        //     u_int16_t window;
        //     u_int16_t check;
        //     u_int16_t urg_ptr;

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

        uint32_t seq_() const 
        {
            return ntohl(seq);
        }
        uint32_t ack_seq_() const
        {
            return ntohl(ack_seq);
        }

        uint8_t res1_() const 
        {
            return res1;
        }
        uint8_t doff_() const
        {
            return doff;
        }
        uint8_t res2_() const 
        { 
            return res2; 
        }

        bool fin_() const 
        { 
            return fin; 
        }
        bool syn_() const 
        { 
            return syn; 
        }
        bool rst_() const 
        { 
            return rst; 
        }
        bool psh_() const 
        { 
            return psh; 
        }
        bool ack_() const 
        { 
            return ack; 
        }
        bool urg_() const 
        { 
            return urg; 
        }

        uint16_t window_() const 
        { 
            return ntohs(window); 
        }

        uint16_t check_() const 
        { 
            return ntohs(check);  
        } 

        uint16_t urg_ptr_() const 
        { 
            return ntohs(urg_ptr);
        };
        
        // size_of and proto member functions:
        //
        
        size_t size_of() const
        {
            return doff << 2;
        }

        uint16_t proto() const
        {
            return 0;
        }
    };

} // namespace net

#endif // _CORE_DISSECTORS_TCP_HPP_
