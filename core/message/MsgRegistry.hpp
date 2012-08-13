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

// DELETEME remove all references to this class after IPFIX refactor complete

#ifndef _CORE_MESSAGE_MSGREGISTRY_HPP_
#define _CORE_MESSAGE_MSGREGISTRY_HPP_

#include<Msg.hpp>
#include<map>
#include<vector>
#include<memory>
#include<mutex>
#include<ClassId.hpp>

namespace blockmon
{
    class MsgRegistry
    {

        std::map<int/*msg id*/,std::shared_ptr<Msg::Descriptor> > m_descriptors_map;

        MsgRegistry():
        m_descriptors_map()
        {}

    public:
        /**
         *Meyer's singleton idiom
         */
        static MsgRegistry& instance()
        {
            static MsgRegistry the_registry;
            return the_registry;
        }  

        /**
         * Regiters the module for a message type.  may be called mutiple times but registration only happens once.
         *
         * FIXME rewrite this documentation
         *
         * @param msg_id the id of the message class as instantiated by ClassId
         * @param podfactory a unique pointer to the subclass of Descriptor associated with this message class
         */

        void register_message_class(int msg_id, std::shared_ptr<Msg::Descriptor>&& descriptor)
        {
            if (m_descriptors_map.find(msg_id) != m_descriptors_map.end())
                return;
            // the model may be registered several times
            
            // do any post-registration necessary
            descriptor->post_register();

            // put descriptor in map
            m_descriptors_map[msg_id] =  std::move(descriptor);
        }

        /**
         * Returns a reference to the registry entry  associated to a given message type
         * @param msg_id the id of the message class as instantiated by ClassId
         */
        const Msg::Descriptor& get_message_descriptor(int msg_id) const
        {
            auto mod_iterator = m_descriptors_map.find(msg_id); 
            if (mod_iterator == m_descriptors_map.end())
                throw std::runtime_error("Descriptor not registered");
            return *(mod_iterator->second);
        }

        /**
         * Retrieves the full list of the registered msg ids.
         * @return a vector containing all of the keys in the registry
         */
        std::vector<int> available_msg_ids()
        {
            std::vector<int> ret;
            for(auto it = m_descriptors_map.begin(); it != m_descriptors_map.end(); ++it)
            {
                ret.push_back(it->first);
            }
            return ret;
        }

    };

    /**
     * when an instance of this class is built, it automatically registers to the factory a module.
     * @param MessageClass the class of the associated message (needed in order to compute the message id)
     * @param DescriptorClass the associated message descriptor class inheriting from Msg::MessageDescriptor
     */


    template <typename MessageClass, typename DescriptorClass>
    class MsgRegistration
    {
    public:
        MsgRegistration()
        {
            MsgRegistry::instance().register_message_class(
                type_to_id<MessageClass>::id(),
                std::shared_ptr<Msg::Descriptor>(new DescriptorClass()));
        }
    };
}//namespace blockmon

/**
  * this macro instantiates the proper registering object and should be inserted at the bottom of the message header file
  * @param MessageClass the class of the associated message (needed in order to compute the message id)
  * @param DescriptorClass the associated message descriptor class inheriting from Msg::MessageDescriptor
  */

#define REGISTER_MESSAGE_CLASS(MessageClass, DescriptorClass)\
    namespace\
    {\
        MsgRegistration<MessageClass,DescriptorClass> MessageClass ##_factory_register;\
    } 

#endif // _CORE_MESSAGE_MSGREGISTRY_HPP_
