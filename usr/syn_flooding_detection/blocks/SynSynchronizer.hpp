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
 * Generate a single message to send a sample CMS sketch to synchronize
 * many counters (the hash functions are synchronized this way).
 * The width and depth of the sketch may be configured.
 * Configuration:
 *	<sketch width="4096" depth="8" />
 * The sketch width and depth represent the number of columns and lines of the generated sketch
 *
 * @blockname{SynSynchronizer}
 * @gates{out_sketch_proto(msg:Sketch)}
 *
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <cms.hpp>

namespace bm
{

    /**
     * Implements a block that generates a sketch packet
     */
    class SynSynchronizer: public Block
    {
        int m_outgate_id;
        bool m_sketch_sent;

        // Configuration
        int m_cms_width;
        int m_cms_depth;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the block
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        SynSynchronizer(const std::string &name, bool active, bool thread_safe);

        /**
         * @brief Destructor
         */
        virtual ~SynSynchronizer();

        /** 
          * Non copyable by default
          */
        SynSynchronizer(const SynSynchronizer &) = delete;
        SynSynchronizer& operator=(const SynSynchronizer &) = delete;

        /**
         * @brief Configures the block
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node&  n);

        /**
         * Receive a message, should not happen
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            return 0;
        }

        /**
         * Performs any asynchronous processing (no-op function)
         * Sends the sketch message
         * @return 0 upon success, negative otherwise
         */
        virtual int do_async_processing();

        /**
         * Timer call back, export the sketch
         * @return 0 upon success, negative otherwise
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&&)
        {
            return 0;
        }
    };

    REGISTER_BLOCK(SynSynchronizer, "syn_synchronizer");
}//bm
