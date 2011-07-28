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

#include <stdlib.h>

#include <utility>
#include <stdexcept>

#include <cms.hpp>
#include <iostream>

using namespace std;

namespace cms
{
    Sketch::Sketch(int width, int depth, unsigned int id_mask, int seed) 
    : bm::Msg(CMS_SKETCH_CODE), m_width(width), m_depth(depth), m_id_mask(id_mask), m_id_length(0), m_counts(), m_hashes()
    {
        // Initialize the pseudo-random generator
        srand48(seed);
        // Initialize the data
        m_counts = new int*[m_depth];
        for (int i = 0; i < m_depth; i++) {
            m_counts[i] = new int[m_width];
            for (int j = 0; j < m_width; j++)
                m_counts[i][j] = 0;
        }
        m_hashes = new bm::HASH*[m_depth];
        // Compute the id length
        compute_id_length();
        // Initialize the hash functions
        for (int i = 0; i < m_depth; i++)
            m_hashes[i] = new bm::ACHash31(lrand48() & CMS_MOD, lrand48() & CMS_MOD);
    }
    
    Sketch::Sketch(const Sketch* sketch) 
    : bm::Msg(CMS_SKETCH_CODE), m_width(sketch->get_width()), m_depth(sketch->get_depth()), m_id_mask(sketch->get_id_mask()), m_id_length(0), m_counts(), m_hashes()
    {
        // Initialize the data
        m_counts = new int*[m_depth];
        for (int i = 0; i < m_depth; i++) {
            m_counts[i] = new int[m_width];
            for (int j = 0; j < m_width; j++)
                m_counts[i][j] = sketch->get_data()[i][j];
        }
        m_hashes = new bm::HASH*[m_depth];
        // Compute the id length
        compute_id_length();
        // Use the same hash functions
        for (int i = 0; i < m_depth; i++)
            m_hashes[i] = sketch->get_hashes()[i];
    }

    Sketch::~Sketch()
    {
        for (int i = 0; i < m_depth; i++)
            delete[] m_counts[i];
        delete[] m_counts;
        m_counts = NULL;
        delete[] m_hashes;
        m_hashes = NULL;
    }
    
    std::shared_ptr<bm::Msg> Sketch::clone() const
    {
        return std::make_shared<cms::Sketch>(this);
    }

    void Sketch::update(const bm::Tuple* tuple, int diff)
    {
        unsigned char id[m_id_length];
        compute_id(tuple, id);
        for (int i = 0; i < m_depth; i++) {
            unsigned int index;
            m_hashes[i]->compute(id, m_id_length, (unsigned char*) &index);
            index%= m_width;
            m_counts[i][index]+= diff;
        }
    }

    int Sketch::estimate(const bm::Tuple* tuple) const
    {
        unsigned char id[m_id_length];
        compute_id(tuple, id);
        int value = 0;
        for (int i = 0; i < m_depth; i++)
        {
            unsigned int index;
            m_hashes[i]->compute(id, m_id_length, (unsigned char*) &index);
            index%= m_width;
            int new_val = m_counts[i][index];
            if (i == 0 || value > new_val)
                value = new_val;
        }
        return value;
    }

    int Sketch::get_width() const
    {
        return m_width;
    }

    int Sketch::get_depth() const
    {
        return m_depth;
    }

    unsigned int Sketch::get_id_mask() const
    {
        return m_id_mask;
    }
	
	void Sketch::get_indexes(const bm::Tuple* tuple, unsigned int indexes[]) const
	{
        unsigned char id[m_id_length];
        compute_id(tuple, id);
        for (int i = 0; i < m_depth; i++)
        {
            unsigned int index;
            m_hashes[i]->compute(id, m_id_length, (unsigned char*) &index);
            index%= m_width;
            indexes[i] = index;
        }
	}

    int** Sketch::get_data() const
    {
        return m_counts;
    }

    int* Sketch::get_data(int index) const
    {
        return m_counts[index];
    }

    bm::HASH** Sketch::get_hashes() const
    {
        return m_hashes;
    }

    void Sketch::merge(const Sketch* sketch)
    {
        for (int i = 0; i < m_depth; i++)
            for (int j = 0; j < m_width; j++)
                m_counts[i][j]+= sketch->get_data()[i][j];
    }

    void Sketch::reset()
    {
        for (int i = 0; i < m_depth; i++)
            for (int j = 0; j < m_width; j++)
                m_counts[i][j] = 0;
    }

    void Sketch::compute_id(const bm::Tuple* tuple, unsigned char* id) const
    {
        int current_offset = 0;
        if (m_id_mask & CMS_ID_PROTOCOL)
        {
            char protocol = tuple->get_protocol();
            add_bytes_to_id(id, &protocol, 1, &current_offset);
        }
        if (m_id_mask & CMS_ID_SRC_IP)
        {
            unsigned int src_ip = tuple->get_src_ip();
            add_bytes_to_id(id, (char*) &src_ip, 4, &current_offset);
        }
        if (m_id_mask & CMS_ID_SRC_PORT)
        {
            unsigned short src_port = tuple->get_src_port();
            add_bytes_to_id(id, (char*) &src_port, 2, &current_offset);
        }
        if (m_id_mask & CMS_ID_DST_IP)
        {
            unsigned int dst_ip = tuple->get_dst_ip();
            add_bytes_to_id(id, (char*) &dst_ip, 4, &current_offset);
        }
        if (m_id_mask & CMS_ID_DST_PORT)
        {
            unsigned short dst_port = tuple->get_dst_port();
            add_bytes_to_id(id, (char*) &dst_port, 2, &current_offset);
        }
    }

    void Sketch::add_bytes_to_id(unsigned char* id, char* bytes, int length, int* current_offset) const
    {
        for (int i = 0; i < length; i++)
        {
            id[*current_offset] = bytes[i];
            (*current_offset)++;
        }
    }

    void Sketch::compute_id_length()
    {
        m_id_length = 0;
        if (m_id_mask & CMS_ID_SRC_IP)
            m_id_length+= 4;
        if (m_id_mask & CMS_ID_DST_IP)
            m_id_length+= 4;
        if (m_id_mask & CMS_ID_SRC_PORT)
            m_id_length+= 2;
        if (m_id_mask & CMS_ID_DST_PORT)
            m_id_length+= 2;
        if (m_id_mask & CMS_ID_PROTOCOL)
            m_id_length+= 1;
    }
}
