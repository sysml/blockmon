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

#ifndef _CORE_DISSECTORS_DISSECTOR_HPP_
#define _CORE_DISSECTORS_DISSECTOR_HPP_

#include "ethernet.hpp"
#include "ipv4.hpp"
#include "tcp.hpp"
#include "udp.hpp"
#include "icmp.hpp"
#include "payload.hpp"
#include "undefinedptr.hpp"

#include <Assert.hpp>
#include <SliceAllocator.hpp>

#include <stdexcept>
#include <type_traits>

/*
 * Author: Nicola Bonelli <nicola.bonelli@cnit.it>
 */

namespace net {

    
    template <typename ...Ts> struct proto_parents {};
    

    template <typename T> struct parent_list_size;
    template <typename ...Ts> struct 
    parent_list_size<proto_parents<Ts...>>
    {
        enum { value = sizeof...(Ts) };
    };

    template <typename T> struct const_proto_parents;
    template <typename ...Ts>
    struct const_proto_parents<proto_parents<Ts...>>
    {
        typedef proto_parents< typename std::add_const<Ts>::type...> type;
    };

    // protocol headers' 
    //

    template <typename Tp> struct header_traits;

    template <>
    struct header_traits<ethernet>
    {
        typedef proto_parents<> parents_type; 
        enum : uint16_t { proto = 0 };
    };

    template <>
    struct header_traits<ipv4>
    {
        typedef proto_parents<ethernet> parents_type; 
        enum : uint16_t { proto = ETHERTYPE_IP };
    };
    template <>
    struct header_traits<tcp>
    {
        typedef proto_parents<ipv4> parents_type; 
        enum : uint16_t { proto = IPPROTO_TCP };
    };
    template <>
    struct header_traits<udp>
    {
        typedef proto_parents<ipv4> parents_type; 
        enum : uint16_t { proto = IPPROTO_UDP };
    };
    template <>
    struct header_traits<icmp>
    {
        typedef proto_parents<ipv4> parents_type; 
        enum : uint16_t { proto = IPPROTO_ICMP };
    };

    template <>
    struct header_traits<payload>
    {
        typedef proto_parents<udp, tcp, icmp, ipv4, ethernet> parents_type; 
        enum : uint16_t { proto = 0 };
    }; 

    template <typename H, typename ...Ts>
    typename std::add_pointer<H>::type get_header(blockmon::slice<Ts...> &s);

    template <typename Tp>
    struct void_pointer
    {
        typedef typename std::conditional<std::is_const<Tp>::value, const void *, void *>::type type;
    };

    template <typename Tp>
    auto void_cast(Tp *p)
    -> decltype(static_cast<typename void_pointer<Tp>::type>(p))
    {
        return static_cast<typename void_pointer<Tp>::type>(p);
    }

    ///////////////////////////////////////////////////////////////////////////////////////

    /// get_parent()

    template <size_t N, typename ...Ts, typename ...Ps>
    std::pair<typename void_pointer<typename blockmon::get_element<0, Ts...>::type >::type,
                size_t> 
    get_parent(blockmon::slice<Ts...> &, uint16_t, proto_parents<Ps...>, std::false_type)
    {
        return {NULL, 0};
    }

    template <size_t N, typename ...Ts, typename ...Ps>
    std::pair<typename void_pointer<typename blockmon::get_element<0, Ts...>::type >::type,
              size_t> 
    get_parent(blockmon::slice<Ts...> &s, uint16_t proto, proto_parents<Ps...>, std::true_type)
    {  
        typedef typename blockmon::get_element<N, Ps...>::type this_parent;
        
        auto p = get_header<this_parent>(s);

#if 0
        std::cout << typeid(this_parent).name() << " *** header: ptr@" << (void *)p << " index:" << N << " protocol:" << std::hex << 
                 ( p ? std::string("*").append(std::to_string(p->proto())) : "-") << std::dec;
#endif

        if (p != nullptr && (proto == 0 || proto == p->proto())) {
            return std::make_pair(void_cast(p), p->size_of());
        }

        return get_parent<N+1>(s, proto, proto_parents<Ps...>(), 
                               typename std::integral_constant<bool, (N+1) < sizeof...(Ps)>());
    }

    template <typename H, typename ...Ts>
    std::pair<typename std::conditional< std::is_const<H>::value, const void *, void *>::type, 
              size_t> 
    get_parent(blockmon::slice<Ts...> &s)
    {   
        typedef typename header_traits<typename std::remove_const<H>::type>::parents_type basic_type;

        typedef typename std::conditional<std::is_const<H>::value,
                            typename const_proto_parents<basic_type>::type, basic_type
                            >::type parents_type; 

        return get_parent<0>(s, header_traits<typename std::remove_const<H>::type>::proto, parents_type(), 
                                std::integral_constant<bool, parent_list_size<parents_type>::value != 0 >());
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////
    
    /// get_header<HeaderType>(Slice)

    template <typename H, typename ...Ts>
    typename std::add_pointer<H>::type
    get_header(blockmon::slice<Ts...> &s, std::true_type)
    {
        auto h = blockmon::get<H>(s);
        if (h != undefinedptr)
            return blockmon::get<H>(s); 

        auto par = get_parent<H>(s);

        if (!par.first) {
            blockmon::get<H>(s) = NULL;
        }
        else {
            blockmon::get<H>(s) = reinterpret_cast<H *>(
                                    static_cast<
                                        typename std::conditional< std::is_const<H>::value, const char *, char *>::type
                                    >(par.first) + par.second);
        }

        return blockmon::get<H>(s);
    }

    template <typename H, typename ...Ts>
    typename std::add_pointer<H>::type
    get_header(blockmon::slice<Ts...> &, std::false_type)
    {
        return static_cast<H *>(0);
    }

    template <typename H, typename ...Ts>
    typename std::add_pointer<H>::type
    get_header(blockmon::slice<Ts...> &s)
    {
        return get_header<H>(s, std::integral_constant<bool, blockmon::get_index<H, Ts...>::value < sizeof...(Ts) >());
    }


} // namespace net


#endif // _CORE_DISSECTORS_DISSECTOR_HPP_
