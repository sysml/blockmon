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
 * <blockinfo type="AppendTag" invocation="both" thread_exclusive="False">
 *   <humandesc>
 *       This is a test-only block that appends random-value tags to Packet messages.
 *       The block can append three different tag type, which can be configured at block configuration time.
 *       The content of the tag to be written is a 64-bit random value which is computed on a per-packet base.
 *   </humandesc>
 *
 *   <shortdesc>Appends tags with random values to the packet message.</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *     <gate type="output" name="out_pkt" msg_type="Packet" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *       element tag
 *       {
 *           attribute type {"long"|"double"|"int"}
 *           attribute id {text}
 *       }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *       <tag type="double" name = "random_tag"/>
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <TagRegistry.hpp>
#include <Packet.hpp>

#include <random>

namespace blockmon
{

    class AppendTag: public Block
    {


    public:

        /*
         * constructor
         */
        AppendTag(const std::string &name, invocation_type invocation)
        : Block(name, invocation),
        m_tag_type(undef),
        m_tag_name(),
        m_ingate_id(register_input_gate("in_pkt")),
        m_outgate_id(register_output_gate("out_pkt")),
        m_handle(TAG_INVALID),
        m_generator()
        {
        }

        AppendTag(const AppendTag &)=delete;
        AppendTag& operator=(const AppendTag &) = delete;

        /*
         * destructor
         */
        virtual ~AppendTag()
        {}

        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(Packet))
                throw std::runtime_error("AppendTag: wrong message type");
            uint64_t random_garbage = m_generator();
            switch (m_tag_type)
            {
            case(in):
                m->emplace_tag<int>(m_handle,(int)random_garbage);
                break;
            case(ll):
                m->emplace_tag<double>(m_handle,(double)random_garbage);
                break;
            case(fl):
                m->emplace_tag<uint64_t>(m_handle,(uint64_t)random_garbage);
                break;
            default:
                throw std::runtime_error("wrong tag type");  
            }
            send_out_through(std::move(m),m_outgate_id);
        }

        virtual void _configure(const pugi::xml_node&  n )
        {
            if(pugi::xml_node tag = n.child("tag"))
            {

                if(pugi::xml_attribute name = tag.attribute("name") )
                {
                    m_tag_name = name.value();
                }
                else  
                    throw std::runtime_error("no name attribute");

                if(pugi::xml_attribute type = tag.attribute("type") )
                {
                    if(!(std::string(type.value()).compare("double")))
                    {
                        m_tag_type = fl; 
                        m_handle = TagRegistry<Packet>::register_tag<double>(m_tag_name);
                    }
                    else if(!(std::string(type.value()).compare("int")))
                    {
                        m_tag_type = in; 
                        m_handle = TagRegistry<Packet>::register_tag<int>(m_tag_name);
                    }
                    else if(!(std::string(type.value()).compare("long")))
                    {
                        m_tag_type = ll; 
                        m_handle = TagRegistry<Packet>::register_tag<uint64_t>(m_tag_name);
                    }
                    else 
                        throw std::runtime_error("unrecognized tag type");

                    if(m_handle == TAG_INVALID)
                        throw std::runtime_error("invalid tag handler");
                }
                else  
                    throw std::runtime_error("no type attribute");
            }
            else  
                throw std::runtime_error("no tag node");
        }


    private:
        enum  {fl, in , ll, undef} m_tag_type;
        std::string m_tag_name;
        int m_ingate_id;
        int m_outgate_id;
        tag_handle<Packet> m_handle; 

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4
        std::mt19937 m_generator;
#else
        std::mt19937_64 m_generator; 
#endif 

    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(AppendTag,"AppendTag");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */

}

