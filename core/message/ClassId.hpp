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

#ifndef _CORE_MESSAGE_CLASSID_HPP_
#define _CORE_MESSAGE_CLASSID_HPP_
#include <cxxabi.h>

#include <typeinfo>
#include <stdexcept>
#include <cstdint>
#include <string>
#include <mutex>                
#include <memory>
#include <mutex>                
#include <map>

namespace blockmon
{
  /**
   * Allows automatic generation of unique id for message classes.
   *
   * It is based on a portable hashing function of demangled type
   * names.  Collision among ids (though unlikely) are detected at run
   * time.  the user should not use this class directly, but rather
   * the MSG_ID macro or the type_to_id<T>::id() function
     */

    class classid
    {
        std::map<uint32_t, std::string> m_ids;
        std::mutex m_mutex;

        static uint32_t hash_(const char* b, size_t s)
        {
            uint32_t h = 0x66B566B5;
            const char* it = b;
            while(s >= 2)
            {
                h ^=    (h <<  7) ^  (*it++) * (h >> 3);
                h ^= (~((h << 11) + ((*it++) ^ (h >> 5))));
                s -= 2;
            }
            if (s)
            {
                h ^= (h <<  7) ^ (*it) * (h >> 3);
            }
            return h;
        }


        /** 
         * Simple constructor 
         */

        classid()
        : m_ids()
        , m_mutex()
        {}

        ~classid()
        {}
         
    public:

        /** 
         * Non copyable class 
         */

        classid(const classid &) = delete;
        classid& operator=(const classid &) = delete;
        
        /**
         * Meyers' idiom for singleton classes
         */

        static classid& instance()
        {
            static classid one;
            return one;
        }

        /**
         * get a unique id for the given type T
         */

        template<typename T> 
        int get_id()
        {
            int status;
            std::unique_ptr<char, decltype(&free)> name(abi::__cxa_demangle(
                        typeid(T).name(), 0,0, &status), ::free);
            if(status<0)
                throw std::runtime_error(__PRETTY_FUNCTION__);

            std::string demangled(name.get());

            uint32_t id = hash_(demangled.c_str(), demangled.length());

            std::lock_guard<std::mutex> lock(m_mutex); 

            auto it = m_ids.find(id);
            if (it != m_ids.end()) {
                throw std::runtime_error(std::string("classid::get_id() error! Hash collision between '").
                                         append(demangled).append("' and '").append(it->second).append("' types"));
            }

            m_ids.insert(std::make_pair(id, demangled));
            return id;
        }

        std::string
        get_name(uint32_t id)
        {
            auto it = m_ids.find(id);
            if (it == m_ids.end())
                throw std::runtime_error(std::string("classid::get_name() error! ").append(std::to_string(id)).append(" unknown id!"));
            
            return it->second;
        }
    };

    /**
     * template class for instantiating the message id
     * T is the message class
     */

    template<typename T>
    struct type_to_id
    {
        static uint32_t id()
        {
            static const uint32_t id = classid::instance().get_id<T>();
            return id;
        }
    };

} // namespace blockmon

/**
 * commodity macro for instantiating the message id
 * type is the message class
 */

#define MSG_ID(type) blockmon::type_to_id<type>::id()

#endif // _CORE_MESSAGE_CLASSID_HPP_
