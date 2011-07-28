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
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/

#include <Configuration.hpp>
#include <ConfigManager.hpp>

using namespace bm;

void Configuration::create_link(const std::string& from_block,const std::string& from_gate ,const std::string& to_block,const std::string& to_gate)
{
    std::map< std::string, std::shared_ptr<Block> >::iterator map_it=m_map.find(from_block);
    if(map_it==m_map.end())
        throw std::runtime_error(std::string(from_block).append(" non existent block in link"));
    std::shared_ptr<Block> src_block=map_it->second;
    OutGate& from=src_block->get_output_gate(from_gate); //throws if gate is missing
    map_it=m_map.find(to_block);
    if(map_it==m_map.end())
        throw std::runtime_error(std::string(to_block).append(" non existent block in link"));
    std::shared_ptr<Block> dst_block=map_it->second;
    InGate& to=dst_block->get_input_gate(to_gate); //throws if gate is missing
    to.connect_to(from);
    from.connect_to(to);

}
void Configuration::delete_link(const std::string& from_block,const std::string& from_gate ,const std::string& to_block,const std::string& to_gate)
{
    std::map< std::string, std::shared_ptr<Block> >::iterator map_it=m_map.find(from_block);
    if(map_it==m_map.end())
        throw std::runtime_error(std::string(from_block).append(" non existent block in link"));
    std::shared_ptr<Block> src_block=map_it->second;
    OutGate& from=src_block->get_output_gate(from_gate); //throws if gate is missing
    map_it=m_map.find(to_block);
    if(map_it==m_map.end())
        throw std::runtime_error(std::string(to_block).append(" non existent block in link"));
    std::shared_ptr<Block> dst_block=map_it->second;
    InGate& to=dst_block->get_input_gate(to_gate); //throws if gate is missing
    to.disconnect_gate(&from);
    from.disconnect_gate(&to);
}

void Configuration::__create_block(const std::string& name,const std::string& type,bool thread_safe, bool active, const xml_node & args)
{
    std::shared_ptr<Block> sp=BlockFactory::instantiate(type,name,active,thread_safe);
    if (!sp)
        throw std::runtime_error(std::string(type).append(": block type not supported"));
    sp->change_execution_mode(active, thread_safe);
    sp->configure(args);
    m_map[name]=std::move(sp);

}


/* this mechanism is not supoprted anymore
void Configuration::create_block_ref(const std::string& name,const std::string& ref,const std::string& config_id )
{

    const Configuration& c=ConfigManager::instance().get_config(config_id);

    std::map< std::string, std::shared_ptr<Block> >::const_iterator map_it=c.m_map.find(ref);
    if (map_it==c.m_map.end())
    {
        throw std::runtime_error(std::string(name).append("external block not found"));
    }
    std::shared_ptr<Block> ext_block(map_it->second);
    m_map[name]=std::move(ext_block);




} */

void Configuration::install(const xml_node& config)
{
    for (xml_node blocknode=config.child("block"); blocknode; blocknode=blocknode.next_sibling("block"))
    {
        std::string name=blocknode.attribute("id").value();
        std::string type=blocknode.attribute("type").value();
        if((name.length()==0)||(type.length()==0)) throw std::runtime_error("block name or tyoe missing");
        std::string threadpool=blocknode.attribute("threadpool").value();
        std::string sched_type=blocknode.attribute("sched_type").value();
        bool active=false;
        if(sched_type.length()>0)
        {
            active=sched_type.compare("active")==0;
            if(!active) throw std::runtime_error("sched_type val invalid");
        }

        bool thread_safe=false;
        std::string sthread_safe=blocknode.attribute("thread_safe_mode").value();
        if(sthread_safe.length()>0)
        {
            if(sthread_safe.compare("on")==0)
                thread_safe=true;
            else if(sthread_safe.compare("off")==0)
                thread_safe=false;
            else
                throw std::runtime_error("thread_safe_mode has a wrong value");
        }
        xml_node args=blocknode.child("params");
        __create_block(name,type,thread_safe,active, args);
        if(active)
        {
            if(threadpool.length()==0) throw std::runtime_error("could not find thread pool id");
            PoolManager::instance().add_to_pool(threadpool,m_map[name]);
        }
    }

    /*
    for (xml_node blockref=config.child("blockref"); blockref; blockref=blockref.next_sibling("blockref"))
    {
        std::string config_id=blockref.attribute("ext_composition_id").value();
        std::string name=blockref.attribute("local_block_id").value();
        std::string ref=blockref.attribute("ext_block_id").value();
        if((name.length()==0)||(ref.length()==0)||(config_id.length()==0))
            throw std::runtime_error("could not read referenced block parameters");
        create_block_ref( name, ref, config_id );
    } */

    for (xml_node link=config.child("connection"); link; link=link.next_sibling("connection"))
    {
        std::string from_block=link.attribute("src_block").value();
        if(from_block.length()==0) throw std::runtime_error("missing begin block in connection");
        std::string from_gate=link.attribute("src_gate").value();
        if(from_gate.length()==0) throw std::runtime_error("missing begin gate in connection");
        std::string to_block=link.attribute("dst_block").value();
        if(to_block.length()==0) throw std::runtime_error("missing dst block in connection");
        std::string to_gate=link.attribute("dst_gate").value();
        if(to_gate.length()==0) throw std::runtime_error("missing begin gate in connection");
        create_link( from_block, from_gate , to_block, to_gate);
    }

}

