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
 * CUSUM change detection algorithm library.
 * This library contains in other files: 
 *	- the non-parameteric CUSUM (CusumNP)
 *	- the multi-channel CUSUM (MultiCusum), which may be used with any other CUSUM class, and applies it on
 * multiple values.
 * The library may easily be extended to add other score functions (use CusumNP as example).
 */

#ifndef CUSUM_HPP
#define CUSUM_HPP

#include <memory>

namespace csm
{
    /**
     * Implements a generic CUSUM change detection on 1 value.
     * This class must be subclassed to add a score function.
     */
    class Cusum
    {
        const double m_threshold;
        double m_current_sum;

    public:
        /**
         * Constructor
         *
         * @param threshold The minimum change sum to throw an alarm
         */
        Cusum(const double threshold);

        /**
         * Destructor
         */
        virtual ~Cusum();

        /**
         * Check if the value raises an alarm
         * Depend on previous values since last reset
         *
         * @param value The value you want to watch
         * @return if an alarm just got raised
         */
        bool check(const double value);

        /**
         * Reset the change detection algorithm
         */
        void reset();

        /**
         * @return the configured threshold
         */
        double get_threshold() const;

        /**
         * Clone the object configuration (not state)
         * @return a clone of this object
         */
        virtual std::shared_ptr<Cusum> clone() const = 0;

    private:
        /**
         * Compute the score of this value.
         * May depend on previous values since last reset
         *
         * @param value the value for which the score should be computed
         * @return the score
         */
        virtual double compute_score(const double /* value */) = 0;
            
        /**
         * Reset the score computation algorithm
         */
        virtual void reset_score() = 0;
    };

}

#endif
