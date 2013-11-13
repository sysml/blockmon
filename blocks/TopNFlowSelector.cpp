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
 * <blockinfo type="TopNFlowSelector" invocation="both" thread_exclusive="False">
 *   <humandesc>
 *        Receives Flow messages and keeps a list of the N messages with the highest number of packets
 *        Upon expiration of a timer, it sends all of them out of its out gate.
 *        The number N of messages to be selected, along with the flush period, are optional configuration parameters.
 *        Default values are 10 messages and 100ms respectively
 *   </humandesc>
 *   <shortdesc>Selects the flows with the highest number of packets </shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="out_flow" msg_type="Flow" m_start="0" m_end="0" />
 *     <gate type="input" name="in_flow" msg_type="Flow" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *       element top_flows{
 *       attribute number {xsd:integer}
 *       }?
 *       element period{
 *       attribute msecs {xsd:integer}
 *       }?
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *            <top_flows number="10"/>
 *            <period msecs="4000"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include<queue>
#include<Block.hpp>
#include<Flow.hpp>
#include<BlockFactory.hpp>
#include<mutex>

namespace blockmon
{

    class TopNFlowSelector: public Block
    {
        /**
          * helper function that reports the number of packet of a Flow.
          * This does not check the message type and assumes it is Flow.
          * @param m a shared pointer to a Msg of type Flow
          * @return the number of packets in the flow
          */
        static uint64_t npackets(const std::shared_ptr<const Msg>& m) 
        {
            return (static_cast<const Flow*>(m.get()))->packets();
        }


        /**
          * callable object that is used to keep the heap sorted
          */
        struct mycmp
        {
            bool operator()(const std::shared_ptr<const Msg>& p1,const std::shared_ptr<const Msg>& p2)
            {
                return !(npackets(p1)<npackets(p2));  
            }

        };
        int m_ingate;
        int m_outgate;
        std::priority_queue<std::shared_ptr<const Msg>,std::vector<std::shared_ptr<const Msg> >,mycmp > m_heap;
        unsigned int m_len;
        unsigned int m_msecs_t;
        bool m_mutex_indirect;
        std::mutex m_mutex;
    public:

        /**
          * class constructor
          */
        TopNFlowSelector(const std::string &name, invocation_type invocation)
        : Block(name, invocation),
        m_ingate(register_input_gate("in_flow")), 
        m_outgate(register_output_gate("out_flow")),
        m_heap(),
        m_len(10),
        m_msecs_t(100),
        m_mutex_indirect((invocation == invocation_type::Direct)),
        m_mutex()
        {}


        /**
          * parsed the xml configuration subtree and sets the number of heavy flows to report
          * and the reporting periof.
          * @param n the xml configurstion subtree
          */
        virtual void _configure(const pugi::xml_node&  n ) 
        {
           pugi::xml_node len=n.child("top_flows");
            if(len)
            {
                if(len.attribute("number"))
                    m_len=len.attribute("number").as_uint();
            }

           pugi::xml_node period=n.child("period");
            if(period)  
            {
                if(period.attribute("msecs"))
                    m_msecs_t=period.attribute("msecs").as_uint();
            }
            set_periodic_timer(m_msecs_t*1000,"HeavyHitters",0);

        }


        /**
          * Receives a Flow message (if the message belongs to another class it throws an exception
          * If the flow is among the N heaviest received in this period, it is saved into a heap.
          * Otherwise it is discarded.
          * @param m Flow message
          */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type() != MSG_ID(Flow))
                throw std::runtime_error("TopNFlowSelector:: wrong input message type");
            std::unique_lock<std::mutex> guard(m_mutex,std::defer_lock);
            if(m_mutex_indirect)
                guard.lock();
            if(m_heap.size()<m_len)
            {
                m_heap.push(std::move(m));
                return;
            }
            if(npackets(m)>npackets(m_heap.top()))
            {
                m_heap.pop();
                m_heap.push(std::move(m));
            }
        }

        /*
         * upun timer expiration, flushes the heaviest flow messages it received during this period
         * */
        void _handle_timer(std::shared_ptr<Timer>&& ) 
        {
            std::unique_lock<std::mutex> guard(m_mutex,std::defer_lock);
            if(m_mutex_indirect)
                guard.lock();
            while(m_heap.size()>0)
            {
                send_out_through(std::shared_ptr<const Msg>(std::move(m_heap.top())),m_outgate);
                m_heap.pop();
            }
        }

        virtual bool _synchronize_access() { return false; }

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(TopNFlowSelector,"TopNFlowSelector");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

};//blockmon




