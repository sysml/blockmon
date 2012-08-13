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
 * Ticket.hpp
 * 
 * Ticket message:
 * timestamp, userID, active features map, <featID1, val_feat1>,<featID2, val_feat2>,...,<featIDN, val_featN>
 */

#ifndef _TICKET_MSG_HPP_
#define _TICKET_MSG_HPP_

#include <Msg.hpp>
#include <ClassId.hpp>

#include <map>
#include <utility>
#include <iostream>
#include <string>
#include <stdint.h>



using namespace std;

namespace blockmon
{
    /**
     * BlockMon Message representing a Ticket. Ticket contains information
     * about a list of active traffic features and their counters.
     */

    class TicketMsg: public Msg
    {
                //Ticket timestamp
		uint64_t  m_timestamp;
                //client IP address of the packet
                uint32_t m_userID;
                //Map containing the feature pairs <key,value> = <string FeatureID, int FeatureValue>
                map<string,uint64_t> m_featurePairs;

    public:
                /**
		 * Message constructor that creates the ticket starting from:
		 *
		 * @param timestamp Timestamp of the current packet
		 * @param userID The client IP address of the current packet
		 */
		TicketMsg(uint64_t timestamp, uint32_t userID)
                : Msg(MSG_ID(TicketMsg)), m_timestamp(timestamp), m_userID(userID),
                    m_featurePairs(map<string,uint64_t>())
                {
                }

                /**
		 * Adds one feature to the map included in the ticket
		 * @param featureID String containing the unique identifier of the feature
                 * @param featreVal The value of the current feature
		 */
		void add_feature(string featureID, uint64_t featureVal);

		/**
		 * Set the features
		 * @param featurePairs The features map
		 */
		void set_features(const map<string,uint64_t> featurePairs);

		/**
		 * Get the timestamp associated to the ticket
		 * @return the timestamp
		 */
		uint64_t get_timestamp() const;
                
                /**
		 * Get the user ID of the ticket
		 * @return the user ID
		 */
		uint32_t get_userID() const;
                
                /**
		 * Get the feature pairs map
		 * @return the features map
		 */
		const map<string,uint64_t>* get_features() const;

                /**
		 * Get the number of feature pairs extracted from the packet
                 * and included in the features map
		 * @return the map size
		 */
		uint get_extracted_features() const;

                /**
		 * Clear the features map
		 */
		void clear_features();

                /**
		 * Set the ticket timestamp
		 * @param timestamp The ticket timestamp to set
		 */
		void set_timestamp(uint64_t timestamp);

                /**
		 * Set the userID
		 * @param userID The client IP address
		 */
		void set_userID(uint32_t userID);

		/**
		 * Convert the TicketMsg into a human-readable string
		 */
		string to_string() const;
                
                /**
		 * Convert the TicketMsg into a message string
		 */
                string to_string_file() const;
                
                /**
		 * Convert the TicketMsg into a qoe_fw message string
		 */
                string to_string_qoe_ticket_file() const;


        /** 
         * This message is not moveable 
         */
        TicketMsg(TicketMsg &&) = delete;
        
        /** 
         * This message is not moveable 
         */
        TicketMsg& operator = (TicketMsg &&) = delete;
        
        /** 
         * This message is not copiable 
         */
        TicketMsg(const TicketMsg& ) = delete;

        /** 
         * This message is not copiable 
         */
        TicketMsg& operator = (const TicketMsg& other) = delete;


        /**
          message destructor: does noting!
          */
        ~TicketMsg()
        {
        }

        /**
         * Clone this message; the new Ticket will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        std::shared_ptr<Msg> clone() const
        {
            std::shared_ptr<TicketMsg> copy = std::make_shared<TicketMsg>(m_timestamp, m_userID);
			copy.get()->set_features(m_featurePairs);
			return copy;
        }

	private:

		/**
		 * Convert an IP into a string
		 * @param ip The IP as an unsigned int
                 * @return the IP as a formatted string
		 */
		std::string ip_to_string(unsigned int ip) const;
    };


    
};



#endif //__TICKET_MSG_HPP_




