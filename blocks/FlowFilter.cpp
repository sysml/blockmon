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

#include "Filter.hpp"

using namespace pugi;

namespace blockmon
{

    class FlowFilter: public Filter
    {

        uint16_t m_src_port;
        uint16_t m_dst_port;


    public:

        /*
         * constructor
         */
        FlowFilter(const std::string &name, invocation_type invocation) :
        Filter(name, invocation),
        m_src_port(0),
        m_dst_port(0)
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
            Filter::_configure(n);
            if(xml_node c = n.child("src_port"))
            {
                if(parse_filter_mode(c,m_src_port_mode))
                {
                    if(xml_attribute attr = c.attribute("number"))
                        m_src_port = attr.as_uint();
                    else
                        signal_error("src_port");
                }
                else
                    signal_error("src_port");
            }

            if(xml_node c = n.child("dst_port"))
            {
                if(parse_filter_mode(c,m_dst_port_mode))
                {
                    if(xml_attribute attr = c.attribute("number"))
                        m_dst_port = attr.as_uint();
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
                packet_passed(std::move(m));


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

            packet_passed(std::move(m));

        }
    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(FlowFilter,"FlowFilter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}
