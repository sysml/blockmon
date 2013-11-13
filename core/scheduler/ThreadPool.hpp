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

#ifndef _CORE_SCHEDULER_THREADPOOL_HPP_
#define _CORE_SCHEDULER_THREADPOOL_HPP_
#include <mutex>
#include <map>

#include <ThreadHandler.hpp>
#include <Scheduler.hpp>





namespace blockmon
{
    /**
      * forward declaration
      */
    class Block;

  /**
   * Manages the threads in a thread pool and binds them to a local scheduler.
   */
    class ThreadPool
    {
        Scheduler m_scheduler;
        std::vector<unsigned int> m_affinity;
        bool m_running;
        const int m_threadnum;
        std::vector<std::unique_ptr<ThreadHandler> > m_threads;
    public:
        /** Constructs a ThreadPool.
          *
          * @param tnum the number of threads in the pool
          * @param affinity a vector specifying all of the allowed
          * cores for the threads in this pool. The affinity will be
          * the same for every thread. An empty vector stands for no
          * affinity specification..
          */
        ThreadPool(int tnum, const std::vector<unsigned int>& affinity):
        m_scheduler(tnum), 
        m_affinity(affinity), 
        m_running(false),
        m_threadnum(tnum), 
        m_threads()
        {
            for (int i=0; i<m_threadnum; ++i)
            {
                m_threads.push_back(std::unique_ptr<ThreadHandler> (new ThreadHandler(m_scheduler,i)));
            }

        }

        ~ThreadPool()
        {}	

        /**
          * assigns a block to this thread pool
          * @ param b a shared pointer to the assigned block
          */
        void add_task(std::shared_ptr<Block> b)
        {
            if(m_running) throw std::runtime_error("cannot add task when thread pool is already running");
            m_scheduler.add_block(std::move(b));
        }

        /**
          * removes a block from the pool.
          * Notice that lookup is done based on the block address
          * @param b a const reference to the block to be removed (only used for computing the address)
          */
        void remove_task(const Block& b)
        {
            if(m_running) throw std::runtime_error("cannot remove task when thread pool is already running");
            m_scheduler.remove_block(&b);
        }

        /**
          * starts all of the threads in the pool
          */
        void run()
        {
            if(m_running) throw std::runtime_error("thread pool il already running");

            for (int i = 0; i < m_threadnum; ++i)
            {
                m_threads[i]->run(m_affinity);
            }
            m_running=true;
        }

		/**
          * stops all of the threads in the pool
          */
        void stop()
        {
            if(!m_running) throw std::runtime_error("thread pool is not running");
            //m_running=false;
            for (int i = 0; i < m_threadnum; ++i)
            {
                m_threads[i]->stop();
            }
            m_running=false;
        }
/*
        void join(){
        	if(m_running){
        		stop();
        	}
        	for (int i = 0; i < m_threadnum; ++i)
			{
				m_threads[i]->join();
			}
        }
*/
    };

}//namespace blockmon

#endif // _CORE_SCHEDULER_THREADPOOL_HPP_
