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

#include <stdlib.h>
#include <math.h>

#include <RRDemux.hpp>
#include <stdio.h>

namespace blockmon
{
    RRDemux::RRDemux(const std::string &name, invocation_type invocation) 
    : Block(name, invocation_type::Direct),
     m_outgates_number(2), m_current_outgate(0)
    {
		register_input_gate("input");
        if (invocation != invocation_type::Direct) {
            blocklog("SynCounter must be direct; ignoring configuration.", log_warning);
        }
	}
	
    RRDemux::~RRDemux()
    {}
	
    void RRDemux::_configure(const pugi::xml_node& n)
    {
        // XML configuration
		// Gates
       pugi::xml_node gates_node = n.child("gates");
        if (gates_node)
        {
		    if (gates_node.attribute("number"))
		        m_outgates_number = std::atoi(std::string(gates_node.attribute("number").value()).c_str());
		}
        // Register the gates
		char output_name[7 + (int) ceil(log10(m_outgates_number))];
		for (int i = 0; i < m_outgates_number; i++) {
			sprintf(output_name, "output%d", i + 1);
			register_output_gate(output_name);
		}
    }

    void RRDemux::_receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
    {
		// Send the message through the current gate
		send_out_through(move(m), m_current_outgate);
		// Update the current gate
        m_current_outgate++;
		if (m_current_outgate >= m_outgates_number)
			m_current_outgate = 0;
    }
}
