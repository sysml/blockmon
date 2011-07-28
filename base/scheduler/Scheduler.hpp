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

#ifndef _SCHEDULER_HPP_
#define _SCHEDULER_HPP_ 

#include <queue>
#include <memory>
#include <iostream>
#include <algorithm>
#include <atomic>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else
#include <atomic>
#endif

#include <Block.hpp>

namespace bm { 

    class Scheduler
    {
        std::vector<std::shared_ptr<Block> > m_queue;

        std::atomic_bool m_running;
        std::atomic_bool m_stop;

        unsigned int m_cur;

    public:

        Scheduler ()
        : m_running(false), m_stop(false),m_cur(0)
        {}

        ~Scheduler()
        {}

        bool isrunning() const
        {
            return m_running.load();
        }

        void stop() 
        {
            m_stop.store(true);
            m_running.store(false);
        }

        struct remover
        {
            std::string m_name;
            remover(std::string s):m_name(s)
            {}
            bool operator()(const std::shared_ptr<Block>& in)
            {
                return (in->get_name()==m_name);
            }
        };

        void remove_block(std::string bname)
        {
            if(m_running.load()) 
                throw std::runtime_error("trying to schedule a block while scheduler is running");

            m_queue.erase(std::remove_if(m_queue.begin(),m_queue.end(),remover(bname)),m_queue.end());

        }

        void add_block(std::shared_ptr<Block> b)
        {
            if(m_running.load()) 
                throw std::runtime_error("trying to schedule a block while scheduler is running");

            if(!b->is_active()) 
                throw std::runtime_error("trying to schedule a passive block ");

            m_queue.push_back(b);
        }

        void operator()()
        {
            m_running.store(true);
            m_stop.store(false);	

            while (!m_stop)
            {
                m_queue[m_cur]->run();
                ++m_cur;
                if(m_cur==m_queue.size())
                    m_cur=0;
            }
        }
    };

} // namespace bm


#endif /* _SCHEDULER_HPP_ */
