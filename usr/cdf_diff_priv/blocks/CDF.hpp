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
 * Logs every interval seconds the cdf for the value field
 *
 * @blockname{CDF}
 * @gates{in_feat(msg:IdValuePair),}
 *
 * <b>Sample XML parameters:</b>
 * @verbatim
 * <params>
 * <build_cdf interval="2000"/> #millisecond
 * <cdf_param min="0" max="1500" bin="150"/>
 * <diff_priv epsilon="0.8"/> #if -1 do not add noise
 * </params>
 * @endverbatim
 *
 */
#include <vector>
#include <sstream>
#include <math.h>

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <IdValueCouple.hpp>

namespace bm
{

    /**
     * Implements a block that print the CDF of the input feature every interval,
     * adding a noise depending on the epsilon value.
     */
    class CDF: public Block
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
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        CDF(const std::string &name, bool active, bool thread_safe) 
        : Block(name,"CDF",active,thread_safe), 
          m_min(0),
          m_max(0),
          m_bin(0),
          m_ingate_id(register_input_gate("in_feat"))
        {}

        /**
         * @brief Destructor
         */
        virtual ~CDF() {}

        /**
         * @brief Configures the block,
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node& /* n */);

        /**
         * If the message received is not of type IdValueCouple throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */);

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


    REGISTER_BLOCK(CDF,"CDF");

}//bm
