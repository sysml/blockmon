/* Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale
 * Interuniversitario per le Telecomunicazioni. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd, Consorzio Nazionale
 *      Interuniversitario per le Telecomunicazioni nor the names of its contributors
 *      may be used to endorse or promote products derived from this software
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT
 * HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <cstdio>
#include <Tweet.hpp>
#include <vector>
#include <WordRecord.hpp>

#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#ifdef _USE_JSMN_LIBRARY
#include <jsmn.h>
#endif
#include <stdlib.h>
#include <string.h>

namespace blockmon
{

     /**
      * Implements a block that receives tweets
      */
     class TweetFinder: public Block
     {
     private:
        int m_msg_recv;
        unsigned int m_reset;
        uint32_t m_msg_type;
        int num_gates;
        long sentMessages;
        long sentTuple;
        long ignored;
        int m_ingate_id;
        int *m_outgate_ids;
        std::vector<std::shared_ptr< WordRecord > > hashtag_batch;
        struct timeval lasttime;
        std::hash<std::string> hash_fn;
        long receivedTweets;
        timeval firsttime;
    #define ALLOC_TOKEN 10
        int allocated_tokens;
        #ifdef _USE_JSMN_LIBRARY
        jsmn_parser parser;
        jsmntok_t *tokens;
        #endif
        long hashtag_found;
        long tweet_found;
     public:

        /**
        * @brief Constructor
        * @param name         The name of the packet counter block
        * @param invocation   Invocation type of the block (Indirect, Direct, Async)
        */
        TweetFinder(const std::string &name, invocation_type invocation)
            : Block(name, invocation),
            m_ingate_id(register_input_gate("in_word")),
            receivedTweets(0),
            allocated_tokens(0),
            #ifdef _USE_JSMN_LIBRARY
            tokens(NULL),
            #endif
            hashtag_found(0),
            tweet_found(0)
        {
            m_reset = 0;
            m_msg_type = type_to_id<Tweet>::id();
        }

       /**
        * @brief Destructor
        */
        ~TweetFinder()  {}

        /**
        * @brief Configures the block.
        * @param n The configuration parameters
        */
        void _configure(const pugi::xml_node&  n)
        {
            #ifndef _USE_JSMN_LIBRARY
            throw std::runtime_error("Twitter Trending was compiled without JSMN parser");
            #endif
            
            pugi::xml_node gates_node=n.child("gates");
            if(!gates_node)
                throw std::runtime_error("TweetFinder: missing node gates");
            std::string gates_s=gates_node.attribute("number").value();
            if(!gates_s.length())
                throw std::runtime_error("TweetFinder: missing attribute number");
             
            num_gates = atoi(gates_s.c_str());
            std::string outgate_basename = "out_hash";
            m_outgate_ids = new int[num_gates];
            for(int i=0; i<num_gates; i++) {
                std::string ogate = outgate_basename + boost::lexical_cast<std::string>(i);
                m_outgate_ids[i] = register_output_gate(ogate.c_str());
                std::shared_ptr< WordRecord > m(new WordRecord());
                hashtag_batch.push_back(m);
            }
        }

        /**
        * @brief Initialize the block
        */
        void _initialize()
        {}

        /**
        * If the message received is not of type RawPacket throw an exception,
        * otherwise count it
        * @param m The message
        * @param index The index of the gate the message came on
        */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != m_msg_type ) {
                throw std::runtime_error("TweetFinder::wrong message type");
            }

            
            if(receivedTweets == 0) {
                gettimeofday(&firsttime, NULL);
            }

            #ifdef _USE_JSMN_LIBRARY
            const Tweet* msg_ptr = static_cast<const Tweet *>(m.get());

            // Parse the tweet
            jsmn_init(&parser);
            while(1) {
                const char* buf = msg_ptr->get_tweet().c_str();
                int r = jsmn_parse(&parser, buf, tokens, allocated_tokens);
                if(r == JSMN_SUCCESS) {
                    // now loop to find the "text" part
                    // we check one token over two, for every JSMN_STRING check if it
                    // contains "text"
                    if(tokens[0].type != JSMN_OBJECT) {
                        ignored++;
                        //std::cerr << "No object found in tweet" << std::endl;
                        break;
                    }

                    int size = tokens[0].size;

                    int jj;
                    for(jj = 0; jj < size; jj += 2) {
                        if(tokens[1 + jj].type == JSMN_STRING && tokens[2 + jj].type == JSMN_STRING) {
                            if(!strncmp(buf + tokens[1 + jj].start, "text", 4)) {
                                tweet_found++;
                                char tmpbuf[16384];
                                int jcn;
                                for(jcn = tokens[2 + jj].start; jcn < tokens[2 + jj].end; jcn++) {
                                    if(buf[jcn] == '#') {
                                        break;
                                    }
                                }
                                if(jcn < tokens[2 + jj].end) {
                                    hashtag_found++;
                                    int jcn_start = jcn;
                                    jcn++;
                                    int hashtag_len = 1;
                                    while(jcn < tokens[2 + jj].end) {
                                        if(!isalnum(buf[jcn]))
                                            break;
                                        jcn++;
                                        hashtag_len++;
                                    }
                                    strncpy(tmpbuf, buf + jcn_start, hashtag_len);
                                    tmpbuf[hashtag_len] = 0;
                                    size_t val_hash = hash_fn((tmpbuf));
                                    int ogate = val_hash % num_gates;
                                    hashtag_batch[ogate]->add_word(std::string(tmpbuf));
#define BATH_SIZE 200
                                    if(hashtag_batch[ogate]->get_word_number() >= BATH_SIZE) {
                                        sentTuple++;
                                        sentMessages += BATH_SIZE;
                                        send_out_through(move(hashtag_batch[ogate]), m_outgate_ids[ogate]);
                                        std::shared_ptr< WordRecord > m(new WordRecord());
                                        hashtag_batch.at(ogate) = m;
                                    }

                                }
                                break;
                            }
                        }
                    }
                        break;
                } else if(r == JSMN_ERROR_NOMEM) {
                    std::cerr << "Reallocating tokens" << std::endl;
                    allocated_tokens += ALLOC_TOKEN;
                    tokens = (jsmntok_t*) realloc(tokens, sizeof(jsmntok_t) * allocated_tokens);
                    if(tokens == NULL) {
                        throw std::runtime_error("Can not allocate memory\n");
                    }
                    continue;
                } else if(r == JSMN_ERROR_INVAL) {
                    break;
                } else if(r == JSMN_ERROR_PART) {
                    break;
                } else {
                    throw std::runtime_error("Unknown error from jsmn\n");
                }
            }
            #endif
    
            receivedTweets++;
            m_msg_recv++;
        }
     };
     REGISTER_BLOCK(TweetFinder, "TweetFinder");
}
