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

// blockmoncco.cpp : Defines the entry point for the console application.
//

#include <map>
#include <vector>
#include <memory>
#include <iostream>

#include <Block.hpp>
#include <Scheduler.hpp>
#include <TimerThread.hpp>
#include <Msg.hpp>


using namespace bm;

namespace test {

    class M: public Msg
    {
    public:

        M():Msg(1)
        {}

        virtual Msg* clone()
        {
            return NULL;
        }
    };

    class Creator: public Block 
    {
        int counter;
    public:
        int id;
        
        Creator(const std::string &name)
        :Block(name,"a",false,true), counter(0),id(register_output_gate("out"))
        {}

    protected:
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            return 0;
        }

        int do_async_processing()
        {
            if(counter<1000000)
            {
                std::shared_ptr<const Msg> tmp(new M);
                send_out_through(std::move(tmp),id);
                counter++;
            }
            else if(counter==1000000)
            {
                std::cout<<"done\n";
                counter++;
            }
            /*
               if(counter%1000==0)
               std::cout<<m_name<<" sending"<<std::endl;*/
            return 0;
        }

    };


    class Consumer: public Block 
    {
    public:
        int id;
        int counter;
        Consumer(const std::string &name)
        : Block(name,"b",false,true),
          id(register_input_gate("in")), counter(0)
        {}

    protected:
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            ++counter;

            //if(counter%1000==0)
            //std::cout<<m_type<<m_name<<" counter is "<<counter<<std::endl;
            return 0;
        }
        int do_async_processing()
        {
            return 0;
        }

    };


    class Timed: public Block 
    {
    public:
        int id;
        int counter;
        Timed(const std::string &name)
        :Block(name,"b",false,false), id(), counter()
        {
            set_periodic_timer(std::chrono::seconds(1),"prova",0);
        }

    protected:
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            ++counter;

            //if(counter%1000==0)
            //std::cout<<m_type<<m_name<<" counter is "<<counter<<std::endl;
            return 0;
        }
        int do_async_processing()
        {
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& t)
        {
            std::cout<<m_name<<" timer scheduled at "<<t->time_point().time_since_epoch().count()<<" triggered at "<<std::chrono::system_clock::now().time_since_epoch().count()<<std::endl;
            return 0;

        }

    };

    class Timed2: public Block 
    {
    public:
        int id;
        int counter;
        Timed2(const std::string &name)
        :Block(name,"b",false,false), id(), counter()
        {
            set_timer_at(std::chrono::system_clock::now()+std::chrono::microseconds(3000000),  name,0);
        }

    protected:
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int index)
        {
            ++counter;

            //if(counter%1000==0)
            //std::cout<<m_type<<m_name<<" counter is "<<counter<<std::endl;
            return 0;
        }
        int do_async_processing()
        {
            return 0;
        }

        virtual int _handle_timer(std::shared_ptr<Timer>&& t)
        {
            std::cout<<m_name<<" timer scheduled at "<<t->time_point().time_since_epoch().count()<<" triggered at "<<std::chrono::system_clock::now().time_since_epoch().count()<<std::endl;
            return 0;

        }

    };

}

using namespace test;

int main(int argc,char *argv[])
{

    std::thread tt(std::ref(TimerThread::instance()));

    Timed t("timer!");

    std::this_thread::sleep_for(std::chrono::seconds(1));

    Timed t2("timer2!");

    std::this_thread::sleep_for(std::chrono::seconds(2));

    Timed2 tt2("async");

    std::this_thread::sleep_for(std::chrono::seconds(10));

    TimerThread::instance().stop();
    tt.join();

    return 0;
}

