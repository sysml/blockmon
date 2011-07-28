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

#ifndef _CONFIGMANAGER_HPP_
#define _CONFIGMANAGER_HPP_ 

#include <Configuration.hpp>
#include <PoolManager.hpp>
#include <memory>

using namespace pugi;

namespace bm
{
    class ConfigManager
    {
        ConfigManager()
        : m_config_map()
        {}

        ~ConfigManager()
        {}

        ConfigManager(const ConfigManager &) = delete;
        ConfigManager& operator=(const ConfigManager &) = delete;

        std::map<std::string, std::shared_ptr<Configuration> > m_config_map;

    public:

        static ConfigManager& 
        instance()
        {
            static ConfigManager cm;
            return cm;
        }

        void delete_config(const std::string &configname)
        {
            std::map<std::string, std::shared_ptr<Configuration> >::iterator it;
            it=m_config_map.find(configname);
            if(it==m_config_map.end())
                throw std::runtime_error(std::string(configname).append(" : composition does not exist"));
            m_config_map.erase(it);
        }

        void add_config_from_file(const std::string & xmlfile)
        {

            xml_document _M_doc;
            xml_parse_result res = _M_doc.load_file(xmlfile.c_str());
            if (!res) {
                throw std::runtime_error(std::string("init: ").append(res.description()));
            }

            xml_node config = _M_doc.child("composition");
            if(!config)
                throw std::runtime_error("config node not found");

            std::string config_id=config.attribute("id").value();
            std::string app_id=config.attribute("app_id").value();


            xml_node install=config.child("install");
            if(install)
            {
                for(xml_node p=install.child("threadpool"); p; p=p.next_sibling("threadpool"))
                    PoolManager::instance().create_pool(p);
                std::map<std::string, std::shared_ptr<Configuration> >::iterator it;
                it=m_config_map.find(config_id);
                if(it!=m_config_map.end())
                    throw std::runtime_error(config_id.append(" : composition already exists"));
                auto it2=m_config_map.insert(std::pair<std::string, std::shared_ptr<Configuration> >(config_id,std::shared_ptr<Configuration>(new Configuration(app_id))));
                it2.first->second->install(install);

            }
            else 
            {
                throw std::runtime_error(" only installation is composition does not exists");
            }

        }


        void add_config(const std::string &configname)
        {

            std::map<std::string, std::shared_ptr<Configuration> >::iterator it;
            it=m_config_map.find(configname);
            if(it!=m_config_map.end())
                throw std::runtime_error(std::string(configname).append(" : composition already exists"));
            m_config_map.insert(std::pair<std::string, std::shared_ptr<Configuration> >(configname,std::shared_ptr<Configuration>(new Configuration(configname))));


        }




        Configuration& 
        get_config(const std::string &config_id)
        {
            std::map<std::string, std::shared_ptr<Configuration> >::iterator it;
            it=m_config_map.find(config_id);
            if(it==m_config_map.end())
                throw std::runtime_error("ConfigManager:: configuration not found");
            return *it->second;
        }	
    };

}//namespace bm

#endif /* _CONFIGMANAGER_HPP_ */
