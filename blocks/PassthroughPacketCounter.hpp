/* Copyright (c) 2011, NEC Europe Ltd.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd. nor the names of its contributors
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

#ifndef _BASE_PASSTHROUGHPACKETCOUNTER_HPP_
#define _BASE_PASSTHROUGHPACKETCOUNTER_HPP_

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>
#include <NewPacket.hpp>
#include <cstdio>

namespace blockmon
{

    /**
     * Implements a block that logs the number of messages it has received every
     * 0.5 seconds.
     */
    class PassthroughPacketCounter: public Block
    {
        unsigned long long  m_pkt_cnt;
        unsigned long long m_byte_cnt;
        double m_pkt_rate;
        double m_byte_rate;
        unsigned int m_reset;

        unsigned long long m_pkt_cnt_prev;
        unsigned long long m_byte_cnt_prev;
        std::chrono::system_clock::time_point m_last_t; 
        bool m_timer;

        int m_ingate_id;
        int m_outgate_id;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        PassthroughPacketCounter(const std::string &name, invocation_type invocation) 
        : Block(name, invocation), 
        m_pkt_cnt(0), 
        m_byte_cnt(0),
	    m_pkt_rate(0),
	    m_byte_rate(0),
	    m_reset(0),
        m_pkt_cnt_prev(0),
        m_byte_cnt_prev(0),
        m_last_t(std::chrono::system_clock::now()),
        m_timer(true),
	  m_ingate_id(register_input_gate("in_pkt")),
	  m_outgate_id(register_output_gate("out_pkt"))
        {
            register_variable("byterate",make_rd_var(no_mutex_t(), m_byte_rate));
            register_variable("pktrate",make_rd_var(no_mutex_t(), m_pkt_rate));
            register_variable("pktcnt",make_rd_var(no_mutex_t(), m_pkt_cnt));
            register_variable("bytecnt",make_rd_var(no_mutex_t(), m_byte_cnt));
            register_variable("reset",make_wr_var(no_mutex_t(), m_reset));
        }

        /**
         * @brief Destructor
         */
        ~PassthroughPacketCounter()  {}

        /**
         * @brief Configures the block, in this case the export time is hard-coded
         * to 0.5 seconds
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n ) 
        {
            if(!n.child("notimer"))
            {
                set_periodic_timer(1000000,"test",0);
            }
        }

        /**
         * @brief Initialize the block
         */
        void _initialize() 
        {
        }

        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type()!=MSG_ID(Packet))
            {
                throw std::runtime_error("wrong message type in pkt counter");
            }
            
            if(m_reset==1)
            {
                m_pkt_cnt = 0;
                m_byte_cnt = 0;
		        m_byte_rate = 0;
		        m_pkt_rate = 0;
                m_reset = 0;
            }
            const Packet* packet_ptr = static_cast<const Packet*>(m.get()); 
            
            ++m_pkt_cnt;

            m_byte_cnt += packet_ptr->length();

	    send_out_through(std::move(m), m_outgate_id);
        }
        
        void _handle_timer(std::shared_ptr<Timer> &&t) ;

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PassthroughPacketCounter,"PassthroughPacketCounter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _BASE_PASSTHROUGHPACKETCOUNTER_HPP_
