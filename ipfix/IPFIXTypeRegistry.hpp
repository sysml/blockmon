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

/* Hi Emacs, please use -*- mode: C++ -*- */
/**
 * @file
 * @author Brian Trammell <trammell@tik.ee.ethz.ch>
 * @author Stephan Neuhaus <neuhaust@tik.ee.ethz.ch>
 */
 
#ifndef IPFIXTYPEREGISTRY_H
#define IPFIXTYPEREGISTRY_H

#include <map>
#include <string>
#include <memory>

#include "IPFIXTypeBridge.hpp"

namespace blockmon {

  /** Register IPFIXTypeBridge instances by name; allows export and 
   * source blocks to get instances of IPFIXTypeBridge by name at runtime.
   * Follows the pattern of the IPFIX template registry. */

    class IPFIXTypeRegistry {
    public:

        static IPFIXTypeRegistry& instance();

        void registerType(std::shared_ptr<IPFIXTypeBridge> bridge);
    
        std::shared_ptr<IPFIXTypeBridge> bridgeForTypeName(std::string& name);

    private:
        /** Private constructor. */
        IPFIXTypeRegistry();

        IPFIXTypeRegistry(const IPFIXTypeRegistry&) = delete;
        IPFIXTypeRegistry& operator=(const IPFIXTypeRegistry&) = delete;

        /** The registry instance. */
        static IPFIXTypeRegistry registry_instance;

        /** Maps strings to template IDs. */
        std::map<std::string, std::shared_ptr<IPFIXTypeBridge>> registry;
    };
    
} // namespace blockmon

#endif // IPFIXTYPEREGISTRY_H