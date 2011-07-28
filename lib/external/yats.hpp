
/*-WARE LICENSE" (Revision 42):
 * <bonelli@antifork.org> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Nicola Bonelli
 * ----------------------------------------------------------------------------
 */

#ifndef _YATS_HPP_
#define _YATS_HPP_

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <functional>
#include <algorithm>
#include <stdexcept>
#include <typeinfo>
#include <vector>
#include <memory>
#include <map>

#ifdef __linux__
#include <cxxabi.h>
#endif

/* the so-called __VA_NARG__ (PP_NARG) macro from the thread at
   http://groups.google.com/group/comp.std.c/browse_frm/thread/77ee8c8f92e4a3fb
 */

#ifndef PP_NARG
#define PP_NARG(...) \
         PP_NARG_(__VA_ARGS__,PP_RSEQ_N())
#define PP_NARG_(...) \
         PP_ARG_N(__VA_ARGS__)
#define PP_ARG_N( \
          _1, _2, _3, _4, _5, _6, _7, _8, _9,_10, \
         _11,_12,_13,_14,_15,_16,_17,_18,_19,_20, \
         _21,_22,_23,_24,_25,_26,_27,_28,_29,_30, \
         _31,_32,_33,_34,_35,_36,_37,_38,_39,_40, \
         _41,_42,_43,_44,_45,_46,_47,_48,_49,_50, \
         _51,_52,_53,_54,_55,_56,_57,_58,_59,_60, \
         _61,_62,_63,N,...) N
#define PP_RSEQ_N() \
         63,62,61,60,                   \
         59,58,57,56,55,54,53,52,51,50, \
         49,48,47,46,45,44,43,42,41,40, \
         39,38,37,36,35,34,33,32,31,30, \
         29,28,27,26,25,24,23,22,21,20, \
         19,18,17,16,15,14,13,12,11,10, \
         9,8,7,6,5,4,3,2,1,0
#endif

#ifndef PASTE
#define PASTE(a,b)      a ## b
#define XPASTE(a,b)     PASTE(a,b)
#endif

#define YATS_assert_1(value)            yats::assert_predicate(value, is_true(),_context_name, _name, __LINE__)
#define YATS_assert_2(value,pred)       yats::assert_predicate(value, pred,     _context_name, _name, __LINE__)

#define YATS_assert_throw_1(value)      YATS_assert_throw_any (value, __LINE__)
#define YATS_assert_throw_2(value,obj)  YATS_assert_throw_type(value, obj, __LINE__)

#define YATS_error(context, name) "Context " << context << ": test " << name

#define YATS_assert_nothrow(exp,line) \
try \
{ \
    exp; \
} \
catch(std::exception &e) \
{           \
    std::ostringstream err; \
    err << std::boolalpha << YATS_error(_context_name, _name) \
                        << " -> exception not expected. Got " \
                        << yats::type_name(e) << "(\"" << e.what() << "\")" \
                        << " error at line " << line; \
    throw std::runtime_error(err.str()); \
} \
catch(...) \
{           \
    std::ostringstream err; \
    err << std::boolalpha << YATS_error(_context_name, _name) \
                        << " -> exception not expected: got unknown exception. Error at line " << line; \
    throw std::runtime_error(err.str()); \
}

#define YATS_assert_throw_any(exp,line) \
{ \
    bool thrown = false; \
    try \
    { \
        exp; \
    } \
    catch(...) \
    {                \
        thrown = true; \
    }           \
    if (!thrown) \
    {  \
        std::ostringstream e; \
        e << std::boolalpha << YATS_error(_context_name, _name) \
                            << " -> exception expected. Error at line " << line; \
        throw std::runtime_error(e.str()); \
    }  \
}

#define YATS_assert_throw_type(exp, obj, line) \
{ \
    bool thrown = false; \
    try \
    { \
        exp; \
    } \
    catch(decltype(obj) &e) \
    { \
        if (std::string(e.what()).compare(obj.what())) { \
            std::ostringstream err; \
            err << std::boolalpha << YATS_error(_context_name, _name) \
                            << " -> " << yats::type_name(obj)  \
                            <<  " caught but reasons mismatching! Got '" << e.what() << "' while '" << obj.what()  << "' is expected. Error at line " << line; \
            throw std::runtime_error(err.str()); \
        } \
        thrown = true; \
    } \
    catch(...) \
    { \
        std::ostringstream err; \
        err << std::boolalpha << YATS_error(_context_name, _name) \
                        << " -> " << yats::type_name(obj)  \
                        <<  " expected. Got a different exception. Error at line " << line; \
        throw std::runtime_error(err.str()); \
    }  \
    \
    if (!thrown) \
    {  \
        std::ostringstream err; \
        err << std::boolalpha << YATS_error(_context_name, _name) \
                            << " -> exception " << yats::type_name(obj) << " expected. Error at line " << line; \
        throw std::runtime_error(err.str()); \
    }  \
}

#define Assert(...)                     XPASTE(YATS_assert_       ,PP_NARG(__VA_ARGS__)) ( __VA_ARGS__)
#define AssertThrow(...)                XPASTE(YATS_assert_throw_ ,PP_NARG(__VA_ARGS__)) ( __VA_ARGS__)
#define AssertNothrow(value)            YATS_assert_nothrow(value, __LINE__)

#define Context(ctx) \
namespace ctx { static const char _context_name[] = #ctx; } \
namespace ctx

#define Test(name) \
void test_ ## name(const char *); \
yats::task_register hook_ ## name(test_ ## name, task_register::type::test, _context_name, #name); \
void test_ ## name(const char *_name)

#define Setup(name) \
void setup_ ## name(const char *); \
yats::task_register fixture_ ## name(setup_ ## name, task_register::type::setup, _context_name); \
void setup_ ## name(const char *)

#define Teardown(name) \
void teardown_ ## name(const char *); \
yats::task_register fixture_ ## name(teardown_ ## name, task_register::type::teardown, _context_name); \
void teardown_ ## name(const char *)

using namespace std::placeholders;

namespace yats
{

#ifdef __linux__
    static inline
    std::string
    cxa_demangle(const char *name)
    {
        int status;
        std::shared_ptr<char> ret(abi::__cxa_demangle(name,0,0, &status), ::free);
        if (status < 0)
            throw std::runtime_error("__cxa_demangle");
        return std::string(ret.get());
    }

#else
    static inline
    std::string
    cxa_demangle(const char *name)
    {
        return std::string(name);
    }
#endif

    template <typename Tp>
    std::string
    type_name(const Tp &t)
    {
        return cxa_demangle(typeid(t).name());
    }

    struct context
    {
        typedef std::function<void()> task;

        std::string name;
        std::vector<task> setup;
        std::vector<task> teardown;
        std::vector<std::pair<task,std::string>> task_list;

        static std::map<std::string, context> &
        instance()
        {
            static std::map<std::string, context> m;
            return m;
        }

        context(const std::string &n)
        : name(n), setup(), teardown(), task_list()
        {}
    };

    static int run()
    {
        auto it = context::instance().begin(),
             it_e = context::instance().end();

        unsigned int tot_task = 0;
        for(auto i = it; i != it_e; ++i)
        {
            tot_task += i->second.task_list.size();
        }

        unsigned int n = 0;
        std::cout << "Running " << tot_task << " tests in " << context::instance().size() << " contexts." << std::endl;

        // iterate over contexts:
        for(; it != it_e; ++it)
        {
            auto i = it->second.task_list.begin(),
                 i_e = it->second.task_list.end();

            // run setup:
            std::for_each(it->second.setup.begin(), it->second.setup.end(),
                          std::mem_fn(&context::task::operator()));

            for(; i != i_e; ++i)
            {
                try
                {
                    i->first.operator()();
                    n++;
                }
                catch(std::exception &e)
                {
                    std::cerr << e.what() << std::endl;
                }
            }

            // run teardown:
            std::for_each(it->second.teardown.begin(), it->second.teardown.end(),
                          std::mem_fn(&context::task::operator()));
        }

        std::cerr << tot_task - n << " tests failed." << std::endl;
        return n == tot_task ? EXIT_SUCCESS : EXIT_FAILURE;
    }

    struct task_register
    {
        enum class type { test, setup, teardown };

        task_register(void(*f)(const char *), type t, const char * ctx, const char *name= "")
        {
            auto i = context::instance().insert(std::make_pair(ctx, context(ctx)));

            switch(t)
            {
            case type::test:
                i.first->second.task_list.push_back(std::make_pair(std::bind(f, name), name));
                break;
            case type::setup:
                i.first->second.setup.push_back(std::bind(f,name));
                break;
            case type::teardown:
                i.first->second.teardown.push_back(std::bind(f,name));
                break;
            default:
                throw std::runtime_error("task_register");
            }
        }
    };

    template <typename T>
    struct predicate
    {
        std::pair<typename std::remove_reference<T>::type,bool> value;
        const char * descr;
        std::function<bool(const T&)> fun;

        predicate(const char * _descr, std::function<bool(const T&)> _fun, const T& _value)
        : value(std::make_pair(_value, true)), descr(_descr), fun(_fun)
        {}

        predicate(const char * _descr, std::function<bool(const T&)> _fun)
        : value(), descr(_descr), fun(_fun)
        {}

        bool operator()(const T &_value) const
        {
            return fun(_value);
        }
    };

    template <typename T1, typename T2>
    void assert_predicate(const T1 &_value, const predicate<T2> &pred, const char *_ctx, const char *_name, int line)
    {
        if (!pred(_value)) {
            std::ostringstream err;
            err << std::boolalpha << YATS_error(_ctx, _name)
                                << " -> predicate " << pred.descr;
            if (pred.value.second)
                err << '(' << pred.value.first << ')';
            err << " failed: got (" << _value <<  "). Error at line " << line;
            throw std::runtime_error(err.str());
        }
    }

    /// standard predicates...

#define YATS_functional(_name_) \
    template <typename T> \
    inline predicate<T> \
    is_ ## _name_ (const T &value)  \
    {                        \
        return predicate<T>("is_" #_name_,  \
                            std::function<bool(const T&)>( \
                                std::bind(std::_name_<T>(), _1, value)), \
                                value); \
    }

    YATS_functional(greater);
    YATS_functional(greater_equal);
    YATS_functional(less);
    YATS_functional(less_equal);
    YATS_functional(equal_to);
    YATS_functional(not_equal_to);

    /// boolean...

    inline predicate<bool>
    is_true()
    {
        return predicate<bool>("is_boolean",
                            std::function<bool(bool)>(
                                std::bind(std::equal_to<bool>(), _1, true)), true);
    }

    inline predicate<bool>
    is_false()
    {
        return predicate<bool>("is_boolean",
                            std::function<bool(bool)>(
                                std::bind(std::equal_to<bool>(), _1, false)), false);
    }

    /// generic predicate: bool(Tp)

    template <typename Tp, typename Fn>
    inline predicate<Tp>
    generic_predicate(const char *name, Fn fun)
    {
        return predicate<Tp>(name, std::function<bool(const Tp &)>(fun));
    }
}

#endif /* _YATS_HPP_ */

