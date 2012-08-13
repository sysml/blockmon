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
 * <blockinfo type="PcapSource" invocation="async" thread_exclusive="True">
 *   <humandesc>
 *     Captures traffic from a local interface or pcap trace file and outputs
 *     packets using a Packet message. If the source parameter is set to live,
 *     the name parameter should be an interface's name (e.g., eth0). If the
 *     source type is set to trace, then the name should be the full path to a
 *     pcap trace file (e.g., /tmp/mytrace.pcap). Use the bfp paramter to filter
 *     traffic using BFP syntax.
 *   </humandesc>
 *
 *   <shortdesc>Captures traffic from a local interface or pcap trace file</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="source_out" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element source {
 *        attribute type {"live" | "trace"}
 *        attribute name {text}
 *      }
 *      element bpf_filter {text}?
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <source type="live" name="eth0">
 *        or
 *        <source type="trace" name="trace.pcap">
 *
 *      <bpf_filter expression=" ">
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <pcap.h>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <PacketTime.hpp>
#include <BMTime.h>

#include <Packet.hpp>
#include <NewPacket.hpp>


using namespace pugi;

namespace blockmon
{
    /**
     * Implements a block that captures packets from a standard pcap source and injects them into BM as Packet messages
     */
    class PcapSource: public Block
    {
    public:

#if   defined(USE_SIMPLE_PACKET)
        typedef blockmon::slice_allocator<blockmon::NewPacket, 
                #ifdef USE_PACKET_TAG
                net::TagBuffer, 
                #endif
                #ifdef USE_PACKET_FLOW
                blockmon::FlowKey,
                #endif
                blockmon::dynamic_buffer> allocator_type;
#elif defined(USE_SLICED_PACKET)
        typedef blockmon::slice_allocator<blockmon::NewPacket, 
                #ifdef USE_PACKET_TAG
                net::TagBuffer,
                #endif
                #ifdef USE_PACKET_FLOW
                blockmon::FlowKey,
                #endif
                net::ethernet,
                net::ipv4,
                net::tcp,
                net::udp,
                net::icmp,
                blockmon::dynamic_buffer> allocator_type;
#endif

    private:
        
        pcap_t* m_source;
        bool    m_live;	
        int     m_gate_id;

#if   defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
        std::unique_ptr<allocator_type> m_allocator;
#else
        std::shared_ptr<MemoryBatch> m_mem_block;  
#endif
        PacketTimeWriter m_writer;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */

        PcapSource(const std::string &name, invocation_type invocation)
        : Block(name, invocation_type::Async) //ignore options, source must be indirect
        , m_source(NULL)
        , m_live(false) 
        , m_gate_id(register_output_gate("source_out"))  
#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
        , m_allocator()
#else
        , m_mem_block(new MemoryBatch(4096*4))
#endif
        , m_writer()
        {
            if (invocation != invocation_type::Async) {
                blocklog("PcapSource must be Async, ignoring configuration", log_warning);
            }
        }

        /**
         * @brief Destructor
         */

        ~PcapSource() 
        {
            if(m_source)
                pcap_close(m_source);
        }


        /**
         * @brief Configures the block: defines the capture interface, whether it's a trace or a live socket and (optional filters)
         * also, it opens the socket for capturing
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node& n) 
        {
            pugi::xml_node source=n.child("source");
            if(!source) 
                throw std::runtime_error("pcapsource: missing parameter source");
            std::string type=source.attribute("type").value();
            std::string name=source.attribute("name").value();

            if((type.length()==0)||(name.length()==0))
                throw std::runtime_error("pcapsource: missing attribute");
            if(type.compare("live")==0)
                m_live=true;
            else if(type.compare("trace")==0)
                m_live=false;
            else throw std::runtime_error("pcapsource: invalid type parameter");
            char errbuf[PCAP_ERRBUF_SIZE];
            if(m_live)
            {
                m_source = pcap_open_live(name.c_str(),BUFSIZ,1 ,10,errbuf);
                if(!m_source)
                { 
                    blocklog(std::string(errbuf), log_error);
                    throw(std::invalid_argument("TcpPcapSource::error within pcap_open_live"));
                }
            }
            else
            {
                m_source=pcap_open_offline(name.c_str(),errbuf);
                if (m_source == NULL) {
                    blocklog(std::string(errbuf), log_error);
                    throw(std::invalid_argument("TcpPcapSource::error within pcap_open_offline"));
                }
            }


            pugi::xml_node bpf=n.child("bpf_filter");
            if(bpf)
            {
                bpf_u_int32 mask=0;
                bpf_u_int32 net=0;
                if(m_live)
                {
                    if (pcap_lookupnet(name.c_str(), &net, &mask, errbuf) == -1) {
                        blocklog("Can't get netmask for device", log_error);
                        net = 0;
                        mask = 0;
                    }
                }

                std::string exp=bpf.attribute("expression").value();
                if(exp.length()==0)
                    throw std::runtime_error("pcapsource: no bpf expression");
                struct bpf_program fp;
                if (pcap_compile(m_source, &fp, exp.c_str(), 0, net) == -1) {
                    blocklog(pcap_geterr(m_source), log_error);
                    throw(std::invalid_argument("TcpPcapSource::error within pcap_compile"));
                }
                if (pcap_setfilter(m_source, &fp) == -1) {
                    blocklog(pcap_geterr(m_source), log_error);
                    throw(std::invalid_argument("TcpPcapSource::error within pcap_setfilter"));
                }
            }             

            blockmon::dynamic_buffer::size_of(BUFSIZ);
           
            // the slice_allocator must be created once the dynamic_buffer
            // is set to a given size.
            //
#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
            m_allocator.reset(new allocator_type);
#endif

        }

        /** 
         * listens on the capture socket, retrieves packets and sends them out as Packet messages
         * Uses optimized allocation.
         * As the socket call is blocking (although it returns after a timeout expires) this cannot share a thread
         */
        void _do_async()
        {
            struct pcap_pkthdr* hdr=NULL;
            const u_char* pkt = NULL;

            int ret_code = pcap_next_ex(m_source,&hdr,&pkt);  
            while (ret_code == 1)
            {
                timespec p_tstamp;
                p_tstamp.tv_sec = hdr->ts.tv_sec;
                p_tstamp.tv_nsec = hdr->ts.tv_usec * 1000;

                if(blockmon_clock_source() == PACKET)
                    m_writer.advance_packet_time(timespec_to_us(p_tstamp));

                auto actual_payload = reinterpret_cast<const uint8_t *>(pkt);

#if   defined(USE_SIMPLE_PACKET)
                auto sp = blockmon::NewPacket::SimplePacket(const_buffer<uint8_t>(actual_payload, hdr->caplen), *m_allocator, hdr->len, hdr->caplen, hdr->ts.tv_sec, hdr->ts.tv_usec);
#elif defined(USE_SLICED_PACKET)
                auto sp = blockmon::NewPacket::SlicedPacket(const_buffer<uint8_t>(actual_payload, hdr->caplen), *m_allocator, hdr->len, hdr->caplen, hdr->ts.tv_sec, hdr->ts.tv_usec);
#else
                auto sp = alloc_msg_from_buffer<Packet>(m_mem_block, (size_t)(hdr->caplen), 
                                                        const_buffer<uint8_t>(actual_payload, hdr->caplen), p_tstamp, hdr->len);
#endif                
                send_out_through(std::move(sp), m_gate_id);

                ret_code = pcap_next_ex(m_source, &hdr, &pkt);
            }

            if (ret_code == -1)
            {
                blocklog(std::string(pcap_geterr(m_source)), log_warning);
            } else if(ret_code == 0) 
            {
                //timeout expired
            } else if(ret_code == -2) {
                blocklog("trace is over", log_info);
            }
        }
    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PcapSource,"PcapSource");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

