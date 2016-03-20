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
 * <blockinfo type="HistoCalc" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *      Takes ticket messages as input and creates histogram messages (HistoMsg),
 *      for the current time interval (timebin), for each of the traffic features
 *      selected through the configuration file.
 *
 *      Features defined as active in the configuration file are extracted
 *      from every input ticket (if present), starting from their values, then,
 *      the histogram vector is filled.
 *      When the current time interval is over (receiving the signaling TicketMsg)
 *      the histogram messages (HistoMsg) related to all the active features,
 *      are generated and sent to the block's output gate.
 *
 *      It is foreseen a "filling holes" technique, in order to avoid having holes
 *      in the time sequence of histograms. To achieve this, a dummy (all 0 elements)
 *      histogram message is created for each time interval, for each active feature.
 *      This histogram is filled in with real values if the feature is actually
 *      active in the current time interval (i.e. a ticket including that feature
 *      has arrived as input). Otherwise the dummy histogram message is sent to
 *      the output gate for the current feature in the current time interval.
 *
 *      Please refer to the schema and examples below to see how to specify
 *      features selection.
 *      Providing that, in order to set up the histogram binning, it is necessary
 *      to set the maximum allowed value, for each active feature, in the configuration
 *      file there must be the list of the active features with the corresponding
 *      max values. (ATTENTION: THE MAX VALUES DEPEND ALSO ON THE TIMESCALE!!!)
 *      It is also needed to set the max number of histogram bins (a common value
 *      for all the feature), and to select whether to apply the zero filtering
 *      or not during the binning procedure.
 *
 *      In this block we do not need to foresee the forwarding of the signaling
 *      messages in order to signal the end of the time interval, because the
 *      next block will be time interval independent, i.e. it will be able to
 *      generate an output message for each input message.
 *   </humandesc>
 *
 * <shortdesc>
 *      Takes ticket messages as input and creates histogram messages (HistoMsg),
 *      for the current time interval (timebin), for each of the traffic features
 *      selected through the configuration file.
 * </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_tckt" msg_type="TicketMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <gates>
 *     <gate type="output" name="out_histo" msg_type="HistoMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *
 *          element timescale{
 *              attribute val = {xsd:integer {1|5|15|30|60}}
 *          }
 *
 *          element feature_max_values{
 *
 *              element feature_1{
 *                      attribute featID = {string}
 *                      attribute max_val = {xsd:integer}
 *              }?
 *              element feature_2{
 *                      attribute featID = {string}
 *                      attribute max_val = {xsd:integer}
 *              }?
 *              element feature_3{
 *                      attribute featID = {string}
 *                      attribute max_val = {xsd:integer}
 *              }?
 *
 *          }
 *
 *          element max_nr_bins{
 *              attribute val = {xsd:integer}
 *          }
 *          element flag0{
 *              attribute val = {"on"|"off"}
 *          }
 *
 *    }
 *
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *
 *              <timescale val = "1"/>
 *
 *              <max_nr_bins val = "80">
 *
 *              <flag0 val = "on"/>
 *
 *              <features_max_values>
 *                      <feature_1 featID = "UL_SYN_packets_p_80"
 *                                 max_val = "300000" />
 *                      <feature_2 featID = "UL_SYN_bytes_p_80"
 *                                 max_val = "4000000" />
 *                      <feature_3 featID = "UL_SYN_packets_p_65535"
 *                                 max_val = "500000" />
 *                      <feature_4 featID = "UL_SYN_bytes_p_65535"
 *                                 max_val = "10000000" />
 *                      <feature_5 featID = "DL_SYNACK_packets_p_65535"
 *                                 max_val = "500000" />
 *                      <feature_6 featID = "DL_SYNACK_bytes_p_65535"
 *                                 max_val = "5000000" /> *
 *              </features_max_values>
 *
 *       </params>
 *   </paramsexample>
 *
 *   <variables>
 *   </variables>
 *
 * </blockinfo>
 */

#include <Block.hpp>
#include <BlockFactory.hpp>
#include <arpa/inet.h>
#include <TicketMsg.hpp>
#include <HistoMsg.hpp>
#include <unordered_map>
#include <iostream>
#include <sstream>
#include <fstream>
#include <binning.hpp>


namespace blockmon
{
    typedef struct {
        uint64_t max_val;
        vector<uint64_t> edges;
        uint16_t histo_dim;
    }feat_info;

    typedef struct {
        map<uint32_t, uint32_t> unique_users_map;
        vector<uint32_t> histogram;
        uint64_t total_val;
    }histo_entry;

    typedef map<string, feat_info> features_map;
    typedef unordered_map<string, histo_entry> histo_hash_table;

    class HistoCalc: public Block
    {
        int m_in_gate;
        int m_out_gate;
        //ofstream m_out_file;
        uint64_t m_current_agg_time;
        uint m_timescale;                 //1,5,15,30,60
        uint m_max_nr_bins; //80
        bool m_flag0;
        features_map m_feat_info_map;
        histo_hash_table m_histo_ht;

        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("HistoCalc:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }

    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be directly invoked, and will ignore any contrary configuration.
         */
        HistoCalc(const std::string &name, invocation_type invocation) :
        Block(name, invocation),
        m_in_gate(register_input_gate("in_tckt")),
        m_out_gate(register_output_gate("out_histo")),
        m_current_agg_time(0),
        m_timescale(0),
        m_max_nr_bins(80),
        m_flag0(true),
        m_feat_info_map(),
        m_histo_ht()
        {}

        HistoCalc(const HistoCalc &)=delete;
        HistoCalc& operator=(const HistoCalc &) = delete;
        HistoCalc(HistoCalc &&)=delete;
        HistoCalc& operator=(HistoCalc &&) = delete;

        /*
         * destructor
         */
        virtual ~HistoCalc()
        {}

        /**
          * configures the histogram, generating a features_map map containing,
          * for each active feature:
          * -the feature ID (key)
          * -the max value allowed
          * -the histogram dimension
          * -the edges vector
          * @param n the xml subtree
          */
        virtual void _configure(const pugi::xml_node&  n )
        {
            if(pugi::xml_node timescale = n.child("timescale"))
            {
                if(pugi::xml_attribute ts = timescale.attribute("val"))
                {
                    m_timescale = ts.as_uint();
                }
                else signal_error("timescale");
            }else signal_error("timescale");

            if(pugi::xml_node max_bins = n.child("max_nr_bins"))
            {
                if(pugi::xml_attribute bins = max_bins.attribute("val"))
                {
                    m_max_nr_bins = bins.as_uint();
                }
                else signal_error("max number of bins");
            }else signal_error("max number of bins");

            if(pugi::xml_node flag_zero = n.child("flag0"))
            {
                if(pugi::xml_attribute f0 = flag_zero.attribute("val"))
                {

                    if(!strcmp(f0.value(),"on"))//strcmp returns 0 (false) if the two strings are equal
                        m_flag0 = true;
                    else
                        m_flag0 = false;

                }
                else signal_error("flag zero");
            }else signal_error("flag zero");

            if(pugi::xml_node features_max_vals = n.child("features_max_values"))
            {
                for(pugi::xml_node_iterator it = features_max_vals.begin(); it != features_max_vals.end(); it++)
                {
                    if(pugi::xml_node feat_m_v = features_max_vals.child(it->name()))
                    {
                        feat_info info;
                        if(pugi::xml_attribute maxVal = feat_m_v.attribute("max_val"))
                        {
                            info.max_val = maxVal.as_uint();
                        }else signal_error("feature_max_val");


                        /**
                         * The binning_function takes as input:
                         * the max values to cover,
                         * the maximum number of bins in the histogram,
                         * the zero filtering flag,
                         * the reference to the histogram dimension (number of edges -1)
                         *
                         * it returns:
                         * - the edges vector
                         * - the histogram dimension (size of edges vector -1) (by reference)
                         */
                        info.edges = binning_function(info.max_val, m_max_nr_bins, m_flag0, &info.histo_dim);

                        if(pugi::xml_attribute feat_ID = feat_m_v.attribute("featID"))
                        {
                            m_feat_info_map.insert(pair<string, feat_info>(feat_ID.value(), info));
                        }else signal_error("feature_ID");

                    }else signal_error("feature");
                }
            }else signal_error("features_max_vals");

            for(features_map::iterator it = m_feat_info_map.begin(); it!=m_feat_info_map.end(); it++)
            {
                feat_info inf = it->second;
                std::stringstream sss;
                sss << "Feature ID: " << it->first << " - Max val: " << inf.max_val
                    << " - Histo dim: " << inf.histo_dim << " - Edges:\n";
                for(vector<uint64_t>::iterator iit = inf.edges.begin(); iit != inf.edges.end(); iit++)
                {
                    sss <<*iit << " ";
                }
                sss << "\n\n";
                blocklog(sss.str(), log_info);
            }

             //m_out_file.open ("Histo_1min_UL_SYN_packets_p65535.txt", fstream::out);

        }

        /**
         * Helper function used to generate, for each element in the hash table,
         * a related histoMsg with the current timestamp, and then empty the table.
         * @param current_timestamp
         */
        void empty_hash_table(uint64_t curr_agg_time)
        {
            /*For each feature (histo_hash_table entry) in the hash_table sends (and prints) out the related
             * histoMSg, and delete it from the histo_hash_table.
             */
            for(histo_hash_table::iterator ht_it = m_histo_ht.begin(); ht_it != m_histo_ht.end(); ht_it++)
            {
                string featID = ht_it->first;
                histo_entry current_entry = ht_it->second;

                std::shared_ptr<HistoMsg> histo_msg = std::make_shared<HistoMsg>(curr_agg_time, featID);
                histo_msg.get()->set_nr_unique_users(current_entry.unique_users_map.size());
                histo_msg.get()->set_histogram(current_entry.histogram);
                histo_msg.get()->set_total_value(current_entry.total_val);

                /*Empty the unique users hash table*/
                current_entry.unique_users_map.clear();

                //Sends the ticket out
                send_out_through(histo_msg, m_out_gate);

                //STAMPARE ANCHE VIDEO L'ISTOGRAMMA CREATO DAL PACCHETTO CORRENTE
                /*
                std::stringstream sss;
                sss << histo_msg.get()->to_string();
                blocklog(sss.str(), log_info);
                */

                //Writes the results to the output file
                //m_out_file << histo_msg.get()->to_string_file();
            }
            //Erases the entire hash table
            m_histo_ht.clear();
        }


        /**
         * Helper function to get the histogram bin index for the current counter.
         * It searches into the corresponding edges vector b_ed the first index of
         * the array whose value (edge) is greater than the current count value.
         *
         * @param count current feature value
         * @param edge_array the vector containing the edges
         * returns the index of the bin where to put the current element
         */
        uint32_t get_bin_for_count(uint64_t count, vector<uint64_t> b_ed)
        {
            /* We check if the zero filtering is activated and the counter is equal
             * to 0 we have to discard this element returning an invalid
             * index = 20*dim.
             */
            if(m_flag0) //it means that the zero filtering is activated
            {
                if(count == 0) //if the counter is zero we don't have to insert this element
                {
                    return 20 * b_ed.size(); // we don't have to put this value into the array
                }
            }

            for (uint i=0; i<b_ed.size()-1; i++)
            {
                if( (count >= b_ed[i]) && (count < b_ed[i+1]) )
                {
                    return i;
                }else if ((i == b_ed.size()-2) && (count >= b_ed[i+1])) //just in case of counter > max_val!
                {
                    return i;
                }
            }
            return 10*b_ed.size();
        }

        /**
         * Helper function which creates dummy (all 0) histograms and
         * put them in the histo_hash_table. It will create one element for
         * each feature listed in the configuration file, and collected during
         * the configure function in the feat_info hash table.
         *
         */
        void insert_dummy_elements()
        {
            features_map::iterator iter;
            histo_entry dummy;
            dummy.total_val = 0;

            for(iter = m_feat_info_map.begin(); iter != m_feat_info_map.end(); iter ++)
            {
                feat_info f_info= iter->second;
                dummy.histogram.assign(f_info.histo_dim,0); //Assigns 0 to all the vector elements
                m_histo_ht.insert(pair<string, histo_entry>(iter->first, dummy));
            }
        }


        /**
         * Helper function used to insert all the feature values included
         * in the current ticket, in the histo_hash_table.
         * It checks whether every feature (in the features map of the ticket message)
         * already exists in the histo_hash_table. If so, it updates:
         * the right feature histogram element,
         * the number of active users,
         * the feature total counter,
         * of the found histo_hash_table entry.
         * Otherwise it means that the user did not list the current feature
         * in the configuration file, so he does not want to analyze it.
         * In this case we just discard the current feature, and we go to the
         * next one included in the ticket message.
         */
        void insert_elements(const TicketMsg* ticket)
        {
            const map<string, uint64_t>* ticket_features = ticket->get_features();
            map<string, uint64_t>::const_iterator tck_feat_it;

            /* For each feature of the current user (ticket) */
            for(tck_feat_it = ticket_features->begin(); tck_feat_it != ticket_features->end(); tck_feat_it ++)
            {
                /* Since we first fill in the histo hash table with dummy
                 * histogram entries and then we substitute the them with actual values,
                 * we should find for sure the histogram related to the feature we
                 * are interested in.
                 */
                histo_hash_table::iterator histo_ht_it = m_histo_ht.find(tck_feat_it->first);
                features_map::iterator feat_map_it = m_feat_info_map.find(tck_feat_it->first);

                /* If the feature is not in the histo_hash_table, it means that
                 * the user did not include this feature (and the related max_value)
                 * in the configuration file, so this feature has to be ignored! */
                if( histo_ht_it == m_histo_ht.end()) continue;

                histo_entry* h_entry = &(histo_ht_it->second);
                feat_info feat_entry = feat_map_it->second;

                //Given the current feature value, gets the index of the histogram element to increase.
                uint32_t histo_index = get_bin_for_count(tck_feat_it->second, feat_entry.edges);
                uint16_t nr_bins = feat_entry.histo_dim;

                /* Checks if the get_bin_for_count returned an invalid value,
                 * or it filtered out the current count value because of the
                 * zero filtering activated.
                 * In these cases we need to skip the current feature
                 * without inserting it in the hash_table, and to go
                 * to the next iteration (next feature in the current ticket)
                 * in the loop.
                 */
                if(histo_index > nr_bins) continue;

                /* Increases the histogram element at the index position */
                h_entry->histogram[histo_index] ++;

                /* Update the total value counter*/
                h_entry->total_val +=  tck_feat_it->second;

                /* Updating the unique active users hash table */
                uint32_t curr_user = ticket->get_userID();
                map<uint32_t,uint32_t>::iterator users_it;
                users_it = h_entry->unique_users_map.find(curr_user);
                /*Only if the current user is not yet in the unique users hash table, we add it*/
                if(users_it == h_entry->unique_users_map.end())
                    h_entry->unique_users_map.insert(pair<uint32_t,uint32_t>(curr_user, curr_user));
             }

            return;
        }


        /**
          * The actual Histogram Calculation function
          * Expects TicketMsg messages, otherwise it throws an Error exception
          * @param m the message to be checked
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(TicketMsg))
                throw std::runtime_error("HistoCalc: wrong message type");
            const TicketMsg* ticket = static_cast<const TicketMsg* > (m.get());

            uint64_t time_now = ticket->get_timestamp();

            /* First iteration -> initialize the hash table with dummy elements */
            if(m_current_agg_time == 0)
            {
                insert_dummy_elements();
                m_current_agg_time = time_now;
            }

            while (time_now > m_current_agg_time)
            {
                /* For each element in histogram hash table, creates and sends
                 * a HistoMsg with timestamp m_current_time */
                empty_hash_table(m_current_agg_time);

                /* Update current aggregate time */
                m_current_agg_time += (m_timescale * 60);

                /* Initialize, with dummy elements, the histogram hash table
                 * entries for this time interval*/
                insert_dummy_elements();
            }

            /* In case of (dummy) signaling message, we understand that a new
             * time interval has begun and we discard it!*/
            if( (ticket->get_userID() == 0) && (ticket->get_extracted_features() == 0) )
                return;

            /* Insert the information included in the current ticket message,
             * in the histogram hash table*/
            insert_elements(ticket);

        }

    };
    REGISTER_BLOCK(HistoCalc,"HistoCalc");

}

