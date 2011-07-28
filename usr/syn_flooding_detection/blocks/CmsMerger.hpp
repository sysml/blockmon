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
 * Receive sketches and merge them to send only one.
 * Configuration:
 *	<merge number="2" />
 * number is the number of sketches the merger waits for to send the sketch
 *
 * @blockname{CmsMerger}
 * @gates{in_sketch(msg:Sketch), out_sketch(msg:Sketch)}
 *
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <cms.hpp>

namespace bm
{

    /**
     * Implements a block that merges sketches
     */
    class CmsMerger: public Block
    {
        int m_ingate_id;
        int m_outgate_id;
        std::shared_ptr<cms::Sketch> m_sketch;
        bool m_sketch_ready;
        int m_sketch_count;

        // Configuration
        int m_merge_number;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the CMS packet counter block
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        CmsMerger(const std::string &name, bool active, bool thread_safe);

        /**
         * @brief Destructor
         */
        virtual ~CmsMerger();

        /** 
          * Non copyable by default: note m_sketch is a pointer, proper copy constructor and op= should be provided. Nicola  
          */
        CmsMerger(const CmsMerger &) = delete;
        CmsMerger& operator=(const CmsMerger &) = delete;

        /**
         * @brief Configures the block
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node&  n);

        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index);

        /**
         * Performs any asynchronous processing (no-op function)
         * @return 0 upon success, negative otherwise
         */
        virtual int do_async_processing()
        {
            return 0;
        }

        /**
         * Timer call back, export the sketch
         * @return 0 upon success, negative otherwise
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&&)
        {
            return 0;
        }
    };


    REGISTER_BLOCK(CmsMerger, "cms_merger");

}//bm
