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
 * <blockinfo type="IPFIXSource" invocation="async" thread_exclusive="True">
 *   <humandesc>
 *     Reads records from an IPFIX transport session and outputs messages 
 *     according to the datatypes registered with the source block. May
 *     send out Messages of any type, depending on the data received from 
 *     the remote IPFIX device and the the registered data types. 
 *   </humandesc>
 *
 *   <shortdesc>Receives messages from an IPFIX exporter</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="source_out" msg_type="Any" m_start="0" m_end="0" />
 *   </gates>
 *
*   <paramsschema>
 *    element params {
 *       element collect {
 *           attribute transport {"udp"|"tcp"|"sctp"},
 *           attribute port      {xsd:integer}?
 *           } |
 *       element file {
 *           attribute name {text}
 *       }
 *       element datatype {
 *           attribute name {text}
 *       }*
 *      }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *       <collect port="4739" transport="tcp"/>
 *       <datatype name="ipv4flow"/>
 *       or
 *       <file name="foo.ipfix"/>
 *       <datatype name="ipv4flow"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <boost/lexical_cast.hpp>
#include <Block.hpp>
#include <Collector.h>
#include <UDPCollector.h>
#include <TCPSingleCollector.h>
#include <FileReader.h>
#include <IPFIXTypeRegistry.hpp>
#include <IPFIXTypeBridge.hpp>
#include <IPFIXBootstrap.hpp>
#include <BlockFactory.hpp>
#include <Timer.hpp>

namespace blockmon
{

class IPFIXSource: public Block {

private:
    
    std::list<std::shared_ptr<IPFIXTypeBridge> >        m_bridges;
    std::unique_ptr<IPFIX::Collector>                   m_collector;
    IPFIX::MBuf                                         m_mbuf;
    int                                                 m_gate_id;
    unsigned int                                        m_eosdelay;
    
    static const unsigned int kEOSTimer = 1;
    
    void configUDPCollection(std::string& port) {
        blocklog(std::string("will collect from udp ") + port, log_info);
        IPFIX::NetAddress na(port, 17, AF_INET);
        m_collector = std::unique_ptr<IPFIX::Collector>(
            new IPFIX::UDPCollector(na));                     
    }

    void configTCPCollection(std::string& port) {
        blocklog(std::string("will collect from tcp ") + port, log_info);
        IPFIX::NetAddress na(port, 6, AF_INET);
        m_collector = std::unique_ptr<IPFIX::Collector>(
            new IPFIX::TCPSingleCollector(na));                     
    }
    
    void configFileImport(std::string& filename) {
        blocklog(std::string("will read from file ") + filename, log_info);
        m_collector = std::unique_ptr<IPFIX::Collector> (
        new IPFIX::FileReader(filename));
    }

public:

    /**
     * Configure the block given an XML element containing configuration.
     * Called before the block will begin receiving messages.
     *
     * @param params_node the <params> XML element containing block parameters
     */
    virtual void _configure(const pugi::xml_node& params_node)  {
        bootstrapIPFIX();

        // Does not support reconfiguration yet.
        if (m_collector) {
            throw new std::logic_error("IPFIXSource not reconfigurable");
        }

        // create a collector
        pugi::xml_node col_node;
        if ((col_node = params_node.child("collect"))) {
            std::string transport = col_node.attribute("transport").value();
            std::string port = col_node.attribute("port").value();

            if (transport.empty()) {
                transport = "tcp";
            }
            if (port.empty()) {
                port = std::string("4739");
            }

            if (transport == std::string("udp")) {
                configUDPCollection(port);
            } else if (transport == std::string("tcp")) {
                configTCPCollection(port);
            } else if (transport == std::string("sctp")) {
                throw std::runtime_error("SCTP not yet supported");
            } else {
                throw std::runtime_error("Unsupported transport");
            }
        } else if ((col_node = params_node.child("file"))) {
            std::string name = col_node.attribute("name").value();
            if (name.empty()) {
                throw std::runtime_error("File requires name");
            }
            configFileImport(name);
        }

        // Populate list of bridges (data types) 
        for (pugi::xml_node dt_node = params_node.child("datatype"); 
                            dt_node; 
                            dt_node = dt_node.next_sibling("datatype"))
        {
            std::string dt_name = dt_node.attribute("name").value();
            if (dt_name.empty()) {
                throw std::runtime_error("Datatype missing name");
            }
        
            std::shared_ptr<IPFIXTypeBridge> bridge = 
                IPFIXTypeRegistry::instance().bridgeForTypeName(dt_name);
            if (bridge.get() == NULL) {
                throw std::runtime_error("Unknown datatype " + dt_name);
            }
            
            // prepare the collector (register receivers)
            bridge->prepareCollector(*m_collector, get_output_gate(m_gate_id));
            
            // store the bridge
            m_bridges.push_back(bridge);
        }
    }
    
    IPFIXSource(const std::string& name, invocation_type invocation):
        Block(name, invocation),
        m_collector(),
        m_mbuf(),
        m_gate_id(register_output_gate("source_out")),
        m_eosdelay(10) {}

    virtual ~IPFIXSource() {}

    void _do_async()  {
        if (m_collector) {
            if (!m_collector->receiveMessage(m_mbuf)) {
                // null out collector -- causes close
                // FIXME yeah sick hackery but g++ is tedious
                m_collector = std::unique_ptr<IPFIX::Collector>(reinterpret_cast<IPFIX::Collector*>(0));
                
                blocklog(std::string("Collector at end of stream, will wait ") + 
                        boost::lexical_cast<std::string>(m_eosdelay) +
                        " seconds, then shut down", log_warning);
                // set a timer to shut down after a delay
                set_timer_at(get_BM_time() + m_eosdelay * 1000000, "end of stream", kEOSTimer);
            }
        } else {
            // async without collector, do nothing.
        }
    }
    
    void _handle_timer(std::shared_ptr<Timer>&& t) {
        if (t->get_id() == kEOSTimer) {
            blocklog(std::string("Collector shutdown"), log_warning);
            exit(0);
        }
    }
};

REGISTER_BLOCK(IPFIXSource,"IPFIXSource")
}
