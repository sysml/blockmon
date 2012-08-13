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


#include "HistoMsg.hpp"
#include <iostream>
#include <sstream>
#include <vector>

namespace blockmon {

	void HistoMsg::set_timestamp(uint64_t timestamp) {
		m_timestamp = timestamp;
	}
        
        void HistoMsg::set_featureID(string featureID) {
		m_featureID = featureID;
	}
        
        void HistoMsg::set_nr_unique_users(uint64_t uniqueUsers){
                m_nr_unique_users = uniqueUsers;            
        }
        
        void HistoMsg::set_histogram(const vector<uint32_t> histogram) {
		m_histogram = vector<uint32_t>(histogram);
	}
        
        void HistoMsg::set_total_value(uint64_t totValue){
                m_total_value = totValue;            
        }
        
        void HistoMsg::add_element(uint index) {
		m_histogram.insert(m_histogram.begin()+index, 1);
	}
	
	
        
        uint64_t HistoMsg::get_timestamp() const{
            return m_timestamp;
        }
        
        string HistoMsg::get_featureID() const{
            return m_featureID;
        }
        
        uint64_t HistoMsg::get_unique_users() const{
            return m_nr_unique_users;
        }
        
	const vector<uint32_t>* HistoMsg::get_histogram() const {
		return &m_histogram;
	}

        uint64_t HistoMsg::get_total_value() const{
            return m_total_value;
        }

        void HistoMsg::clear_histogram() {
		m_histogram.clear();
	}

	
    std::string HistoMsg::to_string() const
    {
        stringstream ss;
		ss << "Histo timestamp: " << m_timestamp << " ; Feature ID: " << m_featureID 
                   << " ; Number of unique users: " << m_nr_unique_users  
                   << " ; Total value: " << m_total_value << "\nHistogram: ";
		vector<uint32_t>::const_iterator it;
                for (it = m_histogram.begin(); it != m_histogram.end(); it++) {
			ss << (*it) << " " ;
		}
                ss << "\n";
        return ss.str();
    }
    
    std::string HistoMsg::to_string_file() const
    {
        stringstream ss;
		ss << m_timestamp << "\t" << m_featureID 
                   << "\t" << m_nr_unique_users  
                   << "\t" << m_total_value << "\t";
		vector<uint32_t>::const_iterator it;
                for (it = m_histogram.begin(); it != m_histogram.end(); it++) {
			ss << (*it) << ";" ;
		}
                ss << "\n";
        return ss.str();
    }

}

