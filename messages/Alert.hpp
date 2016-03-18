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

#ifndef _MESSAGES_ALERT_HPP_
#define _MESSAGES_ALERT_HPP_
/**
 * @file
 *
 * This message represents an alert to be sent for further analysis or mitigation.
 */

#include "Msg.hpp"
#include "ClassId.hpp"
#include <stdint.h>
#include <string>
#include <vector>
#include <time.h>

namespace blockmon
{

    /**
     * BlockMon Message representing an Alert. Alert contains information
	 * about a potential attack or event.
     */

    class Alert : public Msg
    {

	public:

		/**
		 * Represents a node on the network
		 */
		class Node {
			/**
			 * Ipv4
			 */
			bool m_ipv4_set;
			uint32_t m_ipv4;
			/**
			 * Domain name
			 */
			bool m_domain_name_set;
			std::string m_domain_name;

		public:
			/**
			 * Constructor: both IPv4 and domain name
			 */
			Node(uint32_t ipv4, std::string domain_name)
			: m_ipv4_set(true), m_ipv4(ipv4), m_domain_name_set(true), m_domain_name(domain_name)
			{}

			/**
			 * Constructor: IPv4 only
			 */
			Node(uint32_t ipv4)
			: m_ipv4_set(true), m_ipv4(ipv4), m_domain_name_set(false), m_domain_name("")
			{}

			/**
			 * Constructor: domain name only
			 */
			Node(std::string domain_name)
			: m_ipv4_set(false), m_ipv4(0), m_domain_name_set(true), m_domain_name(domain_name)
			{}

			/**
			 * Constructor: copy
			 */
			Node(const Node& original)
			: m_ipv4_set(original.ipv4_set()), m_ipv4(original.get_ipv4()), m_domain_name_set(original.domain_name_set()), m_domain_name(original.get_domain_name())
			{}

			/**
			 * @return if there is an IPv4 set
			 */
			bool ipv4_set() const;

			/**
			 * @return if there is a domain name set
			 */
			bool domain_name_set() const;

			/**
			 * @return the IPv4 of the node
			 */
			uint32_t get_ipv4() const;

			/**
			 * @return the domain name of the node
			 */
			std::string get_domain_name() const;
		};

		/**
		 * Types for assessment of the alert
		 */
		typedef enum {
			sev_info,
			sev_low,
			sev_medium,
			sev_high
		} severity_level_t;

		typedef enum {
			conf_low,
			conf_medium,
			conf_high
		} confidence_level_t;

		typedef struct {
			severity_level_t severity;
			confidence_level_t confidence;
		} assesment_t;

	protected:
		/**
		 * Identifier of the analyzer
		 */
		std::string m_analyzer;

		/**
		 * Identifier of the alarm (unique for an analyzer)
		 */
		int m_identifier;

		/**
		 * Name of the alert type (SYN flooding for example)
		 */
		std::string m_alert_name;

		/**
		 * Time of creation of the laert
		 */
		time_t m_create_time;

		/**
		 * Source node(s) of the event
		 */
		std::vector<Node> m_sources;

		/**
		 * Target node(s) of the event
		 */
		std::vector<Node> m_targets;

		/**
		 * Assessment of the impact of the event
		 */
		assesment_t m_assessment;
		bool m_assessment_set;

		/**
		 * Assessment of the confidence of the analyzer
		 */
		float m_confidence;

    public:

        /**
         *  Create a new Alert
         */
        Alert(std::string analyzer, int identifier, std::string alert_name)
        : Msg(MSG_ID(Alert)), m_analyzer(analyzer), m_identifier(identifier), m_alert_name(alert_name),
		  m_create_time(time(NULL)), m_sources(std::vector<Node>()), m_targets(std::vector<Node>()),
		  m_assessment(), m_assessment_set(false)
        {
        }

		/**
		 * Add one source
		 * @param source The source node to append to the list
		 */
		void add_source(const Node &source);

		/**
		 * Add one target
		 * @param target The target node to append to the list
		 */
		void add_target(const Node &target);

		/**
		 * Set the sources list
		 * @param sources The source nodes list
		 */
		void set_sources(const std::vector<Node> &sources);

		/**
		 * Set the targets list
		 * @param targets The target nodes list
		 */
		void set_targets(const std::vector<Node> &targets);

		/**
		 * Clear the sources list
		 */
		void clear_sources();

		/**
		 * Clear the targets list
		 */
		void clear_targets();

		/**
		 * Get the sources list
		 * @return the source nodes vector
		 */
		const std::vector<Node>* get_sources() const;

		/**
		 * Get the targets list
		 * @return the target nodes vector
		 */
		const std::vector<Node>* get_targets() const;

		/**
		 * Assess the impact and confidence on this alert
		 * @param impseverity The impact severity to set
		 * @param confidence The confidence to set
		 */
		void set_assessment(severity_level_t severity, confidence_level_t confidence);

		/**
		 * Set the analyzer for this alert.
		 * @param analyzer The name of the analyzer
		 */
		void set_analyzer(const std::string &analyzer);

		/**
		 * Set the identifier for this alert.
		 * @param identifier The identifier
		 */
		void set_identifier(int identifier);

		/**
		 * Set the name for this alert.
		 * @param alert_name The name of the alert
		 */
		void set_alert_name(std::string alert_name);

		/**
		 * Gets the indentifier for this alert.
		 */
		int get_identifier() const;

		/**
		 * Gets the analyzer for this alert.
		 */
		std::string get_analyzer() const;

		/**
		 * Is the assesment set?
		 */
		bool is_assessment_set() const;

		/**
		 * Gets the impact for this alert.
		 */
		severity_level_t get_severity() const;

		/**
		 * Gets the impact for this alert.
		 */
		confidence_level_t get_confidence() const;

		/**
		 * Gets the alert name for this alert.
		 */
		std::string get_alert_name() const;

		/**
		 * Gets the create time for this alert.
		 */
		time_t get_create_time() const;

		/**
		 * Convert the alert into a human-readable string
		 */
		std::string to_string() const;

        /** Forbids copy and move constructors.
	 */
        Alert(const Alert &) = delete;

        /** Forbids copy and move assignment.
	 */
        Alert& operator=(const Alert &) = delete;

        /**
        * Destroy this Alert.
        */
        ~Alert()
        {
        }

        /**
         * Clone this message; the new Packet will have the same content, own
         * its buffer, and will lose its parsed field cache.
         */
        std::shared_ptr<Msg> clone() const
        {
            std::shared_ptr<Alert> copy = std::make_shared<Alert>(m_analyzer, m_identifier, m_alert_name);
			if (m_assessment_set)
				copy.get()->set_assessment(m_assessment.severity, m_assessment.confidence);
			copy.get()->set_sources(m_sources);
			copy.get()->set_targets(m_targets);
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
}

#endif // _MESSAGES_ALERT_HPP_
