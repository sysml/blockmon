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

#include "BloomFilter.hpp"

namespace NXAnalyzer{

BloomFilter::BloomFilter():
        bufferSize(BUFFER_SIZE),
        numberHash(NUMBER_HASH),
        m_numberOnes(0),
        compareCount(0) {
			arraySize = (bufferSize/8) + 1;
            buffer = new unsigned char[arraySize];
            initBloom();

        }

BloomFilter::BloomFilter(int bS, int nH):
        bufferSize(bS),
        numberHash(nH),
        m_numberOnes(0),
        compareCount(0) {
			arraySize = (bufferSize/8) + 1;
            buffer = new unsigned char[bufferSize];
            initBloom();
        }

BloomFilter::~BloomFilter(){
		delete [] buffer;
}
		
unsigned* BloomFilter::hashFunction(unsigned char *name, int len){
    unsigned  *msgdig;
	msgdig = new unsigned[5];
	sha.Reset();
    sha.Input((const unsigned char *)name, len);
    if(!sha.Result(msgdig)){
		return NULL;
	}
	return msgdig;
}

bool BloomFilter::addDomain(unsigned char *name, int len){
	int i;
    unsigned hash;
    int count=0;
    for(i=0; i<numberHash; i++){
        hash = (unsigned) hashFunction(name, len)[i];
		hash %= bufferSize;
	
        if((buffer[hash/8] >> (hash%8)) & 1){
            count++;
		} else {
            buffer[hash/8]  |= (1 << (hash%8));
			m_numberOnes++;
		}
   }
   if(count == numberHash) return true;
   return false;
}

bool BloomFilter::contains(unsigned char *name, int len){
    int i=0;
    unsigned hash;
    for(i=0; i<numberHash; i++){
		hash = (unsigned)hashFunction(name, len)[i];
		hash %= bufferSize;

        if(!((buffer[hash/8] >> (hash%8)) & 1)){
            return false;
		}
    }
    return true;

}

float BloomFilter::fillrate(){
    return ((float)(m_numberOnes)/bufferSize);
}

int BloomFilter::numberOnes(){
    int i=0;
    int count=0;
    for(i=0; i<bufferSize; i++){
        if((buffer[i/8] >> (i%8)) & 1)
            count++;
    }
    return count;
}

void BloomFilter::initBloom(){
    int i=0;
    for(i=0; i<arraySize; i++){
        buffer[i]=0;
    }
    m_numberOnes = 0;
}

int BloomFilter::getNumberOnes(){
    return m_numberOnes;
}


void BloomFilter::copyBloom(BloomFilter *bf){
    memcpy(buffer, bf->buffer, bufferSize);
    m_numberOnes = bf->getNumberOnes();
}

unsigned char * BloomFilter::getBuffer() const {
	return buffer;
 }
 
float BloomFilter::compare(BloomFilter* bf){
	int i;
	int counter=0;
	const unsigned char * temp_buffer = bf->getBuffer();
	for(i=0; i<bufferSize; i++){
		if(((temp_buffer[i/8] >> (i%8)) & 1) & ((buffer[i/8] >> (i%8)) & 1))
			counter++;
	}
	if(m_numberOnes > bf->getNumberOnes())
		return (float)(counter/(m_numberOnes*1.0));
	else 
		return (float)(counter/(bf->getNumberOnes()*1.0));

}


void BloomFilter::merge(BloomFilter* bf){
	int i;
	const unsigned char * temp_buffer = bf->getBuffer();
	for(i=0; i<arraySize; i++){
		buffer[i] &= temp_buffer[i];
	}
}


}
