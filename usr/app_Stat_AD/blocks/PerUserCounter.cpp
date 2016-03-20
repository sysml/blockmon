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
 * <blockinfo type="PerUserCounter" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *      Takes tickets messages (TicketMsg) as input and aggregates them in a
 *      different output timescale.
 *
 *      The signaling messages are directly forwarded to the output gate,
 *      after rearranging their timestamp accordingly to the output timescale.
 *
 *      Please refer to the schema and examples below to see how to specify
 *      the input and output timescale.
 *   </humandesc>
 *
 * <shortdesc>
 *      Takes tickets messages (TicketMsg) as input and aggregates them in a
 *      different output timescale.
 * </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_tckt" msg_type="TicketMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <gates>
 *     <gate type="output" name="out_tckt" msg_type="TicketMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *          element timescales{
 *              attribute in_ts = {xsd:integer (0 - 60)}
 *              attribute out_ts = {xsd:integer (0 - 60)}
 *          }
 *    }
 *
 *
 *   </paramsschema>
 *
 *   <paramsexample>
 *       <params>
 *         <timescales in_ts = "0"
 *                     out_ts = "1" /> *
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
#include <unordered_map>

#include <iostream>
#include <sstream>
#include <fstream>


namespace blockmon
{
    typedef map<string, uint64_t> features_map;
    typedef std::unordered_map<uint64_t, features_map> hash_table;

    class PerUserCounter: public Block
    {
        int m_in_gate;
        int m_out_gate;

        //ofstream m_out_file;
        uint64_t m_current_agg_time;

        uint m_in_timescale;                 //0,1,5,15,30
        uint m_out_timescale;                //1,5,15,30,60
        uint8_t m_direction;                    // 1 = uplink, 2 = downlink
        uint8_t m_num_of_ticket_features;
        hash_table m_tickets_ht;

        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("PerUserCounter:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }

    public:

        /*
         * constructor
         */
        PerUserCounter(const std::string &name, invocation_type invocation) :
        Block(name, invocation),
        m_in_gate(register_input_gate("in_tckt")),
        m_out_gate(register_output_gate("out_tckt")),
        m_current_agg_time(0),
        m_in_timescale(0),
        m_out_timescale(1),
        m_direction(0),
        m_num_of_ticket_features(0),
        m_tickets_ht()
        {}

        PerUserCounter(const PerUserCounter &)=delete;
        PerUserCounter& operator=(const PerUserCounter &) = delete;
        PerUserCounter(PerUserCounter &&)=delete;
        PerUserCounter& operator=(PerUserCounter &&) = delete;

        /*
         * destructor
         */
        virtual ~PerUserCounter()
        {}

        /**
          * Configures the aggregation
          * @param n the xml subtree
          */
        virtual void _configure(const pugi::xml_node&  n )
        {
            if(pugi::xml_node timescales = n.child("timescales"))
            {
                if(pugi::xml_attribute in_ts = timescales.attribute("in_ts"))
                {
                    m_in_timescale = in_ts.as_uint();
                }
                else signal_error("input timescale");

                if(pugi::xml_attribute out_ts = timescales.attribute("out_ts"))
                {
                    m_out_timescale = out_ts.as_uint();
                }
                else signal_error("output timescale");

            }else signal_error("timescales");

            //m_out_file.open ("PerUser_Tickets_1min_UL_SYN_packets_p65535.txt", fstream::out);
        }

        /**
         * Helper function used to generate, for each element in the hash table,
         * a related ticket with the current timestamp, and then remove the element.
         * @param curr_agg_time
         */
        void empty_hash_table(uint64_t curr_agg_time)
        {
            /*For each user (hash_table entry) in the hash_table sends (and prints) out the related
             * ticket, and delete it from the hash_table.
             */
            for(hash_table::iterator ht_it = m_tickets_ht.begin(); ht_it != m_tickets_ht.end(); ht_it++)
            {
                uint32_t client_IP = ht_it->first;
                std::shared_ptr<TicketMsg> ticket = std::make_shared<TicketMsg>(curr_agg_time, client_IP);

                ticket.get()->set_features(ht_it->second);
                //Sends the ticket out
                send_out_through(ticket, m_out_gate);


                //STAMPARE ANCHE VIDEO IL TICKET CREATO DAL PACCHETTO CORRENTE
                /*
                std::stringstream sss;
                sss << "Aggregation: " << m_in_timescale << " to " << m_out_timescale << " minute(s) \n"
                    << ticket.get()->to_string() << "\n";
                blocklog(sss.str(), log_info);
                */

                //Writes the results to the output results file
                //m_out_file << ticket.get()->to_string_file();

            }
            //Erases the current element from the hash table
            m_tickets_ht.clear();
        }

        /**
         * Helper function used to insert the current ticket in the ticket hash table
         * It checks whether the current user (hash table entry) already exists
         * in the hash table. If so, it just updates the features values of the
         * found entry; otherwise it creates a new hash table entry (new user),
         * and sets the feature values according to the input ticket values.
         */
        void insert_element_in_hash_table(const TicketMsg* ticket)
        {
            uint32_t lookup_user = ticket->get_userID();
            hash_table::iterator ht_it = m_tickets_ht.find(lookup_user);

            /* If the user (hash_table entry) is not yet in the hash table,
             * the find() function returns an iterator (ht_it) pointing to the end() of
             * the hash_table (unordered_map).
             * Otherwise it returns the the iterator (ht_it) pointing to the found
             * hash_table element
             */
            if( ht_it == m_tickets_ht.end())
            {
                hash_table::key_type key = lookup_user;
                hash_table::mapped_type mapped = *(ticket->get_features());
                hash_table::value_type val = hash_table::value_type(key, mapped);
                m_tickets_ht.insert(val);

            }else //The user (hash_table entry) has been found
            {
                /* For each feature (features_map element) of the input user's ticket,
                 * we check if it already exists in the found hash_table entry.
                 */
                for (features_map::const_iterator tck_map_it = ticket->get_features()->begin();
                     tck_map_it != ticket->get_features()->end(); ++tck_map_it)
                {
                    string lookup_feat_ID = tck_map_it->first;
                    uint64_t lookup_feat_val = tck_map_it->second;

                    features_map::iterator ht_map_it = ht_it->second.find(lookup_feat_ID);

                    /* If the current feature (features_map element) has not been found.
                     * We have to insert this new element into the map
                     */
                    if(ht_map_it == ht_it->second.end())
                    {
                        ht_it->second.insert(pair<string,uint64_t>(lookup_feat_ID, lookup_feat_val));
                    }
                    else //Otherwise, the current feature already exists. We just update its value.
                    {
                        ht_map_it->second += lookup_feat_val;
                        /*********************ATTENZIONE************************
                         * SOLO NEL CASO SI STIA AGGREGANDO DALLA TIMESCALE 0
                         * IN QUALSIASI ALTRA TIMESCALE (m_input_timescale ==0)
                         *                      E
                         * SOLO NEL CASO IN CUI LA FEATURE É IN DIREZIONE UPLINK!!!
                         * E NECESSARIO INSERIRE QUI UNA FUNZIONE CHE CONTI
                         * OPPORTUNAMENTE IL NUMERO DI PORTE O IP ADDRESS NEL
                         * CASO LA FEATURE RIGUARDI PORTE O IP ADDRESS!
                         * INFATTI NEL CASO DI FEATURE DI QUESTO TIPO, IL VALORE
                         * DELLA COPPIA FeatID->Val CONTIENE IL NUMERO DI PORTA O
                         * L'INDIRIZZO IP. A NOI SERVE PERCIÓ CONTARE QUANTE
                         * PORTE DIVERSE O INDIRIZZI IP DIVERSI VENGONO CONTATTATI
                         * É NECESSARIO QUINDI PER CIASCUN UTENTE PREVEDERE ANCHE
                         * DELLE TABELLE CONTENENTI LE PORTE E GLI IP ADD DIVERSI
                         * CONTATTATI PER OGNI FEATURE
                         * N.B. NEL TOOL IMPLEMENTATO NEL QOE FW QUESTO NON ERA
                         * FATTO CORRETTAMENTE!!!! INFATTI IO INCREMENTAVO IL NUMERO
                         * DI PORTE E IP ADD CHE ERANO AGGREGATI SULLA SCALA DI
                         * 1 MINUTO DA PETER!
                         */
                    }
                }

            }
        }


        /**
          * The actual per user counter function
          * Expects TicketMsg messages, otherwise it throws an Error exception
          * @param m the message to be checked
         */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(TicketMsg))
                throw std::runtime_error("PerUserCounter: wrong message type");
            const TicketMsg* ticket = static_cast<const TicketMsg* > (m.get());

            uint64_t time_now = ticket->get_timestamp();

            /* If the current time interval is not over, but an intermediate
             * signaling (DUMMY) ticket has arrived, we need to drop the current
             * useless ticket!
             * This will happen if the output timescale is greater than 1 minute
             * (from 1->5 to 30->60)
             */
            if( (time_now < m_current_agg_time) &&
                ((ticket->get_userID() == 0) && (ticket->get_extracted_features() == 0))
              ) return;


            /* Since the way the dummy signaling tickets are generated in
             * the feature extractor block,  is different from the way they are
             * generated in the current block, we need to foresee a different
             * approach when the tickets come from the featureExtractor block
             * (i.e. the input timescale is 0)
             */
            if(m_in_timescale == 0)
            {

                /* If the current time interval is over (i.e. the first ticket (DUMMY)
                * belonging to the next time interval has arrived)
                * we can empty the hash table, properly update the current time
                * (depending on the ticket just arrived and on the output timescale)
                * forward the signaling (DUMMY) ticket setting in it the just
                * evaluated current time.
                *
                * 2 checks are needed to recognize the beginning of the new time interval:
                */
                if( (time_now >= m_current_agg_time) &&                                  // 1. Input timestamp has to be Greater OR EQUAL to the current
                ((ticket->get_userID() == 0) && (ticket->get_extracted_features() == 0)) // 2. The ticket is a (dummy) signaling ticket
                )
                {
                    /* For each element in hash table create and send a TicketMsg
                     * with timestamp m_current_time, then removes the element from the hash table
                     */
                    empty_hash_table(m_current_agg_time);

                    /* Update the current time interval
                     * IMPORTANT!!! Since we are performing the division between two integers
                     * it is actually the floor of the division result!!!
                     */
                    m_current_agg_time = (time_now/(60*m_out_timescale) + 1) * (60*m_out_timescale);

                    uint32_t dummy_IP = 0;
                    //create a dummy ticket and send it out signaling this event
                    std::shared_ptr<TicketMsg> dummy_ticket = std::make_shared<TicketMsg>(m_current_agg_time, dummy_IP);

                    //PER ORA STAMPARE ANCHE VIDEO IL TICKET CREATO DAL PACCHETTO CORRENTE
                    std::stringstream sss;
                    sss <<  "Signaling Ticket. Timescale: " << m_out_timescale << " minute(s) \n"
                        << dummy_ticket.get()->to_string() << "\n\n";
                    blocklog(sss.str(), log_info);

                    send_out_through(dummy_ticket, m_out_gate);

                    return; //no element to insert because the current ticket is dummy!
                }
            }else // input timescale is not 0
            {
                if( (time_now > m_current_agg_time) &&                                   // 1. Input timestamp has to be Greater than the current
                ((ticket->get_userID() == 0) && (ticket->get_extracted_features() == 0)) // 2. The ticket is a (dummy) signaling ticket
                )
                {
                    //for each element in hash table create and send a TicketMsg with timestamp m_current_time
                    empty_hash_table(m_current_agg_time);

                    /* Update the current time interval
                     * IMPORTANT!!! Since we are performing the division between two integers
                     * it is actually the floor of the division result!!!
                     */
                    m_current_agg_time = (time_now/(60*m_out_timescale) + 1) * (60*m_out_timescale);

                    uint32_t dummy_IP = 0;
                    //create a dummy ticket and send it out signaling this event
                    std::shared_ptr<TicketMsg> dummy_ticket = std::make_shared<TicketMsg>(m_current_agg_time, dummy_IP);

                    //PER ORA STAMPARE ANCHE VIDEO IL TICKET CREATO DAL PACCHETTO CORRENTE
                    std::stringstream sss;
                    sss <<  "Signaling Ticket. Timescale: " << m_out_timescale << " minute(s) \n"
                        << dummy_ticket.get()->to_string() << "\n\n";
                    blocklog(sss.str(), log_info);

                    send_out_through(dummy_ticket, m_out_gate);

                    return; //no element to insert because the current ticket is dummy!
                }
            }

            //Insert the current ticket values in the hash table
            insert_element_in_hash_table(ticket);

        }
    };
    REGISTER_BLOCK(PerUserCounter,"PerUserCounter");
}

