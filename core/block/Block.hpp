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
 * Copyright notice goes here.
 */
#ifndef _CORE_BLOCK_BLOCK_HPP_
#define _CORE_BLOCK_BLOCK_HPP_ 

#include <map>
#include <memory>
#include <chrono>
#include <mutex>
#include <sstream>
#include <stdexcept>
#include <algorithm>

#if __GNUC__ == 4 &&  __GNUC_MINOR__ == 4  
#include <cstdatomic>
#else 
#include <atomic>
#endif

#include <pugixml.hpp>


#include <InGate.hpp>
#include <OutGate.hpp>
#include <MpMcQueue.hpp>
#include <BlockVariable.hpp>
#include <BMTime.h>
#include <TimerThread.hpp>
#include <Timer.hpp>
/**
 * The blockmon namespace contains all classes and functions belonging
 * to Blockmon.
 */
namespace blockmon { 

    class Timer;	// forward definition

    /** Maximum number of messages to dequeue at once in active mode. */
    static const int MAX_MSG_DEQUEUE = 10;

    /** Enumerated list of invocation types.
     *
     * Use Direct for direct invocation (Block::receive_msg() is
     * called in the same thread as the associated
     * Block::send_out_through()). Use Indirect for indirect
     * invocation (each input gate on the Block is associated with a
     * queue, Block::send_out_through() enqueues the message, and
     * Block::receive_msg() is called for each dequeued message by the
     * scheduler). Use Async for blocks which have no input Block, and
     * only do work in their Block::do_async() method. */
    enum class invocation_type { Direct, Indirect, Async };

    enum log_type {log_debug, log_info, log_warning, log_error};
    static const std::vector<std::string> log_type_name = { "debug", "info", "warn", "error" };


/**
 * Base class for Blockmon blocks.
 *
 * A block is a small unit of processing, that comm...
 *
 * The preceding text fragment was found in a maze below a haunted
 * cathedral, written with what appeared to be congealed blood as a
 * palimpsest on parchment.  We think the zombies got him before he
 * could finish the sentence.
 *
 * @section How to Build a Block
 *
 * -# create a subclass of Block ( class MyBlock : public Block { ... }; )
 *    to make it easier on other developers, put this in the blocks/ 
 *    directory, and name it SomethingBlock, unless it meets one of the
 *    following two criteria:
 *    -  Messages sources (e.g. IPFIX importers, packet capture blocks)
 *         should be named SomethingSource.
 *    -  Message sinks for export (e.g., IPFIX exporters) should be
 *         named SomethingExporter.
 * -# implement your constructor in terms of the Block constructor. Your
 *    block constructor should take two parameters, std::string name and 
 *    bool active, which will be supplied by BlockFactory. Resource-intensive
 *    initialization can be deferred to _configure(), below.
 * -# implement the _configure() method to handle block configuration. 
 *    This receives a pugixml node representing the <params> element 
 *    containing block parameters. All blocks must implement _configure(),
 *    which in addition to configuration should also do any necessary
 *    creation of periodic timers or other resource-intensive initialization.
 * -# implement the _receive_msg() method to receive messages (which you'll
 *    need to do unless your block is a Source).
 * -# If your block uses timers (see Timer.hpp), implement the _handle_timer() 
 *    method, which gets called when the timers fire.
 * -# If your block is runtime-reconfigurable, implement the 
 *    _update_config() method.
 * -# If your block can be directly invoked, and is thread-safe, implement
 *    the _synchronize_access() method to return false. _synchronize_access()
 *    is called after _configure(), so your block's thread-safety can be 
 *    configuration dependent.
 * -# If your block can only be asynchronously invoked, and requires
 *    high frequency periodic events without timing constraings (e.g., as
 *    a Source block busywaiting on packets, implement _do_async().
 *    This method should do the smallest amount of processing that is
 *    practical, in order to retain scheduling flexibility.
 * -# Use the REGISTER_BLOCK(classname, configname) macro at the end of your 
 *    SomethingBlock.cpp file macro to register your Block with the factory.
 *
 * @section Block Scheduling
 *
 * Blockmon supports direct, indirect, and asynchronous invocation.
 * Messages sent to indirect blocks are stored in a queue, and
 * receive_msg is called by Blockmon’s scheduler. Messages sent to
 * direct blocks are executed directly as a method call to receive_msg()
 * within the same thread as the block which sends them a
 * message. Asynchronous blocks receive no messages (and should not
 * implement _receive_msg()), but can do work in _do_async() as well
 * as in _handle_timer().
 */
    class Block {

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Class boilerplate: constructors, destructors, copyability
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    protected:

/**
 * Creates a new Block with a given name and type. 
 *
 * @param name the name of the Block
 * @param invocation invocation type of the Block, Direct, Indirect, or Async.
  */

        Block(const std::string &name, invocation_type invocation)
        : m_name(name),
          m_mutex(),
          m_invocation(invocation),
          m_issynchronized(true),
          m_running(false),
          m_input_ids(),
          m_output_ids(),
          m_ingates(),
          m_outgates(),
          m_last_in_id(0),
          m_last_out_id(0),
          m_timer_queue(),
          m_variables(),
          m_queue_type(QUEUETYPE_DROPPING)
        {}
    public:
        /** Virtual destructor */
        virtual ~Block();

    protected:

        /** Null copy constructor for Block; Blocks cannot be copied. */
        Block(const Block &) = delete;

        /** Null copy assignment for Block; Blocks cannot be copied. */
        Block& operator=(const Block &) = delete;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Basic accessors
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    public:

/**
 * Returns the invocation type of this Block.
 */ 

        invocation_type invocation() const {
            return m_invocation;
        }

/**
 * Sets the Block's invocation type.
 *
 * @param invocation invocation type to use, Direct, Indirect, or Async.
 */

        void set_invocation(invocation_type invocation) {
            if (m_running) {
                throw std::runtime_error("cannot change invocation while block is running");
            }
            m_invocation = invocation;
        }

/**
 * Tests if the Block is directly invoked.
 */
 
        bool is_direct() const {
            return m_invocation == invocation_type::Direct;
        }

/**
 * Returns the running status of this Block. 
 *
 * NOTE: This facility is not yet used by BlockMon, and is included
 * for future reconfiguration support.
 *
 * @return TRUE if the Block is presently running (that is, may 
 *         have its receive_msg() and handle_timer() methods called).
 */
        bool is_running() const
        {
            return m_running;
        }

/**
 * Sets the running status of this Block. Called by the
 * BlockMon infrastructure at thread startup and shutdown time.
 *
 * NOTE: This facility is not yet used by BlockMon, and is included
 * for future reconfiguration support.
 *
 * @param running TRUE if the Block is presently running (that is, may 
 *         have its receive_msg() and handle_timer() methods called).
 */
        void set_running(bool running)
        {
            m_running = running;
        }

/**
 * Returns the Block's name.
 *
 * @return the name of the Block
 */
        const std::string& get_name() const
        {
            return m_name;
        }

/**
 * Returns if queues are blocking.
 *
 * @return true if queues are blocking
 */

        const int queue_type() const
        {
            return m_queue_type;
        }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Gate accessors
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Gets an input gate on this Block, given a name.
 *
 * Throws unless the named input gate exists.
 *
 * @param name the name of the input gate to get
 * @return the named gate by reference.
 */
        InGate& get_input_gate(const std::string& name)
        {
            std::map<std::string, int>::iterator it;
            it = m_input_ids.find(name);
            if (it == m_input_ids.end()) {
                throw std::runtime_error(std::string("Gate '").append(name).append("' does not exist for block '").append(get_name()).append("'."));
            }
            return m_ingates[it->second];
        }
/**
 * Gets an output gate on this Block, given a name.
 *
 * Throws unless the named output gate exists.
 *
 * @param name the name of the output gate to get
 * @return the named gate by reference.
 */
        OutGate& get_output_gate(const std::string& name) 
        {
            std::map<std::string, int>::const_iterator it;
            it = m_output_ids.find(name);
            if (it == m_output_ids.end()) 
                throw std::runtime_error(std::string("Gate '").append(name).append("' does not exist."));
            return m_outgates[it->second];
        }

/**
 * Gets an output gate on this Block, given an id.
 *
 * Throws unless the output gate exists.
 *
 * @param id the id of the output gate to get
 * @return the gate by reference.
 */
        OutGate& get_output_gate(int id) 
        {
            return m_outgates.at(id);
        }


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Entry points for the BlockMon infrastructure
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Configures a Block.
 *
 * This is the entry point for configuration. Called by the BlockMon
 * infrastructure at initial configuration time.  Not overridable;
 * derived classes must implement the virtual method _configure() to
 * handle configuration.
 *
 * @param xmlnode the <block> XML node containing Block configuration
 */
      void configure(const pugi::xml_node& block_node)
      {
            // configure needs to take <block> node of XML
            // parsing common block features
#ifdef BLOCKING_QUEUE
    	  auto block_attrib=block_node.attribute("blocking_mode");
    	  if(!block_attrib.empty()){
    		  if (m_invocation != invocation_type::Indirect){
    			  std::cerr << "warning: m_queue_blocking attribute is valid only for indirect blocks. The argument is ignored for the block " <<m_name<<"\n";
    		  }
    		  else
    		  {
				  std::string s(block_attrib.value());
				  std::transform(s.begin(), s.end(), s.begin(), (int (*)(int))std::tolower);
				  if (s.compare("drop")==0){
					  m_queue_type=QUEUETYPE_DROPPING;
					  blocklog("Queues are dropping", log_info);
				  }
				  else if (s.compare("yield")==0){
					  m_queue_type=QUEUETYPE_YIELDING;
					  blocklog("Queues are blocking (threads yield)", log_info);
				  }else if(s.compare("sleep")==0){
					  m_queue_type=block_node.attribute("sleep_usec").as_int();	// returns 0 if sleep_usec is not set
					  if(m_queue_type<=0){
						  throw std::runtime_error(std::string("For block '").append(m_name).append("': 'blocking_mode=sleep' but 'sleep_usec' attribute not set or not > 0"));
					  }
					  blocklog(std::string("Queues are blocking (threads sleep for ").append(std::to_string(m_queue_type)).append(" usec)"), log_info);

				  }else if(s.compare("mutex")==0){
					  m_queue_type=QUEUETYPE_MUTEX;
					  blocklog(std::string("Queues are blocking (using signals and a mutex)"), log_info);
				  }else{
					  throw std::runtime_error(std::string("'blocking_mode' attribute value '").append(s)
											  .append("' for block '").append(m_name).append("' is invalid.\n")
											  .append("Valid parameters are: drop (default), yield, sleep, mutex.")  );
				  }
    		  }
    	  }
    	  else if (m_invocation != invocation_type::Indirect){
    		  blocklog("Queues are non-blocking (i.e., messages will be dropped when queue is full)", log_info);
    		  m_queue_type=QUEUETYPE_DROPPING;
    	  }

#endif	//BLOCKING_QUEUE
            pugi::xml_node params_node = block_node.child("params");

            _configure(params_node);
            m_issynchronized = _synchronize_access();
        }


/**
 * Initializes a Block.
 *
 * Called by the BlockMon infrastructure to initialize the Block. 
 * Not overridable; derived classes must
 * implement the virtual method _initialize() to handle configuration.
 *
 * @param xmlnode the <params> XML node containing Block parameters
 */

        void initialize()
        {
            _initialize();
        }
/**
 * Updates this Block's configuration.
 *
 * Entry point for reconfiguration. Called by the BlockMon 
 * infrastructure at reconfiguration time. Not overridable; derived 
 * classes must implement the virtual method _update_config() to 
 * handle reconfiguration. 
 *
 * @param xmlnode the <params> XML node containing Block parameters
 * @return TRUE if the configuration is updateable, FALSE otherwise.
 */
      bool update_config(const pugi::xml_node& params_node)
        {
            if (_update_config(params_node)) {
                m_issynchronized = _synchronize_access();
                return true;
            } else {
                return false;
            } 
        }

/**
 * Receives a message from another Block.
 *
 * Entry point for passive message processing. Called by the BlockMon 
 * infrastructure when a message is sent to this Block.
 * Handles synchronization for thread-unsafe _receive_msg implementations. 
 * Not overridable; derived classes must implement the virtual method 
 * _receive_msg() to receive messages.
 *
 * @param m a shared pointer to the received message
 * @param gate_id the id of the gate on which the message was received
 */
        void receive_msg(std::shared_ptr<const Msg>&& m, int gate_id)
        {
            if (m_issynchronized) {
            	std::lock_guard<std::mutex> receive_guard(m_mutex);
                _receive_msg(std::move(m), gate_id);
            } else {
                _receive_msg(std::move(m), gate_id);
            }
        }

/**
 * Handles an expired timer.
 *
 * Entry point for timer processing. Called by the BlockMon 
 * infrastructure when a timer event occurs for this Block.
 * Handles queueing for actively scheduled blocks and synchronization 
 * for thread-unsafe _handle_timer implementations. Not overridable; 
 * derived classes must implement the virtual method _handle_timer()
 * to handle timers.
 *
 * @param t a shared pointer to the timer on which the event occurred
 */
        void handle_timer(std::shared_ptr<Timer> t);

 /**
  * Runs this Block.
  *
  * Entry point for the active runloop. Called by the BlockMon infrastructure
  * within a thread in the assigned threadpool. 
  *
  * Handles queued timers and messages via _handle_timer() and _receive_msg(), 
  * and asynchronous processing via _do_async().
  */
        void run();

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Exposed variable accessors
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Lists variables exposed by this Block.
 *
 * this method displays the block variable exposed by this Block and
 * specifies their access permissions (read/write)
 *
 * @return a string reporting a human readable list of variable with
 * their names and permissions
 */
        std::string list_variables();

/**
 * Returns a named variable's value.
 *
 * this method allows to read the value of a block variable. In order
 * for this to happen, such variable has to be registered as readable
 *
 * @return in case read succeeded a string reporting the human
 * readable value of the variable, otherwise an empty string
 */
        std::string read_variable(const std::string& v_name)
        {
            auto it = m_variables.find(v_name);
            if (it == m_variables.end())
            {
                throw std::runtime_error(std::string(v_name).append(" :no such variable"));
            }
            return ((it->second)->read());
        }

/**
 * Sets a named variable's value.
 *
 * writes a value (expressed as a string) to a block variable.  Notice
 * that the interface is type agnostic: the streaming operators in the
 * will convert the content into a type-specific value.  For example
 * if the control plane needs to write 123 into an integer type
 * variable, the content of the string s will be the human-readable
 * "123" which will be converted into its numeric value by the
 * streaming operator.
 *
 * @param v_name name of the variable
 * @param val value to be written into the variable
 */
        void write_variable(const std::string& v_name, const std::string& val)
        {
            auto it = m_variables.find(v_name);
            if(it==m_variables.end())
            {
                throw std::runtime_error(std::string(v_name).append(" :no such variable"));
            }
            (it->second)->write(val);
        }

    /* only subclasses can register variables */
    protected:

/** 
 * Registers a variable which can be externally shared outside the Block.
 *
 * See BlockVariable.hpp for documentation on creating and using
 * exposed variables.
 * 
 * @param name name by which the variable can be accessed
 * @param v a shared pointer to the variable to register (creating it with the helper functions in BlockVariable.hpp is recommended)
 */
        void register_variable(const std::string& name, std::shared_ptr<BlockVariable>&& v)
        {
            auto it = m_variables.find(name);
            if(it != m_variables.end()) {
                throw std::runtime_error(std::string(name).append(" variable already registered"));
            }
            m_variables[name] = std::move(v);
        }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Gate accessors for use by derived classes
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    protected:
 
 /**
  * Sends a message on a given gate.
  *
  * If connected to a passive Block, the downstream receive_msg will
  * be invoked directly; otherwise the message will be queued.
  *
  * @param m the message to send
  * @param gate_id the id of the gate to send the message on, 
  *                as returned by register_output_gate
  */
        void send_out_through(std::shared_ptr<const Msg>&& m, int id)
        {
            assert((id >= 0) && (id < (int)m_outgates.size()));
            m_outgates[id].deliver(std::move(m));
        }

 /**
  * Registers an input gate.
  * 
  * @param name the name of the gate to register
  * @return the id of the registered gate
  */
        int register_input_gate(const std::string &name);

 /**
  * Registers an output gate.
  * 
  * @param name the name of the gate to register
  * @return the id of the registered gate
  */
        int register_output_gate(const std::string &name);

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Timer accessors for use by derived classes
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Sets a one-shot timer to fire on this Block at a specified point in time.
 *
 * @param ts the time at which to fire the timer
 * @param name the name of the timer
 * @param id the id of the timer; retrievable with Timer::get_id() for later
 *           quick comparison
 */
        void set_timer_at(ustime_t ts, 
                          const std::string &name, 
                          unsigned int id);

/**
 * Sets a periodic timer to fire on this Block with a specified period
 *
 * @param us the period of the timer in microseconds.
 * @param name the name of the timer
 * @param id the id of the timer; retrievable with Timer::get_id() for later
 *           quick comparison
 */
        void set_periodic_timer(ustime_t us, 
                                const std::string &name, 
                                unsigned int id);

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Logging to be used by derived classes.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Prints a log message.
 * 
 * FIXME make this not suck
 * 
 * @param l the log message to print
 * @param t the type of the log message (one of debug, info, warning, error)
 */
        void blocklog(std::string l, log_type t)
        {
            std::cerr << m_name << '\t' << log_type_name[t] << '\t' << l << std::endl;
        }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Entry points to be overriden by derived classes.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    protected:
        
/**
 * Configure the block given an XML element containing configuration.
 * Called before the block will begin receiving messages.
 *
 * SHOULD be overridden in a derived class. 
 * Configuration errors should be signaled by throwing.
 *
 * @param xmlnode the <params> XML element containing block parameters
 */
      virtual void _configure(const pugi::xml_node& xmlnode) {}

/**
 * Initializes the Block. 
 * Called before the Block will begin receiving messages.
 *
 * CAN be overridden in a derived class. 
 * Configuration errors should be signaled by throwing.
 */

        virtual void _initialize() {}

/**
 * Updates the configuration on a running Block given an XML 
 * element containing configuration.
 *
 * Can veto a reconfiguration by returning false, after which the
 * block will be destroyed, recreated, and configured from scratch.
 *
 * The default implementation simply returns false, requiring a restart.
 *
 * @param xmlnode the <params> XML node containing block parameters.
 * @return true if update was successful, false if impossible.
 */
      virtual bool _update_config(const pugi::xml_node& xmlnode) { return false; }

/**
 * Handles a message sent from another Block.
 *
 * Should be overridden by any derived class that can receive messages;
 * default does nothing. Errors should be logged. Fatal
 * errors should be handled by throwing.
 *
 * @param m a shared pointer to the message to handle
 * @param gate_id the gate ID of the input gate on which the message was 
 *                received, as returned by register_input_gate()
 *
 */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int gate_id) {}

/**
 * Handles a timer event.
 *
 * Should be overridden by any derived class that uses timers;
 * default throws a logic error. Errors should be logged. Fatal
 * errors should be handled by throwing. 
 *
 * @param t the timer on which the event occurred.
 *
 */
        virtual void _handle_timer(std::shared_ptr<Timer>&& t);
            
        
/**
 * Does asynchronous processing as part of an active Block's runloop.
 *
 * Not called for passively scheduled Blocks. The default implementation
 * does nothing. This method is meant for special, high-frequency periodic
 * events without timing requirements, and should be used carefully.
 */
        virtual void _do_async() { }

/**
 * Determines whether the Block's _receive_msg() and _handle_timer() methods
 * should be synchronized (i.e., should allow only one thread at a time to
 * execute them. Called after configuration or reconfiguration time.
 *
 * Derived classes SHOULD override this method to return false if they are 
 * threadsafe; the default implementation always returns true.
 *
 * @return the synchronized status of the methods in the Block
 */
        virtual bool _synchronize_access() { return true; }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Member variables
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    protected:
        const std::string m_name;

    private:
        std::mutex m_mutex;
        invocation_type m_invocation;
        bool m_issynchronized;
        bool m_running;
        
        // Input and output gates
        std::map<std::string, int > m_input_ids;
        std::map<std::string, int > m_output_ids;
        std::vector<InGate> m_ingates;
        std::vector<OutGate> m_outgates;
        std::atomic_int m_last_in_id;
        std::atomic_int m_last_out_id;

        MpMcQueue<Timer> m_timer_queue;

        std::map<std::string, std::shared_ptr<BlockVariable> > m_variables;

        int m_queue_type;
    };

} // namespace blockmon

#endif /* _CORE_BLOCK_BLOCK_HPP_ */
