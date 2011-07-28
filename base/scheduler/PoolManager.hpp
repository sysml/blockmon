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

#ifndef _POOLMANAGER_HPP_
#define _POOLMANAGER_HPP_ 

#include <ThreadPool.hpp>
#include <pugixml.hpp>

#include <map>
#include <memory>
#include <vector>
#include <cstdio>


using namespace pugi;

namespace bm
{
    class Block;

    class PoolManager
    {
        PoolManager()
        : m_map()
        {}

        ~PoolManager()
        {}
        
        PoolManager(const PoolManager &) = delete;
        PoolManager& operator=(const PoolManager &) = delete;

        std::map<std::string,std::shared_ptr<ThreadPool> > m_map;

    public:
        static	PoolManager& 
        instance()
        {
            static PoolManager pm;
            return pm;
        }

        void create_pool(xml_node n)
        {

            std::string name=n.attribute("id").value();
            int nthreads=n.attribute("num_threads").as_int();
            if((name.length()==0)||(nthreads==0))
                throw std::runtime_error("could not parse thread pool paramters");

            std::vector<unsigned int> affinity;
            for (xml_node t=n.child("core"); t; t=t.next_sibling("core"))
            {
                const char* num=t.attribute("number").value();
                if(!num)
                    throw std::runtime_error("cannot find core number");
                unsigned int corenum=0xffffffff;
                sscanf(num,"%u",&corenum);
                if(corenum==0xffffffff)
                {
                    throw std::runtime_error("cannot parse core number");
                }
                affinity.push_back(corenum);
            }
            auto it = m_map.find(name);
            if(it!=m_map.end())
                throw std::runtime_error(name.append(" : thread pool already exists"));
            m_map[name]=std::make_shared<ThreadPool>(nthreads,affinity);
        }


        void add_to_pool(const std::string &name, std::shared_ptr<Block> b)
        {
            auto it = m_map.find(name);
            if(it==m_map.end())
                throw std::runtime_error(std::string(name).append(" : thread pool does noe exist"));
            it->second->add_task(std::move(b));
        }
        void remove_from_pool(const std::string &name, const Block& b)
        {
            auto it = m_map.find(name);
            if(it==m_map.end())
                throw std::runtime_error(std::string(name).append(" : thread pool does noe exist"));
            it->second->remove_task(b);
        }

        void remove_pool(const std::string &name)
        {
            m_map.erase(name);
        }

        void start()
        {
            auto end=m_map.end();
            for(auto cur=m_map.begin(); cur!=end; ++cur)
            {
                cur->second->run();
            }

        }
        void stop()
        {
            auto end=m_map.end();
            for(auto cur=m_map.begin(); cur!=end; ++cur)
            {
                cur->second->stop();
            }
        }

    };

}


#endif /* _POOLMANAGER_HPP_ */
