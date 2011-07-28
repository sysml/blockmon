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
#include <time.h>
#include <iostream>

#include <cms.hpp>
#include <cusum/cusum_np.hpp>

#include <TuplePacket.hpp>
#include <CmsSignature.hpp>

#include <SynFloodingDetection.hpp>

namespace bm
{
    SynFloodingDetection::SynFloodingDetection(const std::string &name, bool /*active*/, bool /*thread_safe*/) 
    : Block(name, "syn_flooding_detection", false, true),
     m_ingate_id(register_input_gate("in_sketch")), m_outgate_alert_id(register_output_gate("out_alert")),
     m_cusum_size(0), m_checks_count(0),
     m_csm_threshold(50.), m_csm_offset(10.), m_csm_mean_window(20)
    {}

    SynFloodingDetection::~SynFloodingDetection()
    {
        for (int i = 0; i < m_cusum_size; i++) {
            delete m_cusum[i];
            m_cusum[i] = NULL;
        }
        delete[] m_cusum;
        m_cusum_size = 0;
    }

    void SynFloodingDetection::_configure(const xml_node& n)
    {
        // XML configuration
        xml_node cusum = n.child("cusum");
        if (cusum)
        {
            if (cusum.attribute("threshold"))
                m_csm_threshold = std::atof(std::string(cusum.attribute("threshold").value()).c_str());
            if (cusum.attribute("offset"))
                m_csm_offset = std::atof(std::string(cusum.attribute("offset").value()).c_str());
            if (cusum.attribute("mean_window"))
                m_csm_mean_window = std::atoi(std::string(cusum.attribute("mean_window").value()).c_str());
        }
    }

    int SynFloodingDetection::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        if(m->type() != CMS_SKETCH_CODE) throw std::runtime_error("syn_flooding_detection: unexpected msg type");
        m_checks_count++;
        std::shared_ptr<const cms::Sketch> sketch = std::static_pointer_cast<const cms::Sketch>(m);
        // Create the Multi CUSUM agents if not done (one per line)
        if (m_cusum_size <= 0) {
            m_cusum_size = sketch.get()->get_depth();
            m_cusum = new csm::MultiCusum*[m_cusum_size];
            std::shared_ptr<csm::Cusum> cusum_sample = std::shared_ptr<csm::Cusum>((csm::Cusum*) new csm::CusumNP(m_csm_threshold, m_csm_mean_window, m_csm_offset));
            for (int i = 0; i < m_cusum_size; i++)
                m_cusum[i] = new csm::MultiCusum(cusum_sample, sketch.get()->get_width());
        }
		// SYN flooding detected?
        bool syn_flooding = true;
		unsigned int detected_indexes[m_cusum_size];
        for (int i = 0; i < m_cusum_size; i++) {
			int index = m_cusum[i]->check(sketch.get()->get_data(i));
			syn_flooding&= index >= 0;
			detected_indexes[i] = index;
		}
        if (syn_flooding) {
			// Reset the CUSUM algorithms
            for (int i = 0; i < m_cusum_size; i++)
                m_cusum[i]->reset();
			// Signal the SYN flooding in the terminal
            std::cout << "\x1b[31;1m" << "SYN flooding detected" << "\x1b[m" << std::endl;
			// Send back an alert to the counters to determine the target IP
			send_out_through(std::shared_ptr<CmsSignature>(new CmsSignature(detected_indexes, m_cusum_size)), m_outgate_alert_id);
		} else {
			// Normal situation
			if (m_checks_count % 5 == 0)
				std::cout << "\x1b[32;1m" << "Watching..." << "\x1b[m" << std::endl;
		}
        return 0;
    }
}