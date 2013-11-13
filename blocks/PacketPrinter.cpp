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
 * <blockinfo type="PacketPrinter" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *   Receives a Packet message and prints its associated information
 *   (as returned by the methods in the Packet class)
 *   </humandesc>
 *
 *   <shortdesc>Prints meta-information regarding a packet</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>
#include <ClassId.hpp>
#include <arpa/inet.h>
#include <sstream>

namespace blockmon
{

    class PacketPrinter: public Block
    {
    /*
     * simple helper function to print an ip address
     * implemented by using inet_ntop.
     */
        static std::string ip_to_string(uint32_t ip)
        {
            
            char addr_buffer[INET_ADDRSTRLEN];
            //inet_ntop expects network byte order
            uint32_t flipped_ip=htonl(ip);
            
            if(!inet_ntop(AF_INET, &flipped_ip, addr_buffer, INET_ADDRSTRLEN))
                throw std::runtime_error("cannot convert ip address");
            return std::string (addr_buffer);
        }
                

    public:

        /*
         * constructor
         */
        PacketPrinter(const std::string &name, invocation_type invocation)
        : Block(name, invocation),
          m_ingate_id(register_input_gate("in_pkt"))
        {
        }

        PacketPrinter(const PacketPrinter &)=delete;
        PacketPrinter& operator=(const PacketPrinter &) = delete;
        PacketPrinter(PacketPrinter &&)=delete;
        PacketPrinter& operator=(PacketPrinter &&) = delete;

        /*
         * destructor
         */
        virtual ~PacketPrinter()
        {}

        /*
         * this block takes no configuration parameters
         */  
        virtual void _configure(const pugi::xml_node&  /*n*/ )
        {
        
        }

        /*
         * the main method
         * receives a Packet message and prints out its associated information
         * If the message belongs to another class, an exception is thrown.
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if ( m->type() == MSG_ID(Packet) )
            {      
                auto packet = static_cast<const Packet *>(m.get());
                std::stringstream ss;
                ss<<"Packet of length "<< packet->length() <<" bytes received at time " << packet->timestamp_s() << " seconds and "<< packet->timestamp_ms() << " milliseconds" << std::endl;
                int l3_proto = packet->l3_protocol();
                //FIXME how does packet expose this??
                if(l3_proto == Packet::kPktTypeIP4)
                {
                    ss<<"SRC IP: "<< ip_to_string(packet->ip_src()) <<" DST IP: "<< ip_to_string(packet->ip_dst()) << std::endl;
                    ss<<"IP TOS: "<< static_cast<unsigned int> (packet->ip_tos()) << " IP_TTL: "<< static_cast<unsigned int>(packet->ip_ttl()) << std::endl; 
                    uint16_t transport = packet->l4_protocol();
                    if(transport == Packet::kUDP)
                    {
                       ss<<" UDP datagram SRC PORT: "<< packet->src_port() << " DST PORT: "<< packet->dst_port() << std::endl;
                    }
                    else if (transport == Packet::kTCP)
                    {
                       ss<< "TCP segment SRC PORT: "<< packet->src_port() << " DST PORT: "<< packet->dst_port() << std::endl;
                       ss<< "flags:";
                       if( packet->tcp_has_syn())
                           ss<<" SYN ";
                       if( packet->tcp_has_rst())
                           ss<<" RST ";
                       if( packet->tcp_has_psh())
                           ss<<" PSH ";
                       ss<<std::endl;
                       ss<<"CWIN "<< packet->tcp_win() << " SEQNUM "<<packet->tcp_seq()<<std::endl;
                    }
                    else
                    {
                        ss<<"Layer 4 protocol is "<< transport <<std::endl;
                    }
                }
                else
                {
                    ss<<"Layer 3 protocol is "<< l3_proto <<std::endl;
                }
                blocklog(ss.str(), log_info);

            }
            else
            {
                throw std::runtime_error("Packetprinter: wrong message type");
            }
        }

    private:
        
        int m_ingate_id;
 
    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PacketPrinter,"PacketPrinter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

