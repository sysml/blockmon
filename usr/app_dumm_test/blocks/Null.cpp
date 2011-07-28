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

#ifndef __NULL_BLOCK__
#define __NULL_BLOCK__


#include<Block.hpp>

#include<BlockFactory.hpp>
namespace bm
{

    class Null: public Block
    {
        
        
    public:

        /*
         * constructor
         */
        Null(const std::string &name, bool active, bool thread_safe)
        : Block(name,"Null",false,false),
          m_ingate_id(register_input_gate("in_pkt"))
        {
        }

        Null(const Null &)=delete;
        Null& operator=(const Null &) = delete;

        /*
         * destructor
         */
        virtual ~Null()
        {}


        virtual void _configure(const xml_node&  /*n*/ )
        {
        
        }

            
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            return 0;
        }

         

        virtual int do_async_processing()
        {
            throw std::runtime_error(__PRETTY_FUNCTION__);
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error(__PRETTY_FUNCTION__);
            return -1;
        }
    private:
        
        int m_ingate_id;
 
    };


    REGISTER_BLOCK(Null,"Null");

}

#endif	/* STATISTICBLOCK_HPP */

