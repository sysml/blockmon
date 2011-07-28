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

#include <Exporter.h>
#include <Block.hpp>

namespace bm
{

class IpfixExportBlock: public Block {
  
public:
  
  static const uint16_t TUPLE_STATISTIC_TID = 0x7757;
  static const uint16_t TUPLE_TID = 0x7758;
    
  IpfixExportBlock(const std::string &name, bool active, bool thread_safe);
                 
  virtual ~IpfixExportBlock();
  
  /* Idiomatically uncopyable */
  IpfixExportBlock(const IpfixExportBlock &) = delete;
  IpfixExportBlock& operator=(const IpfixExportBlock &) = delete;
  
  virtual void _configure(const xml_node& n);
  virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index); 
  virtual int _handle_timer(std::shared_ptr<bm::Timer>&&);
  virtual int do_async_processing();


private:

  void add_struct_templates();
  void add_export_templates();

  IPFIX::InfoModel*                   model_;
  IPFIX::Exporter*                    exporter_;
  std::map<int, const IPFIX::IETemplate*>    stmap_;
  std::map<int, uint16_t>             tidmap_;
  int                                 ingate_;
};

}
