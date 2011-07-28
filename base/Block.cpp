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

/*
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

#include <Block.hpp>
#include <TimerThread.hpp>

namespace bm { 

    int Block::register_input_gate(const std::string &name) //base class registers gates
    {
        int id = m_last_in_id++;
        m_ingates.push_back(InGate(*this,id)); 
        m_input_ids.insert(std::pair<std::string, int>(name,id));
        return id;
    }

    int Block::register_output_gate(const std::string &name)
    {
        int id = m_last_out_id++;
        m_outgates.push_back(OutGate(*this,id)); 
        m_output_ids.insert(std::pair<std::string, int>(name,id));
        return id;
    }

    Block::~Block(void)
    {
         TimerThread::instance().remove_references(*this);
    }
    void Block::set_timer_at(std::chrono::system_clock::time_point tp, const std::string &name, unsigned int id)
    {
        std::shared_ptr<Timer> t(static_cast<Timer*>(new OneShotTimer(*this,tp,name, id)));
        TimerThread::instance().schedule_timer(std::move(t));
    }

    void Block::set_periodic_timer(std::chrono::microseconds T, const std::string &name, unsigned int id)
    {
        std::shared_ptr<Timer> t(new PeriodicTimer(*this,std::chrono::system_clock::now()+T,name, id,T));
        TimerThread::instance().schedule_timer(std::move(t));
    }

} // namespace bm
