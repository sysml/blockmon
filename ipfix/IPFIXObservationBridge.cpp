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
