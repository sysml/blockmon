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
 * <blockinfo type="LogWriter" invocation="indirect" thread_exclusive="True">
 *   <humandesc>
 *	Prints the received message.
 *   </humandesc>
 *
 *   <shortdesc>Prints the received message.</shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_LogWriter" msg_type="PairMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element output {
 *	 attribute name {"text"}
 *    }
 *   </paramsschema>
 *
 *   <paramsexample>
 *     <params>
 *	  <output name="output.log">
 *     </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <Block.hpp>
#include <pugixml.hpp>
#include <BlockFactory.hpp>

#include <fstream>
#include <iostream>
#include <vector>

#include "boost/array.hpp"
#include "common.h"

#include <PairMsg.hpp>
#define UTIME_WAIT 5 //max usec to wait for the get_tag function to return data

using namespace pugi;

namespace blockmon
{
    /**
     * Implements a block that reads CDRs from file and injects them into BM as PairMsg + tags messages
     */
    class LogWriter: public Block
    {
        int m_ingate_id;
	uint32_t m_msg_type;
	int lineno;

        tag_handle<PairMsg<std::string,std::string>> h_res_gng;
	tag_handle<PairMsg<std::string,std::string>> h_line;
	std::ofstream fout;
	time_t endTime;

        LogWriter(const LogWriter &) = delete;
        LogWriter& operator=(const LogWriter &) = delete;

    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be indirectly invoked, and will ignore any contrary configuration.
         */
        LogWriter(const std::string &name, invocation_type invocation)
        :Block(name, invocation),
        m_ingate_id(register_input_gate("in_LogWriter"))
        {
	    lineno=0;
        }


        /**
         * @brief Destructor
         */
        virtual ~LogWriter()
        {
	    fout.close();
	    char report[256];
	    sprintf(report,"LogWriter: messagges received [%d] at %ld.", lineno, endTime);
	    blocklog(report, log_info);
	}


        /**
         * @brief Configures the block: defines the input file.
         * @param n The configuration parameters
         */
        virtual void _configure(const xml_node& n)
        {
	    xml_node output=n.child("output");
	    if(!output)
		throw std::runtime_error("LogWriter: missing parameter source");
	    std::string name=output.attribute("name").value();
	    if(!name.length())
		throw std::runtime_error("LogWriter: missing attribute");
	    fout.open(name);
	    if(fout.fail())
	    {
		blocklog(std::string("could not open file"), log_error);
		throw(std::invalid_argument("LogWriter: error within ifstream"));
            }
	}

	virtual void _initialize()
	{
	    h_res_gng = ret_tag_handle("res_gng");
         //   h_line = ret_tag_handle("line");
	}

        tag_handle<PairMsg<std::string, std::string>> ret_tag_handle(std::string key)
	{
	    auto h = TagRegistry<PairMsg<std::string, std::string>>::get_handle_by_name(key);
	    if(h == TAG_INVALID)
	      throw std::runtime_error("TBloomFilter: invalid tag handle");
	    return h;
	}

	virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */){
	    if (m->type() != m_msg_type)
	        throw std::runtime_error("LogWriter:: wrong message type");
	    lineno++;
	    endTime = time(NULL);
		if(h_res_gng == TAG_INVALID)
		  throw std::runtime_error("LogWriter: invalid tag handle");

                const char* value;
                int counter = 0;
                while ( (value = (const char* ) m->get_tag<boost::array<char,SIZE_MSG> >(h_res_gng)) == NULL)
                {
                  usleep(1);
                  if (counter == UTIME_WAIT)
                    throw std::runtime_error("LogWriter: max UTIME_WAIT");
                  counter++;
                 }
		  fout   << "," << *value << ")\t";

                 counter = 0;
                 while ( (value = (const char* ) m->get_tag<boost::array<char,SIZE_MSG> >(h_line)) == NULL)
                 {
                      usleep(1);
                      if (counter == UTIME_WAIT)
                        throw std::runtime_error("LogWriter: max UTIME_WAIT");
                      counter++;
                 }
                 fout   << "," << *value << ")\t";
                 fout   << lineno << "]" << std::endl;
           }
    };

    REGISTER_BLOCK(LogWriter,"LogWriter");
}

