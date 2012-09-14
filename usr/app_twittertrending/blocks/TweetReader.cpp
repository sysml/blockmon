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
 * <blockinfo type="TweetReader" invocation="indirect" thread_exclusive="True">
 *   <humandesc>
 *     Reads tweets from file and send tweets to destination nodes.
 *     If the source type is set to tweetfile, then the name should be the 
 *     full path to a file containing the tweets (e.g., /tmp/tweets.log). 
 *   </humandesc>
 *
 *   <shortdesc>Reads tweets from a file and forward them.</shortdesc>
 *
 *   <gates>
 *     <gate type="output" name="source_out" msg_type="Tweet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element source {
 *        attribute type {"offline"}
 *        attribute name {text}
 *      }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *        <source type="offline" name="tweets.log">
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *     <variable name="msg_sent" human_desc="integer" access="read"/>
 *     <variable name="msg_recv" human_desc="integer" access="read"/>
 *   </variables>
 *
 * </blockinfo>
 */
#include <Block.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>

#include <fstream>
#include <iostream>
#include <string.h>
#include <string>
#include <list>
#include <Tweet.hpp>

#include <sys/types.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/ioctl.h> 
#include <net/if.h>  
#include <boost/lexical_cast.hpp>

#define BUF_LEN 2000

using namespace pugi;

namespace blockmon
{

     /** 
      * Implements a block that reads tweets from file and
      * forward them as Tweet messages.
      */

     class TweetReader: public Block
     {
     private:
         std::ifstream m_source;
         int m_gate_id;
         uint32_t m_msg_type;
         int m_msg_sent;
         int m_msg_recv;
         std::string file_name;
         int num_gates;
         int *m_outgate_ids;
         std::string outgate_basename;
         timeval firsttime;
         timeval lasttime;
         int next_out_port;
         std::ifstream file;
         std::list<std::string> tweets;
         std::list<std::string>::iterator tweetiter;

         char buffer[BUF_LEN];
         int  retc;
         char *check;

         TweetReader(const TweetReader &) = delete;
         TweetReader& operator=(const TweetReader &) = delete;


     public:

        /**
         * @brief Constructor
         * @param name The name of the source block
         * @param invocation Invocation type of the block (Indirect, Direct, Async).
         *                     This block can only be async invoked,
         *                     and will ignore any contrary configuration.
         */
        TweetReader(const std::string &name, invocation_type invocation)
            :Block(name, invocation_type::Async),
            next_out_port(0)
            {
                if (invocation != invocation_type::Async) {
                    blocklog("TweetReader must be Async, ignoring configuration", log_warning);
                }
                m_msg_sent = 0;
                m_msg_recv = 0;
                outgate_basename = "out_tweet";
                m_msg_type = type_to_id<Tweet>::id();
                register_variable("msg_sent",make_rd_var(no_mutex_t(), m_msg_sent));
                register_variable("msg_recv",make_rd_var(no_mutex_t(), m_msg_recv));
            }


            /**
            * @brief Destructor
            */
            virtual ~TweetReader()
            {
                delete m_outgate_ids;
                if(m_source)
                    m_source.close();
            }


            /**
            * @brief Configures the block: defines the input file.
            * @param n The configuration parameters
            */
            virtual void _configure(const xml_node& n)
            {
                xml_node source = n.child("source");
                xml_node gates_node = n.child("gates");
                if( (!source)  || (!gates_node) )
                    throw std::runtime_error("TweetReader: missing parameter");
                std::string gates_s = gates_node.attribute("number").value();
                std::string type = source.attribute("type").value();
                std::string ip = source.attribute("ip").value();
                file_name = source.attribute("name").value();
                if(!type.length() || !file_name.length() || !gates_s.length())
                    throw std::runtime_error("TweetReader: missing attribute");
                if(type.compare("offline") != 0)
                    throw std::runtime_error("TweetReader: invalid type parameter");

                num_gates = atoi(gates_s.c_str());

                file.open(file_name);
                if(!file.is_open()) {
                    throw std::runtime_error("TweetReader: cannot open source file");
                }

                // Create and register the output gates
                m_outgate_ids = new int[num_gates];
                for(int i=0; i<num_gates; i++){
                    std::string ogate = outgate_basename + boost::lexical_cast<std::string>(i);
                    m_outgate_ids[i] = register_output_gate(ogate.c_str());
                }
            }
    
            /**
             * Retrieves tweets and send them out as WordRecord message
             */
            void _do_async()
            {               
                if(m_msg_sent == 0) {
                    gettimeofday(&firsttime, NULL);
                }

                if(file.eof()) {
                    sleep(5);
                }
 
                std::string json_tweet;
                getline(file, json_tweet);
                    
                std::shared_ptr<Tweet> m(new Tweet(json_tweet));
                send_out_through(move(m), m_outgate_ids[next_out_port]);
                next_out_port = (next_out_port + 1) % num_gates;
                m_msg_sent++;
           }
     };
     
     REGISTER_BLOCK(TweetReader, "TweetReader");
}
