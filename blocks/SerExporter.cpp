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
 * <blockinfo type="SerExporter" invocation="direct" thread_exclusive="True" thread_safe="False">
 *  <humandesc>
 *  Receives a message and exports it through a TCP session.
 *
 *  For a message to be exported it should do what?
 *  </humandesc>
 *
 *   <shortdesc>Exports Blockmon internal messages over TCP session</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_msg" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *       element export {
 *           attribute host {text},
 *           attribute port {xsd:integer}?
 *           }
 *       }
 *      }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *       <export host="131.114.54.11" port="113"/>
 *     </params>
 *   </paramsexample>
 *      
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <boost/lexical_cast.hpp>
#include <unordered_map>
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Serializer.hpp>

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <errno.h>
#include <netdb.h>

using namespace pugi;

namespace blockmon {
    
    class SerExporter : public Block {

	int m_in_gate_id;
	Serializer ser;
	std::string host;
	int port;
	int sock;
	struct sockaddr_in remote;

    public:
 
	SerExporter(const std::string& name, invocation_type invocation):
	    Block(name, invocation),
	    m_in_gate_id( register_input_gate("in_msg") ),
	    sock(-1)
        {}

	//FIXME destructor , should it be something specific?   
	~SerExporter() {}

/**
 * Configure the block given an XML element containing configuration.
 * Called before the block will begin receiving messages.
 *
 * MUST be overridden in a derived class. 
 * Configuration errors should be signaled by throwing.
 *
 * @param xmlnode the <params> XML element containing block parameters
 */
	virtual void _configure(const xml_node& xmlnode) {
	    xml_node outspec;

	    // Don't support reconfiguration yet
	    /*
	    if (m_exporter) {
		throw new std::logic_error("SerExporter block not reconfigurable");
	    }
	    */

	    if ((outspec = xmlnode.child("export"))) {
		// Parse export (transport, host, port)
		std::string cfghost = outspec.attribute("host").value();
		std::string cfgport = outspec.attribute("port").value();
		if (cfghost.empty() || cfgport.empty()) {
		    throw std::runtime_error("Export specification incomplete");
		}
		host = cfghost;
		port = atoi(cfgport.c_str());
		if(port < 0 || port > 65535) {
		    throw std::runtime_error("Invalid port");
		}
	    } else {
		throw std::runtime_error("No export or file specification");
	    }
	    //register_msg_templates();
  
            // if not already connected try to
            if(sock == -1) {
                struct hostent* tmpconversion = gethostbyname(host.c_str());
                if( !tmpconversion ) {
                    std::cerr << "Cannot resolve destination: " << host << std::endl;
                    std::cerr << strerror(errno) << std::endl;
                    return;
                }
                remote.sin_family = AF_INET;
                remote.sin_addr = *(struct in_addr*) tmpconversion->h_addr_list[0];
                remote.sin_port = htons((short) port);
                sock = socket(AF_INET, SOCK_STREAM, 0);
                if(sock == -1) {
                    std::cerr << "SerExporter: cannot create socket: " << strerror(errno) << std::endl;
                    return;
                }
                if(connect(sock, (struct sockaddr*) &remote, sizeof(remote) ) < 0 ) {
                    std::cerr << "SerExporter: error connecting to remote site: " << strerror(errno) << std::endl;
                    close(sock);
                    sock = -1;
                    return;
                }
            }

	}

/**
 * Receive a BlockMon message
 *
 * @param m a shared pointer to the message to handle
 * @param gate_id the gate ID of the input gate on which the message was 
 *                received, as returned by register_input_gate()
 *
 */
	virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int gate_id) {

	    // if not already connected try to
	    if(sock == -1) {
                struct hostent* tmpconversion = gethostbyname(host.c_str());
                if( !tmpconversion ) {
                    std::cerr << "Cannot resolve destination: " << host << std::endl;
                    std::cerr << strerror(errno) << std::endl;
                    return;
                }
                remote.sin_family = AF_INET;
                remote.sin_addr = *(struct in_addr*) tmpconversion->h_addr_list[0];
                remote.sin_port = htons((short) port);
                sock = socket(AF_INET, SOCK_STREAM, 0);
                if( sock == -1 ) {
                    std::cerr << "SerExporter: cannot create socket: " << strerror(errno) << std::endl;
                    return;
                }
                if(connect(sock, (struct sockaddr*) &remote, sizeof(remote) ) < 0 ) {
                    close(sock);
                    throw new std::runtime_error("Error connecting to remote site: " + std::string(strerror(errno)));
                }
	    }

	    m->serialize(&ser);
	    char* buffer;
	    int len = ser.finalize(&buffer);
	    send(sock, buffer, len, 0);
	}
    };
    REGISTER_BLOCK(SerExporter,"SerExporter")
}
