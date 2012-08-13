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

#ifndef _CORE_SLICE_ALLOCATOR_HPP_
#define _CORE_SLICE_ALLOCATOR_HPP_ 

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

#include <memory>
#include <tuple>
#include <stdexcept>
#include <type_traits>
#include <iostream>

#include <Utility.hpp>

namespace blockmon {

    /////////////////////////////////////////////////////////////////////////
    
    namespace details 
    { 
        template <size_t M, typename Tp>
        static void allocate(Tp &t, std::integral_constant<size_t,0>) 
        {
            typedef typename 
            std::remove_pointer<
                typename std::tuple_element<0, Tp>::type>::type current_type;

            std::get<0>(t) = reinterpret_cast<current_type *>(new char[size_of<current_type>() * M]);
        }
        template <size_t M, size_t N, typename Tp>
        static void allocate(Tp &t, std::integral_constant<size_t, N>) 
        {
            typedef typename 
            std::remove_pointer<
                typename std::tuple_element<N, Tp>::type>::type current_type;

            std::get<N>(t) = reinterpret_cast<current_type *>(new char[size_of<current_type>() * M]);
            allocate<M>(t, std::integral_constant<size_t, N-1>());
        }
        
        template <typename Tp>
        void destroy(Tp &t, size_t s, std::integral_constant<size_t, 0>) 
        {
            typedef typename 
            std::remove_pointer<
                typename std::tuple_element<0, Tp>::type>::type current_type;
            if (!std::has_trivial_destructor<current_type>::value)
            {
                for(size_t i=0; i < s; i++)
                    advance_ptr(std::get<0>(t),i)->~current_type();
            }
            delete []reinterpret_cast<char *>(std::get<0>(t));
        }
        template <size_t N, typename Tp>
        void destroy(Tp &t, size_t s, std::integral_constant<size_t,N>) 
        {
            typedef typename 
            std::remove_pointer<
                typename std::tuple_element<N, Tp>::type>::type current_type;
            if (!std::has_trivial_destructor<current_type>::value)
            {
                for(size_t i=0; i < s; i++)
                    advance_ptr(std::get<N>(t),i)->~current_type();
            }
            delete []reinterpret_cast<char *>(std::get<N>(t));
            destroy(t, s, std::integral_constant<size_t, N-1>());
        }

        template <typename Tp, typename ...Ts>
        static void construct(Tp &r, Tp const &t, size_t offset, std::integral_constant<size_t, 0>, Ts&& ...args) 
        {
            typedef typename std::remove_pointer<
                typename std::tuple_element<0, Tp>::type>::type current_type;
            auto ptr = advance_ptr(std::get<0>(t),offset);
            if (!std::has_trivial_default_constructor<current_type>::value)
            {
                new (ptr) current_type(std::forward<Ts>(args)...); // only the first type can be constructed by passing arguments
            }
            std::get<0>(r) = ptr;
        }
        template <size_t N, typename Tp, typename ...Ts>
        static void construct(Tp &r, Tp const &t, size_t offset, std::integral_constant<size_t, N>, Ts&& ...args) 
        {    
            typedef typename std::remove_pointer<
                typename std::tuple_element<N, Tp>::type>::type current_type;
            auto ptr = advance_ptr(std::get<N>(t),offset);
            if (!std::has_trivial_default_constructor<current_type>::value)
            {
                new (ptr) current_type;
            }
            std::get<N>(r) = ptr;
            construct(r, t, offset, std::integral_constant<size_t, N-1>(), std::forward<Ts>(args)...);
        }

    } // namespace details

    /////////////////////////////////////////////////////////////////////////
    // slice class, an adapter for std::tuple<T0 *, T1 *...>
    //

    template <typename ...Ts>
    struct slice
    {
        typedef std::tuple<typename std::add_pointer<Ts>::type...> tuple_type;
        
        tuple_type tuple_;

        slice() = default;
        slice(slice const &) = default;
        slice& operator=(slice const &) = default;

        template<typename ...Vs>
        explicit slice(Vs && ...args)
        : tuple_(std::forward<Vs>(args)...)
        {}

        template <typename ...Vs>
        slice & operator=(std::tuple<Vs...> const &t)
        {
            tuple_ = t;
            return *this;
        }

        explicit operator tuple_type()
        {
            return tuple_;
        }    
    };

    template <typename Tp> struct slice_size;
    template <typename ...Ts>
    struct slice_size<slice<Ts...>> : std::integral_constant<size_t, sizeof...(Ts)> { };

    // utility to make a slice from a set of pointers
    //
    
  /** Creates a slice from a set of pointers.
   *
   * @param args the pointers to slice.
   * @return the slice.
   */
    template <typename ...Ts>
    auto make_slice(Ts* ... args)
    -> decltype(slice<Ts...>(args...))
    {
        return slice<Ts...>(args...);
    }

    // helper functions ala std::get<>
    // get a pointer by index:
    //

  /** Returns a certain pointer of a set of pointers.
   *
   * Non-const version.
   *
   * @param s a slice of pointers
   * @param N an integer
   * @return the N-th pointer of s
   */
    template <size_t N, typename ...Ts>
    inline auto get(slice<Ts...> &s) -> decltype(std::get<N>(s.tuple_))
    {
        return std::get<N>(s.tuple_);
    }

  /** Returns a certain pointer of a set of pointers.
   *
   * Const version.
   *
   * @param s a slice of pointers
   * @param N an integer
   * @return the N-th pointer of s
   */
    template <size_t N, typename ...Ts>
    inline auto get(slice<Ts...> const &s) -> decltype(std::get<N>(s.tuple_))
    {
        return std::get<N>(s.tuple_);
    }

    // helper functions ala std::get<>
    // get a pointer by name: ie. auto & iph = get<iphdr>(s);
    //
  /** Returns a certain pointer of a set of pointers.
   *
   * Non-const version.
   *
   * @param s a slice of pointers
   * @param T an typename
   * @return the first pointer of s that has type T
   */
    template <typename T, typename ...Ts>
    inline auto get(slice<Ts...> &s) -> decltype(std::get<get_index<T, Ts...>::value>(s.tuple_))
    {
        return std::get<get_index<T, Ts...>::value>(s.tuple_);
    }

  /** Returns a certain pointer of a set of pointers.
   *
   * Const version.
   *
   * @param s a slice of pointers
   * @param T an typename
   * @return the first pointer of s that has type T
   */
    template <typename T, typename ...Ts>
    inline auto get(slice<Ts...> const &s) -> decltype(std::get<get_index<T, Ts...>::value>(s.tuple_))
    {
        return std::get<get_index<T, Ts...>::value>(s.tuple_);
    }

    /////////////////////////////////////////////////////////////////////////
    // slice manager: utility class used to manage memory
    //
    
    template <size_t M, typename ...Ts>
    struct slice_manager
    {
        typedef slice<Ts...> slice_type;
        
        slice_manager()
        : index_(0)
        , slice_()
        {
            details::allocate<M>(slice_.tuple_, std::integral_constant<size_t, sizeof...(Ts)-1>());
        }

        ~slice_manager()
        {
            details::destroy(slice_.tuple_, index_, std::integral_constant<size_t, sizeof...(Ts)-1>());
        }

        slice_manager(const slice_manager &) = delete;
        slice_manager& operator=(const slice_manager &) = delete;

        template <typename ...Xs>
        slice_type 
        alloc(Xs && ...args) 
        {
            slice_type ret;
            if (index_ == M)
                throw std::runtime_error("slice_manager<Ts...>::alloc() overflow");
            details::construct(ret.tuple_, slice_.tuple_, index_++, std::integral_constant<size_t, sizeof...(Ts)-1>(), std::forward<Xs>(args)...);
            return ret;
        }

        size_t 
        size() const 
        {
            return index_;
        }

    private:          
        size_t      index_;
        slice_type  slice_;
    };

    /////////////////////////////////////////////////////////////////////////
    // slice_allocator main class.

    template <typename ...Ts>
    struct slice_allocator
    {
        typedef slice<Ts...> slice_type;
        
        static constexpr size_t NSlots = 4096*32;

        slice_allocator()
        : manager_(new slice_manager<NSlots, Ts...>())
        {}

        ~slice_allocator() = default;

        template <typename ...Xs>
        slice_type
        new_slice(Xs && ... args)
        {
            if (manager_->size() == NSlots)
                manager_.reset(new slice_manager<NSlots, Ts...>());

            return manager_->alloc(std::forward<Xs>(args)...);
        }

        template <typename T>
        std::shared_ptr<T>
        bind_shared(T *managed_memory)
        {
            return std::shared_ptr<T>(manager_, managed_memory);
        }

    private:
        std::shared_ptr<slice_manager<NSlots, Ts...>> manager_;
    };

} // namespace blockmon


#endif /* _CORE_SLICE_ALLOCATOR_HPP_ */
