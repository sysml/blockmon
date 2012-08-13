#ifndef _MESSAGES_EMPTYMESSAGE_HPP_
#define _MESSAGES_EMPTYMESSAGE_HPP_

#include <type_traits>

#include <Msg.hpp>
#include <ClassId.hpp>

namespace blockmon
{

    class EmptyMsg: public Msg
    {
    public:

        /** Forbids move constructor (copying allowed).	 */
    	EmptyMsg(const EmptyMsg&&)=delete;

        /** Forbids copy and move assignment.
	 */
    	EmptyMsg& operator=(const EmptyMsg&)=delete;

        /**
          message constructor that takes key and value by copy
          this version can work with the batch allocator 
          */
    	EmptyMsg(mutable_buffer<char> b = mutable_buffer<char>(), bool ownership = false)
        : Msg(type_to_id<EmptyMsg>::id(), b, ownership)
        {}

    	EmptyMsg(EmptyMsg const &other)
        : Msg(other)        
        {}


        /**
          message destructor 
          */
        ~EmptyMsg()
        {}

        void 
        pod_copy(mutable_buffer<uint8_t> buf) const 
        {
	      	  throw std::runtime_error("EmptyMessage::pod_copy not implemented");
        }

        size_t pod_size() const 
        {
        	throw std::runtime_error("EmptyMessage::pod_size not implemented");
        }

        /**
          returns a copy of the message
          */
         
        std::shared_ptr<Msg> clone() const 
        {
            return std::make_shared<EmptyMsg>(*this);
        }    


    };

}

#endif // _MESSAGES_EMPTYMESSAGE_HPP_
