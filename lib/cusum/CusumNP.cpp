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

#include <CusumNP.hpp>
#include <stdio.h>

namespace csm
{
    CusumNP::CusumNP(const double threshold, const unsigned int mean_window, const double offset)
    : Cusum(threshold), m_mean_window(mean_window), m_offset(offset)
    {
        m_last_values = new double[m_mean_window];
        m_last_value_index = 0;
        m_last_values_count = 0;
    }

    CusumNP::~CusumNP()
    {
        delete[] m_last_values;
    }

    std::shared_ptr<Cusum> CusumNP::clone() const
    {
        std::shared_ptr<Cusum> cloned_cusum = std::shared_ptr<Cusum>((Cusum*) new CusumNP(get_threshold(), m_mean_window, m_offset));
        return cloned_cusum;
    }

    double CusumNP::compute_score(const double value)
    {
        // Compute the mean
        double mean;
        if (m_last_values_count > 0) {
            mean = 0;
            for (unsigned int i = 0; i < m_last_values_count; i++)
                mean+= m_last_values[i];
            mean/= m_last_values_count;
        } else {
            mean = value;
        }
        // Compute the score
        double score = value - mean - m_offset;
        // Add the current value to compute the next mean
        m_last_values[m_last_value_index] = value;
        m_last_value_index = (m_last_value_index + 1) % m_mean_window;
        if (m_last_values_count < m_mean_window)
            m_last_values_count++;
        return score;
    }

    void CusumNP::reset_score()
    {
        m_last_value_index = 0;
        m_last_values_count = 0;
    }
}
