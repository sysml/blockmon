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

#ifndef _CORE_MESSAGE_MEMORYBATCH_HPP_
#define _CORE_MESSAGE_MEMORYBATCH_HPP_
#include <iostream>
#include <Msg.hpp>

#if !defined(USE_SIMPLE_PACKET) && !defined(USE_SLICED_PACKET)

// FIXME this class is replaced by SliceAllocator class


namespace blockmon { 

  /**
   * Basic class and methods for handling batch allocations.
   *
   * This should only work with messages providing a memory_not_owned
   * constructor (e.g. RawPacket).  An object of this class allocates
   * a big buffer where messages can be created in-place through the
   * alloc_msg_from_buffer() function.
   *
   * Notice that an object of this class should never be statically
   * allocated. On the contrary it MUST be dynamically allocated and
   * owned by a shared_ptr. When the buffer is full, the
   * alloc_msg_from_buffer() function releases its ownership and
   * automatically allocates a new object. Messages within the buffer
   * are handled through shared pointers (the C++0x alias constructor
   * semantic is used). Whenever the last pointer to a message in the
   * buffer is released, the whole buffer is automatically freed. For
   * an example of the usage of this mechanism refer to Sniffer.cpp.
   */
    class MemoryBatch
    { 
    public:
        /**
         * class constructor
         * @param size size of the big buffer to be allocated
         */

        MemoryBatch(size_t size)
        : m_buff(new char[size]), m_size(size), m_curr(0)
        {}

        /**
          * this is the only function which is allowed to work with this object
         */
        template <typename T, typename ...Ti>
        friend
        std::shared_ptr<const Msg> 
        alloc_msg_from_buffer(std::shared_ptr<MemoryBatch>& mem_block, size_t additional_space, Ti && ...arg);

        /**
         * class destructor: actually deallocates the buffer
         * it is only call when the shared pointers to all of the internal messages have been released
         */

        ~MemoryBatch()
        {
            delete []m_buff;
        }


        /** Forbids copy and move constructors.
	 */          
        MemoryBatch(const MemoryBatch &) = delete;
        
        /** Forbids copy and move assignment.
	 */          
        MemoryBatch & operator=(const MemoryBatch &) = delete;
        

    private:
        char *
        addr()
        {
            return m_buff;
        }

        const char *
        addr() const
        {
            return m_buff;
        }

        char *
        reserve(size_t size)
        {
            size_t curr = m_curr;
            if (curr+size > m_size) {
                return NULL;
            }
            m_curr+=size;
            return m_buff + curr; 
        }

        char * m_buff;
        size_t m_size;
        size_t m_curr;

    };

    /**
    *  this functions builds a message within the big buffer and returns a shared pointer to it
    *  @param T the message type
    *  @param Ti all of the arguments to the specific class constructor. 
    *  @param mem_block the shared pointer to the MemoryBatch object which will store the message
    *  @param additional_space the additional buffer the message needs (besides the class instance itself). This may the size of the packet buffer, as in Packet
    */  
    template <typename T, typename ...Ti>
    std::shared_ptr<const Msg> 
    alloc_msg_from_buffer(std::shared_ptr<MemoryBatch>& mem_block, size_t additional_space, Ti && ...arg)
    {
        char * mbuf = mem_block->reserve(sizeof(T) + additional_space);
        if(!mbuf)
        {
            mem_block.reset();
            mem_block = std::make_shared<MemoryBatch>(4096*256);
            mbuf = mem_block->reserve(additional_space + sizeof(T)); 
        }
        new (mbuf) T(blockmon::memory_not_owned, sizeof(T), std::forward<Ti>(arg)...);
        return std::shared_ptr<const Msg>(mem_block,reinterpret_cast<const Msg*>(mbuf)); 
    }

} // namespace blockmon

#endif

#endif // _CORE_MESSAGE_MEMORYBATCH_HPP_
