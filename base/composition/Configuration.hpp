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

#ifndef _CONFIGURATION_HPP_
#define _CONFIGURATION_HPP_ 

#include <stdexcept>
#include <string>
#include <map>
#include <pugixml.hpp>
#include <iostream>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <Block.hpp>
#include <BlockFactory.hpp>


using namespace pugi;

namespace bm
{
    class Configuration
    {
        std::map< std::string, std::shared_ptr<Block> > m_map;
        const std::string app_id;
        Configuration(const Configuration&)=delete;
        Configuration& operator=(const Configuration&)=delete;

        //void __update_block(const xml_node& config);
        void __create_block(const std::string& name,const std::string& type,bool ts, bool active, const  xml_node& config);
    public:

        std::string get_appid()
        {
            return app_id;
        }
        void create_link(const std::string& from_block,const std::string& from_gate,const std::string& to_block,const std::string& to_gate);
        void delete_link(const std::string& from_block, const std::string& from_gate,const std::string& to_block,const std::string& to_gate);

        void create_block(const std::string& name,const std::string& type, bool ts, bool active,  const  std::string& config)
        {
            xml_document config_info;
            if(!config_info.load(config.c_str()))
                throw std::runtime_error("Configuration::cannot parse config info");
            xml_node blockxml=config_info.child("params");
            if(!blockxml)
                throw std::runtime_error("Configuration: cannot find params node");
            if(active&&ts)
                throw std::runtime_error("Configuration:: block cannot be active and thread safe at the same time");

            __create_block(name,type,ts,active,blockxml);


        }
        
        //void create_block_ref(const std::string& name,const std::string& ref,const std::string& config_id );	
        void delete_block(const std::string& name)
        {
            auto it=m_map.find(name);
            if(it==m_map.end())
                throw std::runtime_error("Configuration:: trying to delete non-existing block");
            m_map.erase(it);
        }

        Configuration(const std::string &a)
        : m_map(), app_id(a)
        {}

    	std::shared_ptr<Block> get_block(const std::string& b)
        {
            auto it=m_map.find(b);
            if(it==m_map.end())
                throw std::runtime_error("Configuration:: requested non-existing block");
            return it->second;
        }

	

        void install(const xml_node& config);
        void update(const xml_node& config)
        {
        }
    };

}//end namespace


#endif /* _CONFIGURATION_HPP_ */
