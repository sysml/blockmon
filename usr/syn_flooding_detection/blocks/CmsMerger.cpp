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

#include <CmsMerger.hpp>
#include <iostream>

namespace bm
{
    CmsMerger::CmsMerger(const std::string &name, bool /*active*/, bool /*thread_safe*/) 
    : Block(name, "syn_counter", false, true), 
     m_ingate_id(register_input_gate("in_sketch")),
     m_outgate_id(register_output_gate("out_sketch")),
     m_sketch(), m_sketch_ready(false), m_sketch_count(0),
     m_merge_number(2)
    {}

    CmsMerger::~CmsMerger()
    {}

    void CmsMerger::_configure(const xml_node& n)
    {
        // XML configuration
        xml_node merge_node = n.child("merge");
        if (merge_node)
        {
		    if (merge_node.attribute("number"))
		        m_merge_number = std::atoi(std::string(merge_node.attribute("number").value()).c_str());
        }
    }

    int CmsMerger::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        if (m->type() == CMS_SKETCH_CODE) {
            if (!m_sketch_ready) {
                // Initialize the sketch with the size and hash functions of the first sketch received
                m_sketch = std::static_pointer_cast<cms::Sketch>(m.get()->clone());
                m_sketch_ready = true;
            } else {
                // Merge the received sketch with the current one
                m_sketch.get()->merge(static_cast<const cms::Sketch*>(m.get()));
            }
            // If enough sketches received, send the merged sketch and reset
            m_sketch_count++;
            if (m_sketch_count >= m_merge_number) {
                send_out_through(m_sketch.get()->clone(), m_outgate_id);
                m_sketch.get()->reset();
                m_sketch_count = 0;
            }
        }
        else throw std::runtime_error("cms_merger: unexpected msg type");
        return 0;
    }
}