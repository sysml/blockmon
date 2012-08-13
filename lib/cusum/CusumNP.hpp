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
 * Non-parametric CUSUM change detection algorithm.
 */

#ifndef CUSUM_NP_HPP
#define CUSUM_NP_HPP

#include <Cusum.hpp>
#include <memory>

namespace csm
{
    /**
     * Implements the non-parametric CUSUM change detection on 1 value.
     * Does not require the value distribution before and after change.
     */
    class CusumNP: Cusum
    {
        const unsigned int m_mean_window;
        const double m_offset;
        
        double* m_last_values;
        unsigned int m_last_value_index;
        unsigned int m_last_values_count;

    public:
        /**
         * Constructor
         *
         * @param threshold The minimum sum to throw an alarm
         * @param mean_window Number of last values with which the mean should be evaluated
         * @param offset Value to add to the difference in the score computation
         */
        CusumNP(const double threshold, const unsigned int mean_window, const double offset);

        /**
         * Destructor
         */
        ~CusumNP() ;

        /**
         * Clone the object configuration (not state)
         * @return a clone of this object
         */
        std::shared_ptr<Cusum> clone() const ;

    private:
        /**
         * Compute the score of this value.
         * Depend on previous values since last reset
         *
         * @param value the value for which the score should be computed
         * @return the score
         */
        double compute_score(const double value) ;
            
        /**
         * Reset the score computation algorithm
         */
        void reset_score() ;
    };

}

#endif
