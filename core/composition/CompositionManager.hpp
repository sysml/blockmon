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

#ifndef _CORE_COMPOSITION_COMPOSITIONMANAGER_HPP_
#define _CORE_COMPOSITION_COMPOSITIONMANAGER_HPP_
#include <memory>
#include <algorithm>

#include <Composition.hpp>
#include <PoolManager.hpp>


namespace blockmon
{
/**
  * Singleton directory of the installed compositions.
  *
  * It provides an entry point both for the python bindings and the
  * C++ interface.  It is used in order to create, delete and access
  * the installed compositions.
  */

    class CompositionManager
    {
        /**
          * class constructor
          * private,as in Meyer's singleton
          */
        CompositionManager()
        : m_config_map()
        {}

        ~CompositionManager()
        {}

        /**
          * this object is non-moveable and non-copyable
          */
        CompositionManager(const CompositionManager &) = delete;
        CompositionManager& operator=(const CompositionManager &) = delete;
        CompositionManager(CompositionManager &&) = delete;
        CompositionManager& operator=(CompositionManager &&) = delete;

        std::map<std::string, std::shared_ptr<Composition> > m_config_map;

    public:
        /**
          * unique instance accessor as in Meyer's singleton
          * @return a reference to the only instance of this class
          */
        static CompositionManager& 
        instance()
        {
            static CompositionManager cm;
            return cm;
        }


        /**
          * Exposed by the python bindings.
          * Delete a composition from the directory
          * Notice that external connections among different compositions have to be explicitly deleted.
          * @param name composition name
          */
        void delete_composition(const std::string &name)
        {
            auto it = m_config_map.find(name);
            if(it == m_config_map.end())
                throw std::runtime_error(std::string(name).append(" : composition does not exist"));
            m_config_map.erase(it);
        }

        /**
          * Exposed by the python bindings.
          * Creates an empty composition in the directory.
          * @param name composition name
          */
        void add_composition(const std::string &name)
        {

            std::map<std::string, std::shared_ptr<Composition> >::iterator it;
            it = m_config_map.find(name);
            if(it != m_config_map.end())
                throw std::runtime_error(std::string(name).append(" : composition already exists"));
            m_config_map.insert(std::make_pair( name, std::shared_ptr<Composition>(new Composition(name))));
        }

        /**
         * Used by the python bindings to call initialize() on all
         * blocks in a composition
         * @param composition_id the name of the composition
         */
		void init_composition(const std::string &composition_id)
		{
            auto it = m_config_map.find(composition_id);
            if(it == m_config_map.end())
                throw std::runtime_error("CompositionManager:: composition not found");
            it->second->initialize();
		}

        /**
          * Exposed by the python bindings.
          * Used to access one of the compositions in the directory.
          * @param composition_id the name of the compositions
          * @return reference to the composition  
          */ 

        Composition& 
        get_composition(const std::string &composition_id)
        {
            auto it = m_config_map.find(composition_id);
            if(it == m_config_map.end())
                throw std::runtime_error("CompositionManager:: composition not found");
            return *(it->second);
        }

        /**
          * Only entry point for the c++ interface
          * It creates a composition in the directory directly from an xml file.
          * @param xmlfile name of the file where the xml describing the composition is contained
          */ 
        void add_config_from_file(const std::string & xmlfile)
        {

            pugi::xml_document _M_doc;
            pugi::xml_parse_result res = _M_doc.load_file(xmlfile.c_str());
            if (!res) {
                throw std::runtime_error(std::string("init: ").append(res.description()));
            }

           pugi::xml_node config = _M_doc.child("composition");
            if(!config)
                throw std::runtime_error("composition node not found");

            std::string composition_id = config.attribute("id").value();
            std::string app_id = config.attribute("app_id").value();

			pugi::xml_node general = config.child("general");
			if(general==NULL){
				throw std::runtime_error(std::string("init: ").append("No <general> tag found in composition XML"));
			}
			pugi::xml_node clock = general.child("clock");
			if(clock==NULL){
				throw std::runtime_error(std::string("init: ").append("No <clock> tag found within <general> tag in composition XML"));
			}
			auto clocktypeAttr = clock.attribute("type");
			if(clocktypeAttr==NULL){
				throw std::runtime_error(std::string("init: ").append("No 'type' attribute within <clock> tag found"));
			}
			auto clocktype=std::string(clocktypeAttr.value());
			if(clocktype.compare("wall")==0 || clocktype.compare("WALL")==0){
				select_clock(WALL);
			}
			else if(clocktype.compare("packet")==0 || clocktype.compare("PACKET")==0){
				select_clock(PACKET);
			}
			else
				throw std::runtime_error(std::string("init: ").append("Clock type '").append(clocktype).append("' is invalid"));

           pugi::xml_node install = config.child("install");
            if(install)
            {
                for(pugi::xml_node p = install.child("threadpool"); p; p = p.next_sibling("threadpool"))
                    PoolManager::instance().create_pool(p);
                auto it = m_config_map.find(composition_id);
                if(it != m_config_map.end())
                    throw std::runtime_error(composition_id.append(" : composition already exists"));
                auto it2 = m_config_map.insert(std::make_pair(composition_id,std::shared_ptr<Composition>(new Composition(app_id))));
                it2.first->second->install(install);
            }
            else 
            {
                throw std::runtime_error(" only installation is allowed through this entry point");
            }

        }

    };

}//namespace blockmon
#endif // _CORE_COMPOSITION_COMPOSITIONMANAGER_HPP_
