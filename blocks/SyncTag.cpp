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
 * <blockinfo type="SyncTag" invocation="both" thread_exclusive="False">
 *   <humandesc>
 *   Test block that waits for a message to have a set of tags set before forwarding it.
 *   The block is configured with a set of tag to wait for: if all of them are written (the value is not read)
 *   it forwards the message to the next block, otherwise it discards it.
 *   If the same message is going through different parallel processing chains, is will reach the synchronization
 *   block several times and eventually all of its tags will be written.
 *   </humandesc>
 *
 *   <shortdesc>Wait for a message to have a set of tags written</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_msg" msg_type="Msg" m_start="0" m_end="0" />
 *     <gate type="output" name="out_msg" msg_type="Msg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *      element tags
 *       {
 *           element tag {
 *           attribute name {text}
 *           }*
 *        }
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *       <tag name = "tag1"/>
 *       <tag name = "tag2"/>
 *       </tags>
 *       </params>
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

    class SyncTag: public Block
    {

    public:

        /*
         * constructor
         */
        SyncTag(const std::string &name, invocation_type invocation)
        : Block(name, invocation)
        , m_ingate_id(register_input_gate("in_msg"))
        , m_outgate_id(register_output_gate("out_msg"))
        , m_msg_type(MSG_ID(Packet))
        , m_tag_vector()
        {
        }


        void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */) 
        {
            if(m->type() != m_msg_type)
                throw std::runtime_error("SyncTag:: wrong message type");

            uint64_t ready_bitmap = 0;
            unsigned int vector_size =  m_tag_vector.size();
            uint64_t completion_mask = (1<<vector_size) -1;
            //while(ready_bitmap != completion_mask)
            for (int wait=0; wait<100; ++wait)
            {
                for (unsigned int i = 0; i < vector_size; ++i)
                {
                    if(ready_bitmap & (1<<i))
                        continue;
                    if(m->is_available_tag(m_tag_vector[i].handle))
                        ready_bitmap |= (1<<i);
                }
                if(ready_bitmap == completion_mask)
                    break;
            }
            if(ready_bitmap == completion_mask)
                send_out_through(std::move(m), m_outgate_id);
        }

        void _configure(const pugi::xml_node&  n ) 
        {
	    if(pugi::xml_node message = n.child("message"))
            {
	        if(pugi::xml_attribute id = message.attribute("id") )
                {
                    m_msg_type = id.as_int();
                }
            }

            if(pugi::xml_node tags = n.child("tags"))
            {
                for (pugi::xml_node tag = tags.child("tag"); tag; tag = tag.next_sibling("tag"))
                {
                    struct tag_data local;
                    if(pugi::xml_attribute name = tag.attribute("name"))
                        local.name = name.value();
                    else
                        throw std::runtime_error("TagSync: tag with no name");
                    local.handle = TagRegistry<Packet>::get_handle_by_name(local.name);
                    if(local.handle == TAG_INVALID)
                        throw std::runtime_error("TagSync: invalid tag handle");
                    m_tag_vector.push_back(local);
                }

                if(m_tag_vector.size() > 64)
                    throw std::runtime_error("SyncTag : bitmap is too small for the tags");

            }
            else
                throw std::runtime_error("SyncTag: no tags node");
        }

    private:

        struct tag_data
        {
            tag_handle<Packet> handle;
            std::string name;
        };

        int m_ingate_id;
        int m_outgate_id;
        uint32_t m_msg_type;

        std::vector<tag_data> m_tag_vector;
    };


#ifndef _BLOCKMON_DOXYGEN_SKIP_
    REGISTER_BLOCK(SyncTag,"SyncTag");
#endif /* _BLOCKMON_DOXYGEN_SKIP_ */
}

