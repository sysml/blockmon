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

#include <Proxy.hpp>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <cstring>
#include <unistd.h>
#include <fcntl.h>



namespace bm
{


    void Proxy::_configure(const xml_node& n)
    {
        xml_node in=n.child("in");
        xml_node out=n.child("out");
        
        if((!in && !out) ||(in && out))
            throw std::runtime_error("proxy: missing parameter in or out");
        if(in)
        {
            if (!m_live)
                throw std::runtime_error("proxy: if used as in block it must be active");
            server_addr = in.child_value("address");
            
            server_port = (short)in.child("address").attribute("port").as_int();
            if (server_port==0)
                server_port=DEFAULT_PORT;
            if ((server_sock = socket(AF_INET,SOCK_DGRAM,0))<0)
                throw std::runtime_error("proxy: error in socket creating");

            //set socket as nonblock
            int opts = fcntl(server_sock,F_GETFL);
            if (opts < 0) throw std::runtime_error("proxy: error in socket fcntl");
            opts = (opts | O_NONBLOCK);
            if (fcntl(server_sock,F_SETFL,opts) < 0)
                throw std::runtime_error("proxy: error in socket fcntl");


            sockaddr_in saddr;
            memset((void*)&saddr,0,sizeof(saddr));
            saddr.sin_family = AF_INET;
            saddr.sin_addr.s_addr = htonl(INADDR_ANY);
            saddr.sin_port = htons(server_port);
            if (server_addr != "")
                inet_pton(AF_INET,server_addr.c_str(),&saddr.sin_addr);

            if (bind(server_sock,(sockaddr*)&saddr,sizeof(saddr))==-1)
                throw std::runtime_error("proxy: error in socket binding");
            buffer_in = new char [BUFFER_LENGTH];
            m_gate_out= register_output_gate("proxy_out");
        }
        else if(out)
        {
            
            xml_node addr = out.child("address");
            out_addr.push_back(addr.child_value());
            if(out_addr[0]=="")
                throw std::runtime_error("proxy: missing at least one address in node \"out\"");
            out_port.push_back(addr.attribute("port").as_int());
            if(out_port[0]==0)
                out_port[0]=DEFAULT_PORT;
            addr = addr.next_sibling("address");
            while (addr)
            {
                out_addr.push_back(addr.child_value());
                out_port.push_back((short)addr.attribute("port").as_int());
                if(out_port[out_addr.size()-1]==0)
                    out_port[out_addr.size()-1]=DEFAULT_PORT;
                addr = addr.next_sibling("address");
            }
            buffer_out = new char [BUFFER_LENGTH];
            if ((out_sock = socket(AF_INET,SOCK_DGRAM,0))<0)
                throw std::runtime_error("proxy: error in socket creating");
            m_gate_in = register_input_gate("proxy_in");

        }
        
        
    }

    int Proxy::do_async_processing()
    {
        int len;
        fd_set socks;
      	FD_ZERO(&socks);
	FD_SET(server_sock,&socks);
        timeval timeout;
        timeout.tv_usec = 10000;
        timeout.tv_sec = 0;
        while (select(server_sock+1,&socks,NULL,NULL,&timeout)>0)
        {
            len = recvfrom(server_sock,(void*)buffer_in,BUFFER_LENGTH,0,NULL,NULL);
            
            if (len>MarshallFactory::HEAD_SIZE)
            {
                const_buffer<char> c_buf(buffer_in,len);
                send_out_through(MarshallFactory::instance().unmarshall(c_buf),m_gate_out);
            }

        }
        return 0;
    }

    int Proxy::_receive_msg(std::shared_ptr<const Msg>&& m, int /*index*/)
    {
        mutable_buffer<char> m_buf(buffer_out,BUFFER_LENGTH);
        int len = MarshallFactory::instance().marshall(*m,m_buf);
        sockaddr_in addr;
        memset((void*)&addr,0,sizeof(addr));
        addr.sin_family=AF_INET;
        std::cout << "SONO QUI"<<len << m->type()<<"\n";
        for (unsigned int i =0; i < out_addr.size(); i++)
        {
            
            inet_pton(AF_INET,out_addr[i].c_str(),&addr.sin_addr);
            addr.sin_port = htons(out_port[i]);
            if(sendto(out_sock,m_buf.addr(),len,0,(sockaddr*)&  addr,sizeof(addr))<0)
                blocklog("proxy:problem with sendto",warning);
        }
        return 0;
    }

}