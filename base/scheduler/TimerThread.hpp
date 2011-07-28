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

#ifndef _TIMERTHREAD_HPP_
#define _TIMERTHREAD_HPP_ 

#include <iostream>
#include <algorithm>
#include <vector>
#include <thread>
#include <mutex>

#include <Timer.hpp>
#include <MsgQueue.hpp>

namespace bm { 

    class TimerThread
    {
        TimerThread()
        : m_stop(false),
          m_running(false),
          m_queue(),
          m_heap(),
          m_queue_mutex()
        {
            std::make_heap(m_heap.begin(),m_heap.end(),hsorter());
        }

        ~TimerThread()
        {}

        TimerThread(const TimerThread&) = delete;
        TimerThread& operator=(const TimerThread&) = delete;

        struct hsorter
        {
            bool operator()(const std::shared_ptr<Timer>& t1,const std::shared_ptr<Timer>& t2) const
            {
                return t1->time_point() > t2->time_point();
            }
        };

        void insert_in_heap(std::shared_ptr<Timer>&& in)
        {
            m_heap.push_back(std::move(in));
            std::push_heap(m_heap.begin(),m_heap.end(),hsorter());
        }

        std::shared_ptr<Timer> remove_from_heap()
        {
            std::pop_heap(m_heap.begin(),m_heap.end(),hsorter());
            std::shared_ptr<Timer> tmp(std::move(m_heap.back()));
            m_heap.pop_back();
            return tmp;
        }

    public:
        
        /* Meyers singleton is thread-safe with g++-4.x */
        static TimerThread& 
        instance()
        {
            static TimerThread t;
            return t;
        }

        void schedule_timer(std::shared_ptr<Timer>&& in)
        {
            std::lock_guard<std::mutex> tmp(m_queue_mutex);
            m_queue.push_back(std::move(in));
        }

        void stop()
        {
            m_stop=true;
        }

        void operator()()
        {
            if(!m_running)
            {
                m_running=true;
            }
            else
            {
                throw std::runtime_error("trying to start timer thread while it is already running");
            }

            while(!m_stop)
            {
                {
                    std::lock_guard<std::mutex> tmp(m_queue_mutex);
                    while (!m_queue.empty())
                    {
                        insert_in_heap(std::move(m_queue.back()));
                        m_queue.pop_back();
                    }
                }
                std::chrono::system_clock::time_point tnow(std::chrono::system_clock::now());
                while((!m_heap.empty())&&(m_heap.front()->time_point()<=tnow))
                {
                    std::shared_ptr<Timer> t(remove_from_heap());
                    t->owner().handle_timer(t);
                    std::chrono::system_clock::time_point ttmp(t->time_point());
                    t->next_time();
                    if(t->time_point()!= ttmp )
                    {
                        insert_in_heap(std::move(t));
                    }
                }
                std::this_thread::sleep_for(std::chrono::milliseconds(1));//timers queue is sampled every 1 msec
            }

            m_running=false;
            m_stop=false;
        }

        struct remover
        {
            const Block& m_ref;
            remover(const Block& i):m_ref(i)
            {}
            bool operator()(const std::shared_ptr<Timer>& in)
            {
                return (&m_ref==&(in->owner()));
            }
        };

        void remove_references(const Block& b)
        {
            if(m_running)
            {
                throw std::runtime_error("timer thread::cannot remove references while the thread is running");
            }

            m_heap.erase( std::remove_if(m_heap.begin(),m_heap.end(),remover(b)),m_heap.end());
            m_queue.erase( std::remove_if(m_queue.begin(),m_queue.end(),remover(b)),m_queue.end());
        }

    private:
        bool m_stop;
        bool m_running;
        std::vector<std::shared_ptr<Timer> > m_queue;
        std::vector<std::shared_ptr<Timer> > m_heap;
        std::mutex m_queue_mutex;
    };

} // namespace bm

#endif /* _TIMERTHREAD_HPP_ */
