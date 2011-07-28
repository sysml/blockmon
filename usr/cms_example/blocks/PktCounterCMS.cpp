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

#include <PktCounterCMS.hpp>

namespace bm
{
    PktCounterCMS::PktCounterCMS(const std::string &name, bool active, bool thread_safe) 
    : Block(name, "cms_counter", active, thread_safe), m_ingate_id(register_input_gate("in_pkt")), m_sketch()
    {}

    PktCounterCMS::~PktCounterCMS()
    {
        delete m_sketch;
        m_sketch = NULL;
    }

    void PktCounterCMS::_configure(const xml_node& n)
    {
        int cms_width = 4096;
        int cms_depth = 8;
        unsigned int cms_flags = CMS_ID_SRC_IP | CMS_ID_DST_IP | CMS_ID_SRC_PORT | CMS_ID_DST_PORT | CMS_ID_PROTOCOL;
        xml_node sketch = n.child("sketch");
        if (sketch)
        {
            int width = std::atoi(std::string(sketch.attribute("width").value()).c_str());
            if (width > 0)
                cms_width = width;
            int depth = std::atoi(std::string(sketch.attribute("depth").value()).c_str());
            if (depth > 0)
                cms_depth = depth;
        }
        xml_node flow = n.child("flow");
        if (flow)
        {
            cms_flags = 0;
            if (std::string(flow.attribute("src_ip").value()).compare("on") == 0)
                cms_flags|= CMS_ID_SRC_IP;
            if (std::string(flow.attribute("dst_ip").value()).compare("on") == 0)
                cms_flags|= CMS_ID_DST_IP;
            if (std::string(flow.attribute("src_port").value()).compare("on") == 0)
                cms_flags|= CMS_ID_SRC_PORT;
            if (std::string(flow.attribute("dst_port").value()).compare("on") == 0)
                cms_flags|= CMS_ID_DST_PORT;
            if (std::string(flow.attribute("protocol").value()).compare("on") == 0)
                cms_flags|= CMS_ID_PROTOCOL;
        }
        m_sketch = new cms::Sketch(cms_width, cms_depth, cms_flags, (int) time(NULL));
    }

    int PktCounterCMS::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
        if(m->type() != TUPLE_PACKET_CODE) throw std::runtime_error("counter_cms: unexpected msg type");
        const TuplePacket* packet = static_cast<const TuplePacket*>(m.get());
        const Tuple tuple = packet->get_tuple();
        m_sketch->update(&tuple, 1);
        std::cout << tuple.to_string() << "\t" << m_sketch->estimate(&tuple) << std::endl;
        return 0;
    }
}
