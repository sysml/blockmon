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
 * <blockinfo type="FlowFilter" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
 *   </humandesc>
 * Selects packets based on a set of given conditions. Selected packets are
 * sent to the block's output gate, non-selected ones are dropped. A packet
 * is selected if it matches *all* of the given conditions, and each of the
 * conditions can be negated. Logically the selection resolves to
 *                                                                                            
 * select = [not]cond1=val AND [not]cond2=val AND [not]cond3=val ...                          
 *                                                                                             
 * where [not] means that the negation is optional. The conditions can be of                   
 * the following kind:                                                                         
 *                                                                                                                                                                              
 * ip_src                                                                                      
 * ip_dst                                                                                      
 * l4_protocol                                                                                 
 * src_port                                                                                    
 * dst_port                                                                                    
 *                                                                                             
 * Please refer to the schema and examples below to see how to specify                         
 * selection filters. Note that the negation (i.e., "not") is done via the                     
 * "behavior" parameter, which can be set to "accept" or "discard" = negate.                  
 * Default is "accept".
 *
 * <shortdesc>Selects packets based on conditions specified over the 5-tuple</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_msg" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
  *          element ip_src{
 *           attribute address {text}
 *           attribute netmask {text}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          element ip_dst{
 *           attribute address {text}
 *           attribute netmask {text}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          element l4_protocol{
 *           attribute number {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          element src_port{
 *           attribute number {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          element dst_port{
 *           attribute number {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *           <ip_src address="131.114.54.0" netmask="255.255.252.0">
 *               <filter_mode behavior="discard"/>
 *           </ip_src>
 *
 *           <ip_dst address="131.114.54.0" netmask="255.255.252.0">
 *               <filter_mode behavior="accept"/>
 *            </ip_dst>
 *
 *            <l4_protocol number="6">
 *               <filter_mode behavior="accept"/>
 *           </l4_protocol>
 *
 *           <src_port number="80">
 *               <filter_mode behavior="accept"/>
 *           </src_port>
 *
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
#include <arpa/inet.h>
#include <Flow.hpp>

namespace blockmon
{

    class FlowFilter: public Block
    {
        static const int FIELD_ACTIVE = 1;
        static const int FILTER_OUT = 2;

        int m_in_gate;
        int m_out_gate;

        uint32_t m_ip_src_address;
        uint32_t m_ip_src_mask;
        uint8_t m_ip_src_mode;

        uint32_t m_ip_dst_address;
        uint32_t m_ip_dst_mask;
        uint8_t m_ip_dst_mode;

        uint16_t m_layer4_proto;
        uint8_t m_layer4_mode;

        uint16_t m_src_port;
        uint8_t m_src_port_mode;

        uint16_t m_dst_port;
        uint8_t m_dst_port_mode;

        /**
          * helper function, sends the packet out of the out gage
          * @param m the packet to be forwarded
          */
        inline void flow_passed(std::shared_ptr<const Msg>&& m)
        {
            send_out_through(std::move(m),m_out_gate);
        }

        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("FlowFilter:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }
        /**
          * parses the filte_mode xlm and sets the filter mdoe byte accordingly
          * @param field_node the filter_mode xml subtree
          * @param mode_byte the filter mode byte to be set
          */
        static inline bool parse_filter_mode(pugi::xml_node& field_node, uint8_t& mode_byte)
        {
           pugi::xml_node mode;
            if(!(mode = field_node.child("filter_mode")))
                return false;
            mode_byte |= 1<<FIELD_ACTIVE;
            if(pugi::xml_attribute behavior = mode.attribute("behavior"))
            {
                if(!(strcmp(behavior.value(),"discard")))
                    mode_byte |= 1<<FILTER_OUT;
                else if (strcmp(behavior.value(),"accept"))
                    return false;
            }
            else 
                return false;

            return true;
        }

        /**
          * helper function, convert a string representing an ip address to its binary version (in host by order)
          * @param str_ip the strin representing the address
          * @return the binary ip address (in host byte order)
          */
        static uint32_t string_to_ip(const char* str_ip)
        {
            uint32_t ret_val;
            if(inet_pton(AF_INET, str_ip, &ret_val) != 1)
                throw std::runtime_error("FlowFilter : cannot parse ip address");
            return ntohl(ret_val);
        }
        /**
          * decides whether filtering should go on or the packet should be discarded
          * @param filter_result whether the filter matched for a given field
          * @param filter_mode the filter mode byte associated to that field
          * @return false if the packet should be discarded, true otherwise
          */
        static inline bool go_ahead(bool filter_result, uint8_t filter_mode)
        {
            return (((filter_mode & (1<<FILTER_OUT)) && (!filter_result)) ||
                    ((!(filter_mode & (1<<FILTER_OUT))) && filter_result)) ;
        }

        /**
          * helper function, tells whether a given field should be considered for filtering
          * @param filter_mode the filter mode byte for that field
          * @return true if field has to be checked, false otherwise
          */
        static inline bool is_indirect(uint8_t filter_mode)
        {
            return (filter_mode & (1<<FIELD_ACTIVE));
        }

    public:

        /*
         * constructor
         */
        FlowFilter(const std::string &name, invocation_type invocation) : 
        Block(name, invocation),
        m_in_gate(register_input_gate("in_flow")),
        m_out_gate(register_output_gate("out_flow")),
        m_ip_src_address(0),
        m_ip_src_mask(0),
        m_ip_src_mode(0),
        m_ip_dst_address(0),
        m_ip_dst_mask(0),
        m_ip_dst_mode(0),
        m_layer4_proto(0),
        m_layer4_mode(0),
        m_src_port(0),
        m_src_port_mode(0),
        m_dst_port(0),
        m_dst_port_mode(0)
        {
        }

        FlowFilter(const FlowFilter &)=delete;
        FlowFilter& operator=(const FlowFilter &) = delete;
        FlowFilter(FlowFilter &&)=delete;
        FlowFilter& operator=(FlowFilter &&) = delete;



        /*
         * destructor
         */
        virtual ~FlowFilter()
        {}

        /**
          * configures the filter
          * @param n the xml subtree
          */
        virtual void _configure(const pugi::xml_node&  n )
        {

            if(pugi::xml_node c = n.child("ip_src"))
            {
                if(parse_filter_mode(c,m_ip_src_mode))
                {
                    if(pugi::xml_attribute attr = c.attribute("address"))
                    {
                        m_ip_src_address = string_to_ip(attr.value());
                    }
                    else signal_error ("ip_src");
                    
                    if(pugi::xml_attribute attr = c.attribute("netmask"))
                    {
                        m_ip_src_mask = string_to_ip(attr.value());
                    }
                    else signal_error ("ip_src");
                }
                else
                    signal_error("ip_src");
            }

            if(pugi::xml_node c = n.child("ip_dst"))
            {
                if(parse_filter_mode(c,m_ip_dst_mode))
                {
                    if(pugi::xml_attribute attr = c.attribute("address"))
                    {
                        m_ip_dst_address = string_to_ip(attr.value());
                    }
                    else signal_error ("ip_dst");
                    
                    if(pugi::xml_attribute attr = c.attribute("netmask"))
                    {
                        m_ip_dst_mask = string_to_ip(attr.value());
                    }
                    else signal_error ("ip_dst");
                }
                else
                    signal_error("ip_dst");
            }

            if(pugi::xml_node c = n.child("l4_protocol"))
            {
                if(parse_filter_mode(c,m_layer4_mode))
                {
                    if(pugi::xml_attribute attr = c.attribute("number"))
                    {
                        m_layer4_proto = attr.as_uint();
                    }
                else
                    signal_error("l4_protocol");

                }
                else
                    signal_error("l4_protocol");
            }


            if(pugi::xml_node c = n.child("src_port"))
            {
                if(parse_filter_mode(c,m_src_port_mode))
                {
                    if(pugi::xml_attribute attr = c.attribute("number"))
                    {
                        m_src_port = attr.as_uint();
                    }
                else
                    signal_error("src_port");
                }
                else
                    signal_error("src_port");
            }

            if(pugi::xml_node c = n.child("dst_port"))
            {
                if(parse_filter_mode(c,m_dst_port_mode))
                {
                    if(pugi::xml_attribute attr = c.attribute("number"))
                    {
                        m_dst_port = attr.as_uint();
                    }
                else
                    signal_error("dst_port");
                }
                else
                    signal_error("dst_port");
            }


        }


        /**
          * the actual filtering function
          * Expects Flow messages, otherwise it throws
          * @param m the message to be checked
         */ 
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(Flow))
                throw std::runtime_error("FlowFilter: wrong message type");
            const Flow* flow = static_cast<const Flow* > (m.get());
            
            if(is_indirect(m_ip_src_mode))
            {
                if(!go_ahead( (m_ip_src_address & m_ip_src_mask) == (flow->key().src_ip4 & m_ip_src_mask), m_ip_src_mode))
                    return;
            }
            
            if(is_indirect(m_ip_dst_mode))
            {
                if(!go_ahead( (m_ip_dst_address & m_ip_dst_mask) == (flow->key().dst_ip4 & m_ip_dst_mask), m_ip_dst_mode))
                    return;
            }

            if(is_indirect(m_layer4_mode))
            {
                if(!go_ahead(m_layer4_proto == flow->key().proto, m_layer4_mode))
                    return;
            }
            if( (flow->key().proto != Packet::kUDP) &&  (flow->key().proto != Packet::kTCP) )
                flow_passed(std::move(m));


            if(is_indirect(m_src_port_mode))
            {
                if(!go_ahead(m_src_port == flow->key().src_port, m_src_port_mode))
                    return;
            }
            
            if(is_indirect(m_dst_port_mode))
            {
                if(!go_ahead(m_dst_port == flow->key().dst_port, m_dst_port_mode))
                    return;
            }
            
            flow_passed(std::move(m));

        }







    private:

        int m_ingate_id;

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(FlowFilter,"FlowFilter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}

