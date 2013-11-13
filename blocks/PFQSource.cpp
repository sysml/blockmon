/* Copyright (c) 2011, Consorzio Nazionale Interuniversitario 
 * per le Telecomunicazioni, NEC Europe Ltd. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd, Consorzio Nazionale 
 *      Interuniversitario per le Telecomunicazioni nor the names of its 
 *      contributors may be used to endorse or promote products derived from 
 *      this software without specific prior written permission.
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
 * <blockinfo type="PFQSource" invocation="indirect" thread_exclusive="True">
 *   <humandesc>
 *   Wrapper to the PFQ capturing engine:
 *
 *   http://netgroup.iet.unipi.it/software/pfq/
 *
 *   A block of this kind can be associated to a network interface or to a
 *   subset of its associated hardware queues. This is specified as a
 *   configuration parameter: a set of queues for the interface can be
 *   specified, if this is empty the block captures all of the packets on the interface.
 *   This block supports batch message allocation in order to optimize performance 
 *   </humandesc>
 *
 *   <shortdesc>Captures traffic from a local interface by means of the PFQ capturing engine</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="source_out" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element queues {
 *          attribute device {text}
 *          attribute caplen {xsd:integer, default=1514}
 *          attribute offset {xsd:integer, default=0}
 *          attribute slots {xsd:integer, default=131072}
 *          element queue {
 *               attribute number {xsd:integer}
 *               }*
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *  <params>                                                                                                                                 
 *      <queues device="eth3" caplen="1514" offset="0" slots="131072">
 *          <queue number="0"/>
 *      </queues> 
 *  </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <Packet.hpp>
#include <NewPacket.hpp>
#include <Buffer.hpp>

#include <pugixml.hpp>
#include <BlockFactory.hpp>

#include <pfq/pfq.hpp>
#include <mutex>

using namespace pugi;

namespace blockmon
{            
    /**
     * Implement a block that captures packets from PFQ socket (a Linux packet capture system) and injects them into BM as Packet messages
     */
    
    class PFQSource: public Block
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
                                  net::payload> allocator_type;
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
                                  net::payload> allocator_type;
#endif
        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        PFQSource(const std::string &name, invocation_type invocation)
        : Block(name, invocation_type::Async)
        , m_gate_id(register_output_gate("source_out"))
#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
        , m_allocator()
#else
        , m_mem_block(new MemoryBatch(4096*4))
#endif
        , m_pfq()
        , m_device()
        {
            if (invocation != invocation_type::Async) {
                blocklog("PFQSource must be Async, ignoring configuration", log_warning);
            }
        }
        
        virtual ~PFQSource(){
        	auto stats=m_pfq.stats();
        	std::cout << "PFQSource '"<<this->m_name <<"' statistics: " <<std::endl;
        	std::cout << "\tReceived: "<<stats.recv << std::endl;
        	std::cout << "\tDropped: "<<stats.drop << std::endl;
        	std::cout << "\tLost: "<<stats.lost << std::endl;

        	m_pfq.close();
        }

        /**
         * @brief Configures the block: defines the capture interface, the possible hw-queues in use, etc.
         * @param n The configuration parameters 
         */
        virtual void _configure(const pugi::xml_node& n) 
        {
            std::cout << __PRETTY_FUNCTION__ << std::endl;

            int offset = 0;
            int slots  = 131072;
            int caplen = 1514;

            bool timestamp = false;

            pugi::xml_node queues = n.child("queues");
            if(!queues)
                throw std::runtime_error("PFQSource:: no queues node");
            
            m_device = std::string(queues.attribute("device").value());
            if(m_device.length()==0)
                throw std::runtime_error("PFQSource::no device attribute ");
            
            auto clattr  = queues.attribute("caplen");
            auto offattr = queues.attribute("offset");
            auto slotattr = queues.attribute("slots");

            auto tsattr = queues.attribute("tstamp");

            if (!clattr.empty())
                caplen = clattr.as_int();
           
            if (!offattr.empty())
                offset = offattr.as_int();

            if (!slotattr.empty())
                slots = slotattr.as_int();

            if (!tsattr.empty())
                timestamp = tsattr.as_bool();

            std::vector<unsigned int> vq;
            
            m_pfq.open(caplen, offset, slots);

            for (xml_node queue=queues.child("queue"); queue; queue=queue.next_sibling("queue"))
                vq.push_back(queue.attribute("number").as_uint());
            
            if(!vq.empty())
            {
                auto it = vq.begin();
                auto it_e = vq.end();
                for (;it!=it_e;++it)
                {
                    m_pfq.add_device(m_device.c_str(),*it);
                }
            }
            else
            {
                blocklog("PFQSource: no queues specified, sniffing on device ", log_info);
                m_pfq.add_device(m_device.c_str(), net::pfq::any_queue);
            } 
          
            std::cout << "PFQ: dev:" << m_device << " caplen:" << caplen << " tstamp:" << std::boolalpha << timestamp; 
            std::cout << " queues:";
            std::copy(vq.begin(), vq.end(), std::ostream_iterator<int>(std::cout, ","));
            std::cout << std::endl;

            {
                std::lock_guard<std::mutex> lock(m_mutex);
                m_max_caplen = std::max(m_max_caplen, caplen);
            }

            net::payload::size_of(m_max_caplen);

            // the slice_allocator must be created once the dynamic_buffer (or net::payload)
            // is set to a given size.
            //
#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)            
            m_allocator.reset(new allocator_type);
#endif           
            m_pfq.caplen(caplen);
            m_pfq.toggle_time_stamp(timestamp);
            m_pfq.enable();         
            
        }

        virtual void _initialize()
        {
            std::cout << __PRETTY_FUNCTION__  << std::endl;
        }

        /** 
          * listens on the capture socket, retrieves a batch of packets and sends them out as Packet messages
          * Uses optimized allocation.
          */
        void _do_async() 
        {        
            
            net::queue b = m_pfq.read(10 /* microseconds */);

            auto it_e = b.end();
            for (auto it = b.begin(); it != it_e; ++it)
            {
                auto actual_payload = reinterpret_cast<uint8_t *>(it.data());
                
                while (!it->commit)
                {}

#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
                uint16_t len = it->len, caplen = it->caplen;
                uint32_t sec = it->tstamp.tv.sec, nsec = it->tstamp.tv.nsec;
#endif
#if defined(USE_SIMPLE_PACKET)
                auto sp = blockmon::NewPacket::SimplePacket(const_buffer<uint8_t>(actual_payload, it->caplen), *m_allocator, len, caplen, sec, nsec);
#elif defined(USE_SLICED_PACKET) 
                auto sp = blockmon::NewPacket::SlicedPacket(const_buffer<uint8_t>(actual_payload, it->caplen), *m_allocator, len, caplen, sec, nsec);
#else
                auto sp = alloc_msg_from_buffer<Packet>(m_mem_block, it->caplen, const_buffer<uint8_t>(actual_payload, it->caplen));
#endif                
                send_out_through(std::move(sp), m_gate_id);
            }
        }

    private:

        int m_gate_id;

#if   defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)
        std::unique_ptr<allocator_type>  m_allocator;
#else
        std::shared_ptr<MemoryBatch> m_mem_block;  
#endif
        net::pfq m_pfq;
        std::string m_device;

        static std::mutex m_mutex;
        static int m_max_caplen;
    };

    std::mutex PFQSource::m_mutex;
    int PFQSource::m_max_caplen;

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(PFQSource,"PFQSource");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

