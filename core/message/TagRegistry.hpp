/* Copyright (c) 2011, Consorzio Nazionale Interuniversitario 
 * per le Telecomunicazioni. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the name of Interuniversitario per le Telecomunicazioni nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
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

#ifndef _CORE_MESSAGE_TAGREGISTRY_HPP_
#define _CORE_MESSAGE_TAGREGISTRY_HPP_

#include <iostream>
#include <typeinfo>
#include <string>
#include <limits>
#include <vector>
#include <stdexcept>
#include <limits>
#include <cassert>
#include <type_traits>
#include <tuple>
#include <mutex>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include <Buffer.hpp>
#include <Assert.hpp>

namespace blockmon { 

    /** 
     * @brief
     * tag_object class is used to enforce the correct internal alignemnt 
     * for tags allocated in the tag buffer...
     * value is the value of the Tag that be trivially destructible. 
     * valid is an atomic flag used for synchronization.
     */
    struct tag_base
    {
        tag_base()
        : valid()
        {}

        /** An atomic flag used for synchronization. */
        std::atomic_bool valid;
    };

    template <typename Tag>
    struct tag_object : public tag_base
    {
        static_assert(std::has_trivial_destructor<Tag>::value,
                     "Tag must be trivally destructible");

        tag_object()
        : tag_base() 
        , value()
        {
        }

        template <typename ...Ts>
        tag_object(Ts&& ... args)
        : tag_base()
        , value(std::forward<Ts>(args)...)
        {
            valid.store(true,std::memory_order_release);
        }

        Tag          value;
    };
 
    struct tag_invalid {};
    
    namespace 
    {
        tag_invalid TAG_INVALID = {};
    }

    template <typename T>
    struct tag_handle 
    {
        constexpr explicit tag_handle(size_t v = std::numeric_limits<size_t>::max())
        : value(v)
        {}

        tag_handle(tag_invalid)
        : value(std::numeric_limits<size_t>::max())
        {}

        size_t value;
    };

  /** Compares two tag handles for equality.
   *
   * Version where second argument is tag_invalid.
   *
   * @param h the handle to compare
   *
   * @return true if h is equal to tag_invalid, false otherwise.
   */
    template <typename Tp>
    inline
    bool operator==(tag_handle<Tp> h, tag_invalid)
    {
        return h.value == std::numeric_limits<size_t>::max();
    }
    
  /** Compares two tag handles for equality.
   *
   * Version where first argument is tag_invalid.
   *
   * @param h the handle to compare
   *
   * @return true if h is equal to tag_invalid, false otherwise.
   */
    template <typename Tp>
    inline
    bool operator==(tag_invalid, tag_handle<Tp> h)
    {
        return h.value == std::numeric_limits<size_t>::max();
    }

  /** Compares two tag handles for inequality.
   *
   * Version where second argument is tag_invalid.
   *
   * @param h the handle to compare
   *
   * @return true if h is unequal to tag_invalid, false otherwise.
   */
    template <typename Tp>
    inline
    bool operator!=(tag_handle<Tp> h, tag_invalid)
    {
        return !(h == TAG_INVALID);
    }

  /** Compares two tag handles for inequality.
   *
   * Version where first argument is tag_invalid.
   *
   * @param h the handle to compare
   *
   * @return true if h is unequal to tag_invalid, false otherwise.
   */
    template <typename Tp>
    inline
    bool operator!=(tag_invalid, tag_handle<Tp> h)
    {
        return !(TAG_INVALID == h);
    }


    /**
     * @brief
     * TagRegistry class implements a registry of the tags for the message type MsgType.
     * This is a template singleton class, according to Meyer's idiom.
     * When a message tag is registered, an associated handle is returned. Such an handle is then used in 
     * order to read and write the tags associated to a message.
     */

    template <typename MsgType>
    struct TagRegistry
    {
    private:
        struct tag_metadata
        {
            tag_metadata(size_t s, size_t o, size_t hash, std::string id)
            : size(s)
            , offset(o)
            , hash_code(hash)
            , tag_id(std::move(id))
            {
            }

            size_t size;
            size_t offset;
            size_t hash_code;
            std::string tag_id;
        };                                       

        TagRegistry()
        : next_offset_()
        , tag_info_()
        {
        }

        ~TagRegistry()
        {
        }

        tag_handle<MsgType> 
        find_tag_(const char *id) const
        {
            auto end = tag_info_.size();
            for(size_t i = 0; i < end; i++)
            {
                if (tag_info_[i].tag_id.compare(id) == 0)
                    return tag_handle<MsgType>{ i };
            }
            return TAG_INVALID;
        }

        template <typename T>
        static size_t hash_code_()
        {
#if __GNUC__ == 4 && __GNUC_MINOR__ >= 6
            return typeid(T).hash_code();
#else
            /* hash_code() not implemented */
            std::hash<std::string> h;
            return h(typeid(T).name());
#endif
        }


        size_t next_offset_;
        std::vector<tag_metadata> tag_info_;
        std::mutex mutex_;

    public:

        /**
         * TagRegistry is a non-copyable, Meyers' singleton class
         */
        
        TagRegistry(TagRegistry const&) = delete;
        TagRegistry& operator=(TagRegistry const&) = delete;


        /**
         * Accessor to the unique instance of this class for a given Message type (Meyers' singleton)
         * @return a reference to the instance
         */

        static TagRegistry& instance()
        {
            static TagRegistry one;
            return one;
        }

        /**
         * Returns an handle for a tag, given its identifier for the message MsgType.
         * Should be called by the block which needs to access a tag (either read or write).
         * @param tag_id the tag identifier string
         * @return the tag handle
         */

        static tag_handle<MsgType>
        get_handle_by_name(const char *tag_id) 
        {
            auto h = instance().find_tag_(tag_id);
            if (h == TAG_INVALID)
                throw std::runtime_error("TagRegistery::find_tag: No tags registered for this name");
            return h;
        }
        
        static tag_handle<MsgType>
        get_handle_by_name(const std::string &tag_id)
        {
            return get_handle_by_name(tag_id.c_str());
        }

        /**
         * Returns size, offset and hash_code for a given tag in the message's tag buffer for the message MsgType.
         * @param tag_h the tag handle
         * @return a tuple where: the first field is the size, the second is the offset and the third is the hash_code 
         * of the given tag associated with the handle
         */

        static std::tuple<size_t, size_t, size_t> 
        get_info(tag_handle<MsgType> tag_h) 
        {
            auto & ref = instance();
            if (tag_h.value >= ref.tag_info_.size())
                throw std::runtime_error("TagRegistry::get_info: bad tag handler");
            return std::make_tuple(ref.tag_info_[tag_h.value].size, 
                                   ref.tag_info_[tag_h.value].offset,
                                   ref.tag_info_[tag_h.value].hash_code);
        }

        /**
         * Registers a tag of type Tag with the given tag_id for the message MsgType.
         * This should be called by the block which needs to access the tag (either write or read).
         * Should be called at configuration time (not while the composition is running).
         * The function is template over the tag object Tag.
         * Multiple registrations of the same tag are allowed, as long as they are consistent (the tag type is the same).
         * @return the tag handle
         * @param tag_id the tag identifier string
         */

        template <typename Tag>
        static tag_handle<MsgType>
        register_tag(std::string tag_id)
        {
            auto & ref = instance();
            auto hash_code = hash_code_<Tag>();
            auto tag_h = ref.find_tag_(tag_id.c_str());

            if (tag_h != TAG_INVALID)
            {
                if (hash_code != ref.tag_info_[tag_h.value].hash_code)
                    throw std::runtime_error("TagRegistry::register_tag: trying to register the same tag with different types");
                return tag_h;
            }

            std::lock_guard<std::mutex> lock(ref.mutex_);
            
            tag_h.value = ref.tag_info_.size();

            /* enforce aligment fot this tag_object */
            auto rem = ref.next_offset_ % sizeof(tag_object<Tag>);
            if (rem) 
                ref.next_offset_ += sizeof(tag_object<Tag>) - rem;
           
            auto offset = ref.next_offset_;
            ref.next_offset_ += sizeof(tag_object<Tag>); 
            ref.tag_info_.emplace_back(sizeof(Tag), offset, hash_code, std::move(tag_id));
            
            return tag_h;
        }

        /**
         * Returns the size of the tag buffer for the message MsgType.
         * @param buf_h the buffer handle
         * @return the buffer size
         */

        static size_t buffer_size() 
        {
            return instance().next_offset_;
        }

        
        template <typename Tag, typename ...Ts>
        static void emplace_tag(mutable_buffer<char> buf, tag_handle<MsgType> h, Ts && ...args)
        {
            size_t size, offset, hash_code;
            std::tie(size, offset, hash_code) = instance().get_info(h);
            blockmon_assert((offset + size <= buf.len()), "emplace_tag: buffer overflow");
            blockmon_assert( hash_code == hash_code_<Tag>(), "emplace_tag: Tag type mismatch");

            auto ptr = reinterpret_cast<tag_object<Tag> *>(buf.addr() + offset);
            
            new (ptr) tag_object<Tag>(std::forward<Ts>(args)...);
        }


        template <typename Tag>
        static Tag const * get_tag(const_buffer<char> buf, tag_handle<MsgType> h)
        {
            size_t size, offset, hash_code;
            std::tie(size, offset, hash_code) = instance().get_info(h);
            
            blockmon_assert((offset + size <= buf.len()), "get_tag: buffer overflow");
            blockmon_assert( hash_code == hash_code_<Tag>(), "get_tag: Tag type mismatch");
            
            auto ptr = reinterpret_cast<const tag_object<Tag> *>(buf.addr() + offset);

            if (!ptr->valid.load(std::memory_order_acquire)) 
                return NULL;
            else
                return &ptr->value; 
        }
        

        static bool is_available_tag(const_buffer<char> buf, tag_handle<MsgType> h)
        {
            size_t size, offset;
            std::tie(size, offset, std::ignore) = instance().get_info(h);
            
            blockmon_assert((offset + size <= buf.len()), "is_valid_tag: buffer overflow");
            
            auto ptr = reinterpret_cast<const tag_base *>(buf.addr() + offset);
            
            return ptr->valid.load(std::memory_order_acquire);
        }

    };

} // namespace blockmon

#endif // _CORE_MESSAGE_TAGREGISTRY_HPP_
