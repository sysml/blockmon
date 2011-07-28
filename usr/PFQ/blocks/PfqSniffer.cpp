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

/*
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

/**
 * @file
 * Captures traffic from a local interface or pcap trace
 * file and outputs packets using a RawPacket (see base/messages/RawPacket.hpp)
 *
 * @blockname{PfqSniffer}
 * @gates{,sniffer_out(msg:RawPacket)}
 *
 * @param interfa
 * @param device the network interface to listen on
 * @param queues indices of the hardware queues to sniff from
 *
 * <b>Sample XML parameters:</b>
 * @verbatim
    <params><queues device="eth3">
        <queue number="0"/>
    </queues></params>
 
 * @endverbatim
 *
 */
#include <Block.hpp>
#include <RawPacket.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <linux/pf_q.h>
#include<pfq.hpp>


#include <sys/types.h>

using namespace pugi;

namespace bm
{
    class PfqSniffer: public Block
    {
        int m_gate_id;
        std::shared_ptr<MemoryBlock> m_mem_block;        
        net::pfq m_pfq;
        std::string m_device;
        
        PfqSniffer(const PfqSniffer &) = delete;
        PfqSniffer& operator=(const PfqSniffer &) = delete;


    public:

        PfqSniffer(const std::string &name, bool active, bool /* thread_safe */)
        :Block(name,"PFQ_sniffer",true,true), 
        m_gate_id(register_output_gate("sniffer_out")), //ignore options, sniffer has to be active
        m_mem_block(new MemoryBlock(4096*4)),
        m_pfq(net::pfq_open),
        m_device()
        {
            if(!active) 
                std::cout << "WARNING: sniffer has to be active, user option has been ignored" << std::endl;
        }

        virtual ~PfqSniffer()
        {
        }


        virtual void _configure(const xml_node& n)
        {
            xml_node queues=n.child("queues");
            if(!queues)
                throw std::runtime_error("PFQBLock:: no queues node");
            m_device=std::string(queues.attribute("device").value());
            if(m_device.length()==0)
                throw std::runtime_error("PFQBlock::no device attribute ");
            std::vector<unsigned int> vq;
            for (xml_node queue=queues.child("queue"); queue; queue=queue.next_sibling("queue"))
                vq.push_back(queue.attribute("number").as_uint());
            if(vq.size()>0)
            {
                auto it=vq.begin();
                auto end=vq.end();
                for (;it!=end;++it)
                {
                    m_pfq.add_device(m_pfq.ifindex(m_device.c_str()),*it);
                }

            }
            else
            {
                blocklog("no queues specified, sniffing on device",info);
                m_pfq.add_device(m_pfq.ifindex(m_device.c_str()),Q_ANY_QUEUE);

            } 
          m_pfq.enable();

        }

        virtual int _receive_msg(std::shared_ptr<const Msg>&& /* m */, int /* index */)
        {
            return -1;	
        }

        int do_async_processing()
        {        


            net::batch b=m_pfq.read(10);
            for (auto it=b.begin(); it!=b.end(); ++it)
            {
                char* actual_payload=(char*)(&(*it)+1);
                if(!it->commit)
                    continue;
                send_out_through(alloc_from_big_buffer<RawPacket>(m_mem_block,const_buffer<char>(actual_payload,it->caplen)),m_gate_id);
            }
            return 0; 
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
            return -1;
        }
    };

    REGISTER_BLOCK(PfqSniffer,"PFQ_sniffer");
}

