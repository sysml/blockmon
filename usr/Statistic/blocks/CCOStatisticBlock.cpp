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


#include<Block.hpp>
#include<RawPacket.hpp>
#include<BlockFactory.hpp>
#include<TupleStatistic.hpp>
#include<TuplePacket.hpp>
#include<map>
#include<unordered_map>
#include<shared_queue.hpp>



namespace bm
{

    struct myhash : public std::unary_function<Tuple, size_t>
    {
    private:
        static unsigned int ccohash(const char* b,size_t s)
        {
            int remaining_length=s;
            unsigned int hash=0x66B566B5;
            const char* it = b;
            while(remaining_length >= 2)
            {
                hash ^=    (hash <<  7) ^  (*it++) * (hash >> 3);
                hash ^= (~((hash << 11) + ((*it++) ^ (hash >> 5))));
                remaining_length -= 2;
            }
            if (remaining_length)
            {
                hash ^= (hash <<  7) ^ (*it) * (hash >> 3);
            }
            return hash;
        }     
    public:
        size_t operator()(const Tuple& t) const    
        {

            char buffer[64];
            char* p=buffer;
            *(unsigned int*)p=t.m_src_ip;
            p+=sizeof(t.m_src_ip);
            *(unsigned int*)p=t.m_dst_ip;
            p+=sizeof(t.m_src_ip);
            *(unsigned short*)p=t.m_dst_port;
            p+=sizeof(t.m_dst_port);
            *(unsigned short*)p=t.m_src_port;
            p+=sizeof(t.m_dst_port);
            *p='\0';

            return ccohash(buffer,p-buffer);


        }
    };
  
    struct equal_to : public std::binary_function<Tuple, Tuple, bool>
    {
            bool operator()(const Tuple &lhs, const Tuple &rhs) const
                {

                    return ((lhs.m_src_ip==rhs.m_src_ip)&&
                             (lhs.m_dst_ip==rhs.m_dst_ip)&&
                             (lhs.m_dst_port==rhs.m_dst_port)&&
                             (lhs.m_src_port==rhs.m_src_port));

                              }
    };

    class CCOStatBlock: public Block
    {
      

       struct entry
       {
           std::chrono::system_clock::time_point ts;
         unsigned int packets;
          unsigned int bytes;
         entry():packets(0), bytes(0)
         {}
       }; 
       struct to_struct
       {
           Tuple t;
           std::chrono::system_clock::time_point ts;
           to_struct(const Tuple& _t,const std::chrono::system_clock::time_point& _ts):
           t(_t),ts(_ts)
           {}
           to_struct()
           {}
           to_struct(const to_struct& s):
           t(s.t),ts(s.ts)
           {}

           to_struct& operator=(const to_struct& ts)
           {
               memcpy(this,&ts,sizeof(to_struct));
               return *this;
           }
       };
        int m_ingate_id; 
        int m_outgate_id;
        std::unordered_map<Tuple,entry,myhash,equal_to> m_flow_table;
        more::shared_queue<to_struct,1024*1024*4> m_to_queue;
        std::chrono::milliseconds timeout;
    public:

        /*
         * constructor
         */
        CCOStatBlock(const std::string &name, bool active, bool thread_safe)
        : Block(name,"statistic_block",active,thread_safe),
          m_ingate_id(register_input_gate("in_pkt")),
          m_outgate_id(register_output_gate("out_pkt")),
          m_flow_table(),
          m_to_queue(),
          timeout(100)

        {
            m_flow_table.rehash(1024*1024);

        }

        CCOStatBlock(const CCOStatBlock &)=delete;
        CCOStatBlock& operator=(const CCOStatBlock &) = delete;

        /*
         * destructor
         */
        virtual ~CCOStatBlock()
        {}


        virtual void _configure(const xml_node&  /*n*/ )
        {
           set_periodic_timer(std::chrono::microseconds(100000),"clean",0);
        }



            
        /*
         * the main method
         * receives a TuplePacket message, extracts statistic information and
         * stores them
         */
        virtual int _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != TUPLE_PACKET_CODE) 
                throw std::runtime_error("CCOStatBlock: unexpected msg type");
            const TuplePacket* packet = static_cast<const TuplePacket*>(m.get());
            Tuple tp(packet->get_tuple());
            
            std::chrono::system_clock::time_point n=std::chrono::system_clock::now();
            auto it=m_flow_table.find(tp);
            if(it!=m_flow_table.end())
            {
                it->second.bytes+=packet->get_buffer().second;
                it->second.packets++;
                it->second.ts=n+timeout;
            }
            else
            {
                entry e;
                e.bytes=packet->get_buffer().second;
                e.packets=1; 
                e.ts=n+timeout;
                m_flow_table.insert(std::make_pair(tp,e));
                if(!m_to_queue.push_back(to_struct(tp,n)) )
                    throw std::runtime_error("queue full");

            } 

            return 0;
        }

         

        virtual int do_async_processing()
        {
            return 0;
        }

        /*
         * this method is used when is necessary sending out messages or checking old flows
         */
        virtual int _handle_timer(std::shared_ptr<Timer>&& )
        {
            
            std::chrono::system_clock::time_point n=std::chrono::system_clock::now();
           while (1)
           {
               if(m_to_queue.empty()) 
                   return -1; 
               if(m_to_queue.front().ts>n)
               {
                  return -1; 

               }
               to_struct to;
               m_to_queue.pop_front(to);
               
               auto it=m_flow_table.find(to.t);

               assert(it!=m_flow_table.end());
               if(n-it->second.ts>std::chrono::milliseconds(100))
               {
                   send_out_through(std::shared_ptr<Msg> (new TupleStatistic(it->first.m_src_ip,it->first.m_dst_ip,it->first.m_src_port,it->first.m_dst_port,it->first.m_protocol,it->second.bytes,it->second.bytes)), m_outgate_id);
                   m_flow_table.erase(it);                                               
                   
               }
               else
               {
                   to.ts=n+timeout;
                   m_to_queue.push_back(to);
               }


           }

           

            return 0;

        }
        
    private:
        
 
    };


    REGISTER_BLOCK(CCOStatBlock,"statistic_blockCCO");

}


