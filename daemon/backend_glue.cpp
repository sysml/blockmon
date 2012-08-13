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

#include<CompositionManager.hpp>
#include<PoolManager.hpp>
#include<TimerThread.hpp>
#include<BMTime.h>
#include<Block.hpp>

#include <boost/python/enum.hpp>
#include <boost/python/class.hpp>
#include <boost/python/module.hpp>
#include <boost/python/def.hpp>

#include <cctype>
using namespace pugi;
using namespace blockmon;
#undef C_DEBUG
namespace
{

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Timer thread handline 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
  std::thread* tt=NULL;

  void start_timer_thread() {
#ifdef C_DEBUG
    std::cout << "c++: start_timer_thread" << std::endl;
#endif
    tt = new std::thread(std::ref(TimerThread::instance()));
  }
	
  void stop_timer_thread() {
#ifdef C_DEBUG
    std::cout << "c++: stop_timer_thread" << std::endl;
#endif
    TimerThread::instance().stop();
    tt->join();
    delete tt;
  }

  void select_clock_(const std::string &s)
  {
    if (s == "WALL") select_clock(clock_source_t::WALL);
    if (s == "PACKET") select_clock(clock_source_t::PACKET);
  }

  void add_composition(std::string filename)
  {
#ifdef C_DEBUG
    std::cout << "c++: add_composition "<< filename << std::endl;
#endif
    CompositionManager::instance().add_composition(filename);
  }

  void init_composition(std::string comp_id)
  {
#ifdef C_DEBUG
    std::cout << "c++: initializing blocks for composition " << comp_id << std::endl;
#endif
    CompositionManager::instance().init_composition(comp_id);
  }

  void delete_composition(std::string comp_id)
  {
#ifdef C_DEBUG
    std::cout << "c++: delete_composition " << comp_id << std::endl;
#endif
    CompositionManager::instance().delete_composition(comp_id);
  }
   
  void start_schedulers()
  {
#ifdef C_DEBUG
    std::cout << "c++: start_schedulers" << std::endl;
#endif
    PoolManager::instance().start();
  }

  void stop_schedulers()
  {
#ifdef C_DEBUG
    std::cout << "c++: stop_schedulers" << std::endl;
#endif
    PoolManager::instance().stop();
  }

  void create_connection(const std::string& from_composition,\
                         const std::string& from_block,      \
                         const std::string& from_gate,       \
                         const std::string& to_composition,  \
                         const std::string& to_block,        \
                         const std::string& to_gate)
  {
#ifdef C_DEBUG
  std::cout << "c++: create+connection" \
            << from_composition \
            <<from_block \
            <<from_gate \
            <<to_composition \
            <<to_block \
            <<to_gate \
            <<std::endl;
#endif
  OutGate& src=CompositionManager::instance().get_composition(from_composition).get_block(from_block)->get_output_gate(from_gate);
  InGate& dst=CompositionManager::instance().get_composition(to_composition).get_block(to_block)->get_input_gate(to_gate);
  src.connect(dst);
  dst.connect(src);
  }

  void delete_connection(const std::string& from_composition,\
                         const std::string& from_block,      \
                         const std::string& from_gate,  \
                         const std::string& to_composition, \
                         const std::string& to_block,       \
                         const std::string& to_gate)
  {  
#ifdef C_DEBUG
  std::cout << "c++: delete_connection"\
            << from_composition\
            << from_block\
            << from_gate\
            << to_composition\
            << to_block\
            << to_gate\
            << std::endl;
#endif
  OutGate& src=CompositionManager::instance().get_composition(from_composition).get_block(from_block)->get_output_gate(from_gate);
  InGate& dst=CompositionManager::instance().get_composition(to_composition).get_block(to_block)->get_input_gate(to_gate);
  src.disconnect(&dst);
  dst.disconnect(&src);
  }

  void create_block(const std::string& comp_id,\
                    const std::string& name,\
                    const std::string& type,\
                    invocation_type invocation,\
                    const std::string& config)
  {  
#ifdef C_DEBUG
    std::cout << "c++: create_block" << comp_id << name << type << std::endl;
#endif
    CompositionManager::instance().get_composition(comp_id).create_block(name, type, invocation, config);
  }

  void delete_block(const std::string& comp_id, const std::string& name)
  {  
#ifdef C_DEBUG
    std::cout << "c++: delete_block" << comp_id << name <<std::endl;
#endif
    CompositionManager::instance().get_composition(comp_id).delete_block(name);
  }

  bool update_block(const std::string& comp_id,\
                    const std::string& name,\
                    invocation_type invocation,\
                    const std::string& config)
  {
#ifdef C_DEBUG
    std::cout << "c++: update_block" << comp_id << name << std::endl;
#endif
    xml_document config_info;
    if(!config_info.load(config.c_str()))
      throw std::runtime_error("update_config::cannot parse config info");
   pugi::xml_node confxml = config_info.child("params");
    if(!confxml)
      throw std::runtime_error("Configuration: cannot find params node");
    CompositionManager::instance().get_composition(comp_id).get_block(name)->set_invocation(invocation);
    return CompositionManager::instance().get_composition(comp_id).get_block(name)->update_config(confxml);
  }
   
  void add_block_to_thread_pool(const std::string& comp_id,\
                                const std::string& name,\
                                const std::string& pool)
  {
#ifdef C_DEBUG
    std::cout<<"c++: add_block_to_thread_pool" << comp_id << name << std::endl;
#endif
    std::shared_ptr<Block> b= CompositionManager::instance().get_composition(comp_id).get_block(name);
    PoolManager::instance().add_to_pool(pool,b);
  }

  void remove_block_from_thread_pool(const std::string& comp_id,\
                                     const std::string& name,\
                                     const std::string& pool)
  {
#ifdef C_DEBUG
    std::cout << "c++: remove_block_from_thread_pool" << comp_id << name << std::endl;
#endif
    std::shared_ptr<Block> b = CompositionManager::instance().get_composition(comp_id).get_block(name);
    PoolManager::instance().remove_from_pool(pool, *b);
  }

  void add_thread_pool(const std::string& pool_config)
  {                   
#ifdef C_DEBUG
    std::cout << "c++: add thread pool" << pool_config << std::endl;
#endif

    xml_document config_info;
    if(!config_info.load(pool_config.c_str()))
       throw std::runtime_error("add_thread_pool::cannot parse config info");
   pugi::xml_node poolxml = config_info.child("threadpool");
    if(!poolxml)
       throw std::runtime_error("Configuration: cannot find block node");
    PoolManager::instance().create_pool(poolxml);  
  }

   void remove_thread_pool(const std::string& poolname)
   {  
#ifdef C_DEBUG
     std::cout << "c++: remove thread pool" << poolname << std::endl;
#endif
     PoolManager::instance().delete_pool(poolname);
   }
	
   std::string read_block_variable(const std::string& comp_id,\
                                   const std::string& name,\
                                   const std::string& variable)
  {
      return CompositionManager::instance().get_composition(comp_id).get_block(name)->read_variable(variable);
  }

  bool write_block_variable(const std::string& comp_id,\
                           const std::string& name,\
                           const std::string& variable,\
                           const std::string& val)
  {
    CompositionManager::instance().get_composition(comp_id).get_block(name)->write_variable(variable, val);
    return true;
  }

  std::string list_variables(const std::string & comp_id, const std::string& name)
  {
    return CompositionManager::instance().get_composition(comp_id).get_block(name)->list_variables();
  }

  // Needed to convert from within Python to invocation_type enum
  blockmon::invocation_type to_invoc_type(const std::string &s)
  {
	  if (s == "async") return invocation_type::Async;
	  if (s == "indirect") return invocation_type::Indirect;
	  return invocation_type::Direct;
  }

}


BOOST_PYTHON_MODULE(blockmon)
{     
    using namespace boost::python;

    // Needed to convert from within Python to invocation_type enum
    enum_<blockmon::invocation_type>("blockmon::invocation_type")
        .value("Direct", invocation_type::Direct)
        .value("Indirect", invocation_type::Indirect)
        .value("Async", invocation_type::Async)
        ;
    def("to_invoc_type", to_invoc_type);

    // scheduler functions
    def("stop_timer", stop_timer_thread);
    def("start_timer", start_timer_thread);
    def("start_schedulers", start_schedulers);
    def("stop_schedulers", stop_schedulers);
    def("select_clock", select_clock_);

    // composition functions
    def("add_composition", add_composition, arg("filename") );
    def("delete_composition", delete_composition, arg("filename") );
    def("init_composition", init_composition, arg("comp_id") );

    // connection functions
    def("create_connection", create_connection, \
        (arg("from_composition"),\
         arg("from_block"),\
         arg("from_gate"),\
         arg("to_composition"),\
         arg("to_block"),\
         arg("to_gate")));
    def("delete_connection", delete_connection,\
        (arg("from_composition"),\
         arg("from_block"),\
         arg("from_gate"),\
         arg("to_composition"),\
         arg("to_block"),\
         arg("to_gate")));

    // block functions
    def("create_block", create_block,\
        (arg("composition"),\
         arg("name"),\
         arg("type"),\
         arg("invocation"),\
         arg("config")));
    def("update_block", update_block,\
        (arg("composition"),\
         arg("name"),\
         arg("invocation"),\
         arg("config")));
    def("delete_block", delete_block,\
        (arg("composition"),\
         arg("name")));

    // thread functions
    def("add_thread_pool", add_thread_pool, arg("pool_config"));
    def("remove_thread_pool",remove_thread_pool, arg("poolname"));
    def("add_block_to_thread_pool", add_block_to_thread_pool,\
        (arg("composition"),\
         arg("name"),\
         arg("pool")));
    def("remove_block_from_thread_pool", remove_block_from_thread_pool,\
        (arg("composition"),\
         arg("name"),\
         arg("pool")));

    // variables functions
    def("write_block_variable", write_block_variable,\
        (arg("composition"), \
         arg("name"),\
         arg("variable"),\
         arg("val")));
    def("read_block_variable", read_block_variable,\
        (arg("composition"),\
         arg("name"),\
         arg("variable")));
    def("list_variables", list_variables,\
        (arg("composition"),\
         arg("name")));
}
