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

#ifndef _TWITTERTRENDING_WORDCOUNTER_HPP_
#define _TWITTERTRENDING_WORDCOUNTER_HPP_
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <cstdio>
#include <WordRecord.hpp>
#include <map>

#define MAX_SIZE 10

namespace blockmon
{

    /**
     * Implements a block that counts the words.
     */
    class WordCounter: public Block
    {
    private:
        unsigned long long  m_word_cnt;
        int m_msg_recv;
        unsigned int m_reset;
        uint32_t m_msg_type;
        int m_ingate_id;
        std::map<const std::string,unsigned long long> words[MAX_SIZE];

        struct timeval lasttime;
        long receivedMessages;
        long receivedTuple;
    public:

        /**
         * @brief Constructor
         * @param name         The name of the packet counter block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async)
         */
        WordCounter(const std::string &name, invocation_type invocation) 
        : Block(name, invocation), 
        m_ingate_id(register_input_gate("in_word")),
        receivedMessages(0),
        receivedTuple(0)
        {
            m_reset = 0;
            m_word_cnt = 0;
            m_msg_type = type_to_id<WordRecord>::id();
            register_variable("wordcnt",make_rd_var(no_mutex_t(), m_word_cnt));
            register_variable("reset",make_wr_var(no_mutex_t(), m_reset));
        }

        /**
         * @brief Destructor
         */
        ~WordCounter()  {}

        /**
         * @brief Configures the block.
         * @param n The configuration parameters 
         */
        void _configure(const pugi::xml_node&  n ) 
        {}


        /**
         * @brief Initialize the block
         */
        void _initialize() 
        {}

        /**
         * If the message received is not of type RawPacket throw an exception,
         * otherwise count it
         * @param m     The message
         * @param index The index of the gate the message came on
         */
        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
           receivedTuple++;
            if(m->type() != m_msg_type) {
                throw std::runtime_error("WordCounter::wrong message type");
            }

            const WordRecord* msg_ptr = static_cast<const WordRecord *>(m.get()); 
            int idx = 0;
            assert(idx>=0 && idx < MAX_SIZE);
            for(int i = 0; i < msg_ptr->get_word_number(); i++) {
                receivedMessages++;
                std::map<const std::string,unsigned long long>::iterator it;
                if( (it = words[idx].find( msg_ptr->get_word(i))) != words[idx].end() ) {
                    it->second++;
                } else {
                    words[idx].insert( std::pair<const std::string,unsigned long long>(msg_ptr->get_word(i),1) );
                }
            }
            m_msg_recv++;
        }
    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(WordCounter,"WordCounter");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}//blockmon
#endif // _TWITTERTRENDING_WORDCOUNTER_HPP_
