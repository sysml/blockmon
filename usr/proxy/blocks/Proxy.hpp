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
 * File:   Proxy.hpp
 * Author: fabrizio
 *
 * Created on 2 maggio 2011, 23.18
 */

#ifndef PROXY_HPP
#define	PROXY_HPP
#define DEFAULT_PORT 1001
#define BUFFER_LENGTH 1500

#include <Block.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>
#include <Buffer.hpp>
#include <MarshFactory.hpp>
#include <string>
#include <vector>
#include <sys/socket.h>



namespace bm
{
    class Proxy: public Block
    {
        
        bool m_live,th_safe;
        int m_gate_out,m_gate_in;
        std::string server_addr;
        short server_port;
        int server_sock;
        std::vector<std::string> out_addr;
        int out_sock;
        std::vector<short> out_port;
        char *buffer_in;
        char *buffer_out;
        


        Proxy(const Proxy &) = delete;
        Proxy& operator=(const Proxy &) = delete;

    public:

        Proxy(const std::string &name, bool active, bool thread_safe)
        :Block(name,"proxy",active,thread_safe),
         m_live(active),
         th_safe(thread_safe),
         m_gate_out(0),
         m_gate_in(0),
         server_addr(""),
         server_port(0),
         server_sock(0),
         out_addr(),
         out_sock(0),
         out_port(),
         buffer_in(NULL),
         buffer_out(NULL)
        {}

        virtual ~Proxy()
        {
            delete[] buffer_in;
            delete[] buffer_out;
        }


        virtual void _configure(const xml_node& n);


        virtual int _receive_msg(std::shared_ptr<const Msg>&&  m , int /* index */);
        


        int do_async_processing();
        

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
            return -1;
        }
    };

    REGISTER_BLOCK(Proxy,"proxy");
}


#endif	/* PROXY_HPP */

