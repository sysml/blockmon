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

#include <Block.hpp>
#include <Timer.hpp>
#include <TimerThread.hpp>

namespace blockmon { 

    void Block::run()
    {
        int nb = m_ingates.size();

        while (1)
        {
            std::shared_ptr<Timer> t(std::move(m_timer_queue.pop()));
            if(!t) break;
            _handle_timer(std::move(t));
        }

        for (int i=0; i<nb; ++i)
        {
            for (int n=0; n<MAX_MSG_DEQUEUE; ++n)
            {
                std::shared_ptr<const Msg> m(std::move(m_ingates[i].dequeue()));
                if (!m) break;
                _receive_msg(std::move(m),i);
            }
        }
        _do_async();
    }

    int Block::register_input_gate(const std::string& name) //base class registers gates
    {
        int id = m_last_in_id++;
        m_ingates.push_back(InGate(*this,id)); 
        m_input_ids.insert(std::pair<std::string, int>(name,id));
        return id;
    }

    int Block::register_output_gate(const std::string& name)
    {
        int id = m_last_out_id++;
        m_outgates.push_back(OutGate(*this,id)); 
        m_output_ids.insert(std::pair<std::string, int>(name,id));
        return id;
    }

    std::string Block::list_variables()
    {
        std::stringstream ss(std::stringstream::in | std::stringstream::out);
        for (auto it = m_variables.begin(); it != m_variables.end(); ++it)
        {
            ss << it->first;

            if((it->second)->is_readable())
                ss << ",read"; 
            if((it->second)->is_writable())
                ss << ",write";
            ss << ";";
        }
        
        std::string ret;
        ss >> ret;
        return ret;
    }


    Block::~Block(void)
    {
         if (TimerThread::inst != NULL)
           TimerThread::instance().remove_references(*this);
    }
    
    void Block::handle_timer(std::shared_ptr<Timer> t) {
                if (m_invocation == invocation_type::Direct) {
                    if (m_issynchronized) {
                        std::lock_guard<std::mutex> tmp(m_mutex);
                        _handle_timer(std::move(t));
                    } else {
                        _handle_timer(std::move(t));
                    }
                } else {
                    m_timer_queue.push(std::move(t));
                }
            }

    void Block::_handle_timer(std::shared_ptr<Timer>&& t) {
    	throw std::logic_error("timer set on block without _handle_timer()");
    }
    
    void Block::set_timer_at(ustime_t ts, const std::string &name, unsigned int id)
    {
        std::shared_ptr<Timer> t(static_cast<Timer*>(new OneShotTimer(*this, ts, name, id)));
        TimerThread::instance().schedule_timer(std::move(t));
    }

    void Block::set_periodic_timer(ustime_t us, const std::string &name, unsigned int id)
    {
        std::shared_ptr<Timer> t(new PeriodicTimer(*this, get_BM_time() + us, name, id, us));
        TimerThread::instance().schedule_timer(std::move(t));
    }

} // namespace blockmon
