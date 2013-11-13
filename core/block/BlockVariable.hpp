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

#ifndef _CORE_BLOCK_BLOCKVARIABLE_HPP_
#define _CORE_BLOCK_BLOCKVARIABLE_HPP_
/**
 * BlockVariable.hpp
 * Here the block variable mechanism is implemented: this allows the control plane 
 * to have write and read access to inner variables in the block.
 * In order to do this, an object derived from the BlockVariable base class has to be bound
 * to the specific variable and the block has to be notified through the Block::register_variable method.
 * All of the types defining a stream operator are supported.
 * If synchronization is needed for accessing the block variable, the BlockVariable object can
 * be associated to a mutex. 
 * A dirty flag is provided which is set whenever a variable is written to.
 *
 */
 

#include <iostream>
#include <sstream>
#include <string>
#include <stdexcept>
#include <memory>
#include <mutex>
#include<cassert>

/**
  * constructor tag for read_only variables 
  */

typedef enum {RDONLY} rdonly_t;
/**
  * constructor tag for write_only variables 
  */
typedef enum {WRONLY} wronly_t;


/**
  * constructor tag for variables with no synchronization 
  */
typedef enum {NO_LOCK} no_mutex_t;

/**
  * constructor tag for variables synchronized by means of an external mutex  
  */
typedef enum {EXT_LOCK} ext_mutex_t;

/**
  * constructor tag for variables synchronized by of their internal mutex  
  */
typedef enum {OWN_LOCK_T} own_mutex_t;




/**
  * virtual base class for block variables.   
  */
class BlockVariable
{
    bool m_writable;
    bool m_readable;
    bool m_dirty;
public:
    /**
     *  class constructor
     *  @param tw specifies whether writing is enabled for this var
     *  @param tr specifies whether reading is enabled for this var
     */
    BlockVariable(bool tw, bool tr): 
    m_writable(tw), 
    m_readable(tr),
    m_dirty(false)
    {}

    /**
     *  @returns specifies whether writing is enabled for this var
     */
    virtual ~BlockVariable()
    {}
       
    /**
     *  @return specifies whether writing is enabled for this var
     */
    bool is_writable() const
    {
        return m_writable;
    }

    /**
     *  @return specifies whether reading is enabled for this var
     */
    bool is_readable() const
    {
        //assert(m_writable); //this only makes sense for write variables
        return m_readable;
    }
    /**
      * @return the dirty flag for this variable
      */
    bool is_dirty() const
    {
        assert(m_writable); //this only makes sense for write variables
        return m_dirty;
    }

    /**
      * sets a value for the dirty flag for this variable 
      * it is the block's responsibility to clear the dirty flag when the new value has been read
      * @param val the new value for the dirty flag
      */
    void set_dirty(bool val)
    {
        m_dirty=val;
    }
    /**
     * this is the function which is called by the control context when a var has to be written to.
     * Notice that the interface is type agnostic: the streaming operators in the  
     * derived class will convert the content into a type-specific value. For example if the control plane
     * needs to write 123 into an integer type variable, the content of the string s will be the human-readable "123"
     * which will be converted into its numeric value by the derived class.
     * This function actually performs that the operation is allowed, then calls the derived class virtual method _write
     * @param s the content to be written to the var.
     * throws in case of errors
     */
    void write(const std::string& s)
    {
        if (!m_writable) 
        {
            throw std::runtime_error("variable not writable");
        } 
        else 
        {
            _write(s);
            m_dirty=true;
        }
    }

    /**
     * this is the function which is called by the control context when a var has to be read.
     * This function actually performs that the operation is allowed, then calls the derived class virtual method _read
     * @return If read succeeded a returns a human-readable string containing the value of the variable otherwise the string is empty 
     * throws in case of errors
     */
    std::string read() const
    {
        if (!m_readable) 
        {
            throw std::runtime_error("variable not readable");
        } 
        else 
        {
            return _read();
        }
    }

protected:
    /**
     * this is a pure virtual function to be overridden by the derived class.
     * It implements the actual write operation.
     * @param s the content to be written to the var.
     */
    virtual void _write(const std::string& s)=0;


    /**
     * this is a pure virtual function to be overridden by the derived class.
     * It implements the actual read operation.
     * @return If read succeeded a returns a human-readable string containing the value of the variable otherwise the string is empty 
     */
    virtual std::string _read() const =0;
};

/** 
 * generic template for the derived class.
 * this is only needed for template specialization
 */

template<typename T, typename acc_spcifier,typename locking_policy >
class VariableImpl: public BlockVariable
{
};



/** 
 * partial template specialization for read-only variables without synchronization
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,rdonly_t, no_mutex_t>: public BlockVariable
{
    const T& m_var;
public:

    /**
      * class constructor 
      * @param v const reference to the actual variable to be read
      */
    VariableImpl(const T& v): 
    BlockVariable(false,true), 
    m_var(v)
    {}  

    /**
     * this object cannot be copied nor moved
     */
    VariableImpl(const VariableImpl <T,rdonly_t,no_mutex_t>&)=delete;
    VariableImpl( VariableImpl <T,rdonly_t,no_mutex_t>&&)=delete;
    VariableImpl <T,rdonly_t,no_mutex_t>& operator=(const VariableImpl <T,rdonly_t,no_mutex_t>&)=delete;
    VariableImpl <T,rdonly_t,no_mutex_t>& operator=(VariableImpl <T,rdonly_t,no_mutex_t>&&)=delete;


protected:
    /**
      * actual implementation of the base class virtual method
      */

    virtual void _write(const std::string& )
    {
        throw std::runtime_error("trying to write a read-only variable");
    }


    /**
      * actual implementation of the base class virtual method
      */
    virtual std::string _read() const
    {
        std::stringstream s;
        if(!(s << m_var))
            throw std::runtime_error("cannot read variable");
        std::string ret =  s.str();
        return ret;
    }


};


/** 
 * partial template specialization for write-only variables without synchronization
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,wronly_t,no_mutex_t>: public BlockVariable
{
    T& m_var;
public:

    /**
      * class constructor 
      * @param v reference to the actual variable to be written to
      */
    VariableImpl(T& v): 
    BlockVariable(true,false),
    m_var(v) 
    {}

    /**
     * this object cannot be copied nor moved
     */
    VariableImpl(const VariableImpl <T,wronly_t,no_mutex_t>&)=delete;
    VariableImpl( VariableImpl <T,wronly_t,no_mutex_t>&&)=delete;
    VariableImpl <T,wronly_t,no_mutex_t>& operator=(const VariableImpl <T,wronly_t,no_mutex_t>&)=delete;
    VariableImpl <T,wronly_t,no_mutex_t>& operator=(VariableImpl <T,wronly_t,no_mutex_t>&&)=delete;



protected:
    /**
      * actual implementation of the base class virtual method
      */
    virtual void _write(const std::string& s)
    {
        std::stringstream ss(std::stringstream::in | std::stringstream::out);
        ss << s;
        if(!(ss >> m_var))
            throw std::runtime_error("cannot write variable");
    }

    /**
      * actual implementation of the base class virtual method
      */
    virtual std::string _read() const
    {
        throw std::runtime_error("trying to read a write-only variable");
    }


};


/** 
 * partial template specialization for read-only variables synchronized by means of an external mutex
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,wronly_t,ext_mutex_t>: public BlockVariable
{
    T& m_var;
    std::mutex& m_mutex;
public:
    /**
      * class constructor 
      * @param v const reference to the actual variable to be written to
      * @param m reference to the external mutex to be used for synchronization
      */

    VariableImpl(T& v, std::mutex& m): 
      BlockVariable(true,false),
      m_var(v),
      m_mutex(m)
      {}

    /**
     * this object cannot be copied nor moved               
   */
    VariableImpl(const VariableImpl <T,wronly_t,ext_mutex_t>&)=delete;
    VariableImpl( VariableImpl <T,wronly_t,ext_mutex_t>&&)=delete;
    VariableImpl <T,wronly_t,ext_mutex_t>& operator=(const VariableImpl <T,wronly_t,ext_mutex_t>&)=delete;
    VariableImpl <T,wronly_t,ext_mutex_t>& operator=(VariableImpl <T,wronly_t,ext_mutex_t>&&)=delete;




protected:
    /**
      * actual implementation of the base class virtual method
      */
    virtual void _write(const std::string& s)
    {
        std::lock_guard<std::mutex> lock_guard_object(m_mutex);
        std::stringstream ss(std::stringstream::in | std::stringstream::out);
        ss << s;
        if(!(ss >> m_var))
            throw std::runtime_error("cannot write variable");
    }

    /**
      * actual implementation of the base class virtual method
      */
    virtual std::string _read() const
    {
        throw std::runtime_error("trying to read a write-only variable");
    }


};

/** 
 * partial template specialization for write-only variables synchronized by means of an external mutex
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,rdonly_t,ext_mutex_t>: public BlockVariable
{
    const T& m_var;
    std::mutex& m_mutex;
public:

    /**
      * class constructor 
      * @param v reference to the actual variable to be read
      * @param m reference to the external mutex to be used for synchronization
      */
    VariableImpl(const T& v, std::mutex& m): 
    BlockVariable(false,true), 
    m_var(v),
    m_mutex(m)
    {
    }

  /** Forbids copy and move constructors.
   */
    VariableImpl(const VariableImpl <T,rdonly_t,ext_mutex_t>&)=delete;

  /** Forbids copy and move assignment.
   */
    VariableImpl <T,rdonly_t,ext_mutex_t>& operator=(const VariableImpl <T,rdonly_t,ext_mutex_t>&)=delete;

protected:

    /**
      * actual implementation of the base class virtual method
      */
    void _write(const std::string& ) 
    {
        throw std::runtime_error("trying to write a read-only variable");
    }


    /**
      * actual implementation of the base class virtual method
      */
    std::string _read() const 
    {
        std::lock_guard<std::mutex> lock_guard_object(m_mutex);
        std::stringstream s(std::stringstream::in | std::stringstream::out);
        s << m_var;
        return s.str();
    }


};

/** 
 * partial template specialization for write-only variables synchronized by means of its internal mutex
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,wronly_t,own_mutex_t>: public BlockVariable
{
    T& m_var;
    std::mutex m_mutex;
public:

    /**
      * class constructor 
      * @param v reference to the actual variable to be written to
      */
    VariableImpl(T& v): 
      BlockVariable(true,false),
      m_var(v),
      m_mutex()
      {}

    /**
     * this object cannot be copied nor moved               
   */
    VariableImpl(const VariableImpl <T,wronly_t,own_mutex_t>&)=delete;
    VariableImpl( VariableImpl <T,wronly_t,own_mutex_t>&&)=delete;
    VariableImpl <T,wronly_t,own_mutex_t>& operator=(const VariableImpl <T,wronly_t,own_mutex_t>&)=delete;
    VariableImpl <T,wronly_t,own_mutex_t>& operator=(VariableImpl <T,wronly_t,own_mutex_t>&&)=delete;

    /* 
     *  returns a reference to the internal mutex to be used for synchronization
     *  @return a reference to the mutex
     */
    std::mutex var_access_mutex()
    {
        return m_mutex;
    }


protected:


    /**
      * actual implementation of the base class virtual method
      */
    void _write(const std::string& s) 
    {
        std::lock_guard<std::mutex> lock_guard_object(m_mutex);
        std::stringstream ss(std::stringstream::in | std::stringstream::out);
        ss << s;
        if(!(ss >> m_var))
            throw std::runtime_error("cannot write variable");
    }

    /**
      * actual implementation of the base class virtual method
      */
    virtual std::string _read() const
    {
        throw std::runtime_error("trying to read a write-only variable");
    }


};

/** 
 * partial template specialization for read-only variables synchronized by means of its internal mutex
 * @param T the type of the actual block variable
 */
template<typename T>
class VariableImpl<T,rdonly_t,own_mutex_t>: public BlockVariable
{
    const T& m_var;
    std::mutex m_mutex;
public:


    /**
      * class constructor 
      * @param v const reference to the actual variable to be read
      */
    VariableImpl(const T& v): 
    BlockVariable(false,true), 
    m_var(v),
    m_mutex()
    {
    }

    /**
     * this object cannot be copied nor moved               
   */
    VariableImpl(const VariableImpl <T,rdonly_t,own_mutex_t>&)=delete;
    VariableImpl( VariableImpl <T,rdonly_t,own_mutex_t>&&)=delete;
    VariableImpl <T,rdonly_t,own_mutex_t>& operator=(const VariableImpl <T,rdonly_t,own_mutex_t>&)=delete;
    VariableImpl <T,rdonly_t,own_mutex_t>& operator=(VariableImpl <T,rdonly_t,own_mutex_t>&&)=delete;
    
    /* 
     *  returns a reference to the internal mutex to be used for synchronization
     *  @return a reference to the mutex
     */
    std::mutex var_access_mutex()
    {
        return m_mutex;
    }

protected:

    /**
      * actual implementation of the base class virtual method
      */
    virtual void _write(const std::string& )
    {
        throw std::runtime_error("trying to write a read-only variable");
    }


    /**
      * actual implementation of the base class virtual method
      */
    virtual std::string _read() const
    {
        std::lock_guard<std::mutex> lock_guard_object(m_mutex);
        std::stringstream s(std::stringstream::in | std::stringstream::out);
        s << m_var;
        return s.str();
    }


};

  
  
/**
 * helper function to create a BlockVariable object bound to a read_only variable
 * @param lock_policy the synchronization policy tag (for template type deduction)
 * @param ob const reference to the actual variable to be  bound
 * @param Ti additional arguments (this is only needed by variables with external sync in order to convey a reference to the mutex)
 */

template <typename T, typename lock_policy,typename ...Ti>
std::shared_ptr<BlockVariable> make_rd_var(lock_policy,  const T& ob, Ti && ...arg)
{
    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,lock_policy>(ob,std::forward<Ti>(arg)...));
}

/**
 * helper function to create a BlockVariable object bound to a write_only variable
 * @param lock_policy the synchronization policy tag (for template type deduction)
 * @param ob reference to the actual variable to be  bound
 * @param Ti additional arguments (this is only needed by variables with external sync in order to convey a reference to the mutex)
 */
template <typename T, typename lock_policy,typename ...Ti>
std::shared_ptr<BlockVariable> make_wr_var(lock_policy,  T& ob, Ti && ...arg)
{
    return std::shared_ptr<BlockVariable>(new VariableImpl<T,wronly_t,lock_policy>(ob,std::forward<Ti>(arg)...));
}
  
//  template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(no_lock_t, const T& ob)
//{
//}
//
//template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(ext_lock_t, const T& ob,std::mutex& m)
//{
//    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,ext_lock_t>(ob,m));
//}
//
//template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(owned_lock_t, const T& ob)
//{
//    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,ext_lock_t>(ob));
//}
//
//
//template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(no_lock_t, const T& ob)
//{
//    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,no_lock_t>(ob));
//}
//
//template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(ext_lock_t, const T& ob,std::mutex& m)
//{
//    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,ext_lock_t>(ob,m));
//}
//
//template<typename T>
//std::shared_ptr<BlockVariable> make_rd_var(owned_lock_t, const T& ob)
//{
//    return std::shared_ptr<BlockVariable>(new VariableImpl<T,rdonly_t,ext_lock_t>(ob));
//}
//


#endif // _CORE_BLOCK_BLOCKVARIABLE_HPP_
