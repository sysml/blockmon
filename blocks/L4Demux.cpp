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
 * <blockinfo type="L4Demux" invocation="direct, indirect" thread_exclusive="false">
 *   <humandesc>
 *   Takes Packet messages and demultiplexes them across three possible output
 *   gates depending on their transport protocol: TCP packets are forwarded
 *   through the out_tcp gate, UDP packets through out_udp and any other packet
 *   through out_unknown.
 *   </humandesc>
 *
 *   <shortdesc>Demultiplexes packets based on their transport protocol</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="out_tcp" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_udp" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_unknown" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <Packet.hpp>
#include <BlockFactory.hpp>


namespace blockmon
{

    /**
     * Implements a block that demultiplexes packet messages based on their transport protocol
     * 0.5 seconds.
     */
    class L4Demux: public Block
    {
        int m_ingate_id;
        int m_out_tcp;
        int m_out_udp;
        int m_out_unknown;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        L4Demux(const std::string &name, invocation_type invocation)
        : Block(name, invocation), 
          m_ingate_id(register_input_gate("in_pkt")), 
          m_out_tcp(register_output_gate("out_tcp")), 
          m_out_udp(register_output_gate("out_udp")), 
          m_out_unknown(register_output_gate("out_unknown"))
        {}

        L4Demux(const L4Demux&)=delete;
        L4Demux(L4Demux&&)=delete;
        L4Demux& operator=(const L4Demux&)=delete;
        L4Demux& operator=(L4Demux&&)=delete;

        /**
         * @brief Configures the block: in this case does nothing as the block has no params 
         */
        virtual void _configure(const pugi::xml_node& /* n */)
        {
        }

        /**
         * @brief Destructor
         */
        virtual ~L4Demux()
        {}

        /**
         * If the message received is not of type Packet throw an exception,
         * otherwise demultiplexes it. 
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type()!=MSG_ID(Packet)) throw std::runtime_error("counter: unexpected msg type");
            const Packet* packet = static_cast<const Packet*>(m.get());
            
            if(packet->is_tcp()) 
            {
                send_out_through(std::move(m),m_out_tcp);
            } 
            else if(packet->is_udp())
            {
                send_out_through(std::move(m),m_out_udp);
            }
            else
            {
                send_out_through(std::move(m),m_out_unknown);
            }

        }

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(L4Demux,"L4Demux");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

};//blockmon




