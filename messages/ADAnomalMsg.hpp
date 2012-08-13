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
 * ADAnomalMsg.hpp
 * 
 * Anomaly Detection Anomal message:
 * Timestamp, 
 * Timescale,
 * Feature ID, 
 * CCDF size N, 
 * Current CCDF <vector>, 
 * Reference Set size M,
 * Reference Set CCDFs <vector<vector>>,
 */

#ifndef _AD_ANOMAL_MSG_HPP_
#define _AD_ANOMAL_MSG_HPP_

#include <Msg.hpp>
#include <ClassId.hpp>

#include <vector>
#include <utility>
#include <iostream>
#include <string>
#include <stdint.h>



using namespace std;

namespace blockmon
{
    /**
     * BlockMon Message representing the anomalous CCDF and its reference set
     * ADAnomalMsg contains information about the anomalous CCDF of the current traffic 
     * feature distribution, in the current time interval. It includes also the 
     * reference set (set of CCDFs) of the current CCDF.
     */
    typedef struct {
        uint64_t timestamp;
        uint16_t nr_unique_users;
        uint16_t PDF_size;
        vector<double> PDF;
        bool L_phase; //Learning phase = true, Detection phase = false
    }window_element;
    
    typedef vector<window_element> window_array;
    
    class ADAnomalMsg: public Msg
    {
                //CCDF timestamp
		uint64_t  m_timestamp;
                //CCDF Timescale
                uint16_t m_timescale;
                //CCDF feature ID
                string m_featureID;
                //CCDF size
                uint16_t m_CCDF_size;
                //CCDF
                vector<double> m_CCDF;
                //Reference set size
                uint16_t m_RefSet_size;
                //Reference Set
                window_array m_RefSet;

    public:
                /**
		 * Message constructor that creates the Anomalous message starting from:
		 *
		 * @param timestamp Timestamp of the current CCDF
                 * @param timescale Timescale of the current CCDF
		 * @param featureID The identifier of the current feature
		 */
		ADAnomalMsg(uint64_t timestamp, uint16_t timescale, string featID)
                : Msg(MSG_ID(ADAnomalMsg)), m_timestamp(timestamp), 
                        m_timescale(timescale), m_featureID(featID),
                        m_CCDF_size(0), m_CCDF(vector<double>()), 
                        m_RefSet_size(0), m_RefSet()
                {
                }
                
                /**
		 * Set the CCDF timestamp
		 * @param timestamp The CCDF timestamp to set
		 */
		void set_timestamp(uint64_t timestamp);
                
                /**
		 * Set the CCDF timescale
		 * @param timescale The CCDF timescale to set
		 */
		void set_timescale(uint16_t timescale);

                /**
		 * Set the featureID
		 * @param featureID 
		 */
		void set_featureID(string featureID);
                
                /**
		 * Set the size of the CCDF (number of bins)
		 * @param CCDF size 
		 */
		void set_CCDF_size(uint16_t CCDF_size);
                
                /**
		 * Set the CCDF
		 * @param CCDF The CCDF vector
		 */
		void set_CCDF(const vector<double> CCDF);
                
                /**
		 * Set the size of the Reference set (number of CCDFs)
		 * @param RefSet size 
		 */
		void set_RefSet_size(uint16_t RefSet_size);
                
                /**
		 * Set the Reference Set
		 * @param RefSet The Reference Set vector of CCDFs vectors
		 */
		void set_RefSet(const window_array RefSet);
                
               
   /**************************************************************************/             
                
		/**
		 * Get the timestamp associated to the CCDF
		 * @return the timestamp
		 */
		uint64_t get_timestamp() const;
                
                /**
		 * Get the timescale associated to the CCDF
		 * @return the timescale
		 */
		uint16_t get_timescale() const;
                
                /**
		 * Get the user ID of the CCDF
		 * @return the user ID
		 */
		string get_featureID() const;
                
                /**
		 * Get the CCDF size (number of bins) 
		 * @return the CCDF size
		 */
		uint16_t get_CCDF_size() const;
                
                /**
		 * Get the CCDF
		 * @return the CCDF vector
		 */
		const vector<double>* get_CCDF() const;
                
                /**
		 * Get the Reference Set size (number of CCDFs) 
		 * @return the Reference Set size
		 */
		uint16_t get_RefSet_size() const;
                
                /**
		 * Get the Reference Set
		 * @return the RefSet vector of CCDFs vectors
		 */
		const window_array* get_RefSet() const;
                

                /**
		 * Clear the CCDF
		 */
		void clear_CCDF();
                
                /**
		 * Clear the REfSet
		 */
		void clear_RefSet();

                /**
		 * Convert the ADAnomalMsg into a human-readable string
		 */
		string to_string() const;
                
                /**
		 * Convert the ADAnomalMsg into a string to send to a txt file
		 */
		string to_string_file() const;
                
                /**
		 * Convert the PDF into CCDF
		 */
                vector<double> PDF_to_CCDF(vector<double> PDF) const;


        /** 
         * This message is not moveable 
         */
        ADAnomalMsg(ADAnomalMsg &&) = delete;
        
        /** 
         * This message is not moveable 
         */
        ADAnomalMsg& operator = (ADAnomalMsg &&) = delete;
        
        /** 
         * This message is not copiable 
         */
        ADAnomalMsg(const ADAnomalMsg& ) = delete;

        /** 
         * This message is not copiable 
         */
        ADAnomalMsg& operator = (const ADAnomalMsg& other) = delete;


        /**
          message destructor: does noting!
          */
        ~ADAnomalMsg()
        {
        }

        /**
         * Clone this message; the new Ticket will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        std::shared_ptr<Msg> clone() const
        {
            std::shared_ptr<ADAnomalMsg> copy = std::make_shared<ADAnomalMsg>(m_timestamp, m_timescale, m_featureID);
            copy.get()->set_CCDF_size(m_CCDF_size);
            copy.get()->set_CCDF(m_CCDF);
            copy.get()->set_RefSet_size(m_RefSet_size);
            copy.get()->set_RefSet(m_RefSet);
            return copy;
        }
    };


    
};



#endif //__AD_ANOMAL_MSG_H__


