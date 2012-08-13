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

#include <boost/lexical_cast.hpp>
#include "SCDemoFlowBridge.hpp"
#include <TemplateRegistry.h>
#include <Flow.hpp>

namespace blockmon {

static std::string make_flow_label(const Flow& flow) {
    return ipv4_to_string(flow.key().src_ip4) + std::string("/") +
           boost::lexical_cast<std::string>(flow.key().src_port) + 
           std::string("->") +
           ipv4_to_string(flow.key().dst_ip4) + std::string("/") +
           boost::lexical_cast<std::string>(flow.key().dst_port);
}


SCDemoFlowBridge::SCDemoFlowBridge():
    IPFIXTypeBridge("labeled_ipv4flow"),
    m_binsize(5000000)
    {
        
        assert(declareIEVec("observationTimeMilliseconds",
                            "octetDeltaCount",
                            "packetDeltaCount",
                            "observationLabel(35566/805)<string>[v]",
                            (const char*)0));
    }


bool SCDemoFlowBridge::canExport (std::shared_ptr<const Msg>& m) {

    // for now we only can handle bog-standard Flows.
    return (m->type() == MSG_ID(Flow));
}

void SCDemoFlowBridge::exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e) {
    
    std::shared_ptr<const Flow> f = std::dynamic_pointer_cast<const Flow>(m);

    std::cerr << "exporter got record (" << f->packets() << " packets)" << std::endl;

    std::string label = make_flow_label(*f);

    e.setTemplate(m_tid);
    e.beginRecord();
    e.reserveVarlen(m_ievec[3], label.length());
    e.commitVarlen();
    //printf("start_time=%llu\n", f->start_time());
    e.putValue(m_ievec[0], f->start_time() / 1000);
    //e.putValue(m_ievec[0], ((f->start_time() / m_binsize) * m_binsize) / 1000);
    e.putValue(m_ievec[1], f->bytes());
    e.putValue(m_ievec[2], f->packets());
    e.putValue(m_ievec[3], label);
    e.exportRecord();
}

}
