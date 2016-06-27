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

#include "Filter.hpp"

using namespace pugi;

namespace blockmon
{

     class PacketFilter: public Filter
     {
     private:
         typedef std::vector<uint16_t> PORT_LIST;

         uint16_t m_layer3_proto;
         uint8_t m_layer3_mode;

         PORT_LIST m_src_ports;
         PORT_LIST m_dst_ports;

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
                 for (; it != it_end; it++) {
                     if (*it == port) {
                         return !is_mode_discard;
                     }
                 }
                 return is_mode_discard;
             }

             return true;
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
             Filter(name, invocation),
             m_layer3_proto(0),
             m_layer3_mode(0)
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
             Filter::_configure(n);
             if(xml_node c = n.child("l3_protocol"))
             {
                 if(parse_filter_mode(c,m_layer3_mode))
                 {
                     if(xml_attribute attr = c.attribute("number"))
                         m_layer3_proto = attr.as_uint();
                     else
                         signal_error("l3_protocol");
                 }
                 else
                 {
                     signal_error("l3_protocol");
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
                 throw std::runtime_error("PacketFiler: wrong message type");

             const Packet* packet = static_cast<const Packet* > (m.get());

             if(is_indirect(m_layer3_mode))
             {
                 if(!Filter::go_ahead(m_layer3_proto == packet->l3_protocol(), m_layer3_mode))
                     return;
             }
             if( packet->l3_protocol() != Packet::kPktTypeIP4)
             {
                 packet_passed(std::move(m));
                 return;
             }

             if(is_indirect(m_ip_src_mode))
             {
                 if(!Filter::go_ahead( (m_ip_src_address & m_ip_src_mask) == (packet->ip_src() & m_ip_src_mask), m_ip_src_mode))
                     return;
             }

             if(is_indirect(m_ip_dst_mode))
             {
                 if(!Filter::go_ahead( (m_ip_dst_address & m_ip_dst_mask) == (packet->ip_dst() & m_ip_dst_mask), m_ip_dst_mode))
                     return;
             }

             if(is_indirect(m_layer4_mode))
             {
                 if(!Filter::go_ahead(m_layer4_proto == packet->l4_protocol(), m_layer4_mode))
                     return;
             }

             if( (!packet->is_udp()) &&  (!packet->is_tcp()) )
             {
                 packet_passed(std::move(m));
                 return;
             }

             // checks source port.
             if (!go_ahead(m_src_port_mode, m_src_ports, packet->src_port()))
                 return;

             // checks destination port.
             if (!go_ahead(m_dst_port_mode, m_dst_ports, packet->dst_port()))
                 return;

             packet_passed(std::move(m));
         }
     };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PacketFilter,"PacketFilter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}
