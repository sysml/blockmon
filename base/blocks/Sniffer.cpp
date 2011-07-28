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
 * @blockname{Sniffer}
 * @gates{,sniffer_out(msg:RawPacket)}
 *
 * @param type Set to live or trace, depending on whether input is from an
 * interface or a pcap trace
 * @param name The name of the interface (e.g., eth0) or pcap trace
 * @param bpf_filter A BFP filter to filter traffic with
 *
 * <b>Sample XML parameters:</b>
 * @verbatim
 * <params>
 *      <source type="live" name="eth0">
 *      or
 *      <source type="trace" name="trace.pcap">
 *
 *      <bpf_filter expression=" ">
 * </params>
 * @endverbatim
 *
 */
#include <Block.hpp>
#include <RawPacket.hpp>
#include <pcap.h>
#include <pugixml.hpp>
#include <BlockFactory.hpp>



using namespace pugi;

namespace bm
{
    class Sniffer: public Block
    {
        pcap_t* m_source;
        bool m_live;	
        int m_gate_id;
        std::shared_ptr<MemoryBlock> m_mem_block;        

        Sniffer(const Sniffer &) = delete;
        Sniffer& operator=(const Sniffer &) = delete;


    public:

        Sniffer(const std::string &name, bool active, bool /* thread_safe */)
        :Block(name,"pcap_sniffer",true,true), 
        m_source(NULL),
        m_live(false), 
        m_gate_id(register_output_gate("sniffer_out")), //ignore options, sniffer has to be active
        m_mem_block(new MemoryBlock(4096*4))
        {
            if(!active) 
                std::cout << "WARNING: sniffer has to be active, user option has been ignored" << std::endl;
        }

        virtual ~Sniffer()
        {
            pcap_close(m_source);
        }


        virtual void _configure(const xml_node& n)
        {
            xml_node source=n.child("source");
            if(!source) 
                throw std::runtime_error("pcapsniffer: missing parameter source");
            std::string type=source.attribute("type").value();
            std::string name=source.attribute("name").value();
            if((type.length()==0)||(name.length()==0))
                throw std::runtime_error("pcapsniffer: missing attribute");
            if(type.compare("live")==0)
                m_live=true;
            else if(type.compare("trace")==0)
                m_live=false;
            else throw std::runtime_error("pcapsniffer: invalid type parameter");
            char errbuf[PCAP_ERRBUF_SIZE];
            if(m_live)
            {
                m_source = pcap_open_live(name.c_str(),BUFSIZ,1 ,10,errbuf);
                if (m_source == NULL) {
                    blocklog(std::string(errbuf),error);
                    throw(std::invalid_argument("TcpSniffer::error within pcap_open_live"));
                }
            }
            else
            {
                m_source=pcap_open_offline(name.c_str(),errbuf);
                if (m_source == NULL) {
                    blocklog(std::string(errbuf),error);
                    throw(std::invalid_argument("TcpSniffer::error within pcap_open_offline"));
                }
            }

            xml_node bpf=n.child("bpf_filter");
            if(bpf)
            {
                bpf_u_int32 mask=0;
                bpf_u_int32 net=0;
                if(m_live)
                {
                    if (pcap_lookupnet(name.c_str(), &net, &mask, errbuf) == -1) {
                        blocklog( "Can't get netmask for device ",error);
                        net = 0;
                        mask = 0;
                    }
                }

                std::string exp=bpf.attribute("expression").value();
                if(exp.length()==0)
                    throw std::runtime_error("pcapsniffer: no bpf expression");
                struct bpf_program fp;
                if (pcap_compile(m_source, &fp, exp.c_str(), 0, net) == -1) {
                    blocklog(pcap_geterr(m_source),error);
                    throw(std::invalid_argument("TcpSniffer::error within pcap_compile"));
                }
                if (pcap_setfilter(m_source, &fp) == -1) {
                    blocklog(pcap_geterr(m_source),error);
                    throw(std::invalid_argument("TcpSniffer::error within pcap_setfilter"));
                }
            }
        }

        virtual int _receive_msg(std::shared_ptr<const Msg>&& /* m */, int /* index */)
        {
            return -1;	
        }

        int do_async_processing()
        {

            struct pcap_pkthdr* hdr=NULL;
            const u_char* pkt=NULL;
            int ret_code=pcap_next_ex(m_source,&hdr,&pkt);
            while(ret_code==1)
            {
                send_out_through(alloc_from_big_buffer<RawPacket>(m_mem_block,const_buffer<char>(reinterpret_cast<const char *>(pkt),hdr->caplen)),m_gate_id);
                ret_code=pcap_next_ex(m_source,&hdr,&pkt);
            }

            if(ret_code==-1)
            {

                blocklog(std::string(pcap_geterr(m_source)),warning);

            }
            else if(ret_code==0)
            {
                //timeout expired
            }
            else if(ret_code==-2)
            {
                blocklog("trace is over",info);
            }
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
            return -1;
        }
    };

    REGISTER_BLOCK(Sniffer,"pcap_sniffer");
}

