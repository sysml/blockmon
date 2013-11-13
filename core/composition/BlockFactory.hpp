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

#ifndef _CORE_COMPOSITION_BLOCKFACTORY_HPP_
#define _CORE_COMPOSITION_BLOCKFACTORY_HPP_

/** @file
  * Essentially a wrapper around the generic factory in the more library.
  * Standard c++ factory pattern
  */

#include <Factory.hpp>
#include <Block.hpp>
#include <string>

namespace blockmon
{

    /**
      * Singleton factory class (it simply wraps a more::factory object).
      */

    class BlockFactory
    {
       
    public: 
        /**
          * Type of the factory object.
          * It is actually an instantiation of the more template factory class
          */
        typedef more::factory<std::string, blockmon::Block, std::string, invocation_type> fac_type;

    private:
        fac_type m_actual_factory;

        /**
          * class constructor.
          * private as in Meyer's singleton
          */
        BlockFactory():
        m_actual_factory()
        {}

        ~BlockFactory()
        {}

 		/**
          * the factory object is not copiable nor movable
          */
        BlockFactory(const BlockFactory &) = delete;
        BlockFactory& operator=(const BlockFactory &) = delete;
        BlockFactory( BlockFactory &&) = delete;
        BlockFactory& operator=( BlockFactory &&) = delete;
        

    public:
        /**
          * unique instance accessor as in Meyer's singleton
          * @return a reference to the only instance of this class
          */
        static BlockFactory &
        instance()
        {
            static BlockFactory the_factory;
            return the_factory;	
        }

        /**
          * In order for the underlying machinery to work, the registration class needs to access the internals
          */
        fac_type& actual_factory()
        {
            return m_actual_factory;
        }

        /**
          * Generates a block instance
          * @param blocktype the type of block
          * @param name the name of the block instance
          * @param invocation invocation type of the block, Direct, Indirect, or Async.
          */
        static std::shared_ptr<Block> 
        instantiate(const std::string &blocktype, std::string name, invocation_type invocation)
        {
            auto & tf = instance().m_actual_factory;
            return tf.shared(blocktype, std::move(name), std::move(invocation));
        }

    };

/**
  * Registration class. It wraps a more::factory_register object
  */ 

template<typename blocktype>
class BlockFactoryRegistration : public more::factory_register<blockmon::Block, blocktype>
{
public:
    /*
     * the object constructor.
     * It runs before the main starts and registers the blocktype block class  to the factory
     * @param name the string which will have to be provided to the factory in order to generate an block of class blocktype
    */ 
    BlockFactoryRegistration(std::string name):
    more::factory_register<blockmon::Block, blocktype>(blockmon::BlockFactory::instance().actual_factory(), std::move(name))
    {
        std::cout << "BlockFactory: registering block " << name << std::endl;
    }
};


}//namespace blockmon
/**
  * helper macro.
  * It instantiates a BlockFactoryRegistration object for the block class. 
  * This has to be put in the cpp file of the block class after the class definition.
  * @param the block class that needs to be registered
  * @param the string that will be passed to the factory in order for an instance of this class to be generated
 */ 
#define REGISTER_BLOCK(blocktype,name)\
namespace\
{\
    BlockFactoryRegistration<blocktype> __registration__(name);\
} 
#endif // _CORE_COMPOSITION_BLOCKFACTORY_HPP_
