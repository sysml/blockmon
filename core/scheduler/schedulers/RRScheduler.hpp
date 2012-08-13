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

#ifndef _CORE_SCHEDULER_SCHEDULERS_RRSCHEDULER_HPP_
#define _CORE_SCHEDULER_SCHEDULERS_RRSCHEDULER_HPP_
namespace blockmon
{

#include<Block.hpp>
#include<vector>
#include<shared_queue.hpp>

class RRScheduler
{
	unsigned int m_last_id;
	const unsigned int m_nq;
	std::vector<std::shared_ptr<more::shared_queue<std::shared_ptr<Block>,32 > > > m_queues;
	RRScheduler(const RRScheduler&)=delete;
	RRScheduler& operator = (const RRScheduler&)=delete;

	public:
	RRScheduler(unsigned int nq):m_last_id(0),m_nq(nq), m_queues(nq)
	{
		auto end=m_queues.end();
		for (auto it=m_queues.begin();it!=end;++it)
			*it=std::shared_ptr<more::shared_queue<std::shared_ptr<Block>,32 > >(new more::shared_queue<std::shared_ptr<Block>,32 >);
	}

	void register_thread(int id, const std::vector<unsigned int>& )
	{
		if ((unsigned int)id>=m_nq)
			throw std::runtime_error("RRSCheduler::thread index out of range" );
	}

	void unregister_thread(int)
	{
		//nothing to do
	}

	void add_block(std::shared_ptr<Block>&& b )
	{
		if(!m_queues[m_last_id++%m_nq]->push_back(std::move(b)))
			throw std::runtime_error("RRScheduler:: task queue is full");

	}

	void remove_block(const Block* b)
	{
		auto end=m_queues.end();
		for (auto it=m_queues.begin(); it!=end; ++it)
		{
			int size=(*it)->size();
			for (int i=0; i<size; ++i)
			{
				std::shared_ptr<Block> tmp;
				if(!((*it)->pop_front(tmp)))
					throw std::runtime_error("RRScheduler:: wrong size");
				if(tmp.get()==b)
					return;//block out of the queue
			(*it)->push_back(std::move(tmp));
			}
		}

		throw std::runtime_error("RRScheduler:: block to be removed was not found");
	}

	std::shared_ptr<Block> next_task(int id)
	{
		if ((unsigned int)id>=m_nq)
			throw std::runtime_error("RRSCheduler::thread index out of range" );
		
		std::shared_ptr<Block> tmp;
		if(!m_queues[id]->pop_front(tmp))
			std::cout<<"RRScheduler::WARNING:: thread number "<<id<<" has no task to execute\n";
		return tmp;
	}


	void task_done(int id, std::shared_ptr<Block>&& b)
	{
		if ((unsigned int)id>=m_nq)
			throw std::runtime_error("RRSCheduler::thread index out of range" );
		if(!m_queues[id]->push_back(std::move(b)))
			throw std::runtime_error("RRScheduler:: after taks execution task queue has become full");
	}
};
}
#endif // _CORE_SCHEDULER_SCHEDULERS_RRSCHEDULER_HPP_
