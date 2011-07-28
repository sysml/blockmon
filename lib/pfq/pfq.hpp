
/***************************************************************
 *                                                
 * (C) 2011 - Nicola Bonelli <bonelli@cnit.it>   
 *
 ***************************************************************/

#ifndef _PFQ_HPP_
#define _PFQ_HPP_ 

#include <linux/if_ether.h>
#include <linux/pf_q.h>

#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/mman.h>
#include <poll.h>

#include <iostream>
#include <stdexcept>
#include <iterator>
#include <cstring>
#include <cassert>

#ifdef __GXX_EXPERIMENTAL_CXX0X__ 
#define member_function_deleted = delete
#else
#define member_function_deleted
#endif

namespace net { 

    typedef std::pair<char *, size_t> mutable_buffer;
    typedef std::pair<const char *, const size_t> const_buffer;

    class batch 
    {
    public:
         
        struct const_iterator;

        /* simple forward iterator over frames */
        struct iterator : public std::iterator<std::forward_iterator_tag, pfq_hdr>
        {
            friend struct batch::const_iterator;

            iterator(pfq_hdr *h, int n, int l)
            : hdr(h), num(n), len(l)
            {}

            iterator(const iterator &other)
            : hdr(other.hdr), num(other.num), len(other.len)
            {}

            ~iterator()
            {}

            iterator & 
            operator++()
            {
                ++num;
                hdr = reinterpret_cast<pfq_hdr *>(
                        reinterpret_cast<char *>(hdr+1) + len);
                return *this;
            }
            
            iterator 
            operator++(int)
            {
                iterator ret(*this);
                ++(*this);
                return ret;
            }

            pfq_hdr *
            operator->() const
            {
                return hdr;
            }

            pfq_hdr &
            operator*() const                                  
            {
                return *hdr;
            }

            char *
            data() const
            {
                return reinterpret_cast<char *>(hdr+1);
            }

            bool 
            operator==(const iterator &other) const
            {
                return num == other.num;
            }

            bool
            operator!=(const iterator &other) const
            {
                return !(*this == other);
            }

        private:
            pfq_hdr *hdr;
            int num;
            int len;
        };

        /* simple forward const_iterator over frames */
        struct const_iterator : public std::iterator<std::forward_iterator_tag, pfq_hdr>
        {
            const_iterator(pfq_hdr *h, int n, int l)
            : hdr(h), num(n), len(l)
            {}

            const_iterator(const const_iterator &other)
            : hdr(other.hdr), num(other.num), len(other.len)
            {}

            const_iterator(const batch::iterator &other)
            : hdr(other.hdr), num(other.num), len(other.len)
            {}

            ~const_iterator()
            {}

            const_iterator & 
            operator++()
            {
                ++num;
                hdr = reinterpret_cast<pfq_hdr *>(
                        reinterpret_cast<char *>(hdr+1) + len);
                return *this;
            }
            
            const_iterator 
            operator++(int)
            {
                const_iterator ret(*this);
                ++(*this);
                return ret;
            }

            const pfq_hdr *
            operator->() const
            {
                return hdr;
            }

            const pfq_hdr &
            operator*() const
            {
                return *hdr;
            }

            const char *
            data() const
            {
                return reinterpret_cast<const char *>(hdr+1);
            }

            bool 
            operator==(const const_iterator &other) const
            {
                return num == other.num;
            }

            bool
            operator!=(const const_iterator &other) const
            {
                return !(*this == other);
            }

        private:
            pfq_hdr *hdr;
            int num;
            int len;
        };


    public:
        batch(char *p, int n, int l)
        : m_ptr(p), m_num(n), m_len(l)
        {}
        
        size_t
        size() const
        {
            return m_num;
        }

        iterator
        begin()  
        {
            return iterator(reinterpret_cast<pfq_hdr *>(m_ptr),0, m_len);
        }

        const_iterator
        begin() const  
        {
            return const_iterator(reinterpret_cast<pfq_hdr *>(m_ptr),0,m_len);
        }

        iterator
        end()  
        {
            return iterator(reinterpret_cast<pfq_hdr *>(m_ptr),m_num,m_len);
        }

        const_iterator
        end() const 
        {
            return const_iterator(reinterpret_cast<pfq_hdr *>(m_ptr),m_num,m_len);
        }

#ifdef __GXX_EXPERIMENTAL_CXX0X__ 
        const_iterator
        cbegin() const
        {
            return const_iterator(reinterpret_cast<pfq_hdr *>(m_ptr),0,m_len);
        }

        const_iterator
        cend() const 
        {
            return const_iterator(reinterpret_cast<pfq_hdr *>(m_ptr), m_num, m_len);
        }
#endif

    private:
        char *m_ptr;
        int   m_num;
        int   m_len;
    };

    //////////////////////////////////////////////////////////////////////

    struct pfq_open_t {};
    
    namespace
    {
        pfq_open_t pfq_open = {};
    }

    class pfq
    {
    public:
        static const int any_device = Q_ANY_DEVICE;
        static const int any_queue  = Q_ANY_QUEUE;
        static const int any_frame  = Q_ANY_FRAME;

        pfq()
        : m_q(-1),
          m_id(0),
          m_slot(0),
          m_slot_size(0),
          m_queue_size(sizeof(struct pfq_queue_descr)),
          m_mem(NULL),
          m_mem_size(0)
        {}

        pfq(pfq_open_t)
        : m_q(socket(PF_Q, SOCK_RAW, htons(ETH_P_ALL))),
          m_id(get_id()),             
          m_slot(0),
          m_slot_size(0),
          m_queue_size(sizeof(struct pfq_queue_descr)),
          m_mem(NULL),
          m_mem_size(0)
        {
            if (m_q == -1)
                throw std::runtime_error("PFQ module not loaded");

            int tot_mem; socklen_t size = sizeof(int);
            if (::getsockopt(m_q, PF_Q, SO_GET_TOT_MEM, &tot_mem, &size) == -1)
                throw std::runtime_error("pfq: SO_GET_TOT_MEM");

            if ((m_mem = mmap(NULL, tot_mem, PROT_READ|PROT_WRITE, MAP_SHARED, m_q, 0)) == MAP_FAILED) 
                throw std::runtime_error("pfq: mmap");

            m_mem_size = tot_mem;
            
            size = sizeof(int);
            if (::getsockopt(m_q, PF_Q, SO_GET_NUM_SLOT, &m_slot, &size) == -1)
                throw std::runtime_error("pfq: SO_GET_NUM_SLOT");

            size = sizeof(int);
            if (::getsockopt(m_q, PF_Q, SO_GET_SLOT_SIZE, &m_slot_size, &size) == -1)
                throw std::runtime_error("pfq: SO_GET_SLOT_SIZE");

            m_queue_size = sizeof(struct pfq_queue_descr) +
                            (sizeof(struct pfq_hdr) + m_slot_size) * m_slot;

        }

        ~pfq()
        {
            this->dtor();
        }

    private:                 
        pfq(const pfq&) member_function_deleted;
        pfq& operator=(const pfq&) member_function_deleted;

    public:

#ifdef __GXX_EXPERIMENTAL_CXX0X__ 
        pfq(pfq && other)
        : m_q(other.m_q), 
          m_id(other.m_id),
          m_slot(other.m_slot), 
          m_slot_size(other.m_slot_size),
          m_queue_size(other.m_queue_size), 
          m_mem(other.m_mem), 
          m_mem_size(other.m_mem_size)
        {
            other.m_q = -1;
            other.m_id = -1;
            other.m_slot = 0;
            other.m_slot_size = 0;
            other.m_queue_size = 0;
            other.m_mem = 0;
            other.m_mem_size = 0;
        }

        pfq& operator=(pfq &&other)
        {
            if (this != &other)
            {
                this->dtor();

                m_q = other.m_q;
                m_id = other.m_id;
                m_slot = other.m_slot;
                m_slot_size = other.m_slot_size;
                m_queue_size = other.m_queue_size;
                m_mem = other.m_mem;
                m_mem_size = other.m_mem_size;
        
                other.m_q = -1;    
                other.m_id = -1;
                other.m_slot = 0;
                other.m_slot_size = 0;
                other.m_queue_size = 0;
                other.m_mem = 0;
                other.m_mem_size = 0;
            }
            return *this;
        }
#endif
        void swap(pfq &other)
        {
            std::swap(m_q,          other.m_q);
            std::swap(m_id,         other.m_id);
            std::swap(m_slot,       other.m_slot);
            std::swap(m_slot_size,  other.m_slot_size);
            std::swap(m_queue_size, other.m_queue_size);
            std::swap(m_mem,        other.m_mem);
            std::swap(m_mem_size,   other.m_mem_size);
        }

        int id() const
        {
            return m_id;
        }

        void enable()
        {
            char one = 1;
            if(::setsockopt(m_q, PF_Q, SO_TOGGLE_QUEUE, &one, sizeof(one)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        void disable()
        {
            char one = 0;
            if(::setsockopt(m_q, PF_Q, SO_TOGGLE_QUEUE, &one, sizeof(one)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        void load_balance(bool value)
        {
            int one = value;
            if (::setsockopt(m_q, PF_Q, SO_LOAD_BALANCE, &one, sizeof(one)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        bool is_enabled() const
        {
            int ret; socklen_t size = sizeof(int);
            if (::getsockopt(m_q, PF_Q, SO_GET_STATUS, &ret, &size) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
            return ret;
        }

        int ifindex(const char *dev)
        {
            struct ifreq ifreq_io;
            strncpy(ifreq_io.ifr_name, dev, IFNAMSIZ);
            if (::ioctl(m_q, SIOCGIFINDEX, &ifreq_io) == -1)
                return -1;
            return ifreq_io.ifr_ifindex;
        }

        int slots() const
        {
            return m_slot;
        }

        int slot_size() const
        {
            return m_slot_size;
        }

        void tstamp_type(int type)
        {
            if (::setsockopt(m_q, PF_Q, SO_TSTAMP_TYPE, &type, sizeof(int)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        int tstamp_type() const
        {
           int ret; socklen_t size = sizeof(int);
           if (::getsockopt(m_q, PF_Q, SO_GET_TSTAMP_TYPE, &ret, &size) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
           return ret;
        }

        int pipeline_len() const
        {
           int ret; socklen_t size = sizeof(int);
           if (::getsockopt(m_q, PF_Q, SO_GET_PIPELINE_LEN, &ret, &size) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
           return ret;
        }

        void 
        pipeline_len(unsigned int len)
        {
            if (::setsockopt(m_q, PF_Q, SO_SET_PIPELINE_LEN, &len, sizeof(int)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        void add_device(int index, int queue)
        {
            struct pfq_dev_queue dq = { index, queue };
            if (::setsockopt(m_q, PF_Q, SO_ADD_DEVICE, &dq, sizeof(dq)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }
        
        void remove_device(int index, int queue)
        {
            struct pfq_dev_queue dq = { index, queue };
            if (::setsockopt(m_q, PF_Q, SO_REMOVE_DEVICE, &dq, sizeof(dq)) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
        }

        unsigned long 
        owners(int index, int queue) const
        {
            struct pfq_dev_queue dq = { index, queue };
            socklen_t s = sizeof(struct pfq_dev_queue);

            if (::getsockopt(m_q, PF_Q, SO_GET_OWNERS, &dq, &s) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
            return *reinterpret_cast<unsigned long *>(&dq);
        }

        int 
        poll(long int microseconds = -1 /* infinite */)
        {
            struct pollfd fd = {m_q, POLLIN, 0 };
            struct timespec timeout = { microseconds/1000000, (microseconds%1000000) * 1000};

            int ret = ::ppoll(&fd, 1, microseconds < 0 ? NULL : &timeout, NULL);
            if (ret < 0)
               throw std::runtime_error(std::string("ppoll: ").append(strerror(errno)));
            return ret; 
        }

        batch
        read(long int microseconds = -1) 
        {
            struct pfq_buff_descr * bd = 
                (struct pfq_buff_descr *)m_mem;

            volatile int & index = const_cast<volatile int &>(bd->index); 
            int myqueue = index;

            /* wait for watermark or timeout */
            poll(microseconds);
            
            /* swap the double-buffered queue */
            index = !myqueue;

            struct pfq_queue_descr *qd = 
                (struct pfq_queue_descr *) ((char *)(bd+1) + m_queue_size * myqueue);
             
            int counter = qd->counter;
            
            qd->counter = 0;
            qd->disable = 0;

            return batch(reinterpret_cast<char *>(qd + 1), counter, m_slot_size);
        }
        
        batch
        recv(const mutable_buffer &buff, long int microseconds = -1) 
        {
            assert(buff.second == (m_queue_size - sizeof(struct pfq_queue_descr)));

            struct pfq_buff_descr * bd = 
                (struct pfq_buff_descr *)m_mem;

            volatile int & index = const_cast<volatile int &>(bd->index); 
            int myqueue = index;

            /* wait for watermark or timeout */
            poll(microseconds);
            
            /* swap the double-buffered queue */
            index = !myqueue;

            struct pfq_queue_descr *qd = 
                (struct pfq_queue_descr *) ((char *)(bd+1) + m_queue_size * myqueue);
             
            int counter = qd->counter;
            
            int bytes = std::min(buff.second, std::min(m_queue_size - sizeof(struct pfq_queue_descr),    
                                                       counter * (sizeof(struct pfq_hdr) + m_slot_size)
                                                      )); 
            
            /* save this queue into the user buffer */
            if (bytes)
                std::memcpy(buff.first, qd+1, bytes);
            
            qd->counter = 0;
            qd->disable = 0;

            return batch(buff.first, counter, m_slot_size);
        }

        pfq_stats
        stats() const
        {
            pfq_stats stat;
            socklen_t size = sizeof(struct pfq_stats);
            if (::getsockopt(m_q, PF_Q, SO_GET_STATS, &stat, &size) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
            return stat;
        }

        size_t
        mem_size() const
        {
            return m_mem_size;
        }

        const void *
        mem_addr() const
        {
            return m_mem;
        }

        size_t
        queue_size() const
        {
            return m_queue_size - sizeof(struct pfq_queue_descr);
        }

        int get_id() const
        {
            if (m_q == -1)
                return -1;

            int ret; socklen_t size = sizeof(int);
            if (::getsockopt(m_q, PF_Q, SO_GET_ID, &ret, &size) == -1)
                throw std::runtime_error(__PRETTY_FUNCTION__);
            return ret;
        }

    private:
        void dtor()
        {
            if (m_q != -1) {
                ::close(m_q);
                m_q = -1;
                if ( munmap(m_mem, m_mem_size) == -1)
                    throw std::runtime_error("dtor: munmap");
            }
        }

        int m_q;
        int m_id;

        int m_slot;
        int m_slot_size;
        int m_queue_size;

        void * m_mem;
        size_t m_mem_size;
    };


    template <typename CharT, typename Traits>
    typename std::basic_ostream<CharT, Traits> &
    operator<<(std::basic_ostream<CharT,Traits> &out, const pfq_stats& rhs)
    {
        return out << rhs.recv << ' ' << rhs.read << ' ' << rhs.lost << ' ' << rhs.drop;
    }

    inline pfq_stats&
    operator+=(pfq_stats &lhs, const pfq_stats &rhs)
    {
        lhs.recv += rhs.recv;
        lhs.read += rhs.read;
        lhs.lost += rhs.lost;
        lhs.drop += rhs.drop;
        return lhs;
    }
    
    inline pfq_stats&
    operator-=(pfq_stats &lhs, const pfq_stats &rhs)
    {
        lhs.recv -= rhs.recv;
        lhs.read -= rhs.read;
        lhs.lost -= rhs.lost;
        lhs.drop -= rhs.drop;
        return lhs;
    }

    inline pfq_stats
    operator+(pfq_stats lhs, const pfq_stats &rhs)
    {
        lhs += rhs;
        return lhs;
    }

    inline pfq_stats
    operator-(pfq_stats lhs, const pfq_stats &rhs)
    {
        lhs -= rhs;
        return lhs;
    }

} // namespace net

#endif /* _PFQ_HPP_ */
