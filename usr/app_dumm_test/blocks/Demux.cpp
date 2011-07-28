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

/**
 * @file
 * Demultiplexes incoming messages between two output gates; in particular it
 * sends out tcp packets through the out_tcp gate and non-tcp packets through
 * the out_other output gate. All gates handle RawPacket messages (see
 * base/messages/RawPacket.hpp). The block takes no parameters.
 *
 *
 * @blockname{Demux}
 * @gates{in_pkt(msg:RawPacket), out_tcp(msg:RawPacket)
 * out_other(msg:RawPacket)}
 *
 */

/*
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

#include<Block.hpp>
#include<RawPacket.hpp>
#include<BlockFactory.hpp>


namespace bm
{

    class Demux: public Block
    {
        int m_ingate_id;
        int m_out_tcp;
        int m_out_other;

    public:

        Demux(const std::string &name, bool active, bool thread_safe)
        : Block(name,"demux",active,thread_safe), 
          m_ingate_id(register_input_gate("in_pkt")), 
          m_out_tcp(register_output_gate("out_tcp")), 
          m_out_other(register_output_gate("out_other"))
        {}


        virtual void _configure(const xml_node& /* n */)
        {
        }

        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type()!=RAW_PACKET_CODE) throw std::runtime_error("counter: unexpected msg type");
            const RawPacket* tp=static_cast<const RawPacket*>(m.get());
            auto buff =tp->get_buffer();

            unsigned int offset=23;//hansle vlan tagging
            unsigned short l2proto=*(const unsigned int*)(buff.addr()+12);
            if(l2proto==0x8100)
                offset+=4;
            if(buff.len() <= offset)//sure is not tcp
            {
                send_out_through(std::move(m),m_out_other);
                return 0;
            }

            char proto=*(buff.addr()+offset);
            if(proto==0x6)
                send_out_through(std::move(m),m_out_tcp);
            else
                send_out_through(std::move(m),m_out_other);
            return 0;
        }

        virtual int do_async_processing()
        {
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
        }

    };


    REGISTER_BLOCK(Demux,"demux");

};//bm




