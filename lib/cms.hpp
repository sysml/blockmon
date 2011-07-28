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

/**
 * Count Min Sketches algorithm library.
 * Adapted to IP packets count form the Count-Min Sketches code from G. Cormode 2003,2004.
 * Keeps a counter for each IP packets flow defined by one or more of the identifiers:
 * source IP, dest. IP, source port, dest. port, underlying protocol.
 * These identifiers are extracted from a Tuple message.
 * The memory consumption is constant and defined by the width and depth of the sketch.
 * The Sketch is a message itself so it can be sent in blockmon.
 */

#ifndef CMS_HPP
#define CMS_HPP

// Flags for the ids
#define CMS_ID_SRC_IP 0x1
#define CMS_ID_DST_IP 0x2
#define CMS_ID_SRC_PORT 0x4
#define CMS_ID_DST_PORT 0x8
#define CMS_ID_PROTOCOL 0x10

// Internal algorithm constant
#define CMS_MOD 2147483647

// CMS Sketch message code
#define CMS_SKETCH_CODE   0xcacfc

#include<Msg.hpp>
#include <Tuple.hpp>
#include <hash/ACHash31.hpp>

namespace cms
{
    /**
     * Implements a storage sketch using CMS
     */
    class Sketch: public bm::Msg
    {
        const int m_width;
        const int m_depth;
        const unsigned int m_id_mask;
        unsigned int m_id_length;
        // Data of the sketch
        int** m_counts;
        // Hash functions
        bm::HASH** m_hashes;

    public:
        /**
         * Constructor
         *
         * @param width Width of the sketch (number of values per hash)
         * @param depth Depth of the sketch (number of hash functions)
         * @param id_mask Bitwise or of the CMS_ID_ flags to use
         * @param seed Random value to initialize the hash functions
         */
        Sketch(int width, int depth, unsigned int id_mask, int seed);
            
        /**
         * Clone constructor.
         * Hash functions are reused without copy.
         *
         * @param sketch The sketch to clone
         */
        Sketch(const Sketch* sketch);

        /**
         * Destructor
         */
        ~Sketch();

        /**
         * Clone function.
         * Hash functions are reused without copy.
         */
        std::shared_ptr<Msg> clone() const;

        /**
         * Update the count for the given packet
         *
         * @param tuple The tuple for which you update the count
         * @param diff The value to add to the count (may be negative) (typically 1)
         */
        void update(const bm::Tuple* tuple, int diff);

        /**
         * Estimate the count for the given tuple
         *
         * @param tuple The tuple for which you want the count
         * @return the estimated count
         */
        int estimate(const bm::Tuple* tuple) const;			 

        /**
         * @return the width of the sketch
         */
        int get_width() const;	 

        /**
         * @return the depth of the sketch
         */
        int get_depth() const;

        /**
         * @return the mask used for ids in the sketch
         */
        unsigned int get_id_mask() const;

        /**
         * Return the indexes in the sketch for the given tuple
         * @param tuple The tuple for which you want the indexes	 
         * @param indexes The indexes will be put in this array of size "depth"
         */
        void get_indexes(const bm::Tuple* tuple, unsigned int indexes[]) const;

        /**
         * Access to the sketch values (no copy, this is the actual sketch)
         * @return the sketch values
         */
        int** get_data() const;

        /**
         * Access to the sketch values (no copy, this is the actual sketch)
         * @param index The index of the line to get
         * @return a line of the sketch
         */
        int* get_data(int index) const;

        /** 
         * Access to the hash functions used
         */
        bm::HASH** get_hashes() const;

        /**
         * Merge the given sketch in this one.
         * You are responsible to make sure that the merged sketch has the same dimensions and
         * hash functions.
         * @param sketch the sketch to merge.
         */
        void merge(const Sketch* sketch);

        /**
         * Reset the sketch data to 0
         */
        void reset();

    private:
        /**
         * Compute the packet id from its header depending on id_mask
         *
         * @param tuple The tuple to compute the id from
         * @param id The place to store the id, should be allocated with a size of m_id_length
         */
        void compute_id(const bm::Tuple* tuple, unsigned char* id) const;

        /**
         * Add a number of data bytes to an id
         *
         * @param id The id to modify
         * @param bytes The data to add to the id
         * @param length The length of the data in bytes
         * @param current_offset The position where the byte should be written (will be updated)
         */
        void add_bytes_to_id(unsigned char* id, char* bytes, int length, int* current_offset) const;

        /**
         * Compute the id length from the id mask 
         * and put it in m_id_length
         */
        void compute_id_length();
    };

}

#endif
