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
 * HistoMsg.hpp
 * 
 * Histogram message:
 * timestamp, featureID, nr_of_unique_users, histogram<v1,v2,v3,...,vN>, total_value
 */

#ifndef _HISTO_MSG_HPP_
#define _HISTO_MSG_HPP_

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
     * BlockMon Message representing a Histogram. Ticket contains information
     * about a list of active traffic features and their counters.
     */

    class HistoMsg: public Msg
    {
                //Histogram timestamp
		uint64_t  m_timestamp;
                //Histogram feature ID
                string m_featureID;
                //Number of different users composing the histogram
                uint64_t m_nr_unique_users;
                //Histogram
                vector<uint32_t> m_histogram;
                //Total value (sum of feature values)
                uint64_t m_total_value;
                

    public:
                /**
		 * Message constructor that creates the histogram starting from:
		 *
		 * @param timestamp Timestamp of the current packet
		 * @param featureID The identifier of the current feature
		 */
		 
		HistoMsg(uint64_t timestamp, string featID)
                : Msg(MSG_ID(HistoMsg)), m_timestamp(timestamp), m_featureID(featID),
                    m_nr_unique_users(0),m_histogram(vector<uint32_t>())
                {
                }
                
                /**
		 * Set the histogram timestamp
		 * @param timestamp The ticket timestamp to set
		 */
		void set_timestamp(uint64_t timestamp);

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
		 * Set the features
		 * @param histogram The histogram vector
		 */
		void set_histogram(const vector<uint32_t> histogram);
                
                /**
		 * Set the total feature value 
		 * @param total value 
		 */
		void set_total_value(uint64_t totValue);
                
                /**
		 * Adds one element to the histogram. Increases the value of 
                 * the histogram element's value in the specified index position.
		 * @param index The position of the histogram where to add the element
		 */
		void add_element(uint index);

		/**
		 * Get the timestamp associated to the ticket
		 * @return the timestamp
		 */
		uint64_t get_timestamp() const;
                
                /**
		 * Get the user ID of the ticket
		 * @return the user ID
		 */
		string get_featureID() const;
                
                /**
		 * Get the number of different users composing the histogram
		 * @return the number of unique users 
		 */
		uint64_t get_unique_users() const;
                
                /**
		 * Get the histogram
		 * @return the histogram vector
		 */
		const vector<uint32_t>* get_histogram() const;

                /**
		 * Get the total feature value 
		 * @return the total feature value
		 */
		uint64_t get_total_value() const;

                /**
		 * Clear the histogram
		 */
		void clear_histogram();

                /**
		 * Convert the HistoMsg into a human-readable string file
		 */
		string to_string_file() const;
                
                /**
		 * Convert the HistoMsg into a human-readable string
		 */
		string to_string() const;
                
                


        /** 
         * This message is not moveable 
         */
        HistoMsg(HistoMsg &&) = delete;
        
        /** 
         * This message is not moveable 
         */
        HistoMsg& operator = (HistoMsg &&) = delete;
        
        /** 
         * This message is not copiable 
         */
        HistoMsg(const HistoMsg& ) = delete;

        /** 
         * This message is not copiable 
         */
        HistoMsg& operator = (const HistoMsg& other) = delete;


        /**
          message destructor: does noting!
          */
        ~HistoMsg()
        {
        }

        /**
         * Clone this message; the new Ticket will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        std::shared_ptr<Msg> clone() const
        {
           std::shared_ptr<HistoMsg> copy = std::make_shared<HistoMsg> (m_timestamp, m_featureID);
            copy.get()->set_nr_unique_users(m_nr_unique_users);
            copy.get()->set_histogram(m_histogram);
            copy.get()->set_total_value(m_total_value);
	    return copy;
        }
        
    };


    
};



#endif //_HISTO_MSG_H_PP_



