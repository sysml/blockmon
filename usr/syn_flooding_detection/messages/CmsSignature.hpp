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
 * @file
 * Message that represents the signature in a CMS sketch of a detected id:
 * the list of values taken by the hashes.
 * This is not reversible to the id, except a list of supect ids is available.
 */

#ifndef _CMS_SIGNATURE_
#define _CMS_SIGNATURE_

#include<Msg.hpp>

#define CMS_SIGNATURE_CODE   0xeafc

namespace bm
{

    class CmsSignature: public Msg
    {
        unsigned int* m_indexes;
		int m_size;

    public:
        /**
         * Constructor
         *
         * @param indexes The list of indexes
         * @param size the number of indexes
         */
        CmsSignature(const unsigned int indexes[], int size) 
        : Msg(CMS_SIGNATURE_CODE), m_size(size)
        {
			m_indexes = new unsigned int[m_size];
			for (int i = 0 ; i < m_size; i++)
				m_indexes[i] = indexes[i];
        }

		/**
		 * Destructor
		 */
        ~CmsSignature()
        {
			delete[] m_indexes;
		}

        /**
         * Access to the indexes
         *
         * @return a pointer to the actual indexes
         */
        unsigned int* get_indexes() const
        {
            return m_indexes;
        }

        /**
         * Access to the number of indexes
         *
         * @return the number of indexes
         */
        int get_size() const
        {
            return m_size;
        }

		/**
	 	 * Clone function
		 */
		virtual std::shared_ptr<Msg> clone() const
		{
			return std::make_shared<CmsSignature>(m_indexes, m_size);
		}
    };

}


#endif

