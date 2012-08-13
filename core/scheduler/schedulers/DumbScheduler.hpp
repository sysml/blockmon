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

#ifndef _CORE_SCHEDULER_SCHEDULERS_DUMBSCHEDULER_HPP_
#define _CORE_SCHEDULER_SCHEDULERS_DUMBSCHEDULER_HPP_
namespace blockmon
{

#include<Block.hpp>
#include<MpMcQueue.hpp>

class DumbScheduler
{
	MpMcQueue<Block> m_queue;
	DumbScheduler(const DumbScheduler&)=delete;
	DumbScheduler& operator = (const DumbScheduler&)=delete;

	public:
	DumbScheduler(unsigned int) : m_queue()
	{}

	void register_thread(int, const std::vector<unsigned int>&)
	{
		//no need to register
	}

	void unregister_thread(int)
	{
		//nothing to do
	}

	void add_block(std::shared_ptr<Block>&& b)
	{
		m_queue.push(std::move(b));

	}

	void remove_block(const Block* b)
	{
		m_queue.remove(*b);
	}	

	std::shared_ptr<Block> next_task(int)
	{
		return m_queue.pop();
	}


	void task_done(int, std::shared_ptr<Block>&& b)
	{
		m_queue.push(std::move(b));
	}
};
}
#endif // _CORE_SCHEDULER_SCHEDULERS_DUMBSCHEDULER_HPP_
