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

#include <InGate.hpp>
#include <Block.hpp>
#include <PoolManager.hpp>
#include <thread>

namespace blockmon { 

    void InGate::receive(std::shared_ptr<const Msg>&& inm)
    {
    	if(m_owner->is_direct()) {
            // directly invoked blocks: call receive_msg directly
            m_owner->receive_msg(std::move(inm),m_index);
        } else {
            // indirectly invoked blocks: enqueue
			bool queued=m_queue->push(std::move(inm));	// queued=false if the queue was full
#ifdef BLOCKING_QUEUE
			while( !queued &&
					m_owner->queue_type() != QUEUETYPE_DROPPING
					&& PoolManager::instance().isRunning()){
				if(m_owner->queue_type()==QUEUETYPE_MUTEX){
					std::unique_lock<std::mutex> lk(queue_mutex);
					is_waiting=true;
					queue_cond.wait_for(lk, WAIT_DURATION,
										[&]{
										return !m_queue->is_full();
										});
					is_waiting=false;
					lk.unlock();

				}
				else if(m_owner->queue_type()==QUEUETYPE_YIELDING){
					sched_yield();
				}
				else{	//sleeping
					usleep(m_owner->queue_type());
				}

				queued=m_queue->push(std::move(inm));
			}
#endif //BLOCKING_QUEUE
        }

    }

    std::shared_ptr<const Msg> InGate::dequeue()
	{
#ifdef BLOCKING_QUEUE
    	std::shared_ptr<const Msg> tmp;
    	if(m_owner->queue_type()==QUEUETYPE_MUTEX && is_waiting){
    		std::lock_guard<std::mutex> lk(queue_mutex);
    		m_queue->pop_notify_all(tmp, queue_cond);
    	}else{
    		m_queue->pop(tmp);
    	}
#else
    	std::shared_ptr<const Msg> tmp;
    	m_queue->pop(tmp);
#endif

		return tmp;
	}

    void InGate::connect(OutGate& out)
    {
        m_peers.push_back(&out);
    }

    void InGate::disconnect(OutGate* in)
    {
        auto rm=std::remove(m_peers.begin(),m_peers.end(),in);

        auto end=m_peers.end();
        if(rm==end)
            throw std::runtime_error("trying to disconect a non-connected gate");

        m_peers.erase(rm,end);
    }

    void InGate::disconnect_all()
    {
        for (auto it=m_peers.begin(); it!=m_peers.end(); ++it)
        {
            (*it)->disconnect(this);
        }
        m_peers.clear();
        m_queue->reset();
    }

    bool InGate::is_connected(){
    	return m_peers.size()>0;
    }



} // namespace blockmon






