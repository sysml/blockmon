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
 * <blockinfo type="FeaturesExtractor" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *      Takes packets as input and creates tickets messages (TicketMsg)
 *      according to the traffic features selection given in the configuration file.
 *      Features defined as active in the configuration file are extracted
 *      from every single input packet, collected in a TicketMsg and sent to the
 *      block's output gate.
 *
 *      Please refer to the schema and examples below to see how to specify
 *      features selection. Note that the activation is done via the
 *      "mode" parameter, which can be set to "on" or "off". Default is "off".
 *      It is optional to specify every traffic feature, it is allowed to set
 *      only those which are active.
 *   </humandesc>
 *
 * <shortdesc>
 *      Creates tickets messages containing pairs (id,value) of the extracted traffic features.
 *      The traffic features selection is made through the configuration file.
 * </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <gates>
 *     <gate type="output" name="out_tckt" msg_type="TicketMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *          element direction{
 *              attribute type = {"uplink"|"downlink"}
 *          }
 *
 *          element features{
 *
 *              element Feat_x{
 *                  element layer4{
 *                      attribute prot {"TCP"|"UDP"}
 *                  }
 *                  element flags{
 *                      attribute name {"FIN"|"SYN"|"RST"|"PSH"|"ACK"|"FINACK"|"SYNACK"|"RSTACK"|"PSHACK"|"PSHFINACK"}
 *                  }?
 *                  element port{
 *                      attribute number {xsd:integer (1 - 65535); it's the server port, where 65535 = not(80) }
 *                  }
 *                  element mode{
 *                      attribute packets = {"on"|"off"}
 *                      attribute bytes = {"on"|"off"}
 *                      attribute ServPorts = {"on"|"off"} (ONLY IN UPLINK)
 *                      attribute ServIPs = {"on"|"off"} (ONLY IN UPLINK)
 *                  }
 *              }?
 *              element Feat_y{
 *                  element layer4{
 *                      attribute prot {"TCP"|"UDP"}
 *                  }
 *                  element flags{
 *                      attribute name {"FIN"|"SYN"|"RST"|"PSH"|"ACK"|"FINACK"|"SYNACK"|"RSTACK"|"PSHACK"|"PSHFINACK"}
 *                  }
 *                  element port{
 *                      attribute number {xsd:integer (1 - 65535); where 65535 = not(80) }
 *                  }
 *                  element mode{
 *                      attribute packets = {"on"|"off"}
 *                      attribute bytes = {"on"|"off"}
 *                      attribute ServPorts = {"on"|"off"} (ONLY IN UPLINK)
 *                      attribute ServIPs = {"on"|"off"} (ONLY IN UPLINK)
 *                  }
 *              }?
 *
 *           }
 *   }
 *
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *
 *         <direction type = "uplink"/>
 *         <features>
 *
 *              <Feat_1>
 *               <layer4 prot="TCP"/>
 *               <flags name="SYN"/>
 *               <port num="80"/>
 *               <mode packets="on"
 *                     bytes="on"
 *                     ServPorts="on"
 *                     ServIPs="on" />
 *             </Feat_1>
 *
 *             <Feat_2>
 *               <layer4 prot="TCP"/>
 *               <flags name="SYN"/>
 *               <port num="65535"/>
 *               <mode packets="on"
 *                     bytes="on"
 *                     ServPorts="on"
 *                     ServIPs="on" />
 *             </Feat_2>
 *
 *
 *             <Feat_3>
 *               <layer4 prot="UDP"/>
 *               <port num="65535"/>
 *               <mode packets="on"
 *                     bytes="on"
 *                     ServPorts="off"
 *                     ServIPs="off" />
 *             </Feat_3>
 *
 *         </features>
 *
 *       </params>
 *
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <arpa/inet.h>
#include <Packet.hpp>
#include <TicketMsg.hpp>
#include <fstream>
#include <sstream>
#include <iostream>

namespace blockmon
{

    class FeaturesExtractor: public Block
    {
       /*Max number of extractable features groups (10 flags * 2 port = 20)
        *For each group it is possible to activate 4 different features in uplink and 2 in downlink
        *Total number of extractable features: 20 * 4 (UL) + 20 * 2 (DL) = 120
        */
        static const int N_MAX_FEATURES_GROUPS = 20;

        static const int UPLINK = 1;
        static const int DOWNLINK = 2;

        static const int FILTER_OUT = 0;

        static const int PACKETS_ACTIVE = 1;
        static const int BYTES_ACTIVE = 2;
        static const int NUMPORTS_ACTIVE = 4;
        static const int NUMIPS_ACTIVE = 8;

        static const int FIN = 1;
        static const int SYN = 2;
        static const int RST = 4;
        static const int PSH = 8;
        static const int ACK = 16;

        static const uint16_t TCP = 6;
        static const uint16_t UDP = 17;


        int m_in_gate;
        int m_out_gate;
        uint64_t m_current_minute;
        //ofstream m_out_file;

        uint8_t m_direction;                    // 1 = uplink, 2 = downlink
        uint8_t m_num_of_ticket_features;        // evaluated reading the xml conf file
        uint16_t m_feat_L4_prot[N_MAX_FEATURES_GROUPS]; // layer 4 protocol (TCP or UDP)
        uint8_t m_feat_flags[N_MAX_FEATURES_GROUPS];   // TCP flag for each of the active features
        uint16_t m_feat_ports[N_MAX_FEATURES_GROUPS];    // server port for each of the active features
        uint8_t m_feat_modes[N_MAX_FEATURES_GROUPS];    // 0 = all off; 1st bit = packets; 2nd bit = bytes;
                                                // 3rd bit = ServPorts; 4th bit = ServIPs;



        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("FeauresExtractor:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }

        /**
          * parses the flags_node xlm and sets the flags byte accordingly
          * @param feature_node the feature xml subtree
          * @param flags_byte the flags byte to be set
          */
        static inline bool parse_feature_flags(pugi::xml_node& feature_node, uint8_t& flags_byte)
        {
            pugi::xml_node flags_node;
            //Check whether the field "flags" does exist, otherwise returns false
            if(!(flags_node = feature_node.child("flags")))
                return false;

            flags_byte = FILTER_OUT; //Inizialization -> no flag is set!(Flags = 0)

            //If the attribute "name" does exist
            if(pugi::xml_attribute flags_name = flags_node.attribute("name"))
            {
                if (!strcmp(flags_name.value(),"_"))
                {
                    flags_byte = 0;
                }else if (!strcmp(flags_name.value(),"FIN"))
                {
                    flags_byte = FIN;
                }else if (!strcmp(flags_name.value(),"SYN"))
                {
                    flags_byte = SYN;
                }else if (!strcmp(flags_name.value(),"RST"))
                {
                    flags_byte = RST;
                }else if (!strcmp(flags_name.value(),"PSH"))
                {
                    flags_byte = PSH;
                }else if (!strcmp(flags_name.value(),"ACK"))
                {
                    flags_byte = ACK;
                }else if (!strcmp(flags_name.value(),"FINACK"))
                {
                    flags_byte = FIN | ACK;
                }else if (!strcmp(flags_name.value(),"SYNACK"))
                {
                    flags_byte = SYN | ACK;
                }else if (!strcmp(flags_name.value(),"RSTACK"))
                {
                    flags_byte = RST | ACK;
                }else if (!strcmp(flags_name.value(),"PSHACK"))
                {
                    flags_byte = PSH | ACK;
                }else if (!strcmp(flags_name.value(),"PSHFINACK"))
                {
                    flags_byte = PSH | FIN | ACK;
                }
            }else return false; //Otherwise return false

            return true;
        }

        /**
          * parses the port_node xlm and sets the feature port number accordingly
          * @param feature_node the feature xml subtree
          * @param port_number the port number to be set
          */
        static inline bool parse_feature_port(pugi::xml_node& feature_node, uint16_t& port_number)
        {
            pugi::xml_node port_node;
            //Check whether the field "port" does exist, otherwise returns false
            if(!(port_node = feature_node.child("port")))
                return false;

            port_number = 65535;//Initialization port_number = 65535 all ports but 80

            //If the attribute "num" does exist
            if(pugi::xml_attribute port_num = port_node.attribute("num"))
            {
                port_number = port_num.as_uint();
            }
            else return false; //Otherwise return false

            return true;
        }

        /**
          * parses the L4Prot_node xlm and sets the feature layer4 protocol accordingly
          * @param feature_node the feature xml subtree
          * @param layer4_prot the port number to be set
          */
        static inline bool parse_feature_layer4_prot(pugi::xml_node& feature_node, uint16_t& layer4_prot)
        {
            pugi::xml_node L4Prot_node;
            //Check whether the field "port" does exist, otherwise returns false
            if(!(L4Prot_node = feature_node.child("layer4")))
                return false;

            //If the attribute "prot" does exist
            if(pugi::xml_attribute prot = L4Prot_node.attribute("prot"))
            {
                if(!strcmp(prot.value(),"TCP"))
                    layer4_prot = TCP;
                else if(!strcmp(prot.value(),"UDP"))
                    layer4_prot = UDP;
            }
            else return false; //Otherwise return false

            return true;
        }

        /**
          * parses the feature_mode_node xlm and sets the feature mode byte accordingly
          * @param feature_node the feature xml subtree
          * @param mode_byte the feature mode byte to be set
          * @param direction the direction f the connection (direction byte: uplink = 1 or downlink = 2)
          */
        static inline bool parse_feature_mode(pugi::xml_node& feature_node, uint8_t& mode_byte, uint8_t direction)
        {
            pugi::xml_node mode_node;
            //Check whether the field "feature mode" does exist, otherwise returns false
            if(!(mode_node = feature_node.child("mode")))
                return false;

            mode_byte = PACKETS_ACTIVE; //Inizialization = only "packets" is active

            //If the attribute "packets" does exist
            if(pugi::xml_attribute packets = mode_node.attribute("packets"))
            {
                if(!strcmp(packets.value(),"on")) //strcmp returns 0 (false) if the two strings are equal
                    mode_byte |= PACKETS_ACTIVE;
            }

            //If the attribute "bytes" does exist
            if(pugi::xml_attribute bytes = mode_node.attribute("bytes"))
            {
                if(!strcmp(bytes.value(),"on")) //strcmp returns 0 (false) if the two strings are equal
                    mode_byte |= BYTES_ACTIVE;
            }

            //only in uplink we can count the number of server ports and server IPs
            if(direction == UPLINK)
            {
                if(pugi::xml_attribute sPorts = mode_node.attribute("ServPorts"))
                {
                    if(!strcmp(sPorts.value(),"on"))
                        mode_byte |= NUMPORTS_ACTIVE;
                }
                if(pugi::xml_attribute sIPs = mode_node.attribute("ServIPs"))
                {
                    if(!strcmp(sIPs.value(),"on"))
                        mode_byte |= NUMIPS_ACTIVE;
                }
            }

            return true;
        }

        /**
          * helper function, starting from the strings containing details about
          * the current feature, creates a string containing the feature ID:
          * @param directionStr "UL" or "DL" according to the direction of the connection
          * @param flagsStr the string containing the active flags of the current feature
          * @param modeStr the string containing the feature mode {"packets", "bytes", "srvPorts", "srvIPs"}
          * @param port the port (integer) of the current feature
          * @return the feature ID string
          */
        static string featID_to_string(string directionStr, string flagsStr, string modeStr, uint16_t port)
        {
            std::stringstream feat_ID;
            feat_ID << directionStr << "_" << flagsStr << "_" << modeStr << "_p_"<< port;
            return feat_ID.str();

        }

        /**
          * helper function, if the current packet has set one of the desired
          * flags combination, generates the feature ID accordingly.
          * If no match is found the feature ID is set to "empty"
          * @param packet, the pointer to the current sniffed packet
          * @param dirStr "UL" or "DL" according to the direction of the connection
          * @param flagsByte the byte containing the active flags of the current feature
          * @param modeStr the string containing the feature mode {"packets", "bytes", "srvPorts", "srvIPs"}
          * @param port the port (integer) of the current feature
          * @param featIDString the string which will contain the feature ID
          * @return true if any match has been found, false otherwise
          */
        static bool generate_feature_ID(const Packet *packet, string dirStr, uint16_t L4_prot, uint8_t flagsByte, string modeStr, uint16_t port, string& featIDStr)
        {
            /* UDP Datagram */
            if(L4_prot & UDP)
            {
                featIDStr = featID_to_string(dirStr,"UDP",modeStr,port);
                return true;
            }

            /* No TCP flag set */
            if((L4_prot & TCP) && (flagsByte == 0))
            {
                featIDStr = featID_to_string(dirStr,"TCP", modeStr, port);
                return true;
            }

            /* With some TCP flag set */
            uint32_t ack; //useless
            if(flagsByte & PSH)
            {
                if(flagsByte & ACK)
                {
                    if(flagsByte & FIN)
                    {
                        //PSHFINACK
                        if(packet->tcp_has_fin() && packet->tcp_has_psh() && packet->tcp_ack(ack))
                        {
                            featIDStr = featID_to_string(dirStr,"PSHFINACK", modeStr, port);
                            return true;
                        }
                    //PSHACK
                    }else if(packet->tcp_ack(ack) && packet->tcp_has_psh())
                    {
                        featIDStr = featID_to_string(dirStr,"PSHACK", modeStr, port);
                        return true;
                    }
                //PSH
                }else if(packet->tcp_has_psh())
                {
                    featIDStr = featID_to_string(dirStr,"PSH", modeStr, port);
                    return true;
                }
            }else if(flagsByte & RST)
            {
                if(flagsByte & ACK)
                {
                    //RSTACK
                    if (packet->tcp_ack(ack) && packet->tcp_has_rst())
                    {
                        featIDStr = featID_to_string(dirStr,"RSTACK", modeStr, port);
                        return true;
                    }
                //RST
                }else if (packet->tcp_has_rst())
                {
                    featIDStr = featID_to_string(dirStr,"RST", modeStr, port);
                    return true;
                }
            }else if(flagsByte & SYN)
            {
                if(flagsByte & ACK)
                {
                    //SYNACK
                    if (packet->tcp_ack(ack) && packet->tcp_has_syn())
                    {
                        featIDStr = featID_to_string(dirStr,"SYNACK", modeStr, port);
                        return true;
                    }
                //SYN
                }else if (packet->tcp_has_syn())
                {
                    featIDStr = featID_to_string(dirStr,"SYN", modeStr, port);
                    return true;
                }
            }else if(flagsByte & FIN)
            {
                if(flagsByte & ACK)
                {
                    //FINACK
                    if (packet->tcp_ack(ack) && packet->tcp_has_fin())
                    {
                        featIDStr = featID_to_string(dirStr,"FINACK", modeStr, port);
                        return true;
                    }
                //FIN
                }else if (packet->tcp_has_fin())
                {
                    featIDStr = featID_to_string(dirStr,"FIN", modeStr, port);
                    return true;
                }
            }else if(flagsByte & ACK)
            {
                //ACK
                if (packet->tcp_ack(ack))
                {
                    featIDStr = featID_to_string(dirStr,"ACK", modeStr, port);
                    return true;
                }
            }else return false;

            return false;
        }


    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be directly invoked, and will ignore any contrary configuration.
         */
        FeaturesExtractor(const std::string &name, invocation_type invocation) :
        Block(name, invocation),
        m_in_gate(register_input_gate("in_pkt")),
        m_out_gate(register_output_gate("out_tckt")),
        m_current_minute(0),
        m_direction(0),
        m_num_of_ticket_features(0)

        {
            for(int i=0; i< N_MAX_FEATURES_GROUPS; i++)
            {
                m_feat_L4_prot[i] = 0;
                m_feat_flags[i] = 0;
                m_feat_ports[i] = 0;
                m_feat_modes[i] = 0;
            }
        }

        FeaturesExtractor(const FeaturesExtractor &)=delete;
        FeaturesExtractor& operator=(const FeaturesExtractor &) = delete;
        FeaturesExtractor(FeaturesExtractor &&)=delete;
        FeaturesExtractor& operator=(FeaturesExtractor &&) = delete;

        /*
         * destructor
         */
        virtual ~FeaturesExtractor()
        {}

        /**
          * configures the filter
          * @param n the xml subtree
          */
        virtual void _configure(const pugi::xml_node&  n )
        {
            if(pugi::xml_node direction = n.child("direction"))
            {
                pugi::xml_attribute dir = direction.attribute("type");
                if(!(strcmp(dir.value(),"uplink"))) m_direction = UPLINK;
                else if(!(strcmp(dir.value(),"downlink"))) m_direction = DOWNLINK;
                else signal_error("direction_value");

            }else signal_error("direction");

            if(pugi::xml_node features = n.child("features"))
            {
                uint i=0;
                for(pugi::xml_node_iterator it = features.begin(); it != features.end(); it++)
                {
                    if(pugi::xml_node feat = features.child(it->name()))
                    {
                        if(parse_feature_port(feat,m_feat_ports[i]))
                        {
                        }else signal_error("feature_port");

                        if(parse_feature_mode(feat,m_feat_modes[i],m_direction))
                        {
                        }else signal_error("feature_mode");

                        if(parse_feature_layer4_prot(feat,m_feat_L4_prot[i]))
                        {
                            if(m_feat_L4_prot[i] & TCP)//only for tcp packets we have flags
                            {
                                if(parse_feature_flags(feat,m_feat_flags[i]))
                                {
                                }else signal_error("feature_flags");
                            }
                        }else signal_error("feature_L4prot");

                    }else signal_error("features_name");
                    i++;
                }
                m_num_of_ticket_features = i; //evaluates the number of active groups of features included in the xml configuration file
            }else signal_error("features");

            //Opening results text files
            //m_res_file.open (m_res_file_name, fstream::in | fstream::out | fstream::app);

            //m_out_file.open ("FE_Tickets_1min_UL_SYN_packets_p65535.txt", fstream::out);
        }


        /**
          * the actual features extraction function
          * Expects Packet messages, otherwise it throws
          * @param m the message to be checked
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(Packet))
                throw std::runtime_error("FeaturesExtractor: wrong message type");
            const Packet* packet = static_cast<const Packet* > (m.get());

            /*
             * INSERIRE QUI IL CONTROLLO SUL TIMESTAMP DEL PACCHETTO RICEVUTO
             * GENERARE E INVIARE IN OUTPUT UN MESSAGGIO DI SEGNALAZIONE (SEMPRE DI TIPO TICKETMSG)
             * QUANDO TERMINA UN MINUTO E COMINCIA UN ALTRO IN MODO CHE I BLOCCHI
             * SUCCESSIVI POSSANO "CAPIRE" CHE IL MINUTO CORRENTE É FINITO ED
             * ESEGUIRE IMMEDIATAMENTE LE OPERAZIONI SUL MINUTO
             *
             * FAR PROPAGARE QUESTO MESSAGGIO ANCHE TRA I BLOCCHI SUCCESSIVI
             * PER EVITARE L'ACCUMULO DI RITARDI TRA SCALE TEMPORALI
             */
            uint64_t time_now = packet->timestamp_s();
            uint64_t minute_now = time_now/60;

            /*If the current minute is over (i.e. the first ticket belonging to the next minute has arrived)*/
            if(minute_now > m_current_minute) // the packets with timestamp from xxxx00 to xxxx59 will belong to the same "current minute"
            {
                m_current_minute = minute_now;
                uint32_t dummy_IP = 0;
                //create a dummy ticket and send it out signaling this event
                std::shared_ptr<TicketMsg> dummy_ticket = std::make_shared<TicketMsg>(minute_now*60, dummy_IP);

                //PER ORA STAMPARE ANCHE VIDEO IL TICKET CREATO DAL PACCHETTO CORRENTE
                std::stringstream sss;
                sss <<  "Signaling Ticket.\n"
                    << dummy_ticket.get()->to_string() << "\n\n";
                blocklog(sss.str(), log_info);
                send_out_through(dummy_ticket, m_out_gate);
            }

            uint16_t transport = packet->l4_protocol(); //transport protocol (TCP or UDP or other)
            uint32_t client_IP = 0;    //source IP if uplink, destination IP if downlink
            uint32_t server_IP = 0;    //destination IP if uplink, source IP if downlink
            uint16_t server_port = 0;  //destination port if uplink, source port if downlink
            string directionStr;
            string modeStr;
            string featIDStr;

            if(m_direction == UPLINK)
            {
                client_IP = packet->ip_src();
                server_IP = packet->ip_dst();
                server_port = packet->dst_port();
                directionStr = "UL";

            }else if(m_direction == DOWNLINK)
            {
                client_IP = packet->ip_dst();
                server_IP = packet->ip_src();
                server_port = packet->src_port();
                directionStr = "DL";
            }

            /*TODO EXTERNAL TO THIS BLOCK:
             *      Inserire nel filtro applicato alla sorgente (blocco Pcap_source)
             *      un controllo sulla appartenenza dell'IP address:
             *      IN UPLINK (dir = src x.y.z.w)
             *      Considerare come pacchetti validi, solo i pacchetti
             *      che hanno source IP address appartenente al range di
             *      indirizzi assegnati all'operatore.
             *      IN DOWNLINK (dir = dst x.y.z.w)
             *      Considerare come pacchetti validi, solo i pacchetti
             *      che hanno destination IP address appartenente al range di
             *      indirizzi assegnati all'operatore.
             *      In questo modo sará possibile popolare le features in uplink
             *      o downlink!
            */

            std::shared_ptr<TicketMsg> ticket = std::make_shared<TicketMsg>(packet->timestamp_s(), client_IP);

            for(int i = 0 ; i<m_num_of_ticket_features; i++)
            {
                //Extracting only features of the correct transport protocol
                if(m_feat_L4_prot[i] != transport) continue;

                //Extracting features only on the user specified server port
                if( (m_feat_ports[i] != 65535) && (m_feat_ports[i] == server_port) )
                {
                    /************* PACKETS *************/
                    if(m_feat_modes[i] & PACKETS_ACTIVE)
                    {
                        modeStr = "packets";
                        //only if the flags match has been found, the packet contains the required feature
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            //key = featIDStr, value = 1
                            ticket.get()->add_feature(featIDStr, 1);
                    }
                    /************* BYTES ***************/
                    if(m_feat_modes[i] & BYTES_ACTIVE)
                    {
                        modeStr = "bytes";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            //key = featIDStr, value = total length of the packet captured from the wire
                            ticket.get()->add_feature(featIDStr, packet->length());
                    }
                    /************* SERVER PORTS ***************/
                    /************ ONLY IN UPLINK *************/
                    if( (m_direction == UPLINK) && (m_feat_modes[i] & NUMPORTS_ACTIVE) )
                    {
                        modeStr = "srvPorts";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            //key = featIDStr, value = the server port contacted
                            //this will be used to count the number of different server ports contacted in a timebin in the next blocks!
                            ticket.get()->add_feature(featIDStr, server_port);
                    }
                    /************* SERVER IPs ***************/
                    /************ ONLY IN UPLINK *************/
                    if( (m_direction == UPLINK) && (m_feat_modes[i] & NUMIPS_ACTIVE) )
                    {
                        modeStr = "srvIPs";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            //key = featIDStr, value = the server IP address (uint32_t representation) contacted
                            //this will be used to count the number of different server IP contacted in a timebin in the next blocks!
                            ticket.get()->add_feature(featIDStr, server_IP);
                    }

                }//Extracting on all the ports but port 80
                else if( (m_feat_ports[i] == 65535) && (server_port != 80) )
                {
                    /************* PACKETS *************/
                    if(m_feat_modes[i] & PACKETS_ACTIVE)
                    {
                        modeStr = "packets";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            ticket.get()->add_feature(featIDStr, 1);
                    }
                    /************* BYTES ***************/
                    if(m_feat_modes[i] & BYTES_ACTIVE)
                    {
                        modeStr = "bytes";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            ticket.get()->add_feature(featIDStr, packet->length());
                    }
                    /************* SERVER PORTS ***************/
                    /************ ONLY IN UPLINK *************/
                    if( (m_direction == UPLINK) && (m_feat_modes[i] & NUMPORTS_ACTIVE) )
                    {
                        modeStr = "srvPorts";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            ticket.get()->add_feature(featIDStr, server_port);
                    }
                    /************* SERVER IPs ***************/
                    /************ ONLY IN UPLINK *************/
                    if( (m_direction == UPLINK) && (m_feat_modes[i] & NUMIPS_ACTIVE) )
                    {
                        modeStr = "srvIPs";
                        if(generate_feature_ID(packet, directionStr, m_feat_L4_prot[i], m_feat_flags[i], modeStr, m_feat_ports[i],featIDStr))
                            ticket.get()->add_feature(featIDStr, server_IP);
                    }

                }

            }


            //If at least one extraction rule matched with the current packet, output it
            if(ticket.get()->get_extracted_features() > 0)
            {
                send_out_through(ticket, m_out_gate);

                //Writes the results to the output results file
                //m_out_file << ticket.get()->to_string_file();

                //PER ORA STAMPARE ANCHE VIDEO IL TICKET CREATO DAL PACCHETTO CORRENTE
                /*
                std::stringstream ss;
                ss << ticket.get()->to_string() << "\n\n";
                blocklog(ss.str(), log_info);
                */

            }
        }

    private:

        int m_ingate_id;

    };
    REGISTER_BLOCK(FeaturesExtractor,"FeaturesExtractor");

}

