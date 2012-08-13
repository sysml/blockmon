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

#include "ADAnomalMsg.hpp"
#include "crypto/rijndael.h"
#include "CDFGenerator.hpp"
#include <iostream>
#include <sstream>
#include <vector>

namespace blockmon {
    
        void ADAnomalMsg::set_timestamp(uint64_t timestamp) {
		m_timestamp = timestamp;
	}
        
        void ADAnomalMsg::set_timescale(uint16_t timescale) {
		m_timescale = timescale;
	}
        
        void ADAnomalMsg::set_featureID(string featureID) {
		m_featureID = featureID;
	}
        
        void ADAnomalMsg::set_CCDF_size(uint16_t CCDF_size){
                m_CCDF_size = CCDF_size;            
        }
        
        void ADAnomalMsg::set_CCDF(const vector<double> CCDF){
                m_CCDF = vector<double>(CCDF);
        }
        
        void ADAnomalMsg::set_RefSet_size(uint16_t RefSet_size){
                m_RefSet_size = RefSet_size;            
        }
        
        void ADAnomalMsg::set_RefSet(const window_array RefSet){
                m_RefSet = RefSet;
        }
        
        
/******************************************************************************/        
        
        uint64_t ADAnomalMsg::get_timestamp() const{
            return m_timestamp;
        }
        
        uint16_t ADAnomalMsg::get_timescale() const{
            return m_timescale;
        }
        
        string ADAnomalMsg::get_featureID() const{
            return m_featureID;
        }
        
        uint16_t ADAnomalMsg::get_CCDF_size() const{
            return m_CCDF_size;
        }
        
	const vector<double>* ADAnomalMsg::get_CCDF() const {
		return &m_CCDF;
	}
        
        uint16_t ADAnomalMsg::get_RefSet_size() const{
            return m_RefSet_size;
        }
        
	const window_array* ADAnomalMsg::get_RefSet() const {
		return &m_RefSet;
	}

        void ADAnomalMsg::clear_CCDF() {
		m_CCDF.clear();
	}
        
        void ADAnomalMsg::clear_RefSet() {
		m_RefSet.clear();
	}

        
        vector<double> PDF_to_CCDF(vector<double> PDF)
        {
            vector<double> CDF, CCDF;
            uint i;
            for(i=0; i< PDF.size(); i++)
            {
                if(i==0)
                    CDF.push_back(PDF[i]);
                else
                    CDF.push_back(CDF[i-1] + PDF[i]);
                CCDF.push_back(1 - CDF[i]);
            }
            return CCDF;
        }
        
	
        std::string ADAnomalMsg::to_string() const
        {
                stringstream ss;
		ss << "CCDF timestamp: " << m_timestamp 
                   << " ; Timescale: " << m_timescale 
                   << " ; Feature ID: " << m_featureID      
                   << " ; CCDF_size: " << m_CCDF_size 
                   << "\nCCDF: ";
		vector<double>::const_iterator it;
                for (it = m_CCDF.begin(); it != m_CCDF.end(); it++) {
			ss << (*it) << " " ;
		}
                ss << "\nReference Set size: " << m_RefSet_size 
                   << "\nReferenceSet CCDFs:\n";
                window_element w_el;
                window_array::const_iterator itt;
                vector<double> RS_CCDF;
                uint i;
                for (itt = m_RefSet.begin(); itt != m_RefSet.end(); itt++) {
                    w_el = (*itt);
                    RS_CCDF = blockmon::PDF_to_CCDF(w_el.PDF);
                    for(i=0; i< RS_CCDF.size(); i++)
                    {
                        ss << RS_CCDF[i] << " ";
                    }
                    ss << "\n" ;
		}
                ss << "\n" ;
                return ss.str();
        }
        
        std::string ADAnomalMsg::to_string_file() const
        {
                stringstream sss;
		sss << m_timestamp 
                   << "\t" << m_timescale 
                   << "\t" << m_featureID      
                   << "\t" << m_CCDF_size 
                   << "\t";
		vector<double>::const_iterator it;
                for (it = m_CCDF.begin(); it != m_CCDF.end(); it++) {
			sss << (*it) << ";" ;
		}
                sss << "\t" << m_RefSet_size 
                   << "\t";
                window_element w_el;
                window_array::const_iterator itt;
                vector<double> RS_CCDF;
                uint i;
                for (itt = m_RefSet.begin(); itt != m_RefSet.end(); itt++) {
                    w_el = (*itt);
                    RS_CCDF = blockmon::PDF_to_CCDF(w_el.PDF);
                    for(i=0; i< RS_CCDF.size(); i++)
                    {
                        sss << RS_CCDF[i] << ";";
                    }
                    sss << "[+]" ;
		}
                sss << "\n" ;
                return sss.str();
        }

}

