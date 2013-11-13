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

#ifndef _CORE_TIME_TIMER_HPP_
#define _CORE_TIME_TIMER_HPP_
/** @file
 *
 * Here the different timer objects are implemented Such objects are
 * intended to be created by a block and activated by the
 * timer-related methods in the Block superclass (set_timer_at and
 * set_periodic_timer). When a timer expires, it is returned to the
 * block which scheduled it through its handle_timer method.
  */

#include <string>
#include <BMTime.h>

#include <Block.hpp>

namespace blockmon { 

    /**
      * Timer virtual base class.
      *
      * Timers are always handled via this interface
      */
    class Timer
    {
    protected:
        ustime_t m_time;
        Block& m_owner;     

        std::string m_name;
        unsigned int m_id;

    public:
        /**
          * Base class constructor
          * @param b reference to the block the timer is associated with
          * @param tp the absolute time point when the timer is supposed to expire
          * @param n the timer name (can be used by the block in order to distinguish among different timeout events)
          * @param id an (optional) block-scoped timer identifier (can be used by the block in order to distinguish among different timeout events)
          */

        Timer(Block& b, ustime_t tp, std::string n, unsigned int id=0):
        m_time(tp),
        m_owner(b),
        m_name(n),
        m_id(id)
        {}

        virtual ~Timer()
        {}

        /**
          * This object is non copiable and non moveable
          */
        Timer(const Timer &) = delete;
        Timer& operator=(const Timer &) = delete;
        Timer(Timer &&) = delete;
        Timer& operator=( Timer &&) = delete;

        /**
          * @return the timer object name
          */
        std::string get_name() const
        {
            return m_name;
        }

        /**
          * resets the expiration time for this timer
          * @param tp the new expiration time point
         */ 
        void set_time_point( ustime_t tp)
        {
            m_time = tp;
        }

        /**
          * @return the timer's expiration time point
          */
        ustime_t 
        time_point() const
        {
            return m_time;
        }

        /**
          * @return the timer's block-scoped id
          */
        unsigned int get_id() const
        {
            return m_id;
        }

        /**
          * @return a reference to the block this timer is associated with
         */ 
        Block& owner() const
        {
            return m_owner;
        }

        /**
          * pure virtual method which has to be implemented by the derived class
          * It is called after the timer has expired in order to reschedule it
          * @return the new expiration time. If this equals the previous one the timer is not rescheduled.
         */ 
        virtual ustime_t next_time() = 0;

    };

    /**
      * Derived class for one-shot timers.
      * These timers are only meant to be executed once
      */
    class OneShotTimer: public Timer
    {
    public:
        /**
          * Class constructor
          * @param b reference to the block the timer is associated with
          * @param tp the absolute time point when the timer is supposed to expire
          * @param n the timer name (can be used by the block in order to distinguish among different timeout events)
          * @param id an (optional) block-scoped timer identifier (can be used by the block in order to distinguish among different timeout events)
          */
        OneShotTimer (Block& b, ustime_t tp, const std::string& n, unsigned int id=0)
        : Timer(b,  tp, n, id)
        {}

        virtual ~OneShotTimer()
        {}

        /**
          * Implementation of the base class virtual method
          * @return the same time point when the timer expired. This causes the timer not to be rescheduled.
          */
        ustime_t 
        next_time()
        {
            return m_time;
        }

    };

    /**
      * Derived class for one-shot timers.
      * These timers are automatically rescheduled after expiration
      */
    class PeriodicTimer: public Timer
    {
    protected:
        ustime_t m_period;

    public:

        /**
          * Class constructor
          * @param b reference to the block the timer is associated with
          * @param tp the absolute time point when the timer is supposed to expire for the first time
          * @param n the timer name (can be used by the block in order to distinguish among different timeout events)
          * @param id a block-scoped timer identifier (can be used by the block in order to distinguish among different timeout events)
          * @param p the time interval between two consecutive timer executions (in microseconds) 
          */
        PeriodicTimer (Block& b,  ustime_t tp, const std::string& n, unsigned int id, ustime_t p)
        : Timer(b,  tp, n, id), m_period(p)
        {}

        virtual ~PeriodicTimer()
        {}

    // FIXME check whether this method is needed    
    //    PeriodicTimer (const PeriodicTimer& t)
    //    : Timer(t.m_owner,t.m_time,t.m_name,t.m_id), m_period(t.m_period)
    //    {}

        /**
          * Implementation of the base class virtual method
          * @return the next time point when this timer will fire. This equals the last scheduled execution time point plus the period
          */
        ustime_t 
        next_time()
        {
            return m_time = get_BM_time() + m_period;
        }
    };

} // namespace blockmon

#endif // _CORE_TIME_TIMER_HPP_
