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

#include <TimerThread.hpp>

namespace blockmon {

    TimerThread* TimerThread::inst = NULL;
    std::atomic<bool> TimerThread::m_instance(false);

	void TimerThread::insert_in_heap(std::shared_ptr<Timer>&& in){
		m_heap.push(std::move(in));
	}

	std::shared_ptr<Timer> TimerThread::remove_from_heap(){
		std::shared_ptr<Timer> tmp=m_heap.top();
		m_heap.pop();
        return tmp;
	}

	void TimerThread::schedule_timer(std::shared_ptr<Timer>&& in){
			/*std::cout << __LINE__ <<" ";*/ lock();
			m_queue.push_back(std::move(in));
			unlock();
	}

	void TimerThread::stop(){
		m_stop=true;
	}

	void TimerThread::operator()(){
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
				/*std::cout << __LINE__ <<" ";*/ lock();
				while (!m_queue.empty())
				{
					insert_in_heap(std::move(m_queue.back()));
					m_queue.pop_back();
				}
				unlock();
			}

			process_timer_events();

			/**
			  * this time interval can be changed in order to tune the precision/performance trade off
			  */
			std::this_thread::sleep_for(std::chrono::milliseconds(1));//timers queue is sampled every 1 msec
		}

		m_running=false;
		m_stop=true;
		std::cout << "Stopped TimerThread..."<<std::endl;
	}

	void TimerThread::process_timer_events(){
		 //std::chrono::system_clock::time_point tnow(std::chrono::system_clock::now());
		ustime_t tnow = get_BM_time();
		/*std::cout << __LINE__ <<" ";*/
		/* WARNING:
		 * In here we have to be very careful with locks/mutexes as the timer-heap's spinlock
		 * might conflict with a block m_mutex leading to a deadlock. Thats why we use very fine-granular
		 * locking in here
		*/
		lock();
		while((!m_heap.empty())&&(m_heap.top()->time_point() <= tnow))
		{
			std::shared_ptr<Timer> t(remove_from_heap());
			assert(t->time_point() <= m_heap.top()->time_point());
			unlock();	// important to unlock here!
			t->owner().handle_timer(t);
			ustime_t ttmp = t->time_point();
			t->next_time();
			lock();	// and to lock again here
			if(t->time_point()!= ttmp )
			{
				insert_in_heap(std::move(t));
			}

		}
		unlock();
	}

     void TimerThread::remove_references(const Block& b){
      
          if(m_running)
          {
               throw std::runtime_error("timer thread::cannot remove references while the thread is running");
          }
          
          m_queue.erase( std::remove_if(m_queue.begin(),m_queue.end(),remover(b)),m_queue.end());
        
          // remove all from m_heap
          while(!m_heap.empty()){
                m_heap.pop();
          }

     }

}
