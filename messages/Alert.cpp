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

#include "Alert.hpp"
#include <iostream>
#include <sstream>

namespace blockmon {

    void Alert::add_source(const Alert::Node &source) {
        m_sources.push_back(source);
    }

    void Alert::add_target(const Alert::Node &target) {
        m_targets.push_back(target);
    }

    void Alert::set_sources(const std::vector<Alert::Node> &sources) {
        clear_sources();
        for (unsigned int i = 0; i < sources.size(); i++)
            add_source(sources[i]);
    }

    void Alert::set_targets(const std::vector<Alert::Node> &targets) {
        clear_targets();
        for (unsigned int i = 0; i < targets.size(); i++)
            add_target(targets[i]);
    }

    void Alert::clear_sources() {
        m_sources.clear();
    }

    void Alert::clear_targets() {
        m_targets.clear();
    }

    const std::vector<Alert::Node>* Alert::get_sources() const {
        return &m_sources;
    }

    const std::vector<Alert::Node>* Alert::get_targets() const {
        return &m_targets;
    }

    void Alert::set_assessment(severity_level_t severity, confidence_level_t confidence) {
        m_assessment_set = true;
        m_assessment.severity = severity;
        m_assessment.confidence = confidence;
    }

    void Alert::set_analyzer(const std::string& analyzer) {
        m_analyzer = analyzer;
    }

    void Alert::set_identifier(int identifier) {
        m_identifier = identifier;
    }

    void Alert::set_alert_name(std::string alert_name) {
        m_alert_name = alert_name;
    }

    int Alert::get_identifier() const {
        return(m_identifier);
    }

    std::string Alert::get_analyzer() const {
        return m_analyzer;
    }

    std::string Alert::get_alert_name() const {
        return m_alert_name;
    }

    bool Alert::is_assessment_set() const {
        return m_assessment_set;
    }

    Alert::severity_level_t Alert::get_severity() const {
        return m_assessment.severity;
    }


    Alert::confidence_level_t Alert::get_confidence() const {
        return m_assessment.confidence;
    }


    time_t Alert::get_create_time() const {
        return m_create_time;
    }

    std::string Alert::Node::get_domain_name() const {
        return m_domain_name;
    }

    std::string Alert::to_string() const
    {
        std::stringstream ss;
        ss << "Alert " << m_alert_name << " from " << m_analyzer;
        ss << " (" << m_identifier << "): ";
        for (unsigned int i = 0; i < m_sources.size(); i++) {
            if (i > 0)
                ss << ", ";
            ss << ip_to_string(m_sources[i].get_ipv4());
        }
        ss << " -> ";
        for (unsigned int i = 0; i < m_targets.size(); i++) {
            if (i > 0)
                ss << ", ";
            ss << ip_to_string(m_targets[i].get_ipv4());
        }
        return ss.str();
    }

    std::string Alert::ip_to_string(unsigned int ip) const
    {
        std::stringstream ss;
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

    bool Alert::Node::ipv4_set() const {
        return m_ipv4_set;
    }

    bool Alert::Node::domain_name_set() const {
        return m_domain_name_set;
    }

    uint32_t Alert::Node::get_ipv4() const {
        return m_ipv4;
    }
}
