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

/**
 * @file
 *
 * IPFIXObservationBridge handles IPFIX I/O for Observation messages.
 * 
 * @author Brian Trammell <trammell@tik.ee.ethz.ch>
 */

#ifndef IPFIXOBSERVATIONBRIDGE_H
#define IPFIXOBSERVATIONBRIDGE_H

#include "IPFIXTypeBridge.hpp"
#include "IPFIXTypeRegistry.hpp"
#include <MatchTemplate.h>
#include <InfoElement.h>

namespace blockmon {

    class IPFIXObservationBridge : public IPFIXTypeBridge {

    public:
        IPFIXObservationBridge();

        void prepareExporter(IPFIX::Exporter& e) {
            defaultPrepareExporter(e);
        }

        bool canExport (std::shared_ptr<const Msg>& m);
       
        void exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e);
       
        void prepareCollector(IPFIX::Collector& c, OutGate& g) {
            defaultPrepareCollector(c, g);
        }
        
        void receiveRecord();
    };
    
}

#endif
