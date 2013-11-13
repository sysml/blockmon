/* Copyright (c) 2011-2012 ETH Zürich. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of ETH Zürich nor the names of other contributors 
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
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY 
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "IPFIXObservationBridge.hpp"
#include "Observation.hpp"

namespace blockmon {

IPFIXObservationBridge::IPFIXObservationBridge():
    IPFIXTypeBridge("observation")
    {
  assert(declareIEVec("observationTimeMilliseconds",
                      "observationValue(35566/804)<unsigned64>[8]",
                      "observationLabel(35566/805)<string>[v]",
                      (const char*)0));
}


bool IPFIXObservationBridge::canExport (std::shared_ptr<const Msg>& m) {

    // for now we only can handle bog-standard Observations.
    return (m->type() == MSG_ID(Observation));
}

void IPFIXObservationBridge::exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e) {
    
    std::shared_ptr<const Observation> f = std::dynamic_pointer_cast<const Observation>(m);

    std::cerr << "exporter got observation" << std::endl;

    e.setTemplate(m_tid);
    e.beginRecord();
    e.reserveVarlen(m_ievec[2], f->label().length());
    e.commitVarlen();
    e.putValue(m_ievec[0], f->otime());
    e.putValue(m_ievec[1], f->value());
    e.putValue(m_ievec[2], f->label());
    e.exportRecord();
}

void IPFIXObservationBridge::receiveRecord() {
    
    ustime_t time;
    uint64_t value;
    std::string label;
    
    assert(getValue(m_ievec[0], time));
    assert(getValue(m_ievec[1], value));
    assert(getValue(m_ievec[2], label));

    std::cerr << "collector got record" << std::endl;
    
    sendMsg(std::move(std::make_shared<Observation>(time, label, value)));
    
}

}
