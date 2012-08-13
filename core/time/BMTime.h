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


/**
  * @file Simple interface to access blockmon clock value.
  *
  * This makes the source of the clock (packets or wall clock) transparent to the rest of the system
  * The clock source is the wall clock by default.
  * Blockmon code, in principle, should not use the wall clock directly
  */


#include<PacketTime.hpp>

#ifndef _CORE_TIME_BMTIME_H_
#define _CORE_TIME_BMTIME_H_



namespace blockmon
{

    enum clock_source_t {WALL, PACKET, UNSET};
    
    extern clock_source_t clock_source;    

    /**
      * selects the clock source
      * @param val the clock source
      */
    void select_clock(clock_source_t val );

    /**
      * read-only accessor to the clock source
      * @retunr the clock source
      */
    inline clock_source_t blockmon_clock_source()
    {
        return clock_source;
    }


    /**
      * gets the current value of the blockmon clock (whatever the source)
      * @return the actual clock value expressed in the standard BM format (time since epoch in microseconds)
      */
    ustime_t get_BM_time();

}

#endif /* _CORE_TIME_BMTIME_H_ */

