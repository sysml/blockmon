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

#include <stdlib.h>
#include <iostream>
#include <arpa/inet.h>
#include <pugixml.hpp>

#include <Alert.hpp>

#include <IDMEFExporter.hpp>

namespace blockmon
{
	IDMEFExporter::IDMEFExporter(const std::string &name, invocation_type invocation):
		Block(name, invocation_type::Direct),
		m_ingate_id(register_input_gate("in_alert")),
		m_export_method(EXP_FILE), m_host(0), m_port(0), m_filename("log"),
		m_tcp_open(false), m_file_open(false),
		m_file_stream()
	{
		if (invocation != invocation_type::Direct) {
			blocklog("IDMEFExporter must be direct; ignoring configuration.", log_warning);
		}
	}

	IDMEFExporter::~IDMEFExporter()
	{
		// Closes the export method if any
		close_export_method();
	}

	void IDMEFExporter::_configure(const pugi::xml_node& n)
	{
		// Closes the export method if any
		close_export_method();
		// XML configuration
		pugi::xml_node export_node = n.child("export");
		pugi::xml_node file_node = n.child("file");
		if (export_node)
		{
			m_export_method = EXP_TCP;
			if (!export_node.attribute("host") || !export_node.attribute("port"))
				throw std::runtime_error("Export specification incomplete");
			std::string host = export_node.attribute("host").value();
			m_host = inet_addr(host.c_str());
			m_port = std::atoi(export_node.attribute("port").value());
		}
		else if (file_node)
		{
			m_export_method = EXP_FILE;
			if (!file_node.attribute("name"))
				throw std::runtime_error("File specification missing name");
			m_filename = file_node.attribute("name").value();
		}
		else
		{
			throw std::runtime_error("No output specified");
		}
		// Opens the export method
		open_export_method();
	}

	void IDMEFExporter::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
	{
		if(m->type() != MSG_ID(Alert)) return;
		const Alert* alert = std::static_pointer_cast<const Alert>(m).get();
		// Use pugixml to write the IDMEF message
		pugi::xml_document doc;
		pugi::xml_node decl = doc.prepend_child(pugi::node_declaration);
		decl.append_attribute("version").set_value("1.0");
		decl.append_attribute("encoding").set_value("utf-8");
		pugi::xml_node message = doc.append_child("idmef:IDMEF-Message");
		message.append_attribute("xmlns:idmef") = "http://iana.org/idmef";
		message.append_attribute("version") = "1.0";
		pugi::xml_node idmef_alert = message.append_child("idmef:Alert");
		idmef_alert.append_attribute("messageid") = alert->get_identifier();
		// Analyzer
		pugi::xml_node analyzer = idmef_alert.append_child("idmef:Analyzer");
		analyzer.append_attribute("analyzerid") = alert->get_analyzer().c_str();
		// Classification
		pugi::xml_node classification = idmef_alert.append_child("idmef:Classification");
		classification.append_attribute("text") = alert->get_alert_name().c_str();
		// Create time
		time_t time = alert->get_create_time();
		struct tm* utc_time = gmtime(&time);
		char time_str[100];
		strftime(time_str, 100, "%Y-%m-%dT%H:%M:%SZ", utc_time);
		pugi::xml_node create_time = idmef_alert.append_child("idmef:CreateTime");
		create_time.append_child(pugi::node_pcdata).set_value(time_str);
		struct tm ntp_orig;
		ntp_orig.tm_year = 1900;
		ntp_orig.tm_mon = 1;
		ntp_orig.tm_yday = 1;
		ntp_orig.tm_hour = 0;
		ntp_orig.tm_min = 0;
		ntp_orig.tm_sec = 0;
		unsigned int seconds = difftime(time, mktime(&ntp_orig));
		char ntp_timestamp[22];
		sprintf(ntp_timestamp, "0x%x.0x0", seconds);
		create_time.append_attribute("ntpstamp") = ntp_timestamp;
		// Assessment
		if (alert->is_assessment_set()) {
			pugi::xml_node assessment = idmef_alert.append_child("idmef:Assessment");
			pugi::xml_node impact = assessment.append_child("idmef:Impact");
			const char* severity;
			switch (alert->get_severity()) {
				case Alert::sev_high:
					severity = "high";
					break;
				case Alert::sev_medium:
					severity = "medium";
					break;
				case Alert::sev_low:
					severity = "low";
					break;
				case Alert::sev_info:
					severity = "info";
					break;
				default:
					severity = "medium";
					break;
			}
			impact.append_attribute("severity") = severity;
			pugi::xml_node confidence = assessment.append_child("idmef:Confidence");
			const char* conf_str;
			switch (alert->get_confidence()) {
				case Alert::conf_high:
					conf_str = "high";
					break;
				case Alert::conf_medium:
					conf_str = "medium";
					break;
				case Alert::conf_low:
					conf_str = "low";
					break;
				default:
					conf_str = "medium";
					break;
			}
			confidence.append_attribute("confidence") = conf_str;
		}
		// Sources
		const std::vector<Alert::Node>* sources = alert->get_sources();
		for (unsigned int i = 0; i < sources->size(); i++) {
			pugi::xml_node node = idmef_alert.append_child("idmef:Source");
			set_xml_from_node(node, sources->at(i));
		}
		// Targets
		const std::vector<Alert::Node>* targets = alert->get_targets();
		for (unsigned int i = 0; i < targets->size(); i++) {
			pugi::xml_node node = idmef_alert.append_child("idmef:Target");
			set_xml_from_node(node, targets->at(i));
		}
		// Send the IDMEF message to a file or using TCP
		if (m_export_method == EXP_FILE) {
			// Export to a file
			doc.save(m_file_stream);
			m_file_stream.flush();
		} else if (m_export_method == EXP_TCP) {
			// Export through a TCP socket
			std::ostringstream stream;
			doc.save(stream);
			stream.flush();
			std::string str_doc = stream.str();
			if (send(m_tcp_socket, str_doc.c_str(), str_doc.size() + 1, 0) < 0)
				throw std::runtime_error("Impossible to send an alert through the TCP connection");
		}
	}

	void IDMEFExporter::set_xml_from_node(pugi::xml_node& xml_node, const Alert::Node& node) {
		pugi::xml_node idmef_node = xml_node.append_child("idmef:Node");
		if (node.ipv4_set()) {
			pugi::xml_node address = idmef_node.append_child("idmef:Address");
			address.append_attribute("category") = "ipv4-addr-hex";
			pugi::xml_node ip = address.append_child("idmef:address");
			char ipv4[11];
			sprintf(ipv4, "0x%x", node.get_ipv4());
			ip.append_child(pugi::node_pcdata).set_value(ipv4);
		}			
		if (node.domain_name_set()) {
			idmef_node.append_attribute("category") = "dns";
			pugi::xml_node dns_name = idmef_node.append_child("idmef:name");
			dns_name.append_child(pugi::node_pcdata).set_value(node.get_domain_name().c_str());
		}
	}

	void IDMEFExporter::open_export_method() {
		if (m_export_method == EXP_FILE) {
			// Open the file for writing
			m_file_stream.open(m_filename, std::ios::out | std::ios::app);
			m_file_open = true;
		} else if (m_export_method == EXP_TCP) {
			// Open the TCP socket
			m_tcp_socket = socket(AF_INET, SOCK_STREAM, 0);
			if(m_tcp_socket == -1)
				throw std::runtime_error("Impossible to open the TCP connection");
			sockaddr_in sock_addr = { 0 };
			sock_addr.sin_addr.s_addr = m_host;
			sock_addr.sin_port = htons(m_port);
			sock_addr.sin_family = AF_INET;
			if(connect(m_tcp_socket, (sockaddr *) &sock_addr, sizeof(sockaddr)) == -1)
				throw std::runtime_error("No server is accepting the TCP connection");
			m_tcp_open = true;
		}
	}

	void IDMEFExporter::close_export_method() {
		if (m_file_open) {
			// Close the file
			m_file_stream.close();
			m_file_open = false;
		}
		if (m_tcp_open) {
			// Close the TCP connection
			close(m_tcp_socket);
			m_tcp_open = false;
		}
	}
}