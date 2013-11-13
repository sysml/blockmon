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

#ifndef __DB_QUEUE_H__
#define __DB_QUEUE_H__


#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include <array>
#include <stdexcept>
#include <algorithm>
#include <cassert>
#include <chrono>
#include <thread>
#include <condition_variable>

template<typename T,unsigned int Qlen>
class DBQueue
{
    struct slot
    {
        std::atomic_bool valid;
        T payload;
        slot(): valid(false),payload()
        {}
    };
    struct buffer
    {
       std::array<slot,Qlen> vec;
       buffer(): vec()
       {}
    };

    static int exchange_queue(int q)
    {
        assert(q == 0 || q == 1);
        return q == 0 ? 1 : 0;
    }

    

    std::array<buffer,2> m_queues;
    std::atomic_uint m_pointer;        
    unsigned int m_read;
    unsigned int m_consumer_q;
    unsigned int m_full_slots;
    std::atomic_bool m_full;
    static const unsigned int MASK=0|(1<<31)|(1<<30);
    
    void swap_queues()
    {
        for(unsigned int i=0; i<m_full_slots; ++i)
        {
            m_queues[m_consumer_q].vec[i].valid.store(false,std::memory_order_release);
        }
        unsigned int newpoint=m_consumer_q<<30;
        m_consumer_q=exchange_queue(m_consumer_q);
        unsigned int old_pointer=m_pointer.exchange(newpoint,std::memory_order_release); 
        m_full.store(false,std::memory_order_release);
        old_pointer&=~MASK;
        m_full_slots=std::min(old_pointer,Qlen);
        m_read=0;
    }

    bool consume(T& in)
    {
        while(m_read < m_full_slots)
        {
            for (int i=0; i<100; ++i)
            {
                if(m_queues[m_consumer_q].vec[m_read].valid.load(std::memory_order_relaxed))
                {
                    int index = m_read++;
                    in = std::move(m_queues[m_consumer_q].vec[index].payload);
                    return true;
                }
                std::this_thread::sleep_for(std::chrono::microseconds(10));
            } 
            m_read++;
        }
        return false;
    }


public:
    DBQueue():m_queues(),m_pointer(0),m_read(0),m_consumer_q(1),m_full_slots(0),m_full(false)
    {}

    DBQueue(const DBQueue&)=delete;
    DBQueue(DBQueue&& other):m_queues(),m_pointer(other.m_pointer.load()),m_read(other.m_read),m_consumer_q(other.m_consumer_q),m_full_slots(other.m_full_slots),m_full(other.m_full.load())
    {
        for (int q=0; q<2; ++q)
            for (unsigned int i=0; i<Qlen; ++i)
            {
                if(other.m_queues[q].vec[i].valid.load())
                {
                    m_queues[q].vec[i].payload=std::move(other.m_queues[q].vec[i].payload);
                    m_queues[q].vec[i].valid.store(true);
                }
            }
    }


    DBQueue& operator=(const DBQueue&)=delete;
    DBQueue& operator=(DBQueue&& other)
    {
        m_pointer=other.m_pointer.load();
        m_read=other.m_read;
        m_consumer_q=other.m_consumer_q;
        m_full_slots=other.m_full_slots;
        m_full=other.m_full.load();
        for (int q=0; q<2; ++q)
            for (unsigned int i=0; i<Qlen; ++i)
            {
                if(other.m_queues[q].vec[i].valid.load())
                {
                    m_queues[q].vec[i].payload=std::move(other.m_queues[q].vec[i].payload);
                    m_queues[q].vec[i].valid.store(true);
                }
            }
        return *this;


    }

    /** reads the next entry from the consumer queue and forward the pointer.
    	if the last entry was reached already, the queues are swapped and the
    	first entry from the new consumer queue is returned
    */
    bool pop(T& in)
    {
       if(consume(in))
            return true;
        swap_queues();
        return consume(in);
    }

    /**	same as  bool pop(T& in) with one difference:
     *  if (and only if) the queues are swapped, the condition variable's
     *  notify_all() is called.
     */
    bool pop_notify_all(T& in, std::condition_variable& cond){
    	if(consume(in))
			return true;
		swap_queues();
		cond.notify_all();
		return consume(in);
    }

    /**	same as  bool pop(T& in) with one difference:
         *  if (and only if) the queues are swapped, the condition variable's
         *  notify_one() is called.
         */
	bool pop_notify_one(T& in, std::condition_variable& cond){
		if(consume(in))
			return true;
		swap_queues();
		cond.notify_one();
		return consume(in);
	}



    // perfect forwarding...
    template <typename Tp>
    bool push(Tp&& in)
    {
        if(m_full.load(std::memory_order_acquire))
            return false;
        unsigned int cur_pointer = m_pointer.fetch_add(1,std::memory_order_acquire);
        unsigned int cur_queue=(cur_pointer&MASK)>>30;
        assert((cur_queue==0)||(cur_queue==1));

        unsigned int my_slot = cur_pointer&(~MASK); 
        if (my_slot >= Qlen - 1)
        {
            if (my_slot == Qlen -1)
                m_full.store(true,std::memory_order_release);
            else
                return false;        
        }

        m_queues[cur_queue].vec[my_slot].payload=std::forward<Tp>(in);
        m_queues[cur_queue].vec[my_slot].valid.store(true,std::memory_order_release);
        return true;
    }


    bool is_full()
    {
        if(m_full.load(std::memory_order_acquire))
            return true;

        return false;
    }

    //this has to be executed out of the critical session 
    void reset()
    {
        for (auto qit=m_queues.begin(); qit!=m_queues.end(); ++qit)
            for (auto it=qit->vec.begin(); it!=qit->vec.end(); ++it)
            {
                if(it->valid.load())
                {
                T to_del(std::move(it->payload));
                it->valid.store(false,std::memory_order_relaxed);
                }
            }
        m_full.store(false,std::memory_order_relaxed);
        m_pointer.store(0,std::memory_order_relaxed);
        m_consumer_q=1;
        m_read=0;
        m_full_slots=0;
    }


};    
    

#endif //__DB_QUEUE_H__


