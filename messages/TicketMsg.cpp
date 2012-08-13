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

#include "TicketMsg.hpp"
#include <iostream>
#include <sstream>
#include <map>

namespace blockmon {

	void TicketMsg::add_feature(string featureID, uint64_t featureVal) {
		m_featurePairs.insert(pair<string,uint64_t> (featureID, featureVal));
	}
	
	void TicketMsg::set_features(const map<string,uint64_t> featurePairs) {
		m_featurePairs = map<string, uint64_t>(featurePairs);
	}
        
        uint64_t TicketMsg::get_timestamp() const{
            return m_timestamp;
        }
        
        uint32_t TicketMsg::get_userID() const{
            return m_userID;
        }
	
	const map<string, uint64_t>* TicketMsg::get_features() const {
		return &m_featurePairs;
	}

        uint TicketMsg::get_extracted_features() const{
            return m_featurePairs.size();
        }

        void TicketMsg::clear_features() {
		m_featurePairs.clear();
	}

	void TicketMsg::set_timestamp(uint64_t timestamp) {
		m_timestamp = timestamp;
	}

	void TicketMsg::set_userID(uint32_t userID) {
		m_userID = userID;
	}
	
	

    std::string TicketMsg::to_string() const
    {
        stringstream ss;
		ss << "Ticket timestamp: " << m_timestamp << " ; User ID: " << ip_to_string(m_userID) << " ; Number of extracted features: " << (int)m_featurePairs.size() << "\n";
		map<string, uint64_t>::const_iterator it;
                for (it = m_featurePairs.begin(); it != m_featurePairs.end(); it++) {
			ss << "Feat ID: " << (*it).first << " => Feat Val: " << (*it).second << "\n" ;
		}
        return ss.str();
    }
    
    std::string TicketMsg::to_string_file() const
    {
        stringstream ss;
		ss << m_timestamp << "\t" << ip_to_string(m_userID) << "\t" << m_userID << "\t" << (int)m_featurePairs.size() << "\t";
		map<string, uint64_t>::const_iterator it;
                for (it = m_featurePairs.begin(); it != m_featurePairs.end(); it++) {
			ss << (*it).first << "\t" << (*it).second << "\t" ;
		}
                ss << "\n";
        return ss.str();
    }
    
    std::string TicketMsg::to_string_qoe_ticket_file() const
    {
        
        //timestamp imsi cell_plmnid cell_lac cell_ci cell_rac rat = 1 imei phylinkid qos apn flags=2 server_ip nr_server_ips core_port=65535 nr_server_ports proto_pkts[0] 
        //phy_pkts[0] pdu_bytes[0] sdu_bytes[0] phy_bytes[0] proto_pkts[1] phy_pkts[1] pdu_bytes[1] sdu_bytes[1] phy_bytes[1]
        stringstream sss;
		sss << m_timestamp << "\t" << m_userID << "\t000\t000\t000\t000\t1\t000\t000\t000\tfake_apn\t2\t000\t0\t65535\t0\t";
		map<string, uint64_t>::const_iterator it;
                for (it = m_featurePairs.begin(); it != m_featurePairs.end(); it++) {
			sss << (*it).second << "\t0\t0\t0\t0\t0\t0\t0\t0\t0\n" ;
		}                       
        return sss.str();
    }

    std::string TicketMsg::ip_to_string(unsigned int ip) const
    {
        stringstream ss;
		unsigned char* tmp_char = (unsigned char*) &ip;
		unsigned int tmp_val = tmp_char[3];
		ss << tmp_val;
		tmp_val = tmp_char[2];
		ss << "." << tmp_val;
		tmp_val = tmp_char[1];
		ss << "." << tmp_val;
		tmp_val = tmp_char[0];
		ss << "." << tmp_val;
        return ss.str();
    }
}
