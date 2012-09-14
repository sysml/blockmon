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

#ifndef _SERIALIZER_H_
#define _SERIALIZER_H_

#include <string>

#include <BufferSerializer.hpp>

namespace blockmon {
    class Serializer {
    private:
        BufferSerializer serbuffer;
    public:
        Serializer()
        {
            reset();
        }

        void reset()
        {
            serbuffer.reset();
            serbuffer.put(2);
        }

        void empty()
        {
            serbuffer.reset();
        }

        void add_int16(int value)
        {
            serbuffer.put_int16(value);
        }

        void consume(int offset)
        {
            serbuffer.consume(offset);
        }

        int read_int16()
        {
            return serbuffer.get_int16(0);
        }

        int get_int16()
        {
            return serbuffer.consume_int16();
        }

        void add_int32(int value)
        {
            serbuffer.put_int32(value);
        }

        int get_int32()
        {
            return serbuffer.consume_int32();
        }

        void add_int64(long value)
        {
            serbuffer.put_int64(value);
        }

        long get_int64()
        {
            return serbuffer.consume_int64();
        }

        void add_data(char *data, int datalen)
        {
            serbuffer.put_data(data, datalen);
        }

        int get_data(char *dstbuffer, int dstbuffer_maxlen)
        {
            return serbuffer.consume_all_data(dstbuffer, dstbuffer_maxlen);
        }

        std::string get_string()
        {
            return serbuffer.consume_all_data_into_string();
        }

        int get_len()
        {
            return serbuffer.len();
        }

        int finalize(char **buf)
        {
            serbuffer.set_int16(serbuffer.len(), 0);
            *buf = serbuffer.data();
            return serbuffer.len();
        }

        // this should be refactored to avoid memmove for every segment
        void next()
        {
            serbuffer.compact();
        }

        void add_raw_data(char *data_bytes, int data_len)
        {
            serbuffer.put_raw_data(data_bytes, data_len);
        }
    };
}
#endif // _SERIALIZER_H_
