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
 * <blockinfo type="ProtocolFilter" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
 *   </humandesc>
 * Selects packets based on the protocol type (i.e., the mac header's EtherType
 * field). Packets not matching the given protocol type are dropped.
 * 
 *                                                                                            
 * <shortdesc>Selects packets based on the value of the ethernet type field</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pkt" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *          element protocol{
 *           attribute type {xsd:integer}
 *           }?
 *          }
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *           <!-- select IP packets -->
 *           <protocol type="0800" />
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

namespace blockmon
{

  class ProtocolFilter: public Block
  {
       
  public:

    /*
     * constructor
     */  
    ProtocolFilter(const std::string &name, invocation_type invocation) : 
      Block(name, invocation),
      m_in_gate(register_input_gate("in_pkt")),
      m_out_gate(register_output_gate("out_pkt")),
      m_proto(Packet::kPktTypeIP4)
    {
    }

     int tohex(const std::string &s)
    {
      return strtoul(s.c_str(), NULL, 16);
    }
     
    /**
     * configures the filter
     * @param n the xml subtree
     */
    virtual void _configure(const pugi::xml_node&  n ) 
    {
      if (pugi::xml_node c = n.child("protocol"))
      {
        if (pugi::xml_attribute attr = c.attribute("type"))
        {
           std::string tmp(attr.value());
           m_proto = tohex(tmp);
        }
        else
           throw std::runtime_error("wrong type given\n");
      }
      else
         throw std::runtime_error("missing protocol parameter\n");           
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

       // char dst_ip[20];
       // char src_ip[20];
       // packet->ip_src_str(src_ip);
       // packet->ip_src_str(dst_ip);       
       
       if( packet->l3_protocol() == m_proto)
         send_out_through(std::move(m), m_out_gate);
     }

  private:
    int m_in_gate;       
     int m_out_gate;
     uint16_t m_proto;
  };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(ProtocolFilter,"ProtocolFilter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}

