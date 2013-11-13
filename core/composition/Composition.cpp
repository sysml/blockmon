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




#include <Composition.hpp>
#include <CompositionManager.hpp>

using namespace blockmon;


OutGate& Composition::find_output_gate( const std::string& from_block,const std::string& from_gate)
{
    auto map_it = m_map.find(from_block);
    if (map_it == m_map.end())
        throw std::runtime_error(std::string("Cannot create connection from block '").append(
                                 std::string(from_block)).append("': no such block."));
    std::shared_ptr<Block> src_block = map_it->second;
    return src_block->get_output_gate(from_gate); //throws if gate is missing
}


InGate& Composition::find_input_gate( const std::string& to_block,const std::string& to_gate)
{
    auto map_it = m_map.find(to_block);
    if (map_it == m_map.end())
        throw std::runtime_error(std::string("Cannot create connection to block '").append(
                                 std::string(to_block)).append("': no such block."));
    std::shared_ptr<Block> dst_block = map_it->second;
    return dst_block->get_input_gate(to_gate); //throws if gate is missing
}




void Composition::create_link(const std::string& from_block,const std::string& from_gate ,const std::string& to_block,const std::string& to_gate)
{
    OutGate& from = find_output_gate(from_block,from_gate);
    InGate& to = find_input_gate(to_block,to_gate);
    to.connect(from);
    from.connect(to);

}
void Composition::delete_link(const std::string& from_block,const std::string& from_gate ,const std::string& to_block,const std::string& to_gate)
{
    OutGate& from = find_output_gate(from_block,from_gate);
    InGate& to = find_input_gate(to_block,to_gate);
    to.disconnect(&from);
    from.disconnect(&to);
}

void Composition::create_block_from_parsed(const std::string& type, 
                                  const std::string& name, 
                                  invocation_type invocation, 
                                  const pugi::xml_node & blocknode)
{
    std::shared_ptr<Block> sp = BlockFactory::instantiate(type, name, invocation);
    if (!sp) {
        throw std::runtime_error(std::string(type).append(": block type not supported"));
    }
    sp->configure(blocknode);
    m_map[name] = std::move(sp);
}

/*
 * Invoke initialize method on each configured block
 */

void Composition::initialize()
{
    auto it = m_map.begin(),
         it_e = m_map.end();
    
    for(; it != it_e; ++it)
    {
        std::cout << "Composition: Initializing " << it->first << " block" << std::endl;
        it->second->initialize();
    }
}


void Composition::install(const pugi::xml_node& config)
{
    for (pugi::xml_node blocknode=config.child("block"); blocknode; blocknode=blocknode.next_sibling("block"))
    {
        std::string name = blocknode.attribute("id").value();
        std::string type = blocknode.attribute("type").value();

        if((name.length() == 0) || (type.length() == 0)){
            throw std::runtime_error("block name or type missing");
        }
        std::string threadpool=blocknode.attribute("threadpool").value();

        invocation_type invocation = invocation_type::Direct;
        
        /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
         * OLD AND BUSTED sched_type attribute
         * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
        std::string sched_type=blocknode.attribute("sched_type").value();
        if (sched_type.length() > 0) {
            if (sched_type.compare("active") == 0) {
                invocation = invocation_type::Indirect;
            } else {
                std::runtime_error("sched_type val invalid");
            }
        }

        /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
         * NEW invocation attribute (wins)
         * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
        std::string invocation_str=blocknode.attribute("invocation").value();
        if (invocation_str.length() > 0) {
            if (invocation_str.compare("direct") == 0) {
                invocation = invocation_type::Direct;
            } else if (invocation_str.compare("indirect") == 0) {
                invocation = invocation_type::Indirect;
            } else if (invocation_str.compare("async") == 0) {
                invocation = invocation_type::Async;
            } else {
                 std::runtime_error("invalid invocation type: use direct, indirect, async");
            }
        }


        create_block_from_parsed(type, name, invocation, blocknode);

        if (invocation == invocation_type::Indirect || invocation == invocation_type::Async) {
            if (threadpool.length() == 0) {
                throw std::runtime_error("need a threadpool for active/async invocation");
            }
            PoolManager::instance().add_to_pool(threadpool, m_map[name]);
        }
    }

    for (pugi::xml_node link=config.child("connection"); link; link=link.next_sibling("connection"))
    {
        std::string from_block=link.attribute("src_block").value();
        if (from_block.length() == 0) throw std::runtime_error("missing begin block in connection");
        
        std::string from_gate=link.attribute("src_gate").value();
        if (from_gate.length() == 0) throw std::runtime_error("missing begin gate in connection");
        
        std::string to_block=link.attribute("dst_block").value();
        if (to_block.length() == 0) throw std::runtime_error("missing dst block in connection");
        
        std::string to_gate=link.attribute("dst_gate").value();
        if (to_gate.length() == 0) throw std::runtime_error("missing begin gate in connection");
        
        create_link(from_block, from_gate, to_block, to_gate);
    }

    // initialize the configured blocks...
    //

    initialize();
}

