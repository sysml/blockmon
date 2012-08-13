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
 * ADResultMsg.hpp
 * 
 * Anomaly Detection Result message:
 * Timestamp, 
 * Timescale,
 * Feature ID, 
 * Number of active users, 
 * Total counter, 
 * CCDF size N, 
 * Current CCDF <vector>, 
 * Phase (true=Learning, false=Detection), 
 * Acceptance Region lower bound,
 * Acceptance Region upper bound, 
 * Internal Dispersion mean, 
 * External Dispersion mean, 
 * Anomaly type code.
 */

#ifndef _AD_RESULT_MSG_HPP_
#define _AD_RESULT_MSG_HPP_

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
     * BlockMon Message representing the results of the Anomaly Detection 
     * application. 
     * ADResultMsg contains information about the test results of the current traffic 
     * feature distribution, in the current time interval. It includes also the 
     * CCDF of the traffic feature distribution.
     */

    class ADResultMsg: public Msg
    {
                //CCDF timestamp
		uint64_t  m_timestamp;
                //CCDF Timescale
                uint16_t m_timescale;
                //CCDF feature ID
                string m_featureID;
                //Number of different users composing the CCDF
                uint64_t m_nr_unique_users;
                //Total value (sum of feature values)
                uint64_t m_total_value;
                //CCDF size
                uint16_t m_CCDF_size;
                //CCDF
                vector<double> m_CCDF;
                //Algorithm phase (is Learning?)
                bool m_phase;
                //Acceptance Region lower bound
                float m_AR_LB;
                //Acceptance Region upper bound 
                float m_AR_UB;
                //Internal Dispersion mean
                float m_ID_mean;
                //External Dispersion mean ()
                float m_ED_mean;
                //Anomaly type code ()
                uint16_t m_Anomaly_code;

    public:
                /**
		 * Message constructor that creates the Result starting from:
		 *
		 * @param timestamp Timestamp of the current CCDF
		 * @param timescale Timescale of the current CCDF 
                 * @param featureID The identifier of the current feature
		 */
		ADResultMsg(uint64_t timestamp, uint16_t timescale, string featID)
                : Msg(MSG_ID(ADResultMsg)), m_timestamp(timestamp), 
                        m_timescale(timescale), m_featureID(featID),
                        m_nr_unique_users(0), m_total_value(0), m_CCDF_size(0),
                        m_CCDF(vector<double>()), m_phase(true), m_AR_LB(0.0),
                        m_AR_UB(0.0), m_ID_mean(0.0),m_ED_mean(0.0),
                        m_Anomaly_code(255)
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
		 * Set the number of unique users
		 * @param unique users 
		 */
		void set_nr_unique_users(uint64_t uniqueUsers);
                
                /**
		 * Set the total feature value 
		 * @param total value 
		 */
		void set_total_value(uint64_t totValue);
                
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
                 * Set the algorithm phase
                 * @param phase the algorithm phase 
                 */
                void set_phase(bool phase);
                
                /**
                 * Set the acceptance region lower bound
                 * @param arlb the acceptance region lower bound
                 */
                void set_AccReg_LowBound(float arlb);
                
                /**
                 * Set the acceptance region upper bound
                 * @param arub the acceptance region upper bound
                 */
                void set_AccReg_UppBound(float arub);
                
                /**
                 * Set the Internal Dispersion mean
                 * @param idm the Internal Dispersion mean
                 */
                void set_Internal_Dispersion(float idm);
                
                /**
                 * Set the External Dispersion mean
                 * @param edm the External Dispersion mean
                 */
                void set_External_Dispersion(float edm);
                
                /**
		 * Set the anomaly type code
		 * @param code the anomaly type code
		 */
		void set_Anomaly_code(uint16_t code);
               
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
		 * Get the number of different users composing the CCDF
		 * @return the number of unique users 
		 */
		uint64_t get_unique_users() const;
                
                /**
		 * Get the total feature value 
		 * @return the total feature value
		 */
		uint64_t get_total_value() const;
                
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
		 * Get the algorithm phase
		 * @return the algorithm phase
		 */
		bool get_phase() const;

                /**
                 * Get the acceptance region lower bound
                 * @return the acceptance region lower bound
                 */
                float get_AccReg_LowBound() const;
                
                /**
                 * Get the acceptance region upper bound
                 * @return the acceptance region upper bound
                 */
                float get_AccReg_UppBound() const;
                
                /**
                 * Get the Internal Dispersion mean
                 * @return the Internal Dispersion mean
                 */
                float get_Internal_Dispersion() const;
                
                /**
                 * Get the External Dispersion mean
                 * @return the External Dispersion mean
                 */
                float get_External_Dispersion() const;
                
                /**
		 * Get the anomaly type code
		 * @return the anomaly type code
		 */
		uint16_t get_Anomaly_code() const;

                /**
		 * Clear the histogram
		 */
		void clear_CCDF();

                /**
		 * Convert the ADResultMsg into a human-readable string
		 */
		string to_string() const;
                
                /**
		 * Convert the ADResultMsg into a string to send to a file
		 */
		string to_string_file() const;


        /** 
         * This message is not moveable 
         */
        ADResultMsg(ADResultMsg &&) = delete;
        
        /** 
         * This message is not moveable 
         */
        ADResultMsg& operator = (ADResultMsg &&) = delete;
        
        /** 
         * This message is not copiable 
         */
        ADResultMsg(const ADResultMsg& ) = delete;

        /** 
         * This message is not copiable 
         */
        ADResultMsg& operator = (const ADResultMsg& other) = delete;


        /**
          message destructor: does noting!
          */
        ~ADResultMsg()
        {
        }

        /**
         * Clone this message; the new Ticket will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        
        std::shared_ptr<Msg> clone() const
        {
            std::shared_ptr<ADResultMsg> copy = std::make_shared<ADResultMsg>(m_timestamp, m_timescale, m_featureID);
            copy.get()->set_nr_unique_users(m_nr_unique_users);            
            copy.get()->set_total_value(m_total_value);
            copy.get()->set_CCDF_size(m_CCDF_size);
            copy.get()->set_CCDF(m_CCDF);
            copy.get()->set_phase(m_phase);
            copy.get()->set_AccReg_LowBound(m_AR_LB);
            copy.get()->set_AccReg_UppBound(m_AR_UB);
            copy.get()->set_Internal_Dispersion(m_ID_mean);
            copy.get()->set_External_Dispersion(m_ED_mean);
            copy.get()->set_Anomaly_code(m_Anomaly_code);
	    return copy;
        }
    };


    
};



#endif //__AD_RESULT_MSG_H__



