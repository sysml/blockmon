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

#ifndef _BUFFER_H
#define _BUFFER_H

#include <string>
#include <arpa/inet.h>

#define MESSAGE_MAX_DATA 65536



namespace blockmon {
    class BufferSerializer {
    public:
        /**
         * Remove data from the buffer.
         */
        void reset()
        {
            bf.head = bf.data = bf.tail = bf.buf;
            bf.end = bf.buf + MESSAGE_MAX_DATA;
        }

        /**
         * Move data at head.
         */
        void compact()
        {
            int len = bf.tail - bf.data;
            memmove(bf.head, bf.data, len);
            bf.data = bf.head;
            bf.tail = bf.data + len;
        }

        /**
         * Advance tail of the given offset.
         * @param offset The offset.
         */
        void put(int offset)
        {
            assert(bf.tail + offset <= bf.end);
            bf.tail += offset;
        }

        /**
         * Advance data of the given offset.
         * @param offset The offset.
         */
        void consume(int offset)
        {
            assert(bf.head + offset <= bf.tail);
            bf.data += offset;
        }

        /**
         * Add 32-bit integer value at the end of the buffer and advance it.
         * @param val The 32-bit integer value.
         */
        void put_int32(int val)
        {
            assert(bf.tail + 4 <= bf.end);
            uint32_t *tmp = (uint32_t*) (bf.tail);
            *tmp = htonl( (uint32_t) val );
            bf.tail += 4;
        }
        
        /**
         * Add 64-bit integer value at the end of the buffer and advance it.
         * @param val The 64-bit integer value.
         */
        void put_int64(long val)
        {
            assert(bf.tail + 8 <= bf.end);
            uint64_t *tmp = (uint64_t*) (bf.tail);
            *tmp = htonll( (uint64_t) val );
            bf.tail += 8;
        }

        /**
         * Add 16-bit integer value at the end of the buffer and advance it.
         * @param val The 16-bit integer value.
         */
        void put_int16(int val)
        {
            assert(bf.tail + 2 <= bf.end);
            uint16_t *tmp = (uint16_t*) (bf.tail);
            *tmp = htons( (uint16_t) val );
            bf.tail += 2;
        }

        /**
         * Add raw data in the buffer.
         * @param data_bytes The raw data to add.
         * @param data_len The length of the data.
         */
        void put_raw_data(char *data_bytes, int data_len)
        {
            assert(bf.tail + data_len <= bf.end);
            memcpy(bf.tail , data_bytes, data_len);
            bf.tail += data_len;
        }

        /**
         * Add data and its length in the buffer.
         * @param data_bytes The raw data to add.
         * @param data_len The length of the data.
         */
        void put_data(char *data_bytes, int data_len)
        {
            put_int16(data_len );
            put_raw_data(data_bytes, data_len );
        }

        /**
         * Fetch 32-bit integer value at the head and advance head.
         * @return A 32-bit integer value.
         */
        int consume_int32()
        {
            assert(bf.data + 4 <= bf.tail);
            uint32_t *tmp = (uint32_t*) (bf.data);
            bf.data += 4;
            return (int) ntohl(*tmp);
        }

        /**
         * Fetch 64-bit integer value at the head and advance head.
         * @return A 64-bit integer value.
         */
        long consume_int64()
        {
            assert(bf.data + 8 <= bf.tail);
            uint64_t *tmp = (uint64_t*) (bf.data);
            bf.data += 8;
            return (long) ntohll(*tmp);
        }

        /**
         * Fetch 16-bit integer value at the head and advance head.
         * @return A 16-bit integer value.
         */
        int consume_int16()
        {
            assert(bf.data + 2 <= bf.tail);
            uint16_t *tmp = (uint16_t*) (bf.data);
            bf.data += 2;
            return (int) (int16_t) ntohs(*tmp);
        }

        /**
         * Fetch raw data from the buffer.
         * @param data_buffer The buffer where to store the raw data.
         * @param data_len The length of the data.
         */
        void consume_raw_data(char *data_buffer, int data_len)
        {
            assert(bf.data + data_len <= bf.tail);
            memcpy(data_buffer, bf.data, data_len);
            bf.data += data_len;
        }

        /**
         * Fetch all data from the buffer.
         * @param data_buffer The buffer where to store the raw data.
         * @param data_len The length of the data.
         * @return The length of read data. 
         */
        int consume_all_data(char *data_buffer, int max_data_len)
        {
            int data_raw_len = consume_int16();
            assert(data_raw_len <= max_data_len);
            consume_raw_data(data_buffer, data_raw_len);
            return data_raw_len;
        }

        /**
         * Consume data and store it into string.
         * @return The string
         */
        std::string consume_all_data_into_string()
        {
            int data_raw_len = consume_int16();
            std::string str(bf.data, data_raw_len);
            bf.data += data_raw_len;
            return str;
        }

        /**
         * Set a 16-bit integer value at given offset.
         * @param val The value.
         * @param offset The offset.
         */
        void set_int16(int val, int offset)
        {
            int len = bf.tail - bf.data;
            assert(offset >= 0 && offset + 2 <= len);
            uint16_t *tmp = (uint16_t*) (bf.data + offset);
            *tmp = htons((uint16_t) val);
        }

         /**
          * Get a 16-bit integer value at given offset.
          * @param offset The offset.
          * @return The value.
          */
        int get_int16(int offset)
        {
            int len = bf.tail - bf.data;
            assert(offset >= 0 && offset + 2 <= len);
            uint16_t *tmp = (uint16_t*) (bf.data + offset);
            return (int) (int16_t) ntohs(*tmp);
        }

        /**
         * Return the buffer length.
         * @return The length.
         */
        int len()
        {
            return bf.tail - bf.data;
        }

        /**
         * Return a pointer to data.
         * @return The pointer.
         */
        char* data()
        {
            return bf.data;
        }    
        
    private:
        long ntohll(long val) {
            // We keep using long, makes no difference if everything is in the CPU
            long a = val & 0xFFFFFFFF;
            long b = (val >> 32) & 0xFFFFFFFF;
            return (a << 32) | b;
        }

        long htonll(long val)
        {
            return ntohll(val);
        }

        struct InternalBuffer {
            char buf[MESSAGE_MAX_DATA];
            char *head;
            char *data;
            char *tail;
            char *end;
        } bf;
    };
} // namespace blockmon
#endif // _BUFFER_H