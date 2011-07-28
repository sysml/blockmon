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

#include "IpfixExportBlock.hpp"
#include "BlockFactory.hpp"
#include <boost/lexical_cast.hpp>
#include "FileWriter.h"
#include "UDPExporter.h"
#include "TuplePacket.hpp"
#include "TupleStatistic.hpp"

//#include <cstdio>

namespace bm {

struct RawTuple {
    uint32_t src_ip;
    uint32_t dst_ip;
    uint16_t src_port;
    uint16_t dst_port;
    uint8_t  protocol;
};

struct RawTupleStatistic {
    uint32_t bytes;
    uint32_t packets;
    RawTuple t;
};

static void prepareTuplePacket(const TuplePacket* t, uint8_t* buf) {
    RawTuple* rtbuf = reinterpret_cast<RawTuple *>(buf);
    rtbuf->src_ip = t->get_tuple().get_src_ip();
    rtbuf->dst_ip = t->get_tuple().get_dst_ip();
    rtbuf->src_port = t->get_tuple().get_src_port();
    rtbuf->dst_port = t->get_tuple().get_dst_port();
    rtbuf->protocol = t->get_tuple().get_protocol();
}

static void prepareTupleStatistic(const TupleStatistic* ts, uint8_t* buf) {
    RawTupleStatistic *rtsbuf = reinterpret_cast<RawTupleStatistic *>(buf);
    rtsbuf->bytes = ts->get_bytes();
    rtsbuf->packets = ts->get_packets();
    rtsbuf->t.src_ip = ts->get_tuple().get_src_ip();
    rtsbuf->t.dst_ip = ts->get_tuple().get_dst_ip();
    rtsbuf->t.src_port = ts->get_tuple().get_src_port();
    rtsbuf->t.dst_port = ts->get_tuple().get_dst_port();
    rtsbuf->t.protocol = ts->get_tuple().get_protocol();

    //fprintf(stderr, "PTS %08x/%05u -> %08x/%05u %03u %8u %8u\n",
    //              rtsbuf->m_src_ip, rtsbuf->m_src_port,
    //              rtsbuf->m_dst_ip, rtsbuf->m_dst_port,
    //              rtsbuf->m_protocol, rtsbuf->bytes, rtsbuf->packets);
}
    
IpfixExportBlock::IpfixExportBlock(const std::string &name, 
                                   bool active, 
                                   bool thread_safe):
                  Block(name,"ipfix_ep",active,thread_safe),
                  model_(NULL),
                  exporter_(NULL),
                  ingate_(register_input_gate("in_rec")) {
                    
  // Initialize IPFIX model (version 10), no 5103 support
  model_ = new IPFIX::InfoModel(10, false);
  
  // Add internal templates
  add_struct_templates();
}

IpfixExportBlock::~IpfixExportBlock() {

    for (std::map<int, const IPFIX::IETemplate*>::iterator
            iter = stmap_.begin();
            iter != stmap_.end();
            iter++) {
        delete iter->second;
     }

    if (exporter_) {
      exporter_->flush();
      delete exporter_;
    }
    
    if (model_) delete model_;
}

void IpfixExportBlock::add_struct_templates() {
  // Set up struct templates.
  IPFIX::IETemplate* t;
  
  // Add IEs programmatically, like this, once we have structs...
  t = new IPFIX::IETemplate();
  t->add(model_->lookupIE("octetDeltaCount[4]"), offsetof(RawTupleStatistic, bytes));
  t->add(model_->lookupIE("packetDeltaCount[4]"), offsetof(RawTupleStatistic, packets));
  t->add(model_->lookupIE("sourceIPv4Address"), offsetof(RawTupleStatistic, t.src_ip));
  t->add(model_->lookupIE("destinationIPv4Address"), offsetof(RawTupleStatistic, t.dst_ip));
  t->add(model_->lookupIE("sourceTransportPort"), offsetof(RawTupleStatistic, t.src_port));
  t->add(model_->lookupIE("destinationTransportPort"), offsetof(RawTupleStatistic, t.dst_port));
  t->add(model_->lookupIE("protocolIdentifier"), offsetof(RawTupleStatistic, t.protocol));
  t->activate();
  stmap_[TUPLE_STATISTIC_CODE] = t;

  t = new IPFIX::IETemplate();
  t->add(model_->lookupIE("sourceIPv4Address"), offsetof(RawTuple, src_ip));
  t->add(model_->lookupIE("destinationIPv4Address"), offsetof(RawTuple, dst_ip));
  t->add(model_->lookupIE("sourceTransportPort"), offsetof(RawTuple, src_port));
  t->add(model_->lookupIE("destinationTransportPort"), offsetof(RawTuple, dst_port));
  t->add(model_->lookupIE("protocolIdentifier"), offsetof(RawTuple, protocol));
  t->activate();
  stmap_[TUPLE_PACKET_CODE] = t;
}  

void IpfixExportBlock::add_export_templates() {
  IPFIX::IETemplate *t;
  
  t = exporter_->getTemplate(TUPLE_STATISTIC_TID);
  t->add(model_->lookupIE("octetDeltaCount[4]"));
  t->add(model_->lookupIE("packetDeltaCount[4]"));
  t->add(model_->lookupIE("sourceIPv4Address"));
  t->add(model_->lookupIE("destinationIPv4Address"));
  t->add(model_->lookupIE("sourceTransportPort"));
  t->add(model_->lookupIE("destinationTransportPort"));
  t->add(model_->lookupIE("protocolIdentifier"));
  t->activate();
  tidmap_[TUPLE_STATISTIC_CODE] = TUPLE_STATISTIC_TID;
  
  t = exporter_->getTemplate(TUPLE_TID);
  t->add(model_->lookupIE("sourceIPv4Address"));
  t->add(model_->lookupIE("destinationIPv4Address"));
  t->add(model_->lookupIE("sourceTransportPort"));
  t->add(model_->lookupIE("destinationTransportPort"));
  t->add(model_->lookupIE("protocolIdentifier"));
  t->activate();
  tidmap_[TUPLE_PACKET_CODE] = TUPLE_TID;

  exporter_->exportTemplatesForDomain();

}

void IpfixExportBlock::_configure(const xml_node& n) {
    uint32_t        odid = 1;
    xml_node        domspec, outspec;

    // Don't support reconfiguration yet
    if (exporter_) {
        throw new std::logic_error("IPFIX block not reconfigurable");
    }
    
    // Handle optional things first
    // Observation domain ID (defaults to 1).
    if ((domspec = n.child("domain"))) {
        std::string domid = domspec.attribute("id").value();
        
        if (domid.empty()) {
            throw std::runtime_error("Domain missing ID");
        }
        odid = boost::lexical_cast<uint32_t>(domid);
    }
    
    if ((outspec = n.child("export"))) {
        // Parse export (transport, host, port)
        std::string transport = outspec.attribute("transport").value();
        std::string host = outspec.attribute("host").value();
        std::string port = outspec.attribute("port").value();
        if (transport.empty() || host.empty()) {
            throw std::runtime_error("Export specification incomplete");
        }
        if (port.empty()) {
            port = std::string("4739");
        }
        
        // Create exporter based on transport
        if (transport == std::string("udp")) {
            std::cerr << "will export to udp " << host << ":" << port << std::endl;
            exporter_ = new IPFIX::UDPExporter(host, port, model_, odid);
        } else if (transport == std::string("tcp")) {
            throw std::runtime_error("TCP not yet supported");
            //exporter_ = new IPFIX::TCPExporter(host, port, model_, odid);
        } else if (transport == std::string("sctp")) {
            throw std::runtime_error("SCTP not yet supported");
            //exporter_ = new IPFIX::SCTPExporter(host, port, model_, odid);
        } else {
            throw std::runtime_error("Unsupported transport");
        }        
    } else if ((outspec = n.child("file"))) {
        // Parse file writer
        std::string filename = outspec.attribute("name").value();
        if (filename.empty()) {
            throw std::runtime_error("File specification missing name");
        }
        std::cerr << "will export to file " << filename << std::endl;
        exporter_ = new IPFIX::FileWriter(filename, model_, odid);
    } else {
        throw std::runtime_error("No export or file specification");
    }
    
    // Add templates to the exporter
    add_export_templates();
}

int IpfixExportBlock::_handle_timer(std::shared_ptr<bm::Timer>&&) {
  return -1;
}

int IpfixExportBlock::_receive_msg(std::shared_ptr<const Msg>&& m, int index) {

  if (!model_ || !exporter_) {
    throw std::logic_error("IPFIX export not configured");
  }

  uint8_t prebuf[sizeof(RawTupleStatistic)];

  switch (m->type()) {
    case TUPLE_PACKET_CODE: {
      const TuplePacket *tpm = dynamic_cast<const TuplePacket*>(m.get());  
      prepareTuplePacket(tpm, prebuf);
      break;
    } case TUPLE_STATISTIC_CODE: {
      const TupleStatistic *tsm = dynamic_cast<const TupleStatistic *>(m.get());  
      prepareTupleStatistic(tsm, prebuf);
      break;
    } default: {
      throw std::runtime_error("unexpected message type for IPFIX export");
    }
  }

  // prebuf is primed, set template and export record
  exporter_->setTemplate(tidmap_[m->type()]);
  exporter_->exportRecord(*(stmap_[m->type()]), prebuf);
  
  // what do I return here?
  return 0;
}

int IpfixExportBlock::do_async_processing() {
  // FIXME possibly flush here?
  return 0;
}

REGISTER_BLOCK(IpfixExportBlock,"ipfix_ep");


} // namespace bm
