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
 * <blockinfo type="PacketFilter" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
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
 * l3_protocol                                                                                 
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
 * </humandesc>
 * <shortdesc>Selects packets based on conditions specified over the 5-tuple</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *          element l3_protocol{
 *           attribute number {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
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
 *           element number{
 *               attribute value = {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          element dst_port{
 *           element number{
 *               attribute value = {xsd:integer}
 *           element filter_mode{
 *               attribute behavior = {"discard"|"accept"}
 *           }?
 *          }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *           <l3_protocol number="2048">
 *               <filter_mode behavior="accept"/>
 *           </l3_protocol>
 *
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
 *               <number value="80"/>
 *               <number value="110"/>
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
#include <Packet.hpp>

using namespace pugi;

namespace blockmon
{

	 class PacketFilter: public Block
	 {
	 private:
		 typedef std::vector<uint16_t> PORT_LIST;

		 static const int FIELD_ACTIVE = 1;
		 static const int FILTER_OUT = 2;

		 int m_in_gate;
		 int m_out_gate;

		 uint16_t m_layer3_proto;
		 uint8_t m_layer3_mode;

		 uint32_t m_ip_src_address;
		 uint32_t m_ip_src_mask;
		 uint8_t m_ip_src_mode;

		 uint32_t m_ip_dst_address;
		 uint32_t m_ip_dst_mask;
		 uint8_t m_ip_dst_mode;

		 uint16_t m_layer4_proto;
		 uint8_t m_layer4_mode;

		 PORT_LIST m_src_ports;
		 uint8_t m_src_port_mode;

		 PORT_LIST m_dst_ports;
		 uint8_t m_dst_port_mode;

		 /**
		   * helper function, sends the packet out of the out gage
		   * @param m the packet to be forwarded
		   */
		 inline void packet_passed(std::shared_ptr<const Msg>&& m)
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
			 std::string  errstr ("PacketFilter:: malformed xml node for the field ");
			 errstr+=fieldname;
			 throw std::runtime_error(errstr);
		 }
		 /**
		   * parses the filte_mode xlm and sets the filter mdoe byte accordingly
		   * @param field_node the filter_mode xml subtree
		   * @param mode_byte the filter mode byte to be set
		   */
		 static inline bool parse_filter_mode(xml_node& field_node, uint8_t& mode_byte)
		 {
			 xml_node mode;
			 if(!(mode = field_node.child("filter_mode")))
				 return false;
			 mode_byte |= 1<<FIELD_ACTIVE;
			 if(xml_attribute behavior = mode.attribute("behavior"))
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
				 throw std::runtime_error("PacketFilter : cannot parse ip address");
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
		   * decides whether filtering should go on or the packet should be discarded
		   * @param[in] mode the filter mode.
		   * @param[in] port_list port list.
		   * @param[in] port port number.
		   * @return false if the packet should be discarded, true otherwise
		   */
		 static inline bool go_ahead(uint8_t mode, PORT_LIST& port_list, uint16_t port)
		 {
			 if(is_indirect(mode))
			 {
				 PORT_LIST::iterator it = port_list.begin();
				 PORT_LIST::iterator it_end = port_list.end();

				 bool is_mode_discard = (0 != (mode & (1<<FILTER_OUT)));
				 if (is_mode_discard)
				 {
					 while (it != it_end)
					 {
						 if (*it == port)
						 {
							 return false;
						 }

						 it++;
					 }
				 }
				 else
				 {
					 while (it != it_end)
					 {
						 if (*it == port)
						 {
							 return true;
						 }

						 it++;
					 }

					 return false;
				 }
			 }

			 return true;
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

		 /**
		   * Parses port configuration.
		   * @param[out] mode the filter mode.
		   * @param[out] port_list port list.
		   * @param[in] node_param the xml_node object represents the node params.
		   * @param[in] port_node_name the node name for port number.
		   */
		 static inline void parse_port_configuration(
				 uint8_t& mode, PORT_LIST& port_list,
				 const xml_node& node_param, const char_t* port_node_name)
		 {
			 xml_node node_port = node_param.child(port_node_name);

			 if (!node_port.empty())
			 {
				 if(parse_filter_mode(node_port, mode))
				 {
					 for (xml_node node_number = node_port.child("number");
							 !node_number.empty();
							 node_number = node_number.next_sibling("number"))
					 {
						 if(xml_attribute attr = node_number.attribute("value"))
						 {
							 port_list.push_back(attr.as_uint());
						 }
						 else
						 {
							 signal_error(port_node_name);
						 }
					 }

					 if (port_list.empty())
					 {
						 // checks whether the old specification is specified
						 xml_attribute attr = node_port.attribute("number");
						 if(attr.empty())
						 {
							 signal_error(port_node_name);
						 }

						 port_list.push_back(attr.as_uint());
					 }
				 }
				 else
				 {
					 signal_error(port_node_name);
				 }
			 }
		 }

	 public:

		 /*
		  * constructor
		  */
		 PacketFilter(const std::string &name, invocation_type invocation) :
			 Block(name, invocation),
			 m_in_gate(register_input_gate("in_pkt")),
			 m_out_gate(register_output_gate("out_pkt")),
			 m_layer3_proto(0),
			 m_layer3_mode(0),
			 m_ip_src_address(0),
			 m_ip_src_mask(0),
			 m_ip_src_mode(0),
			 m_ip_dst_address(0),
			 m_ip_dst_mask(0),
			 m_ip_dst_mode(0),
			 m_layer4_proto(0),
			 m_layer4_mode(0),
			 m_src_port_mode(0),
			 m_dst_port_mode(0)
		 {
		 }

		 PacketFilter(const PacketFilter &)=delete;
		 PacketFilter& operator=(const PacketFilter &) = delete;
		 PacketFilter(PacketFilter &&)=delete;
		 PacketFilter& operator=(PacketFilter &&) = delete;

		 /*
		  * destructor
		  */
		 virtual ~PacketFilter()
		 {}

		 /**
		   * configures the filter
		   * @param n the xml subtree
		   */
		 virtual void _configure(const xml_node&  n )
		 {
			 if(xml_node c = n.child("l3_protocol"))
			 {
				 if(parse_filter_mode(c,m_layer3_mode))
				 {
					 if(xml_attribute attr = c.attribute("number"))
					 {
						 m_layer3_proto = attr.as_uint();
					 }
					 else
					 {
						 signal_error("l3_protocol");
					 }
				 }
				 else
				 {
					 signal_error("l3_protocol");
				 }
			 }

			 if(xml_node c = n.child("ip_src"))
			 {
				 if(parse_filter_mode(c,m_ip_src_mode))
				 {
					 if(xml_attribute attr = c.attribute("address"))
					 {
						 m_ip_src_address = string_to_ip(attr.value());
					 }
					 else
					 {
						 signal_error ("ip_src");
					 }

					 if(xml_attribute attr = c.attribute("netmask"))
					 {
						 m_ip_src_mask = string_to_ip(attr.value());
					 }
					 else
					 {
						 signal_error ("ip_src");
					 }
				 }
				 else
				 {
					 signal_error("ip_src");
				 }
			 }

			 if(xml_node c = n.child("ip_dst"))
			 {
				 if(parse_filter_mode(c,m_ip_dst_mode))
				 {
					 if(xml_attribute attr = c.attribute("address"))
					 {
						 m_ip_dst_address = string_to_ip(attr.value());
					 }
					 else
					 {
						 signal_error ("ip_dst");
					 }

					 if(xml_attribute attr = c.attribute("netmask"))
					 {
						 m_ip_dst_mask = string_to_ip(attr.value());
					 }
					 else
					 {
						 signal_error ("ip_dst");
					 }
				 }
				 else
				 {
					 signal_error("ip_dst");
				 }
			 }

			 if(xml_node c = n.child("l4_protocol"))
			 {
				 if(parse_filter_mode(c,m_layer4_mode))
				 {
					 if(xml_attribute attr = c.attribute("number"))
					 {
						 m_layer4_proto = attr.as_uint();
					 }
					 else
					 {
						 signal_error("l4_protocol");
					 }
				 }
				 else
				 {
					 signal_error("l4_protocol");
				 }
			 }

			 parse_port_configuration(m_src_port_mode, m_src_ports, n, "src_port");
			 parse_port_configuration(m_dst_port_mode, m_dst_ports, n, "dst_port");
		 }

		 /**
		   * the actual filtering function
		   * Expects Packet messages, otherwise it throws
		   * @param m the message to be checked
		  */
		 virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
		 {
			 if(m->type() != MSG_ID(Packet))
			 {
				 throw std::runtime_error("PacketFiler: wrong message type");
			 }

			 const Packet* packet = static_cast<const Packet* > (m.get());
			 if(is_indirect(m_layer3_mode))
			 {
				 if(!go_ahead(m_layer3_proto == packet->l3_protocol(), m_layer3_mode))
				 {
					 return;
				 }
			 }
			 if( packet->l3_protocol() != Packet::kPktTypeIP4)
			 {
				 packet_passed(std::move(m));
				 return;
			 }

			 if(is_indirect(m_ip_src_mode))
			 {
				 if(!go_ahead( (m_ip_src_address & m_ip_src_mask) == (packet->ip_src() & m_ip_src_mask), m_ip_src_mode))
				 {
					 return;
				 }
			 }

			 if(is_indirect(m_ip_dst_mode))
			 {
				 if(!go_ahead( (m_ip_dst_address & m_ip_dst_mask) == (packet->ip_dst() & m_ip_dst_mask), m_ip_dst_mode))
				 {
					 return;
				 }
			 }

			 if(is_indirect(m_layer4_mode))
			 {
				 if(!go_ahead(m_layer4_proto == packet->l4_protocol(), m_layer4_mode))
				 {
					 return;
				 }
			 }

			 if( (!packet->is_udp()) &&  (!packet->is_tcp()) )
			 {
				 packet_passed(std::move(m));
				 return;
			 }

			 // checks source port.
			 if (!go_ahead(m_src_port_mode, m_src_ports, packet->src_port()))
			 {
				 return;
			 }

			 // checks destination port.
			 if (!go_ahead(m_dst_port_mode, m_dst_ports, packet->dst_port()))
			 {
				 return;
			 }

			 packet_passed(std::move(m));
		 }
	 };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PacketFilter,"PacketFilter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}

