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
 * capture packets from the PFRING sockets
 * can support new NICs with multiple queue, so as to parallellize capture 
 *
 *
 *
 * @blockname{MQPfring_na}
 * @gates{sniffer_out(msg:RawPacket)}
 *
 *@param device to listen on
 *@param queues  to listen on (optional, if not specified will get all of the traffic)
 *
 * <queues device="eth0" >
 * 	<queue number="1"/>
 * 	<queue number="2"/>
 * </queues>
 *
 * 	
 *
 */

#ifdef PFRING_BLOCK


#include<algorithm>
#include<Block.hpp>
#include<RawPacket.hpp>
#include<BlockFactory.hpp>
#include<pfring.h>


namespace bm
{

    class MQPfring_na: public Block
    {
        int m_out_pkts;
	std::string m_device;
	std::vector<pfring*> m_ring;
    std::shared_ptr<MemoryBlock> m_mem_block;



	void create_enable_ring(std::string name)
	{
		int i=m_ring.size();//last position in vector
		m_ring.push_back(pfring_open(const_cast<char*>(name.c_str()), 1,  1500, 0));
		if(m_ring[i] == NULL) {
			throw std::runtime_error(std::string(name).append(" : impossible to open PFRING "));

		} else {
			char buf[128];
			snprintf(buf, sizeof(buf), "blockmon %s",name.c_str());
			pfring_set_application_name(m_ring[i], buf);
		}
		int rc;
		if((rc = pfring_set_direction(m_ring[i], rx_only_direction)) != 0)
		{
			char logmsg[256];
			sprintf(logmsg,"pfring_set_direction returned [rc=%d][direction=%d]\n", rc, 1);
			blocklog(std::string(logmsg),info);
		}
		pfring_enable_ring(m_ring[i]);


	}
    public:

        MQPfring_na(const std::string &name, bool active, bool thread_safe)
        : Block(name,"MQPfring_na",active,thread_safe), 
          m_out_pkts(register_output_gate("sniffer_out")),
          m_mem_block(new MemoryBlock(4096*4))
        {}

	~MQPfring_na()
	{
		std::for_each(m_ring.begin(),m_ring.end(),pfring_close);

	}


        virtual void _configure(const xml_node&  n )
        {
		xml_node queues=n.child("queues");
		if(!queues)
			throw std::runtime_error("MQPfring_na:: no queues node");
		m_device=std::string(queues.attribute("device").value());
		if(m_device.length()==0)
			throw std::runtime_error("MQPfring_na::no device attribute ");
		std::vector<unsigned int> vq;
		for (xml_node queue=queues.child("queue"); queue; queue=queue.next_sibling("queue"))
			vq.push_back(queue.attribute("number").as_uint());
		if(vq.size()>0)
		{
			auto it=vq.begin();
			auto end=vq.end();
			for (;it!=end;++it)
			{
				char devname[64];
				snprintf(devname, sizeof(devname), "%s@%d", m_device.c_str(),*it);
				create_enable_ring(std::string(devname));
			}

		}
		else
		{
			blocklog("no queues specified, sniffing on device",info);
			create_enable_ring(m_device);
			

		}	

		std::cout<<"configuration done\n";

        }

        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            return 0;
        }

        virtual int do_async_processing()
	{
	
		for (int i=0; i<10000; ++i) {

			struct pfring_pkthdr hdr;
			auto it=m_ring.begin();
			auto end=m_ring.end();
			for (;it!=end;++it)
			{
                u_char* p;
				if(pfring_recv(*it,&p /*(char*)buffer*/, 0/*sizeof(buffer)*/, &hdr, 1) > 0) {
					 send_out_through(alloc_from_big_buffer<RawPacket>(m_mem_block,const_buffer<char>(reinterpret_cast<const char *>(p)/*(buffer)*/,hdr.len)),m_out_pkts);
	
				}
			}
		}
	
		return 0;
	}

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
        }

    };


    REGISTER_BLOCK(MQPfring_na,"MQPfring");

};//bm

#else

#warning PFRING block will not be compiled

#endif


