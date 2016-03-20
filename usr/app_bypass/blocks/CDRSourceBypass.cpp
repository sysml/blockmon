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
* <blockinfo type="CDRSourceBypass" invocation="indirect" thread_exclusive="True">
*   <humandesc>
*     Reads CDRs (sorted by timestamp in ascending order) from file and
 *     outputs the fields for each
 *     recorded CDR by using a PairMsg message and appending tags of the class TagRegister
*     If the source type is set to cdrfile, then the name should be the
 *     full path to a file containing the CDRs (e.g., /tmp/calls.cdr).
 *   </humandesc>
*
*   <shortdesc>Reads CDRs (sorted by timestamp) from a file and parses them.</shortdesc>
*
*   <gates>
*     <gate type="output" name="source_out" msg_type="PairMsg" m_start="0" m_end="0" />
*   </gates>
*
*   <paramsschema>
*    element params {
*      element source {
*        attribute type {"offline"}
*        attribute name {text}
*      }
*    }
*   </paramsschema>
*
*   <paramsexample>
*     <params>
*        <source type="offline" name="filename.cdr">
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
#include <string.h>
#include <string>
#include "boost/array.hpp"
#include <vector>
#include <boost/algorithm/string.hpp>

#include <PairMsg.hpp>
#include "common.h"

#include <sys/types.h>
#include <unistd.h>
#include <signal.h>

using namespace pugi;

namespace blockmon
{

    /**
      * Implements a block that reads CDRs from file and
      * converts them as tagged Pair messages.
      */

    class CDRSourceBypass: public Block
    {
        struct tag_data
        {
                tag_handle<PairMsg<std::string, std::string>> handle;
                std::string name;
        };

        std::ifstream m_source;
        int m_gate_id;
        uint32_t m_msg_type;
        int msg_recv;
        int msg_sent;
        char mesg[SIZE_MSG]; // response message
        boost::array<char,SIZE_CID> tmp;
        boost::array<char,SIZE_CID> call_s;
        boost::array<char,SIZE_CID> call_d;
        boost::array<char,SIZE_CID> call_id;
        boost::array<char,SIZE_CID> line;
        boost::array<char,SIZE_CID> timestamp;

	tag_handle<PairMsg<std::string,std::string>> m_handle;
                std::vector<std::string> m_fields;
                std::vector<tag_data> m_tag_vector;

                time_t startTime;
                time_t endTime;

        CDRSourceBypass(const CDRSourceBypass &) = delete;
        CDRSourceBypass& operator=(const CDRSourceBypass &) = delete;


    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async).
         *                     This block can only be async invoked,
         *                     and will ignore any contrary configuration.
         */
        CDRSourceBypass(const std::string &name, invocation_type invocation)
        :Block(name, invocation_type::Async), //ignore options, source must be async
        m_gate_id(register_output_gate("source_out"))
        {
            if (invocation != invocation_type::Async) {
                blocklog("CDRSourceBypass must be Async, ignoring configuration", log_warning);
            }
                    msg_sent = 0;
                    msg_recv = 0;
                    m_msg_type = type_to_id<PairMsg<std::string, std::string>>::id();
                               m_tag_vector.clear();
                               m_fields.clear();
        }


        /**
         * @brief Destructor
         */
        virtual ~CDRSourceBypass()
        {
            if(m_source)
                m_source.close();
                    char report[256];
                    sprintf(report,"CDRSourceBypass: messagges received/sent [%d/%d], first received/last sent [%ld-%ld].", msg_recv, msg_sent, startTime, endTime);
                    blocklog(report, log_info);
        }


        /**
         * @brief Configures the block: defines the input file.
         * @param n The configuration parameters
         */
        virtual void _configure(const xml_node& n)
        {
            xml_node source=n.child("source");
            if(!source)
                throw std::runtime_error("CDRSourceBypass: missing parameter source");
            std::string type=source.attribute("type").value();
            std::string name=source.attribute("name").value();
            if((!type.length()) || (!name.length()))
                throw std::runtime_error("CDRSourceBypass: missing attribute");
            if(type.compare("offline") != 0)
                throw std::runtime_error("CDRSourceBypass: invalid type parameter");

            m_source.open(name.c_str());
                    if(m_source.fail())
                    {
                blocklog(std::string("could not open file"), log_error);
                throw(std::invalid_argument("CDRSourceBypass: error within ifstream"));
                    }

                    // skip the first line
                    //m_source.getline(mesg, SIZE_MSG);

                    if (!m_fields.size())
                    {
                        blocklog("CDRSourceBypass: registering tags. This operation is done only once.", log_info);
                        m_fields.push_back("src_id");
                        m_fields.push_back("dst_id");
                        m_fields.push_back("src_dst");
                        m_fields.push_back("fail");
                        m_fields.push_back("out");
                        m_fields.push_back("call");
                m_fields.push_back("timestamp");
                        if(!register_tags())
                                  throw std::runtime_error("CDRSourceBypass: error while registering tags");
                               blocklog("CDRSourceBypass: tags registered", log_info);
                    }
            m_handle = TagRegistry<PairMsg<std::string,std::string>>::register_tag<boost::array<char,SIZE_CID>>("line");
	    if(m_handle == TAG_INVALID)
		throw std::runtime_error("invalid tag handler");
        }

                /**
                  * compose the message as an array of (key,value) pairs by using
                  * TagRegistry message tag
                  */
                int register_tags()
                {
                    m_tag_vector.clear();
                    for(std::vector<std::string>::iterator it = m_fields.begin(); it != m_fields.end(); ++it)
                    {
                               struct tag_data local;
                               local.name = *it;
                               if( (!local.name.compare("fail"))  || (!local.name.compare("call"))  || (!local.name.compare("out")) )
                                local.handle = TagRegistry<PairMsg<std::string, std::string>>::register_tag<int>(local.name);
                               else
                        local.handle = TagRegistry<PairMsg<std::string, std::string>>::register_tag<boost::array<char,SIZE_CID>>(local.name);
                               if(local.handle == TAG_INVALID)
                                 throw std::runtime_error("CDRSourceBypass: invalid tag handle");
                               m_tag_vector.push_back(local);
                    }
                    return 1;
                }


        void _do_async()
        {//bool ret_code = m_source->getline(mesg, SIZE_MSG).eof();

            //while (!ret_code)
            bool ret_code = m_source.getline(mesg, SIZE_MSG).eof();
            while (!ret_code){
                if(++msg_recv != 1){
                    auto buflen = TagRegistry<PairMsg<std::string, std::string>>::buffer_size();
                    char *buftag = new char[buflen];
                    memset(buftag, 0, buflen);

                    std::shared_ptr< PairMsg<std::string, std::string>>
                    m(new PairMsg<std::string, std::string>("CDR","",
                    mutable_buffer<char>(buftag, buflen), true));

                    char* ptr = mesg;
                    strncpy(line.begin(),mesg , SIZE_CID);
                    m->emplace_tag<boost::array<char,SIZE_CID> >(m_handle, line);
                    int i = 0;
                    int offset[9];
                    int *offptr = offset;

                    while(*ptr != '\0'){
                        if (*ptr == '|'){
                             *ptr = '\0';
                             *offptr++ = i;
                         }
                         i++;
                        ptr++;
                    } int call=1;
                    // if( (strstr(mesg+offset[6]+5,"SMS0")) ==NULL ){
                    for(std::vector<tag_data>::iterator it = m_tag_vector.begin(); it != m_tag_vector.end(); ++it){
                        struct tag_data local;
                        local.name = (*it).name;
                        local.handle = (*it).handle;

                        std::vector<std::string> keylist;
                        if( !local.name.compare("timestamp") ){
                            strncpy(timestamp.begin(), mesg+offset[7]-8,8);
                            std::string min = timestamp.begin();

                            boost::split(keylist, min, boost::is_any_of(":"));
                            int sec=0; std::string str1; int u=0;

                            for(std::vector<std::string>::iterator it2 = keylist.begin(); it2 != keylist.end(); it2++)
                            {
                                str1 =(*it2);
                                int h = atoi(str1.c_str());
                                if(u==0){
                                        sec = sec+h*3600;
                                //std::cout << "inside 0 h: " << h << " str: " << sec << " i: " << u<< std::endl;
                                }
                                else if(u==1){
                                        sec = sec+h*60;
                                //std::cout << "inside 1 h: " << h << " str: " << sec << " i: " << u<< std::endl;
                                }
                                else if(u==2){
                                        sec = sec +h;
                                }
                                else
                                    break;
                                u++;
                            }

                            m->emplace_tag<int>(local.handle, sec);
                        }
                        else if( !local.name.compare("fail") ){
                            int fail=1;
                            if( (offset[8]-offset[7]) > 2)
                            fail=0;

                            m->emplace_tag<int>(local.handle, fail);
                        }
                        else if( !local.name.compare("src_id") ){
                            if( (strstr(mesg+offset[6]+1,"SMS0")) ==NULL ){
                                strncpy(call_s.begin(),mesg+offset[1]-10,SIZE_CID);

                            }
                            else{
                                strncpy(call_s.begin(),mesg+offset[0]-10,SIZE_CID);
                            }m->emplace_tag<boost::array<char,SIZE_CID> >(local.handle, call_s);
                        }
                        else if( !local.name.compare("dst_id") ){
                            if( (strstr(mesg+offset[6]+1,"SMS0")) ==NULL ){
                                strncpy(call_d.begin(),mesg+offset[3]-10,SIZE_CID);
                                m->emplace_tag<boost::array<char,SIZE_CID> >(local.handle, call_d);
                            }

                        }
                        else if( !local.name.compare("out") ){
                            int out=1;
                            if(strstr(mesg+offset[4]-1,"1"))
                                out=0;
                            m->emplace_tag<int>(local.handle, out);
                        }
                        else if( !local.name.compare("call") ){
                            if( (strstr(mesg+offset[6]+1,"SMS0")) ==NULL ){
                                call=1;
                            }
                            else{
                                call=0;

                            }
                            m->emplace_tag<int>(local.handle, call);
                        }
                        else if( !local.name.compare("src_dst") ){
                            strncpy(call_id.begin(),call_s.begin(),SIZE_CID);
                            strcat(call_id.begin(), "|");
                            strcat(call_id.begin(), call_d.begin());
                            m->emplace_tag<boost::array<char,SIZE_CID> >(local.handle, call_id);
                        }

                        else
                            throw std::runtime_error("CDRSourceBypass: error while composing message");

                    }send_out_through( move(m) , m_gate_id);
			endTime = time(NULL);
			msg_sent++;

			if (msg_sent % 1000000 == 0)
			{
	    	    	  char report[256];
		    	  sprintf(report,"CDRSource: Processed %d calls in %ld seconds.", msg_sent, (endTime-startTime));
			  blocklog(report, log_info);
			}
                       }
                else {  blocklog("skipping first line (it contains only headers)", log_info);
                              startTime = time(NULL);
                }
                ret_code =m_source.getline(mesg, SIZE_MSG).eof();
            }

        }

    };

    REGISTER_BLOCK(CDRSourceBypass,"CDRSourceBypass");
}


