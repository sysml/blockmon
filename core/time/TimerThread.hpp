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

#ifndef _CORE_TIME_TIMERTHREAD_HPP_
#define _CORE_TIME_TIMERTHREAD_HPP_


#include <iostream>
#include <algorithm>
#include <vector>
#include <queue>
#include <thread>
#include <mutex>
#include <stdlib.h>

#include <BMTime.h>
#include <Timer.hpp>
#include <pthread.h>

#include<atomic>

namespace blockmon {
/**
  * Represent the callable object which is executed by the timer
  * thread and that handles timers for the whole Blockmon instance.
  *
  * It keeps an ordered timer heap, waits until the next timer is to
  * be executed, and calls the associated Block::handle_timer()
  * function.  In order not to waste too much CPU on busy waiting, the
  * threads checks the timer heap every millisecond and handles all of
  * the expired timers.  This is an obvious trade-off between
  * precision and resource consumption that can be tuned by changing
  * the sampling interval.
  *
  * When a block sets up a new timer, this is inserted into a
  * thread-safe timer queue. When the threads wakes up, all of the
  * timers in the queue are pushed into the timer heap.  Notice that,
  * if the block is passive, the block's timer handling function is
  * executed in the context of this thread.  Notice also that this is
  * a singleton class (there can be only one instance): therefore only
  * one timer thread is allowed, thus guaranteeing that the timers are
  * strictly ordered.  For these reasons, timer handling functions
  * that involve a lot of processing should be avoided (unless the
  * block is always meant to be active).
  */
    class TimerThread
    {
        /**
          * class constructor
          * private,as in Meyer's singleton
          */
        TimerThread()
        : m_stop(false),
          m_running(false),
          m_queue(),
          m_heap(),
          m_queue_spinlock()
        {
            pthread_spin_init(&m_queue_spinlock, PTHREAD_PROCESS_PRIVATE);
            atexit(&cleanup);
        }

        ~TimerThread()
        {
        	pthread_spin_destroy(&m_queue_spinlock);
        }

        static void cleanup() {
            delete inst;
            inst = NULL;
        }

        /**
          * this object is non-moveable and non-copiable
          */
        TimerThread(const TimerThread&) = delete;
        TimerThread& operator=(const TimerThread&) = delete;
        TimerThread(TimerThread&&) = delete;
        TimerThread& operator=(TimerThread&&) = delete;

        /**
          * Callable object class used to sort the timer heap
          */
        struct hsorter
        {
            bool operator()(const std::shared_ptr<Timer>& t1,const std::shared_ptr<Timer>& t2) const
            {
                return t1->time_point() > t2->time_point();
            }
        };

        /**
          * private helper function used to insert a timer in the heap
          * @param in a shared pointer to the timer to be inserted (as r-value reference)
          */
        void insert_in_heap(std::shared_ptr<Timer>&& in);

        /**
          * private helper function used to pop from the heap the timer with the earliest expiration time point
          * @return  a shared pointer to the timer popped from the heap
          */
        std::shared_ptr<Timer> remove_from_heap();

        /** 
          * helper callable objects
          * used in order to remove from the heap all of the timers associated to a given block
          */
        struct remover
        {
            const Block& m_ref;
            remover(const Block& b):m_ref(b)
            {}
            bool operator()(const std::shared_ptr<Timer>& in)
            {
                return (&m_ref == &(in->owner()));
            }
        };
    public:
        
        /**
          * unique instance accessor as in Meyer's singleton
          * @return a reference to the only instance of this class
          */
        static TimerThread& 
        instance()
        {
            if (!m_instance.load()) {
                std::cout << "allocating singleton" << std::endl;
                inst = new TimerThread();
                m_instance.store(true);
                assert(inst != NULL);
            }
            return *inst;
        }
        
        /**
          * This is called by the block (through its base class functions) in order to schedule a timer
          * @param in a shared pointer to the timer to be scheduled (as r-value reference).
          * The timer is provisionally stored into a timer queue and will be pushed into the heap the next time this thread wakes up.
          */
        void schedule_timer(std::shared_ptr<Timer>&& in);

        /**
          * Notifies the timer thread functor that is should stop by setting a boolean flag
          */
        void stop();


        /**
          * This is the actual function which is executed by the timer thread
          * It checks the timer queue every millisecond and handles all of the expired timers.
          * After handling one timer (i.e. calling the handle_timer method of the associated block) it 
          * checks whether it needs to be rescheduled by calling its next_time virtual function.
          * It runs until it is signalled to stop through the stop() method
          */
        void operator()();

        /** checks if there are any timer events which should be processed and calls the handle_timer methods
         *  on the corresponding blocks. This can be called from outside in case you want to make sure that
         *  all timer events have been processed at a certain time.
         */
        void process_timer_events();

        /**
          * Removes both from the timer heap and the timer queue all of the timers associated to a given block.
          * This is needed when a block is removed, otherwise invalid references to is would be left.
          * This function is called by the destructor of the block superclass and can only be executed when the timer thread is stopped
          * @param a const reference to the Block whose timers are to be removed (it is only used to derive the block address)
          */
        void remove_references(const Block& b);

    private:

        inline void lock(){
        	pthread_spin_lock(&m_queue_spinlock);
        }

        inline void unlock(){
        	pthread_spin_unlock(&m_queue_spinlock);
        }

        bool m_stop;
        bool m_running;
        std::vector<std::shared_ptr<Timer> > m_queue;
        std::priority_queue<std::shared_ptr<Timer>, std::vector<std::shared_ptr<Timer>>, hsorter> m_heap;
        pthread_spinlock_t m_queue_spinlock;
    public:
        static std::atomic<bool> m_instance;
        static TimerThread* inst;
    };

} // namespace blockmon

#endif // _CORE_TIME_TIMERTHREAD_HPP_
