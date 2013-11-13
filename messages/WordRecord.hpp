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


#ifndef __WORDRECORD_H_
#define __WORDRECORD_H_

#include <Msg.hpp>

#include <ctime>
#include <cstring>

namespace blockmon
{
    class WordRecord : public Msg {

    protected:
        std::vector<std::string> word;

    public:

        WordRecord(std::vector<std::string> _word) : Msg(MSG_ID(WordRecord)),word(_word)  {}
        
        WordRecord() : Msg(MSG_ID(WordRecord)) {}

        virtual ~WordRecord() {}

        void add_word(std::string str)
        {
            word.push_back(str);
        }

        virtual void serialize(Serializer *ser) const;

        virtual const std::shared_ptr<Msg> build_same(Serializer *ser) const;

        virtual std::string get_message_name() const
        {
            return "WordRecord";
        }

        int get_word_number(void) const
        {
            return word.size();
        }
        
        void clear_words()
        {
            word.clear();
        }

        std::string get_word(int n) const
        {
            return word[n];
        }

        virtual std::shared_ptr<Msg> clone() const
        {
            WordRecord* new_word = new WordRecord(word);
            return std::shared_ptr<Msg>(new_word);
        }
    };
}
#endif// __WORDRECORD_H_
