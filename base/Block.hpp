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
/*
@ authors
Andrea Di Pietro <andrea.dipietro@for.unipi.it> 
Nicola Bonelli <bonelli@cnit.it>
*/


#ifndef _BLOCK_HPP_
#define _BLOCK_HPP_ 

#include <map>
#include <memory>
#include <chrono>
#include <mutex>
#include<sstream>
#include<stdexcept>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include <pugixml.hpp>


#include <InGate.hpp>
#include <OutGate.hpp>
#include <MsgQueue.hpp>
#include <VarBase.hpp>


using namespace pugi;

namespace bm { 

    class Timer;

    static const int MAX_MSG_DEQUEUE = 10;

    class Block
    {
    public:
        Block(const std::string &name, std::string type, bool act, bool ts)
        : m_mutex(),
        m_isthreadsafe(ts),
        m_isactive(act),
        m_running(false),
        m_input_ids(),
        m_output_ids(),
        m_ingates(),
        m_outgates(),
        m_last_in_id(0),
        m_last_out_id(0),
        m_timer_queue(),
        m_name(name),
        m_type(type),
        m_variables()
        {}

        virtual ~Block(void);

        /* non copyable */
        Block(const Block &) = delete;
        Block& operator=(const Block &) = delete;

        InGate& 
        get_input_gate(std::string gname)
        {
            std::map<std::string, int>::iterator it;
            it=m_input_ids.find(gname);
            if(it==m_input_ids.end()) throw std::runtime_error(gname.append(": no such gate"));
            return m_ingates[it->second];
        }

        void toggle_running(bool r)
        {
            m_running=r;
        }

        bool is_running() const
        {
            return m_running;
        }

        bool is_thread_safe() const
        {
            return m_isthreadsafe;
        }

        bool is_active() const
        {
            return m_isactive;
        }

        std::string get_name() const
        {
            return m_name;
        }

        std::string get_type() const
        {
            return m_type;
        }

        //   std::string get_thread_pool() const
        //   {
        //       return m_thread_pool;
        //   }
        void change_execution_mode(bool active, bool ts/* , std::string tp=std::string()*/)
        {
            if(m_running)
                throw std::runtime_error("cannot change execution mode while block is running");
            if(active && ts) 
                std::cout<< "active blocks do not need ts mode, option will be ignored"<<std::endl;
            //   if(!active && (tp.length()>0))
            // 	throw std::runtime_error("cannot specify thread pool for passive block");

            m_isthreadsafe=ts;
            m_isactive=active;
            //m_thread_pool=tp;

        } 


        void configure(const xml_node& n)
        {
            _configure(n);
        }

        int update_config(const xml_node& n)
        {
            return _update_config(n);
        }
        OutGate& get_output_gate(const std::string &gname) 
        {
            std::map<std::string, int>::const_iterator it;
            it=m_output_ids.find(gname);
            if(it==m_output_ids.end()) 
                throw std::runtime_error(std::string(gname).append(": no such gate"));
            return m_outgates[it->second];
        }

        int receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            if (m_isthreadsafe)
            {
                std::lock_guard<std::mutex> tmp (m_mutex);
                return _receive_msg(std::move(m), index);
            }
            else
                return _receive_msg(std::move(m), index);
        }




        void run()
        {
            int nb=m_ingates.size();

            while(1)
            {
                std::shared_ptr<Timer> tmp(std::move(m_timer_queue.pop()));
                if(!tmp) break;
                _handle_timer(std::move(tmp));
            }

            for (int i=0; i<nb; ++i)
            {
                for (int n=0; n<MAX_MSG_DEQUEUE; ++n)
                {
                    std::shared_ptr<const Msg> tmp(std::move(m_ingates[i].dequeue()));
                    if(!tmp) break;
                    _receive_msg(std::move(tmp),i);
                }
            }
            do_async_processing();
        }

        /* block variable handling*/
    protected:

        void register_exposed_variable(const std::string& name, std::shared_ptr<VarBase>&& v)
        {
            auto it = m_variables.find(name);
            if(it!=m_variables.end())
                throw std::runtime_error(std::string(name).append(" variable already registered"));
            m_variables[name]=std::move(v);
		

        }
    public:

        std::string export_exposed_variables()
        {
            std::stringstream  ss(std::stringstream::in | std::stringstream::out);
            for (auto it=m_variables.begin(); it!=m_variables.end(); ++it)
            {
                ss<<it->first;

                if((it->second)->read_en())
                    ss<<",read"; 
                if((it->second)->write_en())
                    ss<<",write";
                ss<<";";
            }
            std::string ret;
            ss>>ret;
            return ret;
        }




        virtual std::string read_variable(const std::string& v_name)
        {
            auto it = m_variables.find(v_name);
            if(it==m_variables.end())
            {
                blocklog(std::string(v_name).append(" :no such variable"),warning);
                return std::string();
            }
            return ((it->second)->read());


        }

        virtual int write_variable(const std::string& v_name, const std::string& val)
        {
            auto it = m_variables.find(v_name);
            if(it==m_variables.end())
            {
                blocklog(std::string(v_name).append(" :no such variable"),warning);
                return -1;
            }
            return ((it->second)->write(val));

        }



        int handle_timer(std::shared_ptr<Timer> t)
        {
            if(m_isactive)
            {
                m_timer_queue.push(std::move(t));
                return 0;
            }
            else if(m_isthreadsafe)
            {
                std::lock_guard<std::mutex> tmp(m_mutex);
                return _handle_timer(std::move(t));
            }
            else
            {
                return _handle_timer(std::move(t));
            }
        }

        void remove_pending_timers();
    private:
        std::mutex m_mutex;
        bool m_isthreadsafe;
        bool m_isactive;	


        bool m_running;
        std::map<std::string, int > m_input_ids;
        std::map<std::string, int > m_output_ids;

        std::vector<InGate> m_ingates;
        std::vector<OutGate> m_outgates;

        std::atomic_int m_last_in_id;
        std::atomic_int m_last_out_id;

        TimerQueue m_timer_queue;


    protected:

        const std::string m_name;
        const std::string m_type;

    private:
        std::map<std::string, std::shared_ptr<VarBase> > m_variables;
    protected:
        virtual int _handle_timer(std::shared_ptr<Timer>&& )=0;
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)=0;

        virtual void _configure(const xml_node& n)=0;
        virtual int _update_config(const xml_node& n)
        {
            return -1;
        }
        enum log_type {info,debug,error,warning};

        void blocklog(std::string l, log_type t)
        {
            std::cout<< m_type << '\t' << m_name << '\t' << l << t << std::endl;
        }

        virtual int do_async_processing()
        {
            throw std::runtime_error(std::string(m_type).append("async processing not implemented"));
        }

        void send_out_through(std::shared_ptr<const Msg>&& m,int id)
        {
            assert((id>=0)&&(id<(int)m_outgates.size()));
            m_outgates[id].deliver(std::move(m));
        }

        int register_input_gate(const std::string &name); //base class registers gates

        int register_output_gate(const std::string &name);

        int outgate_to_id(const std::string &gname) const
        {
            std::map<std::string, int>::const_iterator it;
            it = m_output_ids.find(gname);
            if(it==m_output_ids.end()) 
                throw std::runtime_error(std::string(gname).append(": no such gate"));
            return it->second;
        }

        int ingate_to_id(const std::string &gname) const
        {
            std::map<std::string, int>::const_iterator it;
            it = m_input_ids.find(gname);
            if(it==m_input_ids.end()) 
                throw std::runtime_error(std::string(gname).append(": no such gate"));
            return it->second;
        }

        void set_timer_at(std::chrono::system_clock::time_point, const std::string &name, unsigned int id);

        void set_periodic_timer(std::chrono::microseconds, const std::string &name, unsigned int id);

    };

} // namespace bm

#endif /* _BLOCK_HPP_ */
