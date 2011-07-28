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

#include <SynSynchronizer.hpp>

namespace bm
{
    SynSynchronizer::SynSynchronizer(const std::string &name, bool /*active*/, bool /*thread_safe*/) 
    : Block(name, "syn_synchronizer", true, false), 
     m_outgate_id(register_output_gate("out_sketch_proto")),
     m_sketch_sent(false), m_cms_width(4096), m_cms_depth(8)
    {}

    SynSynchronizer::~SynSynchronizer()
    {}

    void SynSynchronizer::_configure(const xml_node& n)
    {
        // XML configuration
        xml_node sketch = n.child("sketch");
        if (sketch)
        {
            int width = std::atoi(std::string(sketch.attribute("width").value()).c_str());
            if (width > 0)
                m_cms_width = width;
            int depth = std::atoi(std::string(sketch.attribute("depth").value()).c_str());
            if (depth > 0)
                m_cms_depth = depth;
        }
    }

    int SynSynchronizer::do_async_processing()
    {
        // Create and send the sketch and exit
        if (!m_sketch_sent) {
            send_out_through(std::make_shared<const cms::Sketch>(m_cms_width, m_cms_depth, CMS_ID_DST_IP, (int) time(NULL)), m_outgate_id);
            m_sketch_sent = true;
        }
        return 0;
    }
}