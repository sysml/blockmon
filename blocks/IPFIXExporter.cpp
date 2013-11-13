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
 * <blockinfo type="IPFIXExporter" invocation="direct, indirect" thread_exclusive="True" thread_safe="False">
 *  <humandesc>
 *  Receives a message and exports it via an IPFIX transport session or into
 *  an IPFIX file. This block can handle any message class for which there
 *  is a registered record type.
 *
 *  Note that this block can handle any message class for which an associated
 *  datatype entry exists in the configuration. Messages sent to this block 
 *  for which no datatype entry is available are ignored but logged.
 *  </humandesc>
 *
 *   <shortdesc>Exports Blockmon messages via IPFIX</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_msg" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *       element domain {xsd:integer}?,
 *       element export {
 *           attribute transport {"udp"|"tcp"|"sctp"},
 *           attribute host  {text},
 *           attribute port  {xsd:integer}?
 *           } |
 *       element file {
 *           attribute name {text}
 *       }
 *       element datatype {
 *           attribute name {text}
 *       }*
 *       element fastflush?
 *      }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *       <domain id="1"/>
 *       <export host="ipfix-collector.example.net" port="4739" transport="tcp"/>
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
#include <list>
#include <Block.hpp>
#include <Exporter.h>
#include <FileWriter.h>
#include <UDPExporter.h>
#include <TCPExporter.h>
#include <IPFIXTypeRegistry.hpp>
#include <IPFIXTypeBridge.hpp>
#include <IPFIXBootstrap.hpp>
#include <BlockFactory.hpp>

namespace blockmon {

class IPFIXExporter : public Block {

private:
    
    std::list<std::shared_ptr<IPFIXTypeBridge> >    m_bridges;
    std::unique_ptr<IPFIX::Exporter>                m_exporter;
    int m_gate_id;

    void configUDPExport(uint32_t odid, std::string& host, std::string& port) {
        blocklog(std::string("will export to udp ") + host + ":" + port, log_info);
        IPFIX::NetAddress na(host, port, 17);
        m_exporter = std::unique_ptr<IPFIX::Exporter>(
            new IPFIX::UDPExporter(na, odid));
    }
    
    void configTCPExport(uint32_t odid, std::string& host, std::string& port) {
        blocklog(std::string("will export to tcp ") + host + ":" + port, log_info);
        IPFIX::NetAddress na(host, port, 6);
        m_exporter = std::unique_ptr<IPFIX::Exporter>(
            new IPFIX::TCPExporter(na, odid, true));
    }

    void configFileExport(uint32_t odid, std::string& filename) {
        blocklog(std::string("will export to file ") + filename, log_info);
        m_exporter = std::unique_ptr<IPFIX::Exporter>(
            new IPFIX::FileWriter(filename, odid));
    }


public:

    IPFIXExporter(const std::string& name, invocation_type invocation):
        Block(name, invocation),
        m_exporter(),
        m_gate_id(register_input_gate("in_msg")) {}

    virtual ~IPFIXExporter() {}

    /**
     * Configure the block given an XML element containing configuration.
     * Called before the block will begin receiving messages.
     *
     * @param params_node the <params> XML element containing block parameters
     */
    virtual void _configure(const pugi::xml_node& params_node)  {
        uint32_t            odid = 1;

        bootstrapIPFIX();

        // Does not support reconfiguration yet.
        if (m_exporter) {
            throw new std::logic_error("IPFIXExporter not reconfigurable");
        }

        // Get optional observation domain ID (default 1)
        pugi::xml_node domain_node;
        if ((domain_node = params_node.child("domain"))) {
            std::string domain_id = domain_node.attribute("id").value();
            if (domain_id.empty()) {
                throw std::runtime_error("Domain missing ID");
            }
            odid = boost::lexical_cast<uint32_t>(domain_id);
        }

        // create an exporter        
        pugi::xml_node exp_node;
        if ((exp_node = params_node.child("export"))) {
            // Parse export (transport, host, port)
            std::string transport = exp_node.attribute("transport").value();
            std::string host = exp_node.attribute("host").value();
            std::string port = exp_node.attribute("port").value();

            if (transport.empty()) {
                transport = "tcp";
            }
            if (host.empty()) {
                throw std::runtime_error("Export requires host");
            }
            if (port.empty()) {
                port = std::string("4739");
            }

            if (transport == std::string("udp")) {
                configUDPExport(odid, host, port);
            } else if (transport == std::string("tcp")) {
                configTCPExport(odid, host, port);
            } else if (transport == std::string("sctp")) {
                throw std::runtime_error("SCTP not yet supported");
            } else {
                throw std::runtime_error("Unsupported transport");
            }
        } else if ((exp_node = params_node.child("file"))) {
            std::string name = exp_node.attribute("name").value();
            if (name.empty()) {
                throw std::runtime_error("File requires name");
            }
            configFileExport(odid, name);
        }
        
        // Set fast flush mode if required
        if (params_node.child("fastflush")) {
            m_exporter->setFastFlush();
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
            
            // prepare the exporter (populate templates)
            bridge->prepareExporter(*m_exporter);
            
            // store the bridge
            m_bridges.push_back(bridge);
        }
        
        // export all templates
        m_exporter->exportTemplatesForDomain();
    }
    
    virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int gate_id) {
       
        // select the first suitable bridge for the message
        for (auto iter = m_bridges.begin(); iter != m_bridges.end(); iter++) {
            if ((*iter)->canExport(m)) {
                // yep, export and leave.
                (*iter)->exportMsg(m, *m_exporter);
                return;
            }
        }
    
        blocklog("no suitable datatype for message: not exported", log_warning);
    }
};

REGISTER_BLOCK(IPFIXExporter,"IPFIXExporter")
}
