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
 * <blockinfo type="ComboPktSource" invocation="indirect" thread_exclusive="True">
 *   <humandesc>
 *   This block is a wrapper to the SZE2 API available as a part of NetCOPE FPGA framework:
 *
 *   http://www.invea-tech.com/products-and-services/netcope-fpga-platform
 *
 *   A block of this kind can be associated to one or more hardware queues
 *   available on the FPGA acceleration card. Subscribed queues are specified
 *   as a configuration parameter in a mask where each bit corresponds to a single queue.
 *   If no value is provided default value is used. This block supports batch
 *   message allocation in order to optimize performance 
 *   </humandesc>
 *
 *   <shortdesc>Captures traffic from a local interface by means of the SZE2 API as part of NetCOPE</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="out_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element design {
 *          attribute filename {xsd:string}
 *      }
 *      element channels {
 *          attribute rx_mask {xsd:integer}
 *      }
 *      element interfaces {
 *          attribute enable {xsd:integer}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *  <params> 
 *      <design filename="/path/to/firmware.mcs"/>
 *      <channels rx_mask="255"/>
 *      <interfaces enable="1"/>
 *  </params>
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="pktcnt" human_desc="integer" access="read"/>
 *     <variable name="pktagg" human_desc="integer" access="write"/>
 *   </variables>
 *
 * </blockinfo>
 */

#ifdef _COMPILE_COMBO_BLOCK_

#include <Block.hpp>
#include <Packet.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <MemoryBatch.hpp>
#include <netinet/in.h>

#include "ComboSource.hpp"

using namespace pugi;

namespace blockmon
{
    /**
     * Implements a block that is an adapter between SZE2 interface and BlockMon 
     * messages. So it is providing interface to INVEA-TECH COMBO acceleration cards.
     */
    class ComboPktSource: public ComboSource
    {
        int m_gate_id;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the ComboPktSource block instance
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        ComboPktSource(const std::string &name, invocation_type invocation)
            :ComboSource(name),              //ignore options
            m_gate_id(register_output_gate("out_pkt"))
        {
            if (invocation != invocation_type::Async) {
                blocklog("ComboPktSource must be Async, ignoring configuration", log_warning);
            }
        }


        /**
         * @brief Configures the block, opens all necessary contexts
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node& n) 
        {
			ComboSource::_configure(n);
			std::string command;

			command = "tsuctl > /dev/null 2>&1; hfexctl -A -c ./bram32 -r ./registers32; hfexctl -A -R";
			system(command.c_str());
        }

        /**
         * Handle packet received from parent class and send it to output gate as a Packet message.
         */
		void handle_packet(unsigned char * packet, unsigned char * data, unsigned char* hw_data, int data_len, int hw_data_len)
		{
            send_out_through(alloc_msg_from_buffer<Packet>(m_mem_block, data_len, const_buffer<unsigned char>(reinterpret_cast<const unsigned char *>(data), data_len), 0), m_gate_id);
		}
    };

    REGISTER_BLOCK(ComboPktSource,"ComboPktSource");

} //blockmon

#else //_COMPILE_COMBO_BLOCK_

#pragma message "COMBO BLOCK will not be compiled"


#endif


