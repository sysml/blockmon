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
#include <cstdarg>

#include "TemplateRegistry.h"
#include "IPFIXTypeBridge.hpp"

namespace blockmon {
    
    bool IPFIXTypeBridge::declareIEVec(
                std::vector<const IPFIX::InfoElement*>& v,
                const char* spec1,
                va_list args) {
        m_ievec.clear();
        const char* s = spec1;

        IPFIX::InfoModel& m = IPFIX::InfoModel::instance();

        while (s != 0) {
            const IPFIX::InfoElement* e = m.lookupIE(s);
            if (e == 0) {
                // FIXME refactor this, otherwise we throw in a constructor.
                m.add(s);
                if ((e = m.lookupIE(s)) == 0) {
                    return false;
                }
            } 
            m_ievec.push_back(e);
            s = va_arg(args, const char*);
        }
        return true;        
    }

    bool IPFIXTypeBridge::declareIEVec(
                std::vector<const IPFIX::InfoElement*>& v,
                const char* spec1, ...) {
        va_list args;
        va_start(args, spec1);
        bool rv = declareIEVec(v, spec1, args);
        va_end(args);
        return rv;
    }


    bool IPFIXTypeBridge::declareIEVec(const char* spec1, ...) {
        va_list args;
        va_start(args, spec1);
        bool rv = declareIEVec(m_ievec, spec1, args);
        va_end(args);
        return rv;
    }
    
    void IPFIXTypeBridge::defaultPrepareExporter(IPFIX::Exporter& e) {
        // define template
        m_tid = IPFIX::TemplateRegistry::instance().get_template_id(typeName());
        IPFIX::WireTemplate *wt = e.getTemplate(m_tid);

        for (auto i = m_ievec.begin(); i != m_ievec.end(); ++i) {
            wt->add(*i);
        }
        
        wt->activate();
    }
    
    void IPFIXTypeBridge::defaultPrepareCollector(IPFIX::Collector& c, 
                                                  OutGate& g) {
        setGate(g);
        
        m_mtmpl.clear();
        for (auto i=m_ievec.begin(); i!= m_ievec.end(); ++i) {
            m_mtmpl.add(*i);
        }
        
        c.registerReceiver(&m_mtmpl, this);
    }

    void IPFIXTypeBridge::defaultPrepareCollector(IPFIX::Collector& c, 
                                                  OutGate& g,
                                                  std::vector<int> match_indices) {
        setGate(g);
        
        m_mtmpl.clear();
        for (auto i=match_indices.begin(); i!= match_indices.end(); ++i) {
            m_mtmpl.add(m_ievec[*i]);
        }
        
        c.registerReceiver(&m_mtmpl, this);
    }


} // namespace blockmon
