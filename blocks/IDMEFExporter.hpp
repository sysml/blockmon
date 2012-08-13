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

#ifndef _BASE_IDMEFEXPORTER_HPP_
#define _BASE_IDMEFEXPORTER_HPP_
/*
 * <blockinfo type="IDMEFExporter" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *     Receives alert messages and exports them as IDMEF.
 *     Export can ben done to a file or to a distant machine through TCP.
 *   </humandesc>
 *
 *   <shortdesc>Receives alert messages and exports them as IDMEF</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_alert" msg_type="Alert" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *       element export {
 *           attribute host  {text},
 *           attribute port {xsd:integer}
 *           } |
 *       element file {
 *           attribute name {text}
 *       }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <export host="192.168.0.3" port="1234" />
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
#include <fstream>
#include <sys/socket.h>

namespace blockmon
{

    class IDMEFExporter: public Block
    {
        int m_ingate_id;

        // Configuration
		typedef enum {
			EXP_FILE,
			EXP_TCP
		} export_method;
		
        export_method m_export_method;
		
		uint32_t m_host;
		
		uint16_t m_port;
		
		std::string m_filename;

		bool m_tcp_open;

		bool m_file_open;

		std::ofstream m_file_stream;

		int m_tcp_socket;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the CMS packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        IDMEFExporter(const std::string &name, invocation_type invocation);

        /**
         * @brief Destructor
         */
         ~IDMEFExporter() ;

        /**
         * @brief Configures the block, nothing to do.
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n) ;

        /**
         * If the message received is not of type Alert throw an exception,
         * otherwise export it
         * @param m     The message
         * @param index The index of the gate the message came on
         * @return      0 upon success, negative otherwise
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int index) ;

	private:

		/**
		 * Fills an XML element from an Alert Node.
		 * @param xml_node The XMl element to fill
		 * @param node The node to use
		 */
		void set_xml_from_node(pugi::xml_node& xml_node, const Alert::Node& node);

		/**
		 * Opens the configured export method
		 */
		void open_export_method();

		/**
		 * Closes the opened export method
		 */
		void close_export_method();

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(IDMEFExporter, "IDMEFExporter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _BASE_IDMEFEXPORTER_HPP_
