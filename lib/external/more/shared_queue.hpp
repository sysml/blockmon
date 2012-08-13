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
 *
 * Author: Nicola Bonelli
 */

#ifndef _SHARED_QUEUE_HPP_
#define _SHARED_QUEUE_HPP_

#include <type_traits>
#include <thread>
#include <mutex>
#include <array>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4
#include <cstdatomic>
#elif __GNUC__ == 4 &&  __GNUC_MINOR__ >= 5
#include <atomic>
#endif

namespace more 
{
    namespace details {

        template <typename T>
        struct cacheline 
        { 
            cacheline()
            : value()
            {}
            
            T value;

        } __attribute__((aligned(64)));


        template <int N, typename Lock>    
        struct shared_queue_lock_traits
        {
            typedef Lock lock_type;
        };

        template <typename Lock> 
        struct shared_queue_lock_traits<0,Lock>;

        template <typename Lock>
        struct shared_queue_lock_traits<1, Lock>
        {
            struct null_lock
            {
                void lock()
                {}

                void unlock()
                {}

                bool try_lock()
                {
                    return true;
                }
            };

            typedef null_lock lock_type; 
        };
    }

    struct single_producer
    {
        enum { producer_value = 1 };    
    };
    struct multiple_producer
    {
        enum { producer_value = 2 };    
    };
    struct single_consumer
    {
        enum { consumer_value = 1 };    
    };
    struct multiple_consumer
    {
        enum { consumer_value = 2 };    
    };

    template <typename T, unsigned int N = 1024, 
              typename Producer = single_producer, 
              typename Consumer = single_consumer, 
              typename Lock = std::mutex > 
    class shared_queue  
    {
        public:
            typedef typename std::array<T,N>::size_type  size_type;
            typedef typename std::array<T,N>::value_type value_type;

            typedef typename details::shared_queue_lock_traits<Producer::producer_value,Lock>::lock_type head_lock_type;
            typedef typename details::shared_queue_lock_traits<Consumer::consumer_value,Lock>::lock_type tail_lock_type;
            
            typedef unsigned int unsigned_type;
            
            typedef struct _h { _h() : index(0), lock() {}; std::atomic<unsigned_type> index; head_lock_type lock; } head_cache_type;
            typedef struct _t { _t() : index(0), lock() {}; std::atomic<unsigned_type> index; tail_lock_type lock; } tail_cache_type;

        private:
            std::array<value_type, N> _M_storage;

            details::cacheline<head_cache_type> _M_head;
            details::cacheline<tail_cache_type> _M_tail;

            static unsigned_type 
            _S_mod(unsigned_type n)
            {
                return n & (N-1);
            }
        
        public:
            shared_queue() 
            : _M_storage(), _M_head(), _M_tail() 
            {
                static_assert((N & (N-1)) == 0, "N not a power of two"); 
            }

            ~shared_queue() 
            {}

            bool 
            pop_front(T& ret) 
            {
                std::lock_guard<tail_lock_type> _lock_(_M_tail.value.lock);
                auto tail = _M_tail.value.index.load(std::memory_order_acquire);
                if (tail == _M_head.value.index.load(std::memory_order_acquire)) 
                    return false;

                ret = std::move(_M_storage[tail]);
                _M_tail.value.index.store(_S_mod(tail+1), std::memory_order_release);
                return true;
            }

            const T& front()
            {
                auto tail = _M_tail.value.index.load(std::memory_order_acquire);

                return _M_storage[tail];
            }

            bool 
            push_back(const T& elem)  
            {
                std::lock_guard<head_lock_type> _lock_(_M_head.value.lock);
                auto head = _M_head.value.index.load(std::memory_order_acquire);
                auto next = _S_mod(head+1);

                if (next == _M_tail.value.index.load(std::memory_order_acquire)) 
                   return false;

                _M_storage[head] = elem;
                _M_head.value.index.store(next, std::memory_order_release);
                return true;
            }

            bool 
            push_back(T&& elem)  
            {
                std::lock_guard<head_lock_type> _lock_(_M_head.value.lock);
                auto head = _M_head.value.index.load(std::memory_order_acquire);
                auto next = _S_mod(head+1);

                if (next == _M_tail.value.index.load(std::memory_order_acquire)) 
                   return false;
                
                _M_storage[head] = elem;
                _M_head.value.index.store(next, std::memory_order_release);
                return true;
            }

            void 
            clear() 
            { 
                std::lock_guard<tail_lock_type> _lock_(_M_tail.value.lock);
                for(auto n = _M_tail.value.index.load(std::memory_order_acquire); 
                      n != _M_head.value.index.load(std::memory_order_acquire); ) {
                    _M_storage[n] = T();
                    n = _S_mod(n+1);
                }

                _M_tail.value.index.store(_M_head.value.index.load(std::memory_order_acquire), 
                                          std::memory_order_release);
            }
            
            bool
            empty() const 
            { 
                return _M_head.value.index.load(std::memory_order_acquire) == 
                        _M_tail.value.index.load(std::memory_order_acquire); 
            }

            size_type 
            max_size() const 
            { 
                return N; 
            }

            size_type 
            size() const 
            {
                int s =  _M_head.value.index.load(std::memory_order_acquire) - 
                            _M_tail.value.index.load(std::memory_order_acquire);
                return s < 0 ? s + N : s;
            }
        };

} // namespace more

#endif /* _SHARED_QUEUE_HPP_ */

