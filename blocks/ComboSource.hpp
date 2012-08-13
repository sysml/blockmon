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

#ifndef _BLOCKS_COMBOSOURCE_HPP_
#define _BLOCKS_COMBOSOURCE_HPP_

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>
#include <pugixml.hpp>

extern "C" {
#include <libsze2.h>
}

#define sze_dev "/dev/szedataII0"

namespace blockmon
{

    class ComboSource: public Block
    {

	protected:
        struct szedata *sze;
        int m_gate_id;
		int m_pktcnt;
		int m_pktagg;
        std::shared_ptr<MemoryBatch> m_mem_block;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the ComboSource block instance
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        ComboSource(const std::string &name)
            :Block(name, invocation_type::Async),              //ignore options
            m_mem_block(new MemoryBatch(4096*4))
        {
            sze = NULL;

			m_pktcnt = 0;
			m_pktagg = 1;
            register_variable("pktcnt",make_rd_var(no_mutex_t(), m_pktcnt));
            register_variable("pktagg",make_wr_var(no_mutex_t(), m_pktagg));
        }

        /**
         * @brief Destructor
         */
        ~ComboSource() 
		{
            szedata_close(sze);	
		}

        /**
         * @brief Configures the block, opens all necessary contexts
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node& n) 
        {
			std::string command;
           pugi::xml_node source;
			int val;
			unsigned int tx_mask = 0;
			unsigned int rx_mask = 0;

			source = n.child("design");
            if(!source) 
                blocklog("missing parameter design, firwmare of acceleration card was untouched!", log_info);
            else
			{
				command = std::string("csboot -f0 ") + source.attribute("filename").value() + "; sleep 1;";
				val = system(command.c_str());

				command = std::string("Booting card with firwmare file ") + source.attribute("filename").value() + (val == 0 ? ": OK" : ": ERROR");
                blocklog(command , log_info);
			}

			source = n.child("interfaces");
            if(!source)
			{
                blocklog("missing parameter 'interfaces', assuming enable='1'", log_info);
				val = 1;
            }
            else
				val = source.attribute("enable").as_uint();
			if(val)
			{
				blocklog("Enabling input interfaces", log_info);
				command = "ibufctl -Ae1";
				val = system(command.c_str());
			}

			rx_mask = 0xFF;
            source = n.child("channels");
            if(!source) {
				blocklog("missing parameter channels, usign default value!", log_info);
            }
            else
                rx_mask = source.attribute("rx_mask").as_uint();

            /* initialize szedata2 */
            /* get sze device handle */
            sze = szedata_open(sze_dev);
            if (sze == NULL) {
                std::cerr << "szedata_open failed" << std::endl;
                exit(1);
            }

            /* set 5s timeout for szedata_read_next */
            SZE2_RX_POLL_TIMEOUT = 30;

            /* subscribe wanted interfaces and set poll byte conuts */
            val = szedata_subscribe3(sze, &rx_mask, &tx_mask);
            if (val) {
                throw std::runtime_error("subscription failed");
                exit(1);
            }

            /* start */
            val = szedata_start(sze);
            if (val) {
                throw std::runtime_error("start failed");
                exit(1);
            }
            /* szedata2 initialized */
        }

        /**
         * Receive data from SZE2 interface and send it to output gate as a RawPacket message.
         * @return 0 upon success, negative otherwise
         */
        void _do_async() 
        {
            unsigned char *packet;
            unsigned int packet_len;
            unsigned char *data, *hw_data;
            unsigned int data_len, hw_data_len;
            //unsigned int segsize;

            int cnt = m_pktagg;
            /* read */
            while(cnt-- > 0)
            {
                if((packet = szedata_read_next(sze, &packet_len)) != NULL) {
					m_pktcnt++;

                    /*segsize = */
					szedata_decode_packet(packet, &data, &hw_data, &data_len, &hw_data_len);
					handle_packet(packet, data, hw_data, data_len, hw_data_len);
                }
            }
        }

		void handle_packet(unsigned char * packet, unsigned char * data, unsigned char* hw_data, int data_len, int hw_data_len) ;

    };
}
#endif // _BLOCKS_COMBOSOURCE_HPP_
