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

#include <iostream>
#include<sstream>
#include<string>
#include<stdexcept>
#include<memory>



typedef enum {RDONLY} rdonly_t;
typedef enum {WRONLY} wronly_t;



class VarBase
{
    bool m_to_write;
    bool m_to_read;


public:
    
    VarBase(bool tw, bool tr): m_to_write(tw), m_to_read(tr)
    {}

    bool write_en() const
    {
        return m_to_write;
    }

    bool read_en() const
    {
        return m_to_read;
    }
    int write(const std::string& s)
    {
        if(!m_to_write)
            return -1;
        else 
        {
            _write(s);
            return 0;
        }
    }

    std::string read() const
    {
        if(!m_to_read)
            return std::string();
        else
            return _read();
    }


protected:



    virtual void _write(const std::string& s)=0;
    virtual std::string _read() const =0;
};



template<typename T, typename acctype>
class Variable: public VarBase
{

};



template<typename T>
class Variable<T,wronly_t>: public VarBase
{
    T& m_var;
public:


    Variable(T& v): VarBase(true,false),m_var(v)
    {
    }

    Variable(const Variable<T,rdonly_t>& v):VarBase(true,false), m_var(v.m_var)
    {}


protected:
    virtual void _write(const std::string& s)
    {
        std::stringstream ss(std::stringstream::in | std::stringstream::out);
        ss<<s;
        ss>>m_var;
    }


    virtual std::string _read() const
    {
        throw std::runtime_error("trying to read a write-only variable");
    }


};

template<typename T>
class Variable<T,rdonly_t>: public VarBase
{
    const T& m_var;
public:


    Variable(const T& v): VarBase(false,true), m_var(v)
    {
    }

    Variable(const Variable<T,rdonly_t>& v):  VarBase(false,true),m_var(v.m_var)
    {}

protected:

    virtual void _write(const std::string& )
    {
        throw std::runtime_error("trying to write a read-only variable");
    }


    virtual std::string _read() const
    {
        std::stringstream s(std::stringstream::in | std::stringstream::out);
        s<<m_var;
        std::string ret ;
        s>>ret;
        return ret;
    }


};



template<typename T>
std::shared_ptr<VarBase> make_rd_var(const T& ob)
{
    return std::shared_ptr<VarBase>(new Variable<T,rdonly_t>(ob));
}


template<typename T>
std::shared_ptr<VarBase> make_wr_var(T& ob)
{
    return std::shared_ptr<VarBase>(new Variable<T,wronly_t>(ob));
}




