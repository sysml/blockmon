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

#ifndef _BASE_IPDUMBANONYMIZER_HPP_
#define _BASE_IPDUMBANONYMIZER_HPP_
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>


namespace blockmon
{

    /**
     * Implements a block that parses the packet header
     */
    class IPDumbAnonymizer: public Block
    {
        int m_in_gate_id;
        int m_out_gate_id;
        bool anon_src;
        bool anon_dst;
        
    public:

        /**
         * @brief Constructor
         * @param name         The name of the  block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        IPDumbAnonymizer(const std::string &name, invocation_type invocation);

        /**
         * @brief Destructor
         */
        virtual ~IPDumbAnonymizer() {}

        /**
         * @brief Configures the block, nothing to do.
         * @param n The configuration parameters 
         */
        virtual void _configure(const pugi::xml_node&  n);

        /**
         * If the message received is not of type Packet throw an exception,
         * otherwise send a message of Packet
         *
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int index);

    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(IPDumbAnonymizer, "IPDumbAnonymizer");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _BASE_IPDUMBANONYMIZER_HPP_
