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
 * Multiple CUSUM: watch a list of values instead of only one.
 * Use a Cusum child class.
 * A change is detected if one of the values in the list changes strongly.
 */

#ifndef MULTI_CUSUM_HPP
#define MULTI_CUSUM_HPP

#include <Cusum.hpp>

#include <memory>

namespace csm
{
    /**
     * Implement a multiple CUSUM change detection.
     * Work with a Cusum class.
     */
    class MultiCusum
    {
        std::shared_ptr<Cusum>* m_cusum;
        const int m_count;

    public:
        /**
         * Constructor
         *
         * @param cusum a CUSUM object configured to watch one variable
         * @param count the number of variables to watch
         */
        MultiCusum(std::shared_ptr<Cusum> cusum, int count);

        /**
         * Destructor
         */
        ~MultiCusum();

        /**
         * Check if one of the values raises an alarm
         * Depend on previous values since last reset
         *
         * @param value The values you want to watch
         * @return -1 if no alarm got raised, the index of the value which raised it otherwise
         */
        int check(const double* value);

        /**
         * Check if one of the values raises an alarm
         * Depend on previous values since last reset
         *
         * @param value The values you want to watch
         * @return -1 if no alarm got raised, the index of the value which raised it otherwise
         */
        int check(const int* value);

        /**
         * Reset the change detection algorithm
         */
        void reset();
    };

}

#endif
