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
 * <blockinfo type="CDFGenerator" invocation="both" thread_exclusive="false">
 *   <humandesc>
 *       Implements a block that prints the Cumulative Distribution Function
 *       (CDF) of the packet size every interval, adding a noise depending on
 *       the epsilon value. Configuration parameters allow to tune the
 *       endpoints of the CDF, the bin width and to add noise.
 *   </humandesc>
 *
 *   <shortdesc>Prints the CDF of packet sizes for a given interval</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element cdf_build {
 *               attribute interval {xsd:integer}
 *           }
 *      element cdf_param{
 *           attribute min {xsd:integer}
 *           attribute max {xsd:integer}
 *           attribute bin {xsd:integer}
 *           }
 *      element diff_priv{
 *           attribute epsilon {xsd:float}
 *           }
 *       }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *            <build_cdf interval="2000"/> #millisecond
 *            <cdf_param min="0" max="1500" bin="150"/>
 *            <diff_priv epsilon="0.8"/> #if -1 do not add noise
 *       </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */
#include <CDFGenerator.hpp>

namespace blockmon
{
    //set all values in histogram to zero
    static void histoSetZero(std::vector<int>& histo, int min, int max, int bin){
        int values_num = floor(((float)max-min)/bin);
       
        histo.assign(values_num,0);
    }


    void CDFGenerator::_configure(const pugi::xml_node& n ){
        //set interval
        pugi::xml_node source=n.child("build_cdf");
        unsigned int interval=source.attribute("interval").as_uint();
        set_periodic_timer(interval * 1000,"test",0);

        //set max, min and bin
        source=n.child("cdf_param");
        m_min=source.attribute("min").as_uint();
        m_max=source.attribute("max").as_uint();
        m_bin=source.attribute("bin").as_uint();

        //set epsilon
        source=n.child("diff_priv");
        m_epsilon=source.attribute("epsilon").as_double();

        histoSetZero(m_histo, m_min, m_max, m_bin);
        histoSetZero(m_cdf, m_min, m_max, m_bin);
    }


    void CDFGenerator::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */){
        if(m->type() != MSG_ID(Packet)) throw std::runtime_error("CDFGenerator: unexpected msg type");
        const Packet* packet = static_cast<const Packet*>(m.get());

        //update histogram with the received value
        int pkt_size = packet->length();
        if (pkt_size >= m_min && pkt_size <= m_max)
             m_histo[(pkt_size - m_min) / m_bin]++;
    }


    //extract a sample from a Laplace distribution
    static double nextLaplace(double mu, double stddev){
        double num = rand();
        num /= RAND_MAX;

        if (num <= 0.5)
           num = log ( 2 * num );
        else
           num = -log ( 2 * (1-num) );

        return stddev * num + mu;
    }

    //build differentially private noisy cdf
    static void cdf_computation(std::vector<int>& histo, std::vector<int>& cdf, double epsilon){
        unsigned int i;
        
        for (i=0; i<histo.size(); i++){

           if (i == 0)
              cdf[i] = histo[i];
           else
              cdf[i] = cdf[i-1] + histo[i];

           if (epsilon > 0)  //add noise
                cdf[i] += round(nextLaplace(0,sqrt(2)/epsilon));
           }
                
    }

    void CDFGenerator::_handle_timer(std::shared_ptr<Timer>&& ){
        unsigned int i;
        std::stringstream out;
 
        cdf_computation(m_histo, m_cdf, m_epsilon);

        out << "cdf is: ";
        for (i=0; i<m_histo.size(); i++)       
              out << m_cdf[i] << "\t" ;

        out << "\t\t";
        blocklog(out.str(), log_info);

        histoSetZero(m_histo, m_min, m_max, m_bin);
    }



} // namespace blockmon
