/* Copyright (c) 2011, NEC Europe Ltd.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd. nor the names of its contributors
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

/*
 * <blockinfo type="Null" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *   Discards every message it receives.
 *   </humandesc>
 *
 *   <shortdesc>Discards every message it receives.</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_msg" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <Packet.hpp>
#include <NewPacket.hpp>

namespace blockmon
{

    class TouchPacket: public Block
    {
        
        
    public:

        /*
         * constructor
         */
        TouchPacket(const std::string &name, invocation_type invocation)
        : Block(name, invocation),
          m_ingate_id(register_input_gate("in_pkt"))
        {
        }

      void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
      {
	int i;
#if defined(USE_SIMPLE_PACKET)	
#elif defined(USE_SLICED_PACKET)
#else     
        const Packet* packet_ptr = static_cast<const Packet*>(m.get());	

	size_t len = packet_ptr->length();
	int payload_len = (int)len - 42;
	const uint8_t *payload = packet_ptr->payload();
	// const uint8_t *manual_payload = packet_ptr->base() + 42;

	for (i = 0; i < payload_len; i++)
	{
	  //	  if (i < 2)
	  //  printf("payload[%d]=%x\n", i, *payload);
	  ctr = *payload;
	  payload++;	  
	}
#endif

      }

    private:
        uint8_t ctr;
        int pd_count;
        int m_ingate_id;
 
    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(TouchPacket,"TouchPacket");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}

