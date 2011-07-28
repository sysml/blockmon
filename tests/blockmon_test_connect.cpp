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
    public:
        int counter;
        int id;
        Creator(const std::string &name)
        : Block(name,"a",false,true), counter(0), id(register_output_gate("out"))
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
        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
        }

    };

    class Consumer: public Block 
    {
    public:
        int id;
        int counter;
        Consumer(const std::string &name, bool ts, bool active)
        :Block(name,"b",ts,active), id(register_input_gate("in")), counter(0)
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
        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            throw std::runtime_error("not implemented");
        }
    };

}

using namespace test;

int main(int argc, char** argv)
{
    //create blocks

    std::shared_ptr<Block> a (new Creator ("in1"));
    std::shared_ptr<Block> a2 (new Creator ("in2"));

    //passive thread safe consumer
    std::shared_ptr<Block> b (new Consumer ("c1",true,false));

    //connect blocks
    OutGate& aout=a->get_output_gate("out");
    InGate& bin=b->get_input_gate("in");
    OutGate& aout2=a2->get_output_gate("out");

    aout.connect_to(bin);
    bin.connect_to(aout);
    aout2.connect_to(bin);
    bin.connect_to(aout2);

    std::cout<<"beginning test with 2 concurrent producers and 1 paasive thread safe consumer"<<std::endl;

    Scheduler s;
    s.add_block(a);
    Scheduler s2;
    s2.add_block(a2);
    std::thread t(std::ref(s));
    std::thread t2(std::ref(s2));

    sleep(5);

    s.stop();
    s2.stop();
    t.join();
    t2.join();
    
    Consumer* c=static_cast<Consumer*>(b.get());
    std::cout<<c->counter<<std::endl;

    assert(c->counter==2000000);

    std::cout<<"test successful"<<std::endl;

    s.remove_block("in1");
    s.remove_block("in2");

    a.reset();
    a2.reset();
    b.reset();

    a=std::shared_ptr<Block> (new Creator ("in1"));
    a2=std::shared_ptr<Block> (new Creator ("in1"));
    b=std::shared_ptr<Block>(new Consumer("c2",false,false));

    OutGate& naout=a->get_output_gate("out");
    InGate& nbin=b->get_input_gate("in");
    OutGate& naout2=a2->get_output_gate("out");

    naout.connect_to(nbin);
    nbin.connect_to(naout);
    naout2.connect_to(nbin);
    nbin.connect_to(naout2);

    std::cout<<"beginning test with 2 concurrent producers and 1 passive thread unsafe consumer"<<std::endl;
    s.add_block(a);
    s2.add_block(a2);
    std::thread bt(std::ref(s));
    std::thread bt2(std::ref(s2));

    sleep(5);

    s.stop();
    s2.stop();
    bt.join();
    bt2.join();
    c=static_cast<Consumer*>(b.get());
    std::cout<<c->counter<<std::endl;

    assert(c->counter!=2000000);

    std::cout<<"test failed as expected"<<std::endl;


    s.remove_block("in1");
    s.remove_block("in2");

    a.reset();
    a2.reset();
    b.reset();


    a=std::shared_ptr<Block> (new Creator ("in1"));
    a2=std::shared_ptr<Block> (new Creator ("in1"));
    b=std::shared_ptr<Block>(new Consumer("c2",false,true));


    OutGate& nnaout=a->get_output_gate("out");
    InGate& nnbin=b->get_input_gate("in");
    OutGate& nnaout2=a2->get_output_gate("out");

    nnaout.connect_to(nnbin);
    nnbin.connect_to(nnaout);
    nnaout2.connect_to(nnbin);
    nnbin.connect_to(nnaout2);

    std::cout<<"beginning test with 2 concurrent producers and 1 active  consumer"<<std::endl;
    s.add_block(a);
    s2.add_block(a2);
    s2.add_block(b);
    std::thread bbt(std::ref(s));
    std::thread bbt2(std::ref(s2));

    sleep(5);

    s.stop();
    s2.stop();
    bbt.join();
    bbt2.join();
    c=static_cast<Consumer*>(b.get());
    std::cout<<c->counter<<std::endl;

    assert(c->counter==2000000);
    std::cout<<"test suceeded "<<std::endl;

    return 0;
}
