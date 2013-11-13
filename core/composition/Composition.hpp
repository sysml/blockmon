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

#ifndef _CORE_COMPOSITION_COMPOSITION_HPP_
#define _CORE_COMPOSITION_COMPOSITION_HPP_
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


namespace blockmon
{
/**
  * Object handling the blocks and links associated with a composition.
  *
  * It holds an internal directory of the blocks and handles
  * installation and deletion Part of the API is called from the
  * python bindings, while other methods are intended for support of
  * the legacy C++-only implementation
  */ 
    class Composition
    {
        std::map< std::string, std::shared_ptr<Block> > m_map;
        const std::string m_composition_id;

        /**
          * composition is not moveable nor copiable
          */

        Composition(const Composition &)=delete;
        Composition & operator=(const Composition &)=delete;
        Composition(Composition &&)=delete;
        Composition & operator=(Composition &&)=delete;

        /**
          * Adds a block to the composition and configures it
          * This is done before the block is connected to the others
          * This is the internal implementation, which is called both by different public methods
          * @param type the block type
          * @param name the name of the block instance
          * @param invocation type of invocation for the block
          * @param params the xml block-specific configuration subtree 
         */
        void create_block_from_parsed(const std::string& type, const std::string& name, 
                           invocation_type invocation, const pugi::xml_node& params);

        /**
          * Helper function, retrieve a reference to a given output gate, throws upon failure
          * @param from_block block name
          * @param from_gate gate name
          */
        OutGate& find_output_gate( const std::string& from_block,const std::string& from_gate);


        /**
          * Helper function, retrieve a reference to a given output gate, throws upon failure
          * @param from_block block name
          * @param from_gate gate name
          */
        InGate& find_input_gate( const std::string& to_block,const std::string& to_gate);
    public:
        /** 
          *class constructor
          *@param a the composition id
          */
        Composition(const std::string &a) : 
        m_map(), 
        m_composition_id(a)
        {}
        
        std::string composition_id()
        {
            return m_composition_id;
        }

        /**
          * This is the only entry point for the c++ legacy version
          * It does not support reconfiguration
          * @param  the xml subtree containing the whole composition descriptions (including blocks and connections)
          */
        void install(const pugi::xml_node& n);


        /**
          * This method calls _initialize() method on each configured block
          */
        void initialize();

 // these functions are used by the BlockMon demon through the python binding, or are called by the legacy install method 
        /** 
          * Exposed through the python bindings
          * Creates a connection between two gates
          * @param from_block source block name
          * @param from_gate source gate name
          * @param to_block destination block name
          * @param to_gate destination gate name
          */

        void create_link(const std::string& from_block,const std::string& from_gate,const std::string& to_block,const std::string& to_gate);
        /** 
          * Exposed through the python bindings
          * Deletes a connection between two gates
          * @param from_block source block name
          * @param from_gate source gate name
          * @param to_block destination block name
          * @param to_gate destination gate name
          */
        void delete_link(const std::string& from_block, const std::string& from_gate,const std::string& to_block,const std::string& to_gate);

        
        
        /** 
          * Exposed through the python bindings
          * Creates a block (calls the private method create_block_from_parsed)
          * @param type the block type
          * @param name the name of the block instance
          * @param invocation type of invocation for the block
          * @param params  a human-readable string containing xml block-specific configuration subtree 
          */
        void create_block(const std::string& name,const std::string& type, invocation_type invocation, const  std::string& config)
        {
            pugi::xml_document config_info;
            if(!config_info.load(config.c_str()))
                throw std::runtime_error("Composition::create_block: cannot parse config info");
           pugi::xml_node block = config_info.child("block");
            if (!block)
                throw std::runtime_error("Composition: cannot find block node");

            create_block_from_parsed(type, name, invocation, block);
        }

        
        /** 
          * Exposed through the python bindings
          * Delete a block in the composition
          * Notice that this function does not disconnect gates, which has to be done explicitly
          * otherwise there may be invalid references
          * @param name the block name
          */
        void delete_block(const std::string& name)
        {
            auto it = m_map.find(name);
            if(it == m_map.end())
                throw std::runtime_error("Composition:: trying to delete non-existing block");
            m_map.erase(it);
        }


        /** 
          * @return a reference to  a block in the composition
          * @param name the block name
          */
        std::shared_ptr<Block> get_block(const std::string& name)
        {
            auto it = m_map.find(name);
            if(it == m_map.end())
                throw std::runtime_error(std::string("Composition:: requested non-existing block '").append(name).append("'"));
            return it->second;
        }


    };

}//end namespace
#endif // _CORE_COMPOSITION_COMPOSITION_HPP_
