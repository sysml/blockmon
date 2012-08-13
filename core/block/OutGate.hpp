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

#ifndef _CORE_BLOCK_OUTGATE_HPP_
#define _CORE_BLOCK_OUTGATE_HPP_ 

#include <cassert>
#include <utility>
#include <InGate.hpp>
#include<algorithm>

namespace blockmon { 

    class Block;


    class OutGate
    {
    public:
        OutGate(Block& own,int id)
        : m_owner(&own), m_peers(), m_index(id)
        {}

        ~OutGate()
        {}

        OutGate(const OutGate& other) = delete;
        OutGate& operator=(const OutGate& other) = delete;

        void swap(OutGate &other)
        {
            std::swap(m_owner, other.m_owner);
            std::swap(m_peers, other.m_peers);
            std::swap(m_index, other.m_index);
        }

        OutGate(OutGate &&other)
        : m_owner(std::move(other.m_owner)),
        m_peers(std::move(other.m_peers)),
        m_index(std::move(other.m_index))
        {} 

        OutGate& operator=(OutGate &&other)
        {
            OutGate tmp(std::move(other));
            tmp.swap(*this);
            return *this;
        }



        void connect(InGate& in)
        {
            m_peers.push_back(&in);
        }

        void disconnect(InGate* in)
        {
            auto rm=std::remove(m_peers.begin(),m_peers.end(),in);

            auto end=m_peers.end();
            if(rm==end)
                throw std::runtime_error("trying to disconect a non-connected gate");

            m_peers.erase(rm,end);


        }

        void disconnect_all()
        {

            for (auto it=m_peers.begin(); it!=m_peers.end(); ++it)
                (*it)->disconnect(this);
            m_peers.clear();
        }


        int deliver(std::shared_ptr<const Msg>&& m)
        {
            if(m_peers.size()>0){
				unsigned int e=m_peers.size();
				for(unsigned int i=0;i<e-1;++i)//first e-1
				{
					m_peers[i]->receive(std::shared_ptr<const Msg> (m));
				}
				m_peers[e-1]->receive(std::move(m));
            }
            return 0;
        }

    private:
        Block* m_owner;
        std::vector<InGate*> m_peers;
        int m_index;

    };

} // namespace blockmon
#endif /* _CORE_BLOCK_OUTGATE_HPP_ */
