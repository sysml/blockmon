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

#include <ACHash31.hpp>
#include <fstream>


namespace blockmon{

unsigned int ACHash31::compute(unsigned int key)
{
    return compute(key,SMOD_A,SMOD_B);
}

unsigned int ACHash31::compute(unsigned int key, unsigned int a, unsigned int b)
{
    unsigned long long result;
    result = ((unsigned long long) a)*((unsigned long long) key)+((unsigned long long) b);
    result = ((result >> 31) + result) & SMOD_MOD;
    return (unsigned int) result;
}

void ACHash31::compute(const unsigned char key [] , int len, unsigned char output[] )
{
    unsigned int key_int = 0;
    unsigned int key_int_temp = 0;
    for (int i = 0; i < len; i++)
    {
        if((i&0x3)==0)
        {
            key_int += key_int_temp;
            key_int_temp = 0;
        }
        key_int_temp += key[i] << ((i&0x3)<<3); //(i%4)*8
    }
    key_int +=key_int_temp;
    unsigned int out = compute(key_int);
    for (unsigned int i = 0; i < getDigestLength();i++)
    {
        output[i]=out & 0xFF;
        out = out>>8;
    }
}

void ACHash31::computeFile(const char* path, unsigned char output[] )
{
    std::ifstream input;
    input.open(path);
    unsigned int tmp = 0;
    unsigned int key = 0;
    while (!input.eof())
    {
        input >> tmp;
        key += tmp;
    }
    unsigned char* ckey = (unsigned char*)&key;
    compute(ckey,4,output);
}

void ACHash31::compute(const unsigned char* key, int keylen, const unsigned char* input, int ilen, unsigned char output[] )
{
    unsigned int key_int = 0;
    unsigned int key_int_temp = 0;

    //prepare the key
    for (int i = 0; i < keylen; i++)
    {
        if((i&0x3)==0)
        {
            key_int += key_int_temp;
            key_int_temp = 0;
        }
        key_int_temp += key[i] << ((i&0x3)<<3); //(i%4)*8
    }
    key_int +=key_int_temp;
    key_int_temp = 0;
    //add the input message
    for (int i = 0; i < ilen; i++)
    {
        if((i&0x3)==0)
        {
            key_int += key_int_temp;
            key_int_temp = 0;
        }
        key_int_temp += input[i] << ((i&0x3)<<3); //(i%4)*8
    }
    key_int +=key_int_temp;
    unsigned int out = compute(key_int);
    for (unsigned int i = 0; i < getDigestLength();i++)
    {
        output[i]=out & 0xFF;
        out = out>>8;
    }
}

unsigned int ACHash31::get_a()
{
    return SMOD_A;
}

unsigned int ACHash31::get_b()
{
    return SMOD_B;
}

}

