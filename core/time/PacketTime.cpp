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

#include <PacketTime.hpp>

namespace blockmon{

/**
         * Returns the current value of the packet clock
         * @return the packet clock value
         */
       ustime_t PacketTime::get_time()
       {
           return m_packet_time.load(std::memory_order_relaxed);
       }

       /**
         * Notifies the class that a time source has been registered.
         * This should not be called directly, as it is done by the
         * constructor of PacketTimeWriter
        */
       void PacketTime::register_time_writer()
       {
           m_writers++;
       }

       /**
         * Updates the value of the packet time.
         * If the new value is smaller than the previous one, an exception is thrown.
         * If there are several potential writers, an atomic exchange is used to make this operation thread safe.
         * @param next_time the new packet time value
         */
       void PacketTime::time_past(ustime_t target_time)
       {
    	   ustime_t next_time=get_BM_time();
    	   if(next_time==0)	// first time call
    		   next_time=target_time;

    	   ustime_t last_time;

    	   /* we increase the packet time in 1ms order (same resolution as wall timer)*/
    	   do {
    		   next_time = std::min(next_time+1000, target_time);

			   if(m_writers > 1)
			   {
				   last_time = m_packet_time.exchange(next_time, std::memory_order_relaxed);
			   }
			   else if(m_writers == 1)
			   {
				   last_time = m_packet_time.load( std::memory_order_relaxed);
				   m_packet_time.store(next_time, std::memory_order_relaxed);
			   }
			   else
			   {
				   throw std::runtime_error("inconsistent number of packet time writers");
			   }

			   if( last_time > next_time){
				   throw std::runtime_error("packet time value out of order");
			   }

			   /* we must check for timer events now. Otherwise it might be that this packet
				* (which might be quite a bit in the future) is processed before long past
				* timer events are processed.
				*/

			   TimerThread::instance().process_timer_events();
    	   }while(next_time<target_time);

       }

       void PacketTimeWriter::advance_packet_time(ustime_t next_time)
	   {
		   PacketTime::instance().time_past(next_time);
	   }

}
