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

#ifndef _BLOCKS_RRDEMUX_HPP_
#define _BLOCKS_RRDEMUX_HPP_
/*
 * <blockinfo type="RRDemux" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *     Receives messages and sends them through a configured number
 *     of output gates in a round-robin fashion. There can be any number of
 *     output gates, each named outputX with X going from 1 to the configured
 *     number of gates.
 *   </humandesc>
 *
 *   <shortdesc>Sends messages out through its gates in a round-robin fashion</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="input" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="output1" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="output2" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="outputN" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element gates {
 *        attribute number {integer}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <gates number="5" />
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

namespace blockmon
{

    /**
     * Implements a block that merges sketches.
     */
    class RRDemux: public Block
    {
		int m_outgates_number;
		int m_current_outgate;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
         RRDemux(const std::string &name, invocation_type invocation);
    
         virtual ~RRDemux() ;

        /**
         * @brief Configures the block, get the number of gates
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node& n) ;

        /**
         * Resend the received messages
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int index) ;

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(RRDemux, "RRDemux");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _BLOCKS_RRDEMUX_HPP_
