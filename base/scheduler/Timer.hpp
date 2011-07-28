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

#ifndef _TIMER_HPP_
#define _TIMER_HPP_ 

#include <chrono>
#include <string>

#include <Block.hpp>

namespace bm { 

    class Timer
    {
    protected:
        std::chrono::system_clock::time_point m_time;
        Block& m_owner;     

        std::string m_name;
        unsigned int m_id;

    public:

        Timer(Block& b, std::chrono::system_clock::time_point tp, std::string n, unsigned int id=0)
        : m_time(tp),m_owner(b),m_name(n),m_id(id)
        {}

        virtual ~Timer()
        {}

        // noncopyable!

        Timer(const Timer &) = delete;
        Timer& operator=(const Timer &) = delete;

        std::string get_name() const
        {
            return m_name;
        }

        void set_time_point( std::chrono::system_clock::time_point tp)
        {
            m_time=tp;
        }

        std::chrono::system_clock::time_point 
        time_point() const
        {
            return m_time;
        }

        unsigned int get_id() const
        {
            return m_id;
        }

        Block& owner() const
        {
            return m_owner;
        }

        virtual std::chrono::system_clock::time_point next_time()=0;

    };

    class OneShotTimer: public Timer
    {
    public:
        OneShotTimer (Block& b, std::chrono::system_clock::time_point tp, const std::string& n, unsigned int id=0)
        : Timer(b,  tp, n, id)
        {}

        virtual ~OneShotTimer()
        {}

        std::chrono::system_clock::time_point 
        next_time()
        {
            return m_time;
        }

    };

    class PeriodicTimer: public Timer
    {
    protected:
        std::chrono::microseconds m_period;

    public:

        PeriodicTimer (Block& b,  std::chrono::system_clock::time_point tp, const std::string& n, unsigned int id, std::chrono::microseconds p)
        : Timer(b,  tp, n, id), m_period(p)
        {}

        virtual ~PeriodicTimer()
        {}

        PeriodicTimer (const PeriodicTimer& t)
        : Timer(t.m_owner,t.m_time,t.m_name,t.m_id), m_period(t.m_period)
        {}

        std::chrono::system_clock::time_point 
        next_time()
        {
            return m_time=std::chrono::system_clock::now()+m_period;
        }
    };

} // namespace bm

#endif /* _TIMER_HPP_ */
