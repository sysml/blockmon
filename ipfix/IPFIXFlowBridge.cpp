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

#include "IPFIXFlowBridge.hpp"
#include "Flow.hpp"
#include <cassert>

namespace blockmon {

IPFIXFlowBridge::IPFIXFlowBridge():
    IPFIXTypeBridge("ipv4flow"),
    m_flow_mtmpl() {

    // prepare information elements
    assert(declareIEVec("flowStartMilliseconds",
                         "flowEndMilliseconds",
                         "octetDeltaCount",
                         "packetDeltaCount",
                         "sourceIPv4Address",
                         "destinationIPv4Address",
                         "sourceTransportPort",
                         "destinationTransportPort",
                         "protocolIdentifier",
                         (const char*)0));
}


bool IPFIXFlowBridge::canExport (std::shared_ptr<const Msg>& m) {

    // for now we only can handle bog-standard Flows.
    return (m->type() == MSG_ID(Flow));
}

void IPFIXFlowBridge::exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e) {
    
    std::shared_ptr<const Flow> f = std::dynamic_pointer_cast<const Flow>(m);

    std::cerr << "exporter got record (" << f->packets() << " packets)" << std::endl;

    e.setTemplate(m_tid);
    e.beginRecord();
    e.putValue(m_ievec[0], f->start_time() / 1000);
    e.putValue(m_ievec[1], f->end_time() / 1000);
    e.putValue(m_ievec[2], f->bytes());
    e.putValue(m_ievec[3], f->packets());
    e.putValue(m_ievec[4], f->key().src_ip4);
    e.putValue(m_ievec[5], f->key().dst_ip4);
    e.putValue(m_ievec[6], f->key().src_port);
    e.putValue(m_ievec[7], f->key().dst_port);
    e.putValue(m_ievec[8], f->key().proto);
    e.exportRecord();
}

void IPFIXFlowBridge::prepareCollector (IPFIX::Collector& c, OutGate& g) {
    std::vector<int> indices = { 0, 2, 3, 4, 5 };
    defaultPrepareCollector(c, g, indices);
}

void IPFIXFlowBridge::receiveRecord() {
    
    FlowKey key;
    ustime_t start_time;
    ustime_t end_time;
    uint64_t bytes;
    uint64_t packets;
    
    assert(getValue(m_ievec[0], start_time)); // stime
    if (!getValue(m_ievec[1], end_time)) end_time = start_time; // etime
    assert(getValue(m_ievec[2], bytes)); // bytes
    assert(getValue(m_ievec[3], packets)); // packets
    assert(getValue(m_ievec[4], key.src_ip4)); // src_ip
    assert(getValue(m_ievec[5], key.dst_ip4)); // dst_ip
    if (!getValue(m_ievec[6], key.src_port)) key.src_port = 0; // src_port
    if (!getValue(m_ievec[7], key.dst_port)) key.dst_port = 0; // dst_port
    if (!getValue(m_ievec[8], key.proto)) key.proto = 0; // proto

    std::cerr << "collector got record (" << packets << " packets)" << std::endl;
    
    sendMsg(std::move(std::make_shared<Flow>(key, start_time * 1000, end_time * 1000, bytes, packets)));
    
}

}
