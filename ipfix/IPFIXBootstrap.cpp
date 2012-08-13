#include "IPFIXBootstrap.hpp"
#include "IPFIXTypeRegistry.hpp"
#include "IPFIXFlowBridge.hpp"
#include "SCDemoFlowBridge.hpp"

#include <InfoModel.h>
#include <memory>

namespace blockmon {

    void bootstrapIPFIX() {
        static bool bootstrapped = false;
        
        if (bootstrapped) return;
        
        // set up information model
        IPFIX::InfoModel::instance().defaultIPFIX();
        
        // set up bridges
        IPFIXTypeRegistry::instance().registerType(std::make_shared<IPFIXFlowBridge>());
        IPFIXTypeRegistry::instance().registerType(std::make_shared<SCDemoFlowBridge>());
    }

}