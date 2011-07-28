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

#ifndef _THREADHANDLER_HPP_
#define _THREADHANDLER_HPP_ 

#include <thread>
#include <memory>
#include <vector>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include <MpMcQueue.hpp>
#include <pthread.h>
#include <Block.hpp>

#include<PCScheduler.hpp>

namespace bm
{

    class ThreadHandler
    {
        

	Scheduler& m_scheduler;    
	cpu_set_t m_mask;
        std::atomic_bool m_stop;
        std::unique_ptr<std::thread> m_thread;
	int m_id;

    public:
        ThreadHandler(Scheduler& m, unsigned int id)
        :m_scheduler(m),m_mask(), m_stop(false), m_thread(),m_id(id)
        {}

        void run(const std::vector<unsigned int>& aff)
        {
            CPU_ZERO(&m_mask);
            for(unsigned int i=0; i<aff.size(); ++i)
            {
                if(aff[i]>CPU_SETSIZE)
                    throw std::runtime_error("affinity value hogher than maximum allowed");
                CPU_SET(aff[i],&m_mask);

            }
	    m_scheduler.register_thread(m_id,aff);

            m_thread=std::unique_ptr<std::thread> (new std::thread(std::ref(*this)));
        }

        void operator()()
	{
		if(CPU_COUNT(&m_mask)>0)
		{
			pthread_t id=pthread_self();
			int ret=pthread_setaffinity_np(id, sizeof(m_mask),&m_mask);
			if(ret!=0)
			{
				perror("setaffinity");
				throw(std::runtime_error("set affinity failed"));
			}
		}
		while(!m_stop.load())
		{

			std::shared_ptr<Block>torun(m_scheduler.next_task(m_id));
			if(torun)
			{
				torun->run();
				m_scheduler.task_done(m_id,std::move(torun));
			}
			else
			{
				std::this_thread::sleep_for(std::chrono::milliseconds(10));
			}
		}
		m_stop.store(false);
	}

        void stop()
        {
            m_stop.store(true);
            m_thread->join();
            m_thread.reset();
        }

    };

}

#endif /* _THREADHANDLER_HPP_ */
