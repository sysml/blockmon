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
 * Gets data from SZE2 interface and translates them into RawPacket message.
 *
 * @blockname{combo}
 * @gates{out_pkt(msg:RawPacket),}
 *
 */

#include <Block.hpp>
#include <RawPacket.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <MemoryBlock.hpp>
#include <netinet/in.h>

extern "C" {
#include <libsze2.h>
}

#define sze_dev "/dev/szedataII0"

using namespace pugi;

namespace bm
{
    /**
     * Implements a block that is an adapter between SZE2 interface and BlockMon 
     * messages. So it is providing interface to INVEA-TECH COMBO acceleration cards.
     */
    class Combo: public Block
    {

        struct szedata *sze;
        unsigned int tx;
        int m_gate_id;
        std::shared_ptr<MemoryBlock> m_mem_block;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the Combo block instance
         * @param active       Whether the block should be active or passive
         * @param thread_safe  Whether thread-safety should be enabled
         */
        Combo(const std::string &name, bool active, bool /* thread_safe */)
            :Block(name,"combo",true,true),              //ignore options
            m_gate_id(register_output_gate("out_pkt")),
            m_mem_block(new MemoryBlock(4096*4))
        {
            if(!active) 
                std::cout << "WARNING: combo has to be active, user option has been ignored" << std::endl;

            sze = NULL;
            tx = 0x00;
        }

        /**
         * @brief Destructor
         */
        virtual ~Combo()
        {
            /* close szedata */
            szedata_close(sze);	
        }

        /**
         * @brief Configures the block, opens all necessary contexts
         * @param n The configuration parameters 
         */
        virtual void _configure(const xml_node& n)
        {
            int ret;
            unsigned int rx_mask = 0xFF;
            char out [100];
    
            xml_node source = n.child("channels");
            if(!source) {
                sprintf(out, "missing parameter channels, usign default value!");
                blocklog(std::string(out),info);
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
            SZE2_RX_POLL_TIMEOUT = 5000;

            printf("subscribing: RX interface mask-0x%02hx; TX interface mask-0x%02hx\n", rx_mask, tx);
            printf("poll timeouts: RX %ums; TX %ums\n", SZE2_RX_POLL_TIMEOUT, SZE2_TX_POLL_TIMEOUT);

            /* subscribe wanted interfaces and set poll byte conuts */
            ret = szedata_subscribe3(sze, &rx_mask, &tx);
            if (ret) {
                throw std::runtime_error("subscription failed");
                exit(1);
            }
            printf("subscribed: RX 0x%02hx; TX 0x%02hx\n\n", rx_mask, tx);

            /* start */
            ret = szedata_start(sze);
            if (ret) {
                throw std::runtime_error("start failed");
                exit(1);
            }
            /* szedata2 initialized */
        }

        /**
         * Receives messages from other BlockMon blocks. Used to provide loopback configuration.
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& /* m */, int /* index */)
        {
            return -1;	
        }

        /**
         * Receive data from SZE2 interface and send it to output gate as a RawPacket message.
         * @return 0 upon success, negative otherwise
         */
        int do_async_processing()
        {
            unsigned char *packet;
            unsigned int packet_len;
            unsigned char *data, *hw_data;
            unsigned int data_len, hw_data_len;
            unsigned int segsize;


            /* read */
            while(1) {
                if((packet = szedata_read_next(sze, &packet_len)) != NULL) {


                    segsize = szedata_decode_packet(packet, &data, &hw_data, &data_len, &hw_data_len);

/*                    send_out_through(make_rawpkt(const_buffer<char>(reinterpret_cast<const char *>(data), (size_t)data_len)),
                                     m_gate_id);
*/

                    send_out_through(alloc_from_big_buffer<RawPacket>(m_mem_block,
                                                                      const_buffer<char>(
                                                                        reinterpret_cast<const char *>(data),
                                                                        data_len)),
                                     m_gate_id);

                }
            }
            return 0;
        }

        /**
         * Timer call back.
         * @return 0 upon success, negative otherwise
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
            return -1;
        }
    };

    REGISTER_BLOCK(Combo,"combo");

} //bm
