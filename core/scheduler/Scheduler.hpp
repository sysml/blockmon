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

#ifndef _CORE_SCHEDULER_SCHEDULER_HPP_
#define _CORE_SCHEDULER_SCHEDULER_HPP_
#include<schedulers/DumbScheduler.hpp>
//#include<schedulers/RRScheduler.hpp>



namespace blockmon
{



    /**
     * this is a template class that represents the scheduler that assigns Blocks to
     * the different threads in a thread pool (recall that there is only one scheduler for each pool).
     * Notice that the actual scheduling is performed by an internal object, whose type is a template parameter.
     * This just represents a concept class that forces the actual scheduler to implement a set of methods.
     * This pattern represents a sort of compile-time polymorphism.
     * See DumbScheduler to have an idea of how to implement a new scheduling policy.
     * It is possible to select a specific scheduling class by using the  SELECT_SCHEDULING_POLICY macro.
     * Notice that only one policy can be chosen for each BlockMon binary.
     */


/**
  * This is the macro that allows to specify BlockMon's scheduling policy.
  * Such policy needs to be unique for BlockMon's instance, otherwise the project will not build
  * @param the scheduling policy class
  */
#define SELECT_SCHEDULING_POLICY(policyclass)\
    typedef PluginScheduler<policyclass> Scheduler;


    template<typename T>
    class PluginScheduler
    {
        /**
         * This is the internal object which actually does the scheduling. Its type is a template parameter.
         */
        T m_scheduler;

         /**
         * this object is not copiable nor moveable
         */
        PluginScheduler(const PluginScheduler&)=delete;
        PluginScheduler& operator = (const PluginScheduler&) = delete;
        PluginScheduler(PluginScheduler&&)=delete;
        PluginScheduler& operator = (PluginScheduler&&) = delete;

    public:
        /**
         * class constructor. 
         * @param nthreads number of threads in the thread pool. This information is passed to the constructor of the actual scheduling object.
         */
        PluginScheduler(unsigned int nthreads ):
        m_scheduler(nthreads)
        {}

        /**
         * registers a thread in the pool to the scheduler.
         * @param id the thread id (this is not the OS id but an internal thread pool identifier)
         * @param affinity the set of cores this thread is allowed to run on (an empty vector meaning that no affinity is specified)
         */
        void register_thread(int id, const std::vector<unsigned int>& affinity)
        {
            m_scheduler.register_thread(id,affinity);
        }

        /**
         * unregisters a thread from this scheduler
         * @param id the thread's pool-wide identifier
         */
        void unregister_thread(int id)
        {
            m_scheduler.unregister_thread(id);
        }

        /**
         * assigns a new block to the scheduler
         * @param b a shared pointer to the block (as r-val reference)
         */
        void add_block(std::shared_ptr<Block>&& b )
        {
            m_scheduler.add_block(std::move(b));
        }

        /**
         * Removes a block from the scheduler.
         * The block is identified through its address
         * @param b the address of the block to be removed
         */
        void remove_block(const Block* b)
        {
            m_scheduler.remove_block(b);
        }	

        /**
         * this function is called by the thread when it requests a new block to run
         * @param id the thread's pool-wide identifier
         */
        std::shared_ptr<Block> next_task(int id)
        {
            return m_scheduler.next_task(id);

        }
        /**
         * When a thread has finished executing a block's run method, it returns the block to the scheduler via this method.
         * @param id the thread's pool-wide identifier
         * @param b a shared pointer to the block (as r-val reference)
         */ 
        void task_done(int id, std::shared_ptr<Block>&& b)
        {
            m_scheduler.task_done(id,std::move(b));

        }
    };

    SELECT_SCHEDULING_POLICY(DumbScheduler)


}
#endif // _CORE_SCHEDULER_SCHEDULER_HPP_
