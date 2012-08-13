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

#ifndef _MESSAGES_OBSERVATION_HPP_
#define _MESSAGES_OBSERVATION_HPP_

#include "Msg.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"

#include <ctime>
#include <cstring>

namespace blockmon
{

  /**
   * A labeled number with a timestamp.
   */
    class Observation: public Msg {
    public:

        /**
         * regular constructor          */
        Observation(ustime_t otime, std::string label, uint64_t value):
        Msg(MSG_ID(Observation)),
        m_otime(otime),
        m_label(label),
        m_value(value) 
        {}

        Observation(std::string label, uint64_t value):
        Msg(MSG_ID(Observation)),
        m_otime(0),
        m_label(label),
        m_value(value) 
        {
          timeval now;
          gettimeofday(&now, NULL);
          m_otime = timeval_to_us(now);
        }

        ustime_t otime() const
        {
            return m_otime;
        }
        
        uint64_t value() const
        {
            return m_value;
        }

        const std::string& label() const
        {
            return m_label;
        }
        
        /*
         * destructor
         */
        ~Observation() 
        {}


        /**
          *returns a copy of the message 
          */

        std::shared_ptr<Msg> clone() const 
        {
            Observation* new_obs = new Observation(m_otime, m_label, m_value);
            return std::shared_ptr<Msg>(new_obs);
        }


    protected:
        ustime_t m_otime;
        std::string m_label;
        uint64_t m_value;
    };

}

#endif // _MESSAGES_OBSERVATION_HPP_
