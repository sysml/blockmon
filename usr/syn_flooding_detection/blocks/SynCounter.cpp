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

#include <stdlib.h>
#include <iostream>

#include <TuplePacket.hpp>
#include <CmsSignature.hpp>

#include <SynCounter.hpp>

namespace bm
{
    SynCounter::SynCounter(const std::string &name, bool /*active*/, bool /*thread_safe*/) 
    : Block(name, "syn_counter", false, false), 
     m_ingate_proto_id(register_input_gate("in_sketch_proto")), m_ingate_alert_id(register_input_gate("in_alert")),
	 m_ingate_id(register_input_gate("in_pkt")),
     m_outgate_id(register_output_gate("out_sketch")),
     m_sketch(), m_sketch_ready(false), m_last_ip_index(-1), m_last_ip_count(0),
     m_period(500000)
    {}

    SynCounter::~SynCounter()
    {}

    void SynCounter::_configure(const xml_node& n)
    {
        // XML configuration
        xml_node export_node = n.child("export");
        if (export_node)
        {
		    if (export_node.attribute("period"))
		        m_period = std::atoi(std::string(export_node.attribute("period").value()).c_str());
        }
        // Start the timer
        set_periodic_timer(std::chrono::microseconds(m_period), "sketch_sending", 0);
    }

    int SynCounter::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        if (m->type() == TUPLE_PACKET_CODE) {
            // Received a packet, treated if the sketch is ready
            if (!m_sketch_ready)
                return 0;
            const TuplePacket* packet = static_cast<const TuplePacket*>(m.get());
            const Tuple tuple = packet->get_tuple();
            // Extract the SYN flag
            std::pair<const char*, int> buffer = packet->get_trans_buffer();
            const char* data = buffer.first;
            int data_size = buffer.second;
            if (data_size <= SYF_TCP_FLAGS_LOCATION)
                return -1;
            bool is_syn = data[SYF_TCP_FLAGS_LOCATION] & SYF_TCP_FLAGS_SYN;
            bool is_ack = data[SYF_TCP_FLAGS_LOCATION] & SYF_TCP_FLAGS_ACK;
            if (!is_syn || is_ack)
                return 0;
            // Update the sketch
            m_sketch.get()->update(&tuple, 1);
		    // Update the last IP
		    m_last_ip_index = (m_last_ip_index + 1) % SYF_LAST_IPS_MAX;
		    m_last_ips[m_last_ip_index] = tuple.get_dst_ip();
		    if (m_last_ip_count < SYF_LAST_IPS_MAX)
			    m_last_ip_count++;
        } else if (m->type() == CMS_SKETCH_CODE) {
			// Receive a CMS that determines the hashes and size of the sketch
            m_sketch = std::static_pointer_cast<cms::Sketch>(m.get()->clone());
            m_sketch_ready = true;
        } else if (m->type() == CMS_SIGNATURE_CODE) {
			// Receive an alert: SYN flooding detected, with the detected indexes
			std::shared_ptr<const CmsSignature> signature = std::static_pointer_cast<const CmsSignature>(m);
			// Search the detected IP
			unsigned int detected_ip = 0;
			for (int i = 0; i < m_last_ip_count; i++) {
				unsigned int checked_ip = m_last_ips[(m_last_ip_index - i) % SYF_LAST_IPS_MAX];
				Tuple tuple(0, checked_ip, 0, 0, 0);
				unsigned int checked_indexes[signature.get()->get_size()];
				m_sketch->get_indexes(&tuple, checked_indexes);
				bool found = true;
				for (int j = 0; j < signature.get()->get_size(); j++) {
					if (signature.get()->get_indexes()[j] != checked_indexes[j]) {
						found = false;
						break;
					}
				}
				if (found) {
					detected_ip = checked_ip;
					break;
				}
			}
			// Display the detected IP if any
			if (detected_ip > 0) {
				std::cout << "\x1b[31;1m" << "Target IP identified by " << this->get_name() << ": ";
				unsigned char* tmp_char = (unsigned char*) &detected_ip;
				unsigned int tmp_val = tmp_char[3];
				std::cout << tmp_val;
				tmp_val = tmp_char[2];
				std::cout << "." << tmp_val;
				tmp_val = tmp_char[1];
				std::cout << "." << tmp_val;
				tmp_val = tmp_char[0];
				std::cout << "." << tmp_val;
				std::cout << "\x1b[m" << std::endl;
			}
		}
        else throw std::runtime_error("syn_counter: unexpected msg type");
        return 0;
    }

    int SynCounter::_handle_timer(std::shared_ptr<Timer>&&)
    {
        // Send a copy of the sketch
        send_out_through(m_sketch.get()->clone(), m_outgate_id);
		// Reset the sketch
        m_sketch.get()->reset();
        return 0;
    }
}