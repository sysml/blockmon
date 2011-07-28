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
 * Logs every 0.5 seconds the number of messages it received, expects messages
 * of type RawPacket (see base/messages/RawPacket.hpp). This blocks takes no
 * parameters
 *
 * @blockname{PktCounter}
 * @gates{in_pkt(msg:RawPacket),}
 *
 */
#include<Block.hpp>
#include<RawPacket.hpp>
#include<BlockFactory.hpp>
#include<cstdio>


namespace bm
{

    /**
     * Implements a block that logs the number of messages it has received every
     * 0.5 seconds.
     */
    class PktCounter: public Block
    {

        unsigned long long m_count;
        int m_ingate_id;
        std::chrono::system_clock::time_point m_last_t; 
        bool m_timer;
        unsigned long long m_prec;
    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        PktCounter(const std::string &name, bool active, bool thread_safe) 
        : Block(name,"counter",active,thread_safe), 
        m_count(0), 
        m_ingate_id(register_input_gate("in_pkt")),
        m_last_t(std::chrono::system_clock::now()),
        m_timer(true),
        m_prec(0)
        {
            register_exposed_variable("count",make_rd_var(m_count));
            register_exposed_variable("wcount",make_wr_var(m_count));
        }

        /**
         * @brief Destructor
         */
        virtual ~PktCounter() {}

        /**
         * @brief Configures the block, in this case the export time is hard-coded
         * to 0.5 seconds
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node&  n )
        {
            if(!n.child("notimer"))
            {
                set_periodic_timer(std::chrono::microseconds(500000),"test",0);
            }
        }



        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != RAW_PACKET_CODE) throw std::runtime_error("counter: unexpected msg type");
            ++m_count;
            return 0;
        }

        /**
         * Performs any asynchronous processing (no-op function)
         * @return 0 upon success, negative otherwise
         */
        virtual int do_async_processing()
        {
            return 0;
        }

        /**
         * Timer call back, prints out the current message count to the console
         * @return 0 upon success, negative otherwise
         */

        virtual int _handle_timer(std::shared_ptr<Timer>&& );
    };


    REGISTER_BLOCK(PktCounter,"counter");

}//bm
