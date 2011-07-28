

/*-WARE LICENSE" (Revision 42):
 * <bonelli@antifork.org> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Nicola Bonelli
 * ----------------------------------------------------------------------------
 */

#ifndef _MORE_FACTORY_HPP_
#define _MORE_FACTORY_HPP_

#include <type_traits>
#include <memory>
#include <string>
#include <map>

namespace more {

    template <typename B, typename ... Arg>
    struct factory_base_allocator
    {
        virtual ~factory_base_allocator()
        {}

        virtual B * alloc(Arg&& ... ) = 0;
    };

    template <typename B, typename E, typename ... Arg >   // B must be a base class of E
    struct factory_allocator : public factory_base_allocator<B,Arg...>
    {
        static_assert(std::is_base_of<B,E>::value, "base_of relationship violated");

        virtual E * alloc(Arg && ... arg)
        {
            return new E(std::forward<Arg>(arg)...);
        }
    };

    /////////////////////////////////////////////////////////////////////
    // utility: auto-register the allocator of E element (derived from B)
    //                to the F factory

    template <typename Tp>
    struct fac_arg {};

    template <typename B  /* Base */,
              typename E  /* element */
              >
    struct factory_register
    {
        static_assert( std::is_base_of<B,E>::value, "base_of relationship violated");

        template <typename F, typename K, typename ...Arg>
        factory_register(F &f, const K &key, fac_arg<Arg>&& ...)
        {
            f.regist(key, new typename more::factory_allocator<B, E, Arg...>);
        }
    };

    /////////////////////////////////////////
    // factory class: K:key -> T:base_element

    template <typename K, typename B, typename ... Arg>
    class factory
    {
    public:
        typedef std::map<K, std::shared_ptr<factory_base_allocator<B,Arg...>>> map_type;

        factory()
        : _M_map()
        {}

        ~factory()
        {}

        bool
        regist(const K & key, factory_base_allocator<B,Arg...> * value)
        { return _M_map.insert(make_pair(key, std::shared_ptr<factory_base_allocator<B,Arg...> >(value))).second; }

        bool
        unregist(const K &key)
        { return _M_map.erase(key) == 1; }

        bool
        is_registered(const K &key) const
        {
            return _M_map.count(key) != 0;
        }

        template <typename ...Ti>
        std::shared_ptr<B>
        operator()(const K &key, Ti&& ... arg) const
        {
            auto it = _M_map.find(key);
            if (it == _M_map.end())
                return std::shared_ptr<B>();
            return std::shared_ptr<B>(it->second->alloc(std::forward<Ti>(arg)...));
        }

        // static instances...
        template <size_t N>
        static factory &
        instance()
        {
            static factory s;
            return s;
        }

    private:
        map_type _M_map;
    };

} // namespace more

#endif /* _MORE_FACTORY_HPP_ */

