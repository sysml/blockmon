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
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

#ifndef _MEMORY_BLOCK_HPP_
#define _MEMORY_BLOCK_HPP_ 


#include <iostream>
#include<Msg.hpp>

namespace bm { 

    class MemoryBlock
    { 
    public:
        MemoryBlock(size_t size)
        : m_buff(new char[size]), m_size(size), m_curr(0)//, m_ctr(1)
        {}

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


       
        ~MemoryBlock()
        {
            delete []m_buff;
        }

    private:
        char * m_buff;
        size_t m_size;
        size_t m_curr;

        
        MemoryBlock(const MemoryBlock &) = delete;
        MemoryBlock & operator=(const MemoryBlock &) = delete;

    };


    template <typename T>
    std::shared_ptr<const Msg> alloc_from_big_buffer(std::shared_ptr<MemoryBlock>& mem_block,const const_buffer<char>& buff )
    {
        char* mbuf=mem_block->reserve(buff.len()+sizeof(T));
        if(!mbuf)
        {
            mem_block.reset();
            mem_block=std::shared_ptr<MemoryBlock>(new MemoryBlock(4096*64));
            mbuf=mem_block->reserve(buff.len()+sizeof(T)); 
        }
        new (mbuf) T(buff,&*mem_block);
        return std::shared_ptr<const Msg>(mem_block,reinterpret_cast<const Msg*>(mbuf)); 
    }

    template <typename T, typename ...Ti>
    std::shared_ptr<const Msg> alloc_from_big_buffer(std::shared_ptr<MemoryBlock>& mem_block,size_t additional_space, Ti && ...arg)
    {
        char* mbuf=mem_block->reserve(sizeof(T)+additional_space);
        if(!mbuf)
        {
            mem_block.reset();
            mem_block=std::shared_ptr<MemoryBlock>(new MemoryBlock(4096*256));
            mbuf=mem_block->reserve(additional_space+sizeof(T)); 
        }
        new (mbuf) T(std::forward<Ti>(arg)...);
        return std::shared_ptr<const Msg>(mem_block,reinterpret_cast<const Msg*>(mbuf)); 
    }
} // namespace bm


#endif /* _MEMORY_BLOCK_HPP_ */
