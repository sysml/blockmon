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

#include "NetTypes.hpp"
#include <sstream>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

namespace blockmon {

    static const uint64_t k10_3 = 1000;
    static const uint64_t k10_6 = 1000000;
    static const uint64_t k10_9 = 1000000000;
    static const uint64_t k2_32 = static_cast<double>(2ULL<<32);

    ustime_t timespec_to_us(const timespec& ts) {
        return ts.tv_sec * k10_6 + ts.tv_nsec / k10_3;
    }
    
    const timespec us_to_timespec (ustime_t us) {
        timespec ts;
        ts.tv_sec = us / k10_6;
        ts.tv_nsec = (us % k10_6) * k10_3;
        return ts;
    }
    
    ustime_t timeval_to_us(const timeval& tv) {
        return tv.tv_sec * k10_6 + tv.tv_usec;
    }
    
    const ntptime us_to_ntp (ustime_t us) {
        ntptime nt;
        nt.sec = us / k10_6;
        nt.frac = static_cast<uint32_t>(static_cast<double>(us % k10_6) / k10_6 * k2_32);
        return nt;
    }

    const ntptime timespec_to_ntp (const timespec& ts) {
        ntptime nt;
        nt.sec = ts.tv_sec;
        nt.frac = static_cast<uint32_t>(static_cast<double>(ts.tv_nsec) / k10_9 * k2_32);
        return nt;
    }

    ustime_t ntp_to_us (const ntptime& nt) {
        return nt.sec * k10_6 + static_cast<uint32_t>(static_cast<double>(nt.frac) * k10_6 / k2_32);
    }
    
    const timespec ntp_to_timespec(const ntptime& nt) {
        timespec ts;
        ts.tv_sec = nt.sec;
        ts.tv_nsec = static_cast<uint32_t>(static_cast<double>(nt.frac) * k10_9 / k2_32);
        return ts;
    }
    
    const std::string ipv4_to_string(uint32_t ipv4) {
        std::ostringstream os;
        os  << ((ipv4 & 0xFF000000) >> 24) << "."
            << ((ipv4 & 0x00FF0000) >> 16) << "."
            << ((ipv4 & 0x0000FF00) >> 8) << "."
            << (ipv4 & 0x000000FF);
        return os.str();
    }
        
    const uint32_t string_to_ipv4(std::string str) {
        std::vector<std::string> strvec;
        boost::split(strvec, str, boost::is_any_of("."));
        uint32_t a = boost::lexical_cast<uint32_t>(strvec[0]) << 24;
        a |= (boost::lexical_cast<uint32_t>(strvec[1]) << 16);
        a |= (boost::lexical_cast<uint32_t>(strvec[2]) << 8);
        a |= boost::lexical_cast<uint32_t>(strvec[3]);
        return a;
    }
    
}
