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
 * Recieved TCP SYN packets counts by CMS sketches regularly. If the number of SYN packets sent to an IP
 * changes too much, launch a SYN flooding alarm (printed on stdout).
 * The watching period is determined by the sketches reception period.
 * Configuration:
 *	<cusum threshold="50." offset="10." mean_window="20" />
 * The CUSUM threshold and offset are parameters of the NP-CUSUM algorithm.
 * The mean window is the number of values used to compute the mean of packets per period.
 *
 * @blockname{SynFloodingDetection}
 * @gates{in_sketch(msg:Sketch), out_alert(msg:CmsSignature)}
 *
 */

#include <Block.hpp>
#include <BlockFactory.hpp>

#include <cusum/multi_cusum.hpp>

#define SYF_LAST_IPS_MAX 100
#define SYF_TCP_FLAGS_LOCATION 13
#define SYF_TCP_FLAGS_ACK 0x10
#define SYF_TCP_FLAGS_SYN 0x02

namespace bm
{

    /**
     * Implements a block that watches the received packets by flow
     */
    class SynFloodingDetection: public Block
    {
        int m_ingate_id;
		int m_outgate_alert_id;
        csm::MultiCusum** m_cusum;
        int m_cusum_size;
		unsigned int m_checks_count;

        // Configuration
        double m_csm_threshold;
        double m_csm_offset;
        int m_csm_mean_window;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the CMS packet counter block
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        SynFloodingDetection(const std::string &name, bool active, bool thread_safe);

        /**
         * @brief Destructor
         */
        virtual ~SynFloodingDetection();

        /** 
          * Non copyable by default: note m_sketch is a pointer, proper copy constructor and op= should be provided. Nicola  
          */

        SynFloodingDetection(const SynFloodingDetection &) = delete;
        SynFloodingDetection& operator=(const SynFloodingDetection &) = delete;

        /**
         * @brief Configures the block, nothing to do.
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
         * Timer call back
         * @return 0 upon success, negative otherwise
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&&)
        {
            return 0;
        }
    };


    REGISTER_BLOCK(SynFloodingDetection, "syn_flooding_detection");

}//bm
