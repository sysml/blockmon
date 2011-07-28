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

#ifndef _BUFFER_HPP_
#define _BUFFER_HPP_ 

#include <utility>

namespace bm { 

    // this is a basic buffer implementation, ala boost. Nicola
    //

    template <typename Tp>
    struct mutable_buffer
    {
        mutable_buffer()
        : m_addr(0), m_len(0)
        {}

        mutable_buffer(Tp *a, size_t l)
        : m_addr(a), m_len(l)
        {}

        const Tp *
        addr() const
        {
            return m_addr;
        }

        Tp *
        addr()
        {
            return m_addr;
        }

        size_t
        len() const
        {
            return m_len;
        }

	void change_buff(Tp* naddr, size_t nlen)
	{
		m_addr=naddr;
		m_len=nlen;
	}

    private:
        Tp       *m_addr;
        size_t      m_len; 

    };

    template <typename Tp>
    struct const_buffer
    {
        const_buffer()
        : m_addr(0), m_len(0)
        {}

        const_buffer(const Tp *a, size_t l)
        : m_addr(a), m_len(l)
        {}

        const_buffer(const mutable_buffer<Tp> &other)
        : m_addr(other.addr()), m_len(other.len())
        {}

        const Tp *
        addr() const
        {
            return m_addr;
        }

        size_t
        len() const
        {
            return m_len;
        }
	void change_buff(Tp* naddr, size_t nlen)
	{
		m_addr=naddr;
		m_len=nlen;
	}

    private:
        const Tp *m_addr;
        size_t      m_len; 
    };

} // namespace bm

#endif /* _BUFFER_HPP_ */
