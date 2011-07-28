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

/**
 * @file
 * Parse the headers of a RawPacket to read its tuple and add it
 * in a TuplePacket.
 *
 * @blockname{TupleViewer}
 * @gates{in_pkt(msg:RawPacket),out_pkt(msg:TuplePacket)}
 *
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <RawPacket.hpp>
#include <TuplePacket.hpp>

#define ETH_PROTO_IP4 0x800

namespace bm
{

    /**
     * Implements a block that parses the packet header
     */
    class TupleViewer: public Block
    {
        int m_in_gate_id;
        //int m_out_gate_id;
        
    public:

        /**
         * @brief Constructor
         * @param name         The name of the CMS packet counter block
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        TupleViewer(const std::string &name, bool active, bool thread_safe);

        /**
         * @brief Destructor
         */
        virtual ~TupleViewer() {}

        /**
         * @brief Configures the block, nothing to do.
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node& /*n*/) 
        {}

        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise send a message of type TuplePacket
         *
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index);

        /**
         * Performs any asynchronous processing (no-op function)
         *
         * @return 0 upon success, negative otherwise
         */
        virtual int do_async_processing()
        {
            return 0;
        }

        /**
         * Timer call back, prints out the current message count to the console
         *
         * @return 0 upon success, negative otherwise
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&&)
        {
            return 0;
        }
    };

    REGISTER_BLOCK(TupleViewer, "tuple_viewer");

}//bm
