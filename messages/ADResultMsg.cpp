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

#include "ADResultMsg.hpp"
#include "crypto/rijndael.h"
#include <iostream>
#include <sstream>
#include <vector>

namespace blockmon {

	void ADResultMsg::set_timestamp(uint64_t timestamp) {
		m_timestamp = timestamp;
	}
        
        void ADResultMsg::set_timescale(uint16_t timescale) {
		m_timescale = timescale;
	}
        
        void ADResultMsg::set_featureID(string featureID) {
		m_featureID = featureID;
	}
        
        void ADResultMsg::set_nr_unique_users(uint64_t uniqueUsers){
                m_nr_unique_users = uniqueUsers;            
        }
        
        void ADResultMsg::set_total_value(uint64_t totValue){
                m_total_value = totValue;            
        }
        
        void ADResultMsg::set_CCDF_size(uint16_t CCDF_size){
                m_CCDF_size = CCDF_size;            
        }
        
        void ADResultMsg::set_CCDF(const vector<double> CCDF){
                m_CCDF = vector<double>(CCDF);
        }
        
        void ADResultMsg::set_phase(bool phase){
                m_phase = phase;
        }
	
        void ADResultMsg::set_AccReg_LowBound(float arlb){
                m_AR_LB = arlb;
        }
	
        void ADResultMsg::set_AccReg_UppBound(float arub){
                m_AR_UB = arub;
        }
        
        void ADResultMsg::set_Internal_Dispersion(float idm){
            m_ID_mean = idm;
        }
        
        void ADResultMsg::set_External_Dispersion(float edm){
            m_ED_mean = edm;
        }
        
        void ADResultMsg::set_Anomaly_code(uint16_t code){
            m_Anomaly_code = code;
        }
        
/******************************************************************************/        
        
        uint64_t ADResultMsg::get_timestamp() const{
            return m_timestamp;
        }
        
        uint16_t ADResultMsg::get_timescale() const{
            return m_timescale;
        }
        
        string ADResultMsg::get_featureID() const{
            return m_featureID;
        }
        
        uint64_t ADResultMsg::get_unique_users() const{
            return m_nr_unique_users;
        }
        
        uint64_t ADResultMsg::get_total_value() const{
            return m_total_value;
        }
        
        uint16_t ADResultMsg::get_CCDF_size() const{
            return m_CCDF_size;
        }
        
	const vector<double>* ADResultMsg::get_CCDF() const {
		return &m_CCDF;
	}
        
        bool ADResultMsg::get_phase() const{
            return m_phase;
        }

        float ADResultMsg::get_AccReg_LowBound() const{
            return m_AR_LB;
        }
        
        float ADResultMsg::get_AccReg_UppBound() const{
            return m_AR_UB;
        }
        
        float ADResultMsg::get_Internal_Dispersion() const{
            return m_ID_mean;
        }
        
        float ADResultMsg::get_External_Dispersion() const{
            return m_ED_mean;
        }
        
        uint16_t ADResultMsg::get_Anomaly_code() const{
            return m_Anomaly_code;
        }

        void ADResultMsg::clear_CCDF() {
		m_CCDF.clear();
	}

	
    std::string ADResultMsg::to_string() const
    {
        stringstream ss;
		ss << "CCDF timestamp: " << m_timestamp 
                   << " ; Timescale: " << m_timescale 
                   << " ; Feature ID: " << m_featureID      
                   << " ; Number of unique users: " << m_nr_unique_users  
                   << " ; Total value: " << m_total_value 
                   << " ; CCDF_size: " << m_CCDF_size 
                   << "\nCCDF:\n";
		vector<double>::const_iterator it;
                for (it = m_CCDF.begin(); it != m_CCDF.end(); it++) {
			ss << (*it) << " " ;
		}
                ss << "\n";
                
                string phase;
                if(m_phase) phase = "Learning";
                else phase = "Detection";
                
                ss << "phase: " << phase 
                   << " ; Acceptance Region Lower Bound: " << m_AR_LB 
                   << " ; Acceptance Region Upper Bound: " << m_AR_UB
                   << " ; Internal Dispersion Mean: " << m_ID_mean     
                   << " ; External Dispersion Mean: " << m_ED_mean
                   << " ; Anomaly code: " << m_Anomaly_code << "\n";    
        return ss.str();
    }
    
    std::string ADResultMsg::to_string_file() const
    {
        stringstream sss;
		sss << m_timestamp 
                   << "\t" << m_timescale 
                   << "\t" << m_featureID      
                   << "\t" << m_nr_unique_users  
                   << "\t" << m_total_value 
                   << "\t" << m_CCDF_size 
                   << "\t";
		vector<double>::const_iterator it;
                for (it = m_CCDF.begin(); it != m_CCDF.end(); it++) {
			sss << (*it) << ";" ;
		}
                
                string phase;
                if(m_phase) phase = "Learning";
                else phase = "Detection";
                
                sss << "\t" << phase 
                   << "\t" << m_AR_LB 
                   << "\t" << m_AR_UB
                   << "\t" << m_ID_mean     
                   << "\t" << m_ED_mean
                   << "\t" << m_Anomaly_code << "\n";    
        return sss.str();
    }

}

