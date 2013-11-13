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

#ifndef _CORE_TIME_PACKETTIME_HPP_
#define _CORE_TIME_PACKETTIME_HPP_
/**
  * @file 
  *
  * This file implements the mechanism for tracking and incrementing
  * the packet based time source It consists of two classes:
  * PacketTime is a singleton entity keeping the unique value of the
  * packet time, PacketTimeWriter is a proxy class that each of the
  * blocks incrementing the packet time has to instantiate.  The
  * purpose for that is letting the singleton object know how many
  * possible writers to the time value are present.
  */ 

#include<NetTypes.hpp>

#include<algorithm>
#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include<stdexcept>
#include <TimerThread.hpp>

namespace blockmon
{
//	class TimerThread;// forward declaration

    class PacketTime
    {
    private:
        std::atomic_ullong m_packet_time;
        unsigned int m_writers;

        PacketTime():
        m_packet_time(0),
        m_writers(0)
        {}

        /** Forbids copy and move constructors.
	 */
        PacketTime(const PacketTime&) = delete;

        /** Forbids copy and move assignments.
	 */
        PacketTime& operator = (const PacketTime&) = delete;


    public:

        /**
          * Returns the current value of the packet clock
          * @return the packet clock value
          */
        ustime_t get_time();


        /**
          * Returns the unique instance of this class.
          *
          * @return the unique instance of this class
          */
	   static PacketTime& instance()
	   {
		   static PacketTime the_time;
		   return the_time;
	   }

        /**
          * Notifies the class that a time source has been registered.
          * This should not be called directly, as it is done by the
          * constructor of PacketTimeWriter
         */
        void register_time_writer();

        /**
          * Updates the value of the packet time.
          * If the new value is smaller than the previous one, an exception is thrown.
          * If there are several potential writers, an atomic exchange is used to make this operation thread safe.
          * @param next_time the new packet time value
          */
        void time_past(ustime_t next_time);

    }; 


    /**
      * This is a proxy class that every packet clock source should create
      * Updates to the packet clock value should always be proxied by an instance of this class
      */
    class PacketTimeWriter
    {
    public:
        /**
          * constructor of the proxy class, just notifies the singleton instance that another clock source is present
          */
        PacketTimeWriter()
        {
            PacketTime::instance().register_time_writer();
        }

        /**
          * updates the packet clock time (just forwards the call to the singleton instance)
          * @param next_time the new value of the packet clock
          */
        void advance_packet_time(ustime_t next_time);

    };

}

#endif // _CORE_TIME_PACKETTIME_HPP_
