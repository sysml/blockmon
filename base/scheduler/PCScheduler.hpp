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

#ifndef __PCSCHEDULER_H_
#define __PCSCHEDULER_H_

#include<schedulers/DummScheduler.hpp>
#include<schedulers/RRScheduler.hpp>

namespace bm
{




template<typename T>
class PCScheduler
{
	T m_scheduler;
	PCScheduler(const PCScheduler&)=delete;
	PCScheduler& operator = (const PCScheduler&) = delete;
	
	public:
	PCScheduler(unsigned int n ): m_scheduler(n)
	{}

	void register_thread(int id, const std::vector<unsigned int>& affinity)
	{
		m_scheduler.register_thread(id,affinity);
	}

	void unregister_thread(int id)
	{
		m_scheduler.unregister_thread(id);
	}

	void add_block(std::shared_ptr<Block>&& b )
	{
		m_scheduler.add_block(std::move(b));
	}

	void remove_block(const Block* b)
	{
		m_scheduler.remove_block(b);
	}	
	
	std::shared_ptr<Block> next_task(int id)
	{
		return m_scheduler.next_task(id);
	
	}

	void task_done(int id, std::shared_ptr<Block>&& b)
	{
		m_scheduler.task_done(id,std::move(b));
	
	}
};

typedef PCScheduler<RRScheduler> Scheduler;
}
#endif
