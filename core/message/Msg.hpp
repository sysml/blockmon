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

/*
 * Copyright notice goes here.
 */

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
         * Serialize a message to be sent across the network.
         * @param ser The serializer.
         */
        virtual void serialize(Serializer *ser) const
        {
            assert(0);
        }

        /**
         * Deserialize data received from the network.
         * @param ser The serializer.
         */
        virtual const std::shared_ptr<Msg> build_same(Serializer *ser) const
        {
            assert(0);
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
      virtual std::shared_ptr<Msg> clone() const = 0;

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
        
      // DELETEME after SketchMsg gets fixed
         //         class Descriptor 
         //         {
         //             const uint16_t m_template_id;
         // 
         //         public:
         //             /*
         //              * Keeps a class-wide index of the last assigned template ids.
         // *
         // * It is used to assign consecutive ids to all of the
         //              * registered messages Notice that, for IPFIX export,
         //              * templates do not need to be consistent across different
         //              * nodes.
         // *
         // * @return the template id assigned to the next message
         //              */   
         // 
         //             static uint16_t next_template_id()
         //             {
         // 
         //                 static uint16_t last_id=256;
         //                 // as registration happens when the main thread starts
         //                 // up, there is no concurrent access
         //                 if (!last_id) {
         //                     throw std::runtime_error("blockmon ran out of template ids");
         //                 }
         //                 return ++last_id;
         //             }
         // 
         //             /**
         //              * Returns the template id.
         // *
         // * The template id is computed once for all by the
         //              * registry when the message type is registered.  The
         //              * registry guarantees that there are no collisions among
         //              * template ids.
         // *
         //              * @return the template id
         //              */
         //             uint16_t template_id() const
         //             {
         //                 return m_template_id;
         //             }
         // 
         //             /**
         //              * Constructs a template id.
         // *
         // * Automatically obtains a template id from the static
         // * class function
         //              */  
         //             Descriptor():
         //             m_template_id( next_template_id() )
         //             {}
         // 
         //             /**
         //              * Constructs a new Msg from the POD representation
         //              * returned by copy_pod for the given Msg.
         //              *
         //              * @param buf buffer containing the POD representation
         //              */
         //             virtual const std::shared_ptr<Msg> create_from_pod(const_buffer<uint8_t>& buf) const = 0;
         // 
         //             /**
         // * Fills the POD template.
         // *
         //              * Given a reference to an empty IETemplate, this method
         //              * fills the template with IEs representing the POD
         //              * representation of this Message.
         //              *
         //              * @param st template to fill
         //              */
         //             virtual void fill_pod_template (IPFIX::StructTemplate& st) const = 0;
         // 
         //             /**
         // * Fills the wire template.
         // *
         //              * Given a reference to an empty IETemplate (a
         //              * WireTemplate returned from
         //              * IPFIX::Session.getTemplate()), this method fills the
         //              * template with IEs representing the wire representation
         //              * of this Message.
         //              *
         //              * @param wt template to fill
         //              */
         //             virtual void fill_wire_template (IPFIX::WireTemplate& wt) const = 0;
         // 
         //             std::shared_ptr<IPFIX::StructTemplate> get_pod_template() const {
         //                 auto st = std::make_shared<IPFIX::StructTemplate>();
         //                 fill_pod_template(*st);
         //                 return std::move(st);
         //             }
         // 
         //             /**
         //              * Called after a message descriptor is registered. 
         //              */
         //             virtual void post_register() const = 0;
         // 
         //         };

    protected:
        void assert_pod_size(size_t len) const 
        {
            if (len < pod_size()) {
                throw std::runtime_error("buffer too small for pod_copy/create_from_pod()");
            }            
        }

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
