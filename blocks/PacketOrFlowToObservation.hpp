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

#ifndef _BLOCKS_PACKETORFLOWTOOBSERVATION_HPP_
#  define _BLOCKS_PACKETORFLOWTOOBSERVATION_HPP_

#  include <Block.hpp>
#  include <BlockFactory.hpp>

namespace blockmon {

  /** Implements a block that turns Packets or Flows into Observations.
   */
  class PacketOrFlowToObservation : public Block {
  private:
    /** The input gate. Only Packets or Flows are allowed. */
    int in_gate;

    /** The output gate. Only Observations will be sent through here. */
    int out_gate;

    static std::string proto_label(const Packet* p); 
  public:
    PacketOrFlowToObservation(const std::string &name,
                              invocation_type invocation);
    void _receive_msg(std::shared_ptr<const Msg>&& m,
                              int /* index */) ;
    void send_record(std::shared_ptr<const Msg>&& msg);
  };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
  REGISTER_BLOCK(PacketOrFlowToObservation, "PacketOrFlowToObservation");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

} /* namespace blockmon */

#endif // _BLOCKS_PACKETORFLOWTOOBSERVATION_HPP
