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

#include<ConfigManager.hpp>
#include<PoolManager.hpp>
#include<TimerThread.hpp>


#include <boost/python/class.hpp>
#include <boost/python/module.hpp>
#include <boost/python/def.hpp>
#include <pugixml.hpp>


using namespace pugi;
using namespace bm;


namespace
{
	std::thread* tt=NULL;
	void start_timer_thread()
	{
#ifdef C_DEBUG
        std::cout<<"c++:start_timer_thread"<<std::endl;
#endif
	  tt= new std::thread(std::ref(TimerThread::instance()));
	}
	
	void stop_timer_thread()
	{
#ifdef C_DEBUG
        std::cout<<"c++:start_timer_thread"<<std::endl;
#endif
		TimerThread::instance().stop();
		tt->join();
		delete tt;

	}
	void add_config(std::string filename)
	{
#ifdef C_DEBUG
        std::cout<<"c++:add config "<<filename<<std::endl;
#endif
		ConfigManager::instance().add_config(filename);
	}
	void delete_config(std::string filename)
	{
#ifdef C_DEBUG
        std::cout<<"c++:remove  config "<<filename<<std::endl;
#endif
		ConfigManager::instance().delete_config(filename);
	}
	void start_schedulers()
	{
#ifdef C_DEBUG
        std::cout<<"c++:start schedulers "<<std::endl;
#endif
		PoolManager::instance().start();
	}
	void stop_schedulers()
	{
#ifdef C_DEBUG
        std::cout<<"c++:stop schedulers "<<std::endl;
#endif
		PoolManager::instance().stop();
	}

	void create_link(const std::string& from_composition,const std::string& from_block,const std::string& from_gate,const std::string& to_composition,const std::string& to_block,const std::string& to_gate)
	{
#ifdef C_DEBUG
        std::cout<<"c++:creating link"<<from_composition<<from_block<<from_gate<<to_composition<<to_block<<to_gate<<std::endl;
#endif
        OutGate& src=ConfigManager::instance().get_config(from_composition).get_block(from_block)->get_output_gate(from_gate);
		InGate& dst=ConfigManager::instance().get_config(to_composition).get_block(to_block)->get_input_gate(to_gate);
        src.connect_to(dst);
        dst.connect_to(src);
	}
	void delete_link(const std::string& from_composition,const std::string& from_block, const std::string& from_gate,const std::string& to_composition,const std::string& to_block,const std::string& to_gate)
	{
#ifdef C_DEBUG
        std::cout<<"c++:deleting link"<<from_composition<<from_block<<from_gate<<to_composition<<to_block<<to_gate<<std::endl;
#endif
		OutGate& src=ConfigManager::instance().get_config(from_composition).get_block(from_block)->get_output_gate(from_gate);
		InGate& dst=ConfigManager::instance().get_config(to_composition).get_block(to_block)->get_input_gate(to_gate);
        src.disconnect_gate(&dst);
        dst.disconnect_gate(&src);
	}
	void create_block(const std::string& composition,const std::string& name,const std::string& type, bool ts, bool active, const  std::string& config)
	{
#ifdef C_DEBUG
        std::cout<<"c++:creating block"<<composition<<name<<type<<std::endl;
#endif
		ConfigManager::instance().get_config(composition).create_block(name,type,ts,active,config);
	}
    /*
	void create_block_ref(const std::string& composition,const std::string& name,const std::string& ref,const std::string& config_id )	
	{
		ConfigManager::instance().get_config(composition).create_block_ref(name,ref,config_id);
	} */
	void delete_block(const std::string& composition,const std::string& name)
	{
#ifdef C_DEBUG
        std::cout<<"c++:deleting block"<<composition<<name<<std::endl;
#endif
		ConfigManager::instance().get_config(composition).delete_block(name);
	}


    void add_block_to_thread_pool(const std::string& composition,const std::string& name,  const std::string& pool)
    {
#ifdef C_DEBUG
        std::cout<<"c++:dd to thread pool"<<composition<<name<<std::endl;
#endif
        std::shared_ptr<Block> b= ConfigManager::instance().get_config(composition).get_block(name);
        PoolManager::instance().add_to_pool(pool,b);
    }

    void remove_block_from_thread_pool( const std::string& composition,const std::string& name, const std::string& pool)
    {
#ifdef C_DEBUG
        std::cout<<"c++:remove from thread pool"<<composition<<name<<std::endl;
#endif
        std::shared_ptr<Block> b= ConfigManager::instance().get_config(composition).get_block(name);
        PoolManager::instance().remove_from_pool(pool,*b);
    }

	void add_thread_pool(const std::string& pool_config )
	{                   
#ifdef C_DEBUG
        std::cout<<"c++:add thread pool"<<pool_config<<std::endl;
#endif

		xml_document config_info;
		if(!config_info.load(pool_config.c_str()))
			throw std::runtime_error("add_thread_pool::cannot parse config info");
		xml_node poolxml=config_info.child("threadpool");
		if(!poolxml)
			throw std::runtime_error("Configuration: cannot find block node");
		PoolManager::instance().create_pool(poolxml);

	}

	void remove_thread_pool(const std::string& poolname )
	{
#ifdef C_DEBUG
        std::cout<<"c++remove thread  pool"<<poolname<<std::endl;
#endif
		PoolManager::instance().remove_pool(poolname);
	}
	
    std::string read_block_variable(const std::string& composition, const std::string& name, const std::string& variable)
    {
        return ConfigManager::instance().get_config(composition).get_block(name)->read_variable(variable);
    }

    int write_block_variable(const std::string& composition, const std::string& name, const std::string& variable, const std::string& val)
    {
        return ConfigManager::instance().get_config(composition).get_block(name)->write_variable(variable,val);
    }

    int update_block(const std::string& composition,const std::string& name,bool ts, bool active,  const std::string& config)
    {
#ifdef C_DEBUG
        std::cout<<"c++:update block"<<composition<<name<<std::endl;
#endif
		xml_document config_info;
		if(!config_info.load(config.c_str()))
			throw std::runtime_error("update_config::cannot parse config info");
		xml_node confxml=config_info.child("params");
		if(!confxml)
			throw std::runtime_error("Configuration: cannot find params node");
        ConfigManager::instance().get_config(composition).get_block(name)->change_execution_mode(active,ts);
        return  ConfigManager::instance().get_config(composition).get_block(name)->update_config(confxml);

    }


    std::string list_variables(const std::string & composition, const std::string& name)
    {
        return  ConfigManager::instance().get_config(composition).get_block(name)->export_exposed_variables();
    }


}





BOOST_PYTHON_MODULE(blockmon)
{     
    using namespace boost::python;
    def("stop_timer", stop_timer_thread);
    def("start_timer", start_timer_thread);
    def("start_schedulers", start_schedulers);
    def("stop_schedulers", stop_schedulers);
    def("add_config", add_config,arg("filename") );
    def("delete_config", delete_config,arg("filename") );
    def("create_link",create_link,(arg("from_composition"),arg("from_block"),arg("from_gate"),arg("to_composition"),arg("to_block"),arg("to_gate")));
    def("delete_link",delete_link,(arg("from_composition"),arg("from_block"),arg("from_gate"),arg("to_composition"),arg("to_block"),arg("to_gate")));
    def("create_block",create_block,(arg("composition"),arg("name"),arg("type"),arg("ts"),arg("active"),arg("config")));
    def("update_block",update_block,(arg("composition"),arg("name"),arg("ts"),arg("active"),arg("config")));
 //   def("create_block_ref",create_block_ref,(arg("composition"),arg("name"),arg("ref"),arg("config_id")));
    def("delete_block",delete_block,(arg("composition"),arg("name")));
    def("add_thread_pool",add_thread_pool, arg("pool_config"));
    def("remove_thread_pool",remove_thread_pool, arg("poolname"));
    def("add_block_to_thread_pool",add_block_to_thread_pool,(  arg("composition"),arg("name"),arg("pool")));
    def("remove_block_from_thread_pool",remove_block_from_thread_pool,( arg("composition"),arg("name"), arg("pool")));
    def("write_block_variable",write_block_variable,( arg("composition"), arg("name"),arg("variable"),arg("val")));
    def("read_block_variable",read_block_variable,( arg("composition"), arg("name"),arg("variable")));
    def("list_variables",list_variables,( arg("composition"), arg("name")));
    
}



