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

#include "IPFIXTypeRegistry.hpp"
#include <Block.hpp>

namespace blockmon {

IPFIXTypeRegistry IPFIXTypeRegistry::registry_instance;

IPFIXTypeRegistry& IPFIXTypeRegistry::instance() {
    return registry_instance;
}

void IPFIXTypeRegistry::registerType(std::shared_ptr<IPFIXTypeBridge> bridge) {
    std::cerr << "registered type " << bridge->typeName() << std::endl;
    registry[bridge->typeName()] = bridge;
}

std::shared_ptr<IPFIXTypeBridge> IPFIXTypeRegistry::bridgeForTypeName(std::string& name) {
    auto i = registry.find(name);
    if (i == registry.end()) {
      // NULL doesn't work on g++ 4.5.3, have to do explicit cast
      return std::shared_ptr<IPFIXTypeBridge>((IPFIXTypeBridge*)0);
    }
    
    return i->second;
}

IPFIXTypeRegistry::IPFIXTypeRegistry() {}

} // namespace blockmon
