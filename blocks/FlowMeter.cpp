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
 * <blockinfo type="FlowMeter" invocation="indirect" thread_exclusive="False">
 *   <humandesc>
 *       Receives packet messages and keeps a table of per-flow statistics, and, depending on the configuration, also the packets making up that flow.
 *       A circular queue is used to keep track of the last time a flow has been checked for 
 *       expiration. 
 *       Two timeout values are used. The first one is the idle timeout (default value is 500 ms): whenever a flow record has not been
 *       receiving a packet for more than such time interval, the flow is considered as expired, its associated
 *       record is sent out and its table entry erased
 *.      The second one, the active timeout (default value is 100 ms), is activated when a flow has been active for longer than the corresponding time
 *       interval. When such timeout expires, a record about the flow is sent out and the counters in the corresponding table entry
 *       are reset. 
 *       Notice that, while the idle timeout is checked by using a Blockmon timer mechanism, the indirect timeout is checked upon
 *       arrival of a new packet belonging to the flow.
 *   </humandesc>
 *   <shortdesc>Receives packet messages and keeps a table of per-flow statistics, and, depending on the configuration, also the packets making up that flow.</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="out_flow" msg_type="Flow" m_start="0" m_end="0" />
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      attribute store_packets {xsd:boolean}?
 *      element idle_timeout{
 *           attribute ms {xsd:integer}
 *           }?
 *      element idle_timeout{
 *           attribute ms {xsd:integer}
 *           }?
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params store_packets="true">
 *          <active_timeout ms="500"/>
 *          <idle_timeout ms="100"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Flow.hpp>
#include <Packet.hpp>
#include <arpa/inet.h>

#include <memory>
#include <unordered_map>
#include <vector>

namespace blockmon
{
    
    /**
      * Class implementing a flow table
      * A hash table stores the flow entries while a circular list keeps track of which
      * entries have to be checked for expiration
      */
    
    class FlowMeter: public Block
    {

      static std::string ip_to_string(uint32_t ip)
      {

	char addr_buffer[INET_ADDRSTRLEN];
	//inet_ntop expects network byte order                                                                                                                      
	uint32_t flipped_ip=htonl(ip);

	if(!inet_ntop(AF_INET, &flipped_ip, addr_buffer, INET_ADDRSTRLEN))
	  throw std::runtime_error("cannot convert ip address");
	return std::string (addr_buffer);
      }
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
        /**
          * slot of the flow queue, keeps track of the last time
          * when the flow was checked for expiration
          * it also stores a shared pointer to the table entry
          */
        struct queue_slot
        {
            std::shared_ptr<const Msg>  flow_ptr;
            ustime_t last_checked;
            queue_slot& operator=(queue_slot&& qs)
            {
                flow_ptr = std::move(qs.flow_ptr);
                last_checked = qs.last_checked;
                return *this;
            }
        };

        std::unordered_map<FlowKey, std::shared_ptr<const Msg>, my_hash, my_equal_to  > m_flow_table;
        static const int Q_SIZE = 128*1024;
        //WARNING THS NEED TO BE POWER OF 2
        std::vector<queue_slot> m_flow_queue;
        unsigned int m_queue_head;
        unsigned int m_queue_tail;
        int m_in_gate_id;
        int m_out_gate_id;
        int  m_idle_timeout_ms; 
        unsigned int  m_active_timeout_ms; 
        bool m_store_packets;

        /**
          * helper function to dequeue a slot from the flow queue
          * @param slot the where the content will be moved into
          * @return true if extraction succeeded, false if the queue was empty
          */
        bool pop_slot(queue_slot& slot)
        {
            if(m_queue_head == m_queue_tail)
                return false;
            slot = std::move(m_flow_queue[m_queue_head]);
            unsigned int next_head = (m_queue_head + 1)&(Q_SIZE -1);
            m_queue_head = next_head;
            return true;
        }

        /**
          * helper function to enqueue a slot into the flow queue
          * @param slot the content which will be moved into the queue
          * @return true if insertion succeeded, false if the queue was full
          */
        bool push_slot(queue_slot&& slot)
        {
            unsigned int next_tail = (m_queue_tail + 1)&(Q_SIZE -1);
            if(next_tail == m_queue_head)
                return false;
            m_flow_queue[m_queue_tail] = std::move(slot);
            m_queue_tail = next_tail;
            return true;
        }

    public:

        /**
         * Constructs a FlowMeter.
	 *
         * @param name         The name of the  block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be indirectly invoked, and will ignore any contrary configuration.
         */
        FlowMeter(const std::string &name, invocation_type invocation)
        :Block(name, invocation_type::Indirect), //ignore options, flow meter  must be indirect
        m_flow_table(),
        m_flow_queue(Q_SIZE),
        m_queue_head(0),
        m_queue_tail(0),
        m_in_gate_id(register_input_gate("in_pkt")),
        m_out_gate_id(register_output_gate("out_flow")),
        m_idle_timeout_ms(500),
	m_active_timeout_ms(100),
	m_store_packets(false)
        {
            if (invocation != invocation_type::Indirect) 
            {
                blocklog("FlowMeter must be Indirect, ignoring configuration", log_warning);
            }
        }

        FlowMeter(const FlowMeter&) = delete;
        FlowMeter& operator=(const FlowMeter&) = delete;
        FlowMeter(FlowMeter&&) = delete;
        FlowMeter& operator=(FlowMeter&&) = delete;

        /**
         * @brief Configures the block: defines whether reports should only concern expired flows 
         * and sets the timeout value.
         * This routine also sets a periodic timer for checking the table for expired flows.
         * The timer period is set to the value of the idle timeout.
         * @param n The configuration parameters 
         */
        virtual void _configure(const pugi::xml_node&  n ) 
        {
            pugi::xml_node idle_timeout = n.child("idle_timeout");
            if(idle_timeout)
            {
                if(idle_timeout.attribute("ms"))
                    m_idle_timeout_ms = idle_timeout.attribute("ms").as_uint();
                else
                    throw std::runtime_error("FlowMeter: malformed timeout paramter");
            }
            pugi::xml_node active_timeout = n.child("active_timeout");
            if(active_timeout)
            {
                if(active_timeout.attribute("ms"))
                    m_active_timeout_ms = active_timeout.attribute("ms").as_uint();
                else
                    throw std::runtime_error("FlowMeter: malformed timeout paramter");
            }

            set_periodic_timer( m_idle_timeout_ms * 1000,"flow_active_timeout",0);
            pugi::xml_attribute store_packets = n.attribute("store_packets");
            if(store_packets)
            {
	        m_store_packets = store_packets.as_bool();
	    }
        }
        /**
          * Upon expiration of the idle timeout timer, it goes through the flows in the list and checks whether the timeout for them expired
          * If so, it sends the flow report out and deletes the flow from the table
          * Otherwise (if the option is set) it exports a flow report anyhow and inserts it back into the queue
          * Notice that the timer is handled in the indirect block's context and not in the context of the timer thread
          */
        void _handle_timer(std::shared_ptr<Timer>&& )
        {
            //flows whose last packet is older than this limit are considered as expired
            ustime_t tnow = get_BM_time();
            ustime_t us_limit = tnow - m_idle_timeout_ms * 1000;
            while(1)
            {
                queue_slot cur_slot;
                if(!pop_slot(cur_slot))
                    return; //queue is empty    
                const Flow* cur_flow = static_cast<const Flow*> (cur_slot.flow_ptr.get());
                if(cur_flow->end_time() < us_limit) //timeout expired for this flow+
                {
                    m_flow_table.erase(cur_flow->key());
		    printf("sending info out from handle_timer!\n");
                    send_out_through(std::move(cur_slot.flow_ptr),m_out_gate_id);
                }
                else 
                {
                    bool last_slot = (cur_slot.last_checked > us_limit);
                    cur_slot.last_checked = tnow;
                    push_slot(std::move(cur_slot)); //enqueue again
                    if(last_slot)
                        return;

                }
            }
        }

        /**
          * It receives a Packet message (if not, it throws an exception)
          * It checks if the corresponding flow is already in the table.
          * If so, it updates the corresponding entry, otherwise it inserts
          * a new entry into the table and the flow queue
          * @param m a Packet message
          */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type()!=MSG_ID(Packet))
                throw std::runtime_error("FlowMeter: wrong message type"
					 " (only Packet is accepted)");
            const Packet* packet = static_cast<const Packet*> (m.get());
            auto flow_it = m_flow_table.find( packet->key());
            ustime_t us_now = get_BM_time();
            if (flow_it ==  m_flow_table.end())
            {
                Flow* new_flow = new Flow (packet->key());

		/*printf("insert flow: <%s:%d -> %s:%d proto=%d>\n", 
		       ip_to_string(new_flow->key().src_ip4).c_str(),
		       new_flow->key().src_port,
		       ip_to_string(new_flow->key().dst_ip4).c_str(),
		       new_flow->key().dst_port,
		       new_flow->key().proto);*/

                new_flow->expand_interval (us_now);
                new_flow->increment_bytes (packet->length());
                new_flow->increment_packets (1);
		if (m_store_packets)
		  new_flow->add_packet(std::dynamic_pointer_cast<const Packet>(m));
                std::shared_ptr<const Msg> flow_sp (new_flow);
                m_flow_table[packet->key()] = flow_sp;
                queue_slot new_slot;
                new_slot.flow_ptr = std::move (flow_sp);
                new_slot.last_checked = us_now;
                if(!push_slot(std::move(new_slot)))
                    throw std::runtime_error("FlowMeter: queue is full");
            }
            else
            {
                Flow* flow = const_cast<Flow*> (static_cast<const Flow*>(flow_it->second.get()));
                if( ((us_now - flow->start_time()) / 1000) > m_active_timeout_ms )
                {
                    flow->expand_interval (us_now);
                    
                    /* printf("exporting flow: <%s:%d -> %s:%d proto=%d>\n", 
                           ip_to_string(flow->key().src_ip4).c_str(),
                           flow->key().src_port,
                           ip_to_string(flow->key().dst_ip4).c_str(),
                           flow->key().dst_port,
                           flow->key().proto);*/
            
                    send_out_through(flow_it->second->clone(),m_out_gate_id);
                    flow->reset();
                }
                flow->expand_interval (us_now);
                flow->increment_bytes (packet->length());
                flow->increment_packets (1);
		if (m_store_packets)
		  flow->add_packet(std::dynamic_pointer_cast<const Packet>(m));

            }
        }


    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(FlowMeter,"FlowMeter")
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}//namespace blockmon
