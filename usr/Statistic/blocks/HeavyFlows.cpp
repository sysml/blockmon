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

/**
 * @file
 * Computes the heaviest flows (flows with the highest packet number) among the flow statistics it receives and
 * sends them out periodically
 * @blockname{HeavyFlows}
 * @gates{in_flows(msg:TupleStatistic), out_flows(msg:TupleStatistic)
 * }
 *
 *@param nflows: the number of heavy flows to be exported (default value is 10)
 *@param period: the exporting period in milliseconds (default value is 10)
 *
 * <b>Sample XML parameters:</b>
 * @verbatim
 *<params>
 *	<nflows n="100">
 *	<period msecs="100">
 *<params\>
 *@endverbatim
 *
 */

#include<queue>
#include<Block.hpp>
#include<RawPacket.hpp>
#include<BlockFactory.hpp>
#include<mutex>
#include<TupleStatistic.hpp>

namespace bm
{

    class HeavyFlows: public Block
    {
	static int npackets(const std::shared_ptr<const Msg>& m) 
	{
		return (static_cast<const TupleStatistic*>(m.get()))->get_packets();
	}


	struct mycmp
	{
		bool operator()(const std::shared_ptr<const Msg>& p1,const std::shared_ptr<const Msg>& p2)
		{
			return (npackets(p1)>npackets(p2));  
		}

	};
        int m_ingate;
        int m_outgate;
	std::priority_queue<std::shared_ptr<const Msg>,std::vector<std::shared_ptr<const Msg> >,mycmp > m_heap;
	unsigned int m_len;
	unsigned int m_msecs_t;
	bool m_mutex_active;
	std::mutex m_mutex;
    public:

        HeavyFlows(const std::string &name, bool active, bool thread_safe)
        : Block(name,"HeavyFlows",active,thread_safe), 
          m_ingate(register_input_gate("in_flows")), 
          m_outgate(register_output_gate("out_flows")),
	  m_heap(),
	  m_len(10),
	  m_msecs_t(10),
	  m_mutex_active((!active)&&(!thread_safe)),
	  m_mutex()
        {}


        virtual void _configure(const xml_node&  n )
        {
		xml_node len=n.child("flows");
		if(len)
			m_len=len.attribute("n").as_uint();

		xml_node period=n.child("period");
		if(period)
			m_msecs_t=period.attribute("msecs").as_uint();
			
		set_periodic_timer(std::chrono::microseconds(m_msecs_t*1000),"HeavyHitters",0);

        }

        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
	    if(m->type()!=TUPLE_STATISTIC_CODE)
		throw std::runtime_error("HeavyFlows:: wrong input message type");
	    std::unique_lock<std::mutex> guard(m_mutex,std::defer_lock);
	    if(m_mutex_active)
		    guard.lock();
	    if(m_heap.size()<m_len)
		    m_heap.push(std::move(m));
	    else if(npackets(m)>npackets(m_heap.top()))
	    {
		    m_heap.pop();
		    m_heap.push(std::move(m));
	    }
	    
            return 0;
        }

        virtual int do_async_processing()
        {
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
	    std::unique_lock<std::mutex> guard(m_mutex,std::defer_lock);
	    if(m_mutex_active)
		    guard.lock();
	    while(m_heap.size()>0)
	    {
		    send_out_through(std::shared_ptr<const Msg>(std::move(m_heap.top())),m_outgate);
		    m_heap.pop();

	    }
	    return 0;
        }

    };


    REGISTER_BLOCK(HeavyFlows,"heavyflows");

};//bm




