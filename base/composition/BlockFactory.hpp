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

#ifndef _BLOCKFACTORY_HPP_
#define _BLOCKFACTORY_HPP_ 

#include <factory.hpp>
#include <Block.hpp>
#include <string>

namespace bm
{
    struct BlockFactory
    {
        typedef more::factory<std::string, bm::Block, std::string, bool, bool> fac_type;

    private:
        BlockFactory()
        {}

        ~BlockFactory()
        {}

        BlockFactory(const BlockFactory &) = delete;
        BlockFactory& operator=(const BlockFactory &) = delete;

    public:
        static fac_type &
        instance()
        {
            static fac_type tf;
            return tf;	
        }

        static std::shared_ptr<Block> 
        instantiate(const std::string &blocktype, std::string name, bool a, bool ts)
        {
            auto tf = instance();
            return tf(blocktype,std::move(name),std::move(a),std::move(ts));
        }
    };
}

#define REGISTER_BLOCK(type,name)\
namespace\
{\
    more::factory_register<Block,type> _factory_register_(static_cast<bm::BlockFactory::fac_type&>(bm::BlockFactory::instance()), \
                                                          name, more::fac_arg<std::string>(),more::fac_arg<bool>(),more::fac_arg<bool>());\
} 

#endif /* _BLOCKFACTORY_HPP_ */
