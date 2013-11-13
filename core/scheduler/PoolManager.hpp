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

#ifndef _CORE_SCHEDULER_POOLMANAGER_HPP_
#define _CORE_SCHEDULER_POOLMANAGER_HPP_


#include <ThreadPool.hpp>
#include <pugixml.hpp>

#include <map>
#include <memory>
#include <vector>
#include <cstdio>

namespace blockmon
{
    
/**
  * Directory of Blockmon's thread pools.
  *
  * It is used in order to dispatch active blocks to thread pools,
  * according to the user specifications, as well as to create, manage
  * and delete the thread pools themselves.
  */
    class PoolManager
    {
        std::map<std::string,std::shared_ptr<ThreadPool> > m_map;
        std::atomic_bool running;

		/**
          * class constructor
          * private,as in Meyer's singleton
          */
        PoolManager()
        : m_map(), running(false)
        {}

        ~PoolManager()
        {}
        
        /**
          * this object is non-moveable and non-copiable
          */
        PoolManager(const PoolManager &) = delete;
        PoolManager& operator=(const PoolManager &) = delete;
        PoolManager(PoolManager &&) = delete;
        PoolManager& operator=(PoolManager &&) = delete;


    public:
        /**
          * unique instance accessor as in Meyer's singleton
          * @return a reference to the only instance of this class
          */
        static PoolManager& 
        instance()
        {
            static PoolManager pm;
            return pm;
        }

        /**
          * Adds a new thread pool to the directory.
	  *
          * @param n an xml subtree (parsed as a pugixml node)
          * describing the thread pool, as it appears in the
          * composition specification
         */ 
        void create_pool(pugi::xml_node n)
        {

            std::string name = n.attribute("id").value();
            int nthreads = n.attribute("num_threads").as_int();
            if((name.length() == 0)||(nthreads == 0))
                throw std::runtime_error("could not parse thread pool paramters");

            std::vector<unsigned int> affinity;
            for (pugi::xml_node t = n.child("core"); t; t = t.next_sibling("core"))
            {
                const char* num = t.attribute("number").value();
                if(!num)
                    throw std::runtime_error("cannot find core number");
                unsigned int corenum = 0xffffffff;
                sscanf(num,"%u",&corenum);
                if(corenum == 0xffffffff)
                {
                    throw std::runtime_error("cannot parse core number");
                }
                affinity.push_back(corenum);
            }
            auto it = m_map.find(name);
            if(it != m_map.end())
                throw std::runtime_error(name.append(" : thread pool already exists"));
            m_map[name] = std::make_shared<ThreadPool>(nthreads,affinity);
        }

        /**
          * Dispatches a block to a given thread pool.
	  *
          * Notice that an active block as to be explicitly removed
          * from its pool, otherwise it will not be destroyed
	  *
          * @param name the thread pool identifier
          * @param b a shared pointer to the block
          */
        void add_to_pool(const std::string &name, std::shared_ptr<Block> b)
        {
            auto it = m_map.find(name);
            if(it == m_map.end())
                throw std::runtime_error(std::string(name).append(" : thread pool does noe exist"));
            it->second->add_task(std::move(b));
        }

        /**
          * Removes a block from a given thread pool.
	  *
          * Notice that an active block as to be explicitly removed
          * from its pool, otherwise it will not be destroyed.
	  *
          * @param name the thread pool identifier
          * @param b a shared pointer to the block
          */
        void remove_from_pool(const std::string &name, const Block& b)
        {
            auto it = m_map.find(name);
            if(it == m_map.end())
                throw std::runtime_error(std::string(name).append(" : thread pool does noe exist"));
            it->second->remove_task(b);
        }

        /**
          * Removes a thread pool from the directory and destroys it.
	  *
          * Notice that any active blocks assigned to the pool will
          * not be executed anymore.
	  *
          * @param name the thread pool identifier
          */
        void delete_pool(const std::string &name)
        {
            m_map.erase(name);
        }

        /**
          * Creates all of the threads of all of the thread pools.
	  *
          * This is when BlockMon actually starts working.
          */
        void start()
        {
            running.store(true);
            auto end = m_map.end();
            for(auto cur = m_map.begin(); cur!=end; ++cur)
            {
                cur->second->run();
            }

        }


        /**
          * Stops all of the threads of all of the thread pools.
	  *
          * This is needs to be done prior to any reconfiguration.
          */

        void stop() {
            running.store(false);
            auto end = m_map.end();
            for(auto cur=m_map.begin(); cur!=end; ++cur) {
                cur->second->stop();
            }
        }
        /*
         * Replaced with the code above
         */
/*
        void stop()
        {
        	running.store(false);
        	std::cout << "Stopping all thread pools..." << std::endl;
            auto end=m_map.end();
            for(auto cur=m_map.begin(); cur!=end; ++cur)
            {
                cur->second->stop();
            }
            std::cout << "Waiting for all threads to finish..." << std::endl;
            for(auto cur=m_map.begin(); cur!=end; ++cur)
			{
				cur->second->join();
			}
        }
*/
        bool isRunning(){
        	return running.load();
        }

    };
}

#endif // _CORE_SCHEDULER_POOLMANAGER_HPP_
