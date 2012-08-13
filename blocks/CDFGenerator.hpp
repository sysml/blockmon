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

#ifndef _BLOCKS_CDFGENERATOR_HPP_
#define _BLOCKS_CDFGENERATOR_HPP_

#include <vector>
#include <sstream>
#include <math.h>

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>

namespace blockmon
{

    /**
     * Implements a block that print the CDFGenerator of the input feature every interval,
     * adding a noise depending on the epsilon value.
     */
    class CDFGenerator: public Block
    {

        int m_min;
        int m_max;
        int m_bin;
        int m_ingate_id;
        double m_epsilon;
        std::vector<int> m_histo;
        std::vector<int> m_cdf;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        CDFGenerator(const std::string &name, invocation_type invocation) 
        : Block(name, invocation), 
          m_min(0),
          m_max(0),
          m_bin(0),
          m_ingate_id(register_input_gate("in_feat"))
        {}

        /**
         * @brief Destructor
         */
        ~CDFGenerator()  {}

        /**
         * @brief Configures the block,
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node& /* n */) ;

        /**
         * If the message received is not of type IdValueCouple throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) ;

        /**
         * Timer call back, prints out the current message count to the console
         * @return 0 upon success, negative otherwise
         */
        void _handle_timer(std::shared_ptr<Timer>&& ) ;
    };


  #ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(CDFGenerator,"CDFGenerator");
  #endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _BLOCKS_CDFGENERATOR_HPP_
