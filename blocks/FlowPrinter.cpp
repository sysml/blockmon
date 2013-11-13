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
 * <blockinfo type="FlowPrinter" invocation="direct, indirect" thread_exclusive="False">
 *   <humandesc>
 *   Receives a Flow message and prints its associated information (as returned
 *   by the methods in the Flow class)
 *   </humandesc>
 *
 *   <shortdesc>Prints meta-information regarding a flow</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_flow" msg_type="Flow" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      }
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
#include <Flow.hpp>
#include <ClassId.hpp>
#include <arpa/inet.h>
#include <sstream>

namespace blockmon
{

    class FlowPrinter: public Block
    {
    /*
     * simple helper function to print an ip address
     * implemented by using inet_ntop.
     */
        static std::string ip_to_string(uint32_t ip)
        {
            
            char addr_buffer[INET_ADDRSTRLEN];
            //inet_ntop expects network byte order
            uint32_t flipped_ip=htonl(ip);
            
            if(!inet_ntop(AF_INET, &flipped_ip, addr_buffer, INET_ADDRSTRLEN))
                throw std::runtime_error("cannot convert ip address");
            return std::string (addr_buffer);
        }
                

    public:

        /*
         * constructor
         */
        FlowPrinter(const std::string &name, invocation_type invocation)
        : Block(name, invocation),
          m_ingate_id(register_input_gate("in_flow"))
        {
        }

        FlowPrinter(const FlowPrinter &)=delete;
        FlowPrinter& operator=(const FlowPrinter &) = delete;
        FlowPrinter(FlowPrinter &&)=delete;
        FlowPrinter& operator=(FlowPrinter &&) = delete;

        /*
         * destructor
         */
        virtual ~FlowPrinter()
        {}

        /*
         * this block takes no configuration parameters
         */  
        virtual void _configure(const pugi::xml_node&  /*n*/ )
        {}

        /*
         * the main method
         * receives a Flow message and prints out its associated information
         * If the message belongs to another class, an exception is thrown.
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if ( m->type() == MSG_ID(Flow) )
            {      
                auto flow = static_cast<const Flow *>(m.get());
                std::stringstream ss;
                const FlowKey& fk = flow->key();
                int duration = flow->end_time() - flow->start_time();
                ss<<"Flow of  "<< flow->packets() << " packets and "<<flow->bytes()<<" bytes begin at "<<flow->start_time()<<" end at "<<flow->end_time()<< "duration (ms.) "<<duration <<std::endl;
                ss<<"SRC IP "<<ip_to_string(fk.src_ip4)<<" SRC port "<<fk.src_port<<std::endl;
                ss<<"DST IP "<<ip_to_string(fk.dst_ip4)<<" DST port "<<fk.dst_port<<std::endl;
                ss<<"protocol "<<fk.proto<<std::endl;
                blocklog(ss.str(),log_info);


            }
                else
            {
                throw std::runtime_error("Flowprinter: wrong message type");
            }
        }

    private:
        
        int m_ingate_id;
 
    };

#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(FlowPrinter,"FlowPrinter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

