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
 * <blockinfo type="PeriodFlowMeter" invocation="indirect" thread_exclusive="False">
 *   <humandesc>
 *       Receives packet messages and keeps a table of per-flow statistics.
 *       Upon expiration of a timer (default is 500 ms), the whole table is flushed: a Flow message for
 *       every table entry is sent out and the whole state of the table is erased.
 *   </humandesc>
 *   <shortdesc>Receives packet messages and keeps a table of per-flow
 *   statistics, exporting them periodically</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="out_flow" msg_type="Flow" m_start="0" m_end="0" />
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element timeout{
 *           attribute ms {xsd:integer}
 *           }?
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *          <timeout ms="500"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include<Block.hpp>
#include <BlockFactory.hpp>
#include<Flow.hpp>
#include<Packet.hpp>
#include<unordered_map>
#include<vector>

namespace blockmon
{
    
    /**
      * Class implementing a flow table
      * A hash table stores the flow entries while a circular list keeps track of which
      * entries have to be checked for expiration
      */
    
    class PeriodFlowMeter: public Block
    {

        /**
          * callable object used to compute the hash of a FlowKey
          */
        struct my_hash : public std::unary_function<FlowKey, size_t>
        {
        private:
            /**
              * general purpose hash function that computes the hash of a byte array
              * @param b the byte array address
              * @param s the array size
              */
            static unsigned int simplehash(const char* b,size_t s)
            {
                int remaining_length=s;
                unsigned int hash=0x66B566B5;
                const char* it = b;
                while(remaining_length >= 2)
                {
                    hash ^=    (hash <<  7) ^  (*it++) * (hash >> 3);
                    hash ^= (~((hash << 11) + ((*it++) ^ (hash >> 5))));
                    remaining_length -= 2;
                }
                if (remaining_length)
                {
                    hash ^= (hash <<  7) ^ (*it) * (hash >> 3);
                }
                return hash;
            }     
        public:
            /**
              * computes the hash of a flow_key object
              * First it copies the content of the key into a zeroed area so that 
              * there is not random garbage in the padding bytes
              * @param t the flow key
              */
            size_t operator()(const FlowKey& t) const    
            {
                FlowKey local;
                memset(&local,0,sizeof(local)); //we need to 0 any random garbage in the padding
                local = t; 
                return simplehash(reinterpret_cast<const char*> (&local),sizeof(FlowKey) );
            }
        };

        /**
          * callable object used to check whether two flows are equal
          */
        struct my_equal_to : public std::binary_function<FlowKey,FlowKey, bool>
        {
            bool operator()(const FlowKey &lhs, const FlowKey &rhs) const
            {
                return (lhs == rhs) ;
            }
        };

        std::unordered_map<FlowKey, std::shared_ptr<const Msg>, my_hash, my_equal_to  > m_flow_table;
        int m_in_gate_id;
        int m_out_gate_id;
        int  m_timeout_ms; 


    public:

        /**
         * @brief Constructor
         * @param name         The name of the  block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be indirectly invoked, and will ignore any contrary configuration.
         */
        PeriodFlowMeter(const std::string &name, invocation_type invocation)
        :Block(name, invocation_type::Indirect), //ignore options, sniffer must be indirect
        m_flow_table(),
        m_in_gate_id(register_input_gate("in_pkt")),
        m_out_gate_id(register_output_gate("out_flow")),
        m_timeout_ms(100)
        {
            if (invocation != invocation_type::Indirect) 
            {
                blocklog("PeriodFlowMeter must be Indirect, ignoring configuration", log_warning);
            }
        }


        PeriodFlowMeter(const PeriodFlowMeter&) = delete;
        PeriodFlowMeter& operator=(const PeriodFlowMeter&) = delete;
        PeriodFlowMeter(PeriodFlowMeter&&) = delete;
        PeriodFlowMeter& operator=(PeriodFlowMeter&&) = delete;

        /**
         * @brief Configures the block: defines whether reports should only concern expired flows 
         * and sets the timeout value
         * @param n The configuration parameters 
         */
        virtual void _configure(const pugi::xml_node&  n ) 
        {
           pugi::xml_node timeout = n.child("timeout");
            if(timeout)
            {
                if(timeout.attribute("ms"))
                    m_timeout_ms = timeout.attribute("ms").as_uint();
                else
                    throw std::runtime_error("PeriodFlowMeter: malformed timeout paramter");
            }
            set_periodic_timer(m_timeout_ms * 1000,"flow_indirect_timeout",0);

        }
        /**
          * Goes through the flows in the list and sends out a corresponding Flow message
          * After that, it resets the flow table
          */
        void _handle_timer(std::shared_ptr<Timer>&& )
        {
            for (auto it = m_flow_table.begin(); it != m_flow_table.end(); ++it)
            {
                    send_out_through(std::move(it->second),m_out_gate_id);
            }
            m_flow_table.clear();

        }

        /**
          * It receives a Packet message (if not, it throws an exception)
          * It checks if the corresponding flow is already in the table.
          * If so, it updates the corresponding entry, otherwise it inserts
          * a new entry into the table 
          * @param m a Packet message
          */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type()!=MSG_ID(Packet))
                throw std::runtime_error("PeriodFlowMeter:: wrong message type");
            const Packet* packet = static_cast<const Packet*> (m.get());
            auto flow_it = m_flow_table.find( packet->key());
            auto chrono_now =  std::chrono::system_clock::now();
            ustime_t us_now =  (std::chrono::duration_cast<std::chrono::milliseconds> (chrono_now.time_since_epoch())).count();
            if (flow_it ==  m_flow_table.end())
            {
                Flow* new_flow = new Flow (packet->key());
                new_flow->expand_interval (us_now);
                new_flow->increment_bytes (packet->length());
                new_flow->increment_packets (1);
                std::shared_ptr<const Msg> flow_sp (new_flow);
                m_flow_table[packet->key()] = flow_sp;
            }
            else
            {
                Flow* flow = const_cast<Flow*> (static_cast<const Flow*>(flow_it->second.get()));
                flow->expand_interval (us_now);
                flow->increment_bytes (packet->length());
                flow->increment_packets (1);
            }
        }


    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PeriodFlowMeter,"PeriodFlowMeter")
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}//namespace blockmon
