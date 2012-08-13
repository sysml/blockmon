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

#ifndef _CORE_UTILITY_HPP_
#define _CORE_UTILITY_HPP_ 

#include <type_traits>
#include <stdexcept>

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace blockmon { 

  /**
   * Checks at compile time whether the list of given types are pod. 
   *
   * Arbitrary number of types. A placeholder.
   */
    template <typename ...Ts> struct static_assert_is_pod;

  /**
   * Checks at compile time whether the list of given types are pod. 
   *
   * A single type. Used to bootstrap the induction.
   */
    template <typename T>
    struct static_assert_is_pod<T>
    {
        static_assert(std::is_pod<T>::value, "T is not pod");
    };

  /**
   * Checks at compile time whether the list of given types are pod. 
   *
   * More than one type. Induction step.
   */
    template <typename T, typename ...Ts>
    struct static_assert_is_pod<T,Ts...> : static_assert_is_pod<Ts...>
    {
        static_assert(std::is_pod<T>::value, "T is not pod");
    };

  /**
   * Throws an exception if types aren't POD.
   *
   * Arbitrary number of types. A placeholder.
   */
    template <typename ...Ts> struct assert_is_pod;

  /**
   * Throws an exception if types aren't POD.
   *
   * A single type. Used to bootstrap the induction.
   */
    template <typename T>
    struct assert_is_pod<T>
    {
        assert_is_pod() 
        {
            if (!std::is_pod<T>::value)
                throw std::runtime_error("T is not pod");
        }
    };

  /**
   * Throws an exception if types aren't POD.
   *
   * More than one type. Induction step.
   */
    template <typename T, typename ...Ts>
    struct assert_is_pod<T,Ts...> : assert_is_pod<Ts...>
    {
        assert_is_pod()
        {
            if (!std::is_pod<T>::value)
                throw std::runtime_error("T is not pod");
        }
    };


  /**
   * Tells the compiler that a boolean condition is likely to be true.
   *
   * If supported by the compiler, this will be used for better branch
   * prediction.  For example:
   *
   * @code
   * double x = ...;
   * double y = -1.0;;
   *
   * if (likely(x >= 0.0))
   *   y = sqrt(x);
   * @endcode
   */
    template <typename Tp>
    inline bool likely(Tp && expr)
    {
        return __builtin_expect(static_cast<bool>(std::forward<Tp>(expr)), 1);
    }

  /**
   * Tells the compiler that a boolean condition is unlikely to be true.
   *
   * If supported by the compiler, this will be used for better branch
   * prediction.  For example:
   *
   * @code
   * char* s = malloc(100);
   *
   * if (unlikely(s == 0))
   *   fatal("can't allocate 100 bytes");
   * @endcode
   */
    template <typename Tp>
    inline bool unlikely(Tp && expr)
    {
        return __builtin_expect(static_cast<bool>(std::forward<Tp>(expr)), 0);
    }

    /*
     * has size_of member using SFINAE... 
     */

    template <typename T>   
    class has_size_of  
    {   
        typedef char __one;
        typedef struct { char __arr[2]; } __two;

        template <typename C> static __one test(typename std::remove_reference<decltype(C::size_of())>::type *);  
        template <typename C> static __two test(...);   

    public: 
        enum { value = sizeof(test<T>(0)) == sizeof(__one) };   
    };

  /** Computes the size of a type.
   *
   * size_of<TYPE>():
   *
   * @return the value of TYPE::size_of() static function if
   * supported (required by dynamic_buffer and similars);
   * sizeof(TYPE) otherwise.
   */
     template <typename Tp>
     inline auto  
     size_of() 
     -> typename std::enable_if<has_size_of<Tp>::value,size_t>::type
     {
         return Tp::size_of(); 
     }

  /** Computes the size of a type.
   *
   * size_of<TYPE>():
   *
   * @return the value of sizeof(TYPE).
   */
     template <typename Tp>
     inline auto  
     size_of() 
     -> typename std::enable_if<!has_size_of<Tp>::value,size_t>::type
     {
         return sizeof(Tp);    
     }

  /** Advances the given pointer by the number of slots.
   *
   * Takes into account those types supporting the dynamic size
   * (size_of()).
   *
   * @param ptr the pointer to advance
   * @param n the number of slots to advance
   */

     template <typename Tp>
     inline auto 
     advance_ptr(Tp *ptr, std::size_t n) 
     -> typename std::enable_if<has_size_of<Tp>::value, Tp *>::type
     {
        return reinterpret_cast<Tp *>(
            reinterpret_cast<
                typename std::conditional<std::is_const<Tp>::value, const char, char>::type
                    *>(ptr) + Tp::size_of() * n);
     }

  /** Advances the given pointer by the number of slots.
   *
   * For types of static size.
   *
   * @param ptr the pointer to advance
   * @param n the number of slots to advance
   */
     template <typename Tp>
     inline auto 
     advance_ptr(Tp *ptr, std::size_t n) 
     -> typename std::enable_if<!has_size_of<Tp>::value, Tp *>::type 
     {
        return ptr + n;
     }


  /**
   * The N-element from a pack of types.
   * 
   * Arbitrary number of types. A placeholder.
   */

    template <size_t N, typename ...Ts> struct get_element;

  /**
   * The N-element from a pack of types.
   *
   * A single type. Used to bootstrap the induction.
   */

    template <typename T, typename ...Ts>
    struct get_element<0,T,Ts...>
    {
        typedef T type;
    };

  /**
   * The N-element from a pack of types.
   *
   * More than one type. Induction step.
   */

    template <size_t N, typename T, typename ...Ts>
    struct get_element<N,T,Ts...>
    {
        typedef typename get_element<N-1, Ts...>::type type;
    };

  /**
   * Given a type and a pack, return the index of the type, 
   * the number of types in the pack otherwise.
   *
   * Version with no matching types.
   */

    template <typename T, typename ...Ts>  
    struct get_index
    {
      enum { value = 0 }; // Conflicts with the comment!
    };

  /**
   * Given a type and a pack, return the index of the type, 
   * the number of types in the pack otherwise.
   *
   * Version where first type doesn't match.
   */
    template <typename T, typename T0, typename ...Ts>
    struct get_index<T, T0, Ts...>
    {
        enum { value = 1 + get_index<T, Ts...>::value };
    };

  /**
   * Given a type and a pack, return the index of the type, 
   * the number of types in the pack otherwise.
   *
   * Version where first type matches.
   */
    template <typename T, typename ...Ts>
    struct get_index<T, T, Ts...>
    {
        enum { value = 0 };
    };

} // namespace blockmon


#endif /* _CORE_UTILITY_HPP_ */
