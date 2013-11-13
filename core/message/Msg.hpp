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

#ifndef _CORE_MESSAGE_MSG_HPP_
#define _CORE_MESSAGE_MSG_HPP_

#include <string>
#include <stdexcept>
#include <memory>
#include <cstring>

#include <TagRegistry.hpp>
#include <Utility.hpp>

#include <Buffer.hpp>
#include <ClassId.hpp>

#include <WireTemplate.h>
#include <StructTemplate.h>
#include <InfoModel.h>

#include <Serializer.hpp>

namespace blockmon { 

  /**
   * If present in a constructor, this signals that the object to be
   * constructed does not own the memory in which it resides.
   *
   * There is only one instance of this class: memory_not_owned.
   *
   * FIXME: to be removed! 
   */
    struct memory_not_owned_t {};

  /** The only instance of memory_not_owned_t. */
    constexpr memory_not_owned_t memory_not_owned = memory_not_owned_t();

/**
 * Base class for Blockmon messages.
 *
 * Models a message containing no data except its type. You probably
 * want to use an existing derived class of Msg, or create your own.
 *
 * @section How to Build a Message
 *
 * brian will write this on the train while wearing noise-cancelling
 * headphones so he can ignore the boring conversation that guy is
 * having about when he will arrive in Basel.
 */
    class Msg {

    public:

        /**
         * Creates a new message of a given type. 
         *
         * Type is simply an integer. Derived classes may set the private
         * m_type field in their own constructors, if they represent only 
         * one type of message.
         *
         * @param type message type number
         */
        Msg(int msg_id, mutable_buffer<char> buf = mutable_buffer<char>(), bool ownership = false) 
        : m_type(msg_id)
        , m_tagbuf(buf)
        , m_tagowner(ownership)
        {}

        /**
         * Destroys this message and free its storage.
         */

        virtual ~Msg()
        {
            if (m_tagowner)
                delete [] m_tagbuf.addr();
        }

	/**
	 * For debugging purpose it could be useful to get the name of the message
	 */
	virtual std::string get_message_name() const {
		return "Msg";
	}

	/**
	 * Create a new message of the same type using the data in the serializer
	 * (deserialization)
	 */
	virtual const std::shared_ptr<Msg> build_same(Serializer *ser) const {
		assert(0);
	}

	/**
	 * Modify the serializer to reflect the content of the message
	 * The serializer will then be used to send this message across
	 * the network
	 */
	virtual void serialize(Serializer *ser) const {
		assert(0);
	}


        /**
         * Set the tag buffer this message.
         *
         * Buf is the mutable_buffer used for this Msg. ownership
         * tells the Msg where to free the memory or not in the 
         * destructor.
         *
         * @param buf the mutable_buffer for the tagbuf
         * @param ownership the boolean value
         */
        
        void set_tagbuf(mutable_buffer<char> buf, bool ownership)
        {  
            if (m_tagowner)
                delete [] m_tagbuf.addr();

            m_tagbuf = buf;
            m_tagowner = ownership;
        }

        /**
         * Builds an tag object into the message
	 *
         * In order to use that, the block must register a tag
         * beforehand with the proper method in TagRegistry.hpp The
         * function is template over the tag object type T and its
         * constructor arguments.  A perfect forwarding idiom is used
         * to pass whatever constructor arguments to the constructor.
	 *
         * @param tag_h the tag handler obtained upon registration
         */
        template <typename Tag, typename MsgType, typename ...Ts>
        void emplace_tag(tag_handle<MsgType> handle, Ts && ...args) const
        {
            if (!m_tagbuf)
                throw std::runtime_error("tag buffer not available");
            TagRegistry<MsgType>::template emplace_tag<Tag>(m_tagbuf, handle, 
                                                            std::forward<Ts>(args)...);
        }

        /**
         * Retrieves a pointer to a tag object associated with this message.
	 *
         * If the valid bit has not been set yet (meaning that the tag
         * has not been written) a NULL pointer is retrieved.  The
         * function is template over the tag object type.
	 *
	 * @return a pointer to the tag object if its valid bit has
         * been set, NULL otherwise @param tag_h the tag handler
         * obtained upon registration
         */ 
        template<typename Tag, typename MsgType>
        const Tag * get_tag(tag_handle<MsgType> handle) const
        {
            if (!m_tagbuf)
                throw std::runtime_error("tag buffer not available");
            return TagRegistry<MsgType>::template get_tag<Tag>(const_buffer<char>(m_tagbuf), handle);
        }

        /**
         * Checks whether a given tag has been written on this message (i.e. its valid bit is set).
	 *
         * @param tag_h the tag handler obtained upon registration
	 *
         * @return true whether the tag has been written, false otherwise
         */ 
        template <typename MsgType>
        bool is_available_tag(tag_handle<MsgType> handle) const
        {
            if (!m_tagbuf)
                throw std::runtime_error("tag buffer not available");
            return TagRegistry<MsgType>::is_available_tag(const_buffer<char>(m_tagbuf), handle);
        }

        /**
         * Exchanges this message's content with the content of another message.
         *
         * In the base class, this simply swaps the message type;
         * derived classes should swap all members.
         *
         * @param rhs message to swap content with
         */
        void swap(Msg &rhs)
        {
            std::swap(m_type, rhs.m_type);            
            std::swap(m_tagbuf, rhs.m_tagbuf);
            std::swap(m_tagowner, rhs.m_tagowner);
        }

        /**
         * Returns the type of the message.
         *
         * The type facilitiates the runtime separation of messages
         * based on type.
         *
         * @return message type
         */

        uint32_t type() const
        {
            return m_type;
        }

        /**
         * Creates a clone of this message.
         *
         * This function creates a clone for this message. Derived
         * classes should implement the proper copy constructor and an
         * overridden clone() method as the following one:
         *
         * std::shared_ptr<Msg> clone() const 
         * {
	 *     // This invokes copy-ctor of DerivedType
         *     return std::make_shared<DerivedType>(*this);
         * }    
         *
         */
        virtual std::shared_ptr<Msg> clone() const 
        {   
            throw std::runtime_error(std::string("Msg::clone: virtual method not implemented in msg type ").
                                     append(classid::instance().get_name(m_type)));
            
            return std::shared_ptr<Msg>();
        }

        /**
         * Copies the content of this message as a C struct (Plain Old
         * Data) to a mutable buffer.
         *
         * @param buf buffer to copy
         */

      virtual void pod_copy(mutable_buffer<uint8_t>) const {
          throw std::runtime_error(__PRETTY_FUNCTION__);
      }

      virtual size_t pod_size() const {
          throw std::runtime_error(__PRETTY_FUNCTION__);
      }
        

    protected:
        void assert_pod_size(size_t len) const 
        {
            if (len < pod_size()) {
                throw std::runtime_error("buffer too small for pod_copy/create_from_pod()");
            }            
        }

		/* 
         * Copy constructor
         */        
        Msg(Msg const &other)
        : m_type(other.m_type)
        , m_tagbuf(mutable_buffer<char>(new char[other.m_tagbuf.len()], other.m_tagbuf.len()))
        , m_tagowner(true)
        {
            memcpy(m_tagbuf.addr(), other.m_tagbuf.addr(), other.m_tagbuf.len());
        }

    private:

        uint32_t             m_type;
        mutable_buffer<char> m_tagbuf;
        bool                 m_tagowner;
    };

} // namespace blockmon

#endif // _CORE_MESSAGE_MSG_HPP_
