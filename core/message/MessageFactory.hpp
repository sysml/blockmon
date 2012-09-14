/* Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale
 * Interuniversitario per le Telecomunicazioni. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd, Consorzio Nazionale
 *      Interuniversitario per le Telecomunicazioni nor the names of its contributors
 *      may be used to endorse or promote products derived from this software
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT
 * HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 */

#ifndef _CORE_MESSAGE_MESSAGEFACTORY_HPP_
#define _CORE_MESSAGE_MESSAGEFACTORY_HPP_

#include <Factory.hpp>
#include <Msg.hpp>
#include <string>

namespace blockmon
{

    /**
      * Singleton factory class (it simply wraps a more::factory object).
      */

    class MessageFactory
    {

    public:
        /**
          * Type of the factory object.
          * It is actually an instantiation of the more template factory class
          */
        typedef more::factory<std::string, blockmon::Msg> fac_type;

    private:
        fac_type m_actual_factory;

        /**
          * class constructor.
          * private as in Meyer's singleton
          */
        MessageFactory():
        m_actual_factory()
        {}

        ~MessageFactory()
        {}

        /** Forbids copy and move constructors.
         */
        MessageFactory(const MessageFactory &) = delete;

        /** Forbids copy and move assignment.
         */
        MessageFactory& operator=(const MessageFactory &) = delete;


    public:
        /**
          * unique instance accessor as in Meyer's singleton
          * @return a reference to the only instance of this class
          */
        static MessageFactory & instance()
        {
            static MessageFactory the_factory;
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
          * Generates a message instance
          * @param msgtype the type of message
          * @param name the name of the message instance
          */
        static std::shared_ptr<Msg> instantiate(const std::string &msgtype)
        {
            auto & tf = instance().m_actual_factory;
            return tf.shared(msgtype);
        }

    };

    /**
    * Registration class. It wraps a more::factory_register object
    */

    template<typename msgtype>
    class MessageFactoryRegistration : public more::factory_register<blockmon::Msg, msgtype>
    {
    public:
        /**
         * the object constructor.
         * It runs before the main starts and registers the msgtype message class to the factory.
         * @param name the string which will have to be provided to the factory in order to generate a message.
         */
        MessageFactoryRegistration(std::string name):
        more::factory_register<blockmon::Msg, msgtype>(blockmon::MessageFactory::instance().actual_factory(), std::move(name))
        {
            std::cout << "MessageFactory: registering message " << name << std::endl;
        }
    };


} //namespace blockmon
/**
  * helper macro.
  * It instantiates a MessageFactoryRegistration object for the message class.
  * This has to be put in the cpp file of the message class after the class definition.
  * @param the message class that needs to be registered
  * @param the string that will be passed to the factory in order for an instance of this class to be generated
 */
#define REGISTER_MESSAGE(msgtype,name)\
namespace\
{\
    MessageFactoryRegistration<msgtype>  msgtype##registration__(name);\
}
#endif // _CORE_MESSAGE_MESSAGEFACTORY_HPP_
