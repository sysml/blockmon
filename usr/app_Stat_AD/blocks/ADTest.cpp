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
 * <blockinfo type="ADTest" invocation="direct" thread_exclusive="False">
 *   <humandesc>
 *      Takes HistoMsg messages as input and returns ADResultMsg messages and
 *      optionally ADAnomalMsg messages, for each of the traffic features
 *      in the current time interval (timebin),
 *
 *      It performs the Statistical-Based Anomaly Detection Algorithm for each
 *      incoming histogram.
 *      During the learning phase (whose duration is settable in the configuration
 *      file) it just collects all the histograms for each feature (actually
 *      transforms them in CCDF vectors); during the detection phase it evaluates,
 *      by mean of a Reference Set Identification Algorithm, if the current
 *      histogram (CCDF) is anomalous or not, comparing it within those contained
 *      in the ReferenceSet.
 *
 *      After the test the block returns a ADResultMsg message containing the
 *      current CCDF and other information about the test result.
 *      If the current histogram (CCDF) is declared anomalous, the block returns
 *      also a ADAnomalMsg message which contains the current CCDF and all the
 *      CCDFs included in its reference set.
 *
 *      Output messages are generated on the fly, this means that as soon as an
 *      histogram (referred to a single traffic feature for the current time interval)
 *      is analyzed, an ADResultMsg is generated and sent to the output gate.
 *   </humandesc>
 *
 * <shortdesc>
 *      Takes HistoMsg messages as input, performs the Statistical-based Anomaly
 *      Detection Algorithm and returns ADResultMsg messages containing information
 *      about the test results. If the input histogram is declared anomalous, an
 *      ADAnomalMsg is also generated and sent out.
 * </shortdesc>
 *
 *   <gates>
 *     <gate type="input" name="in_histo" msg_type="HistoMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <gates>
 *     <gate type="output" name="out_res" msg_type="ADResultMsg" m_start="0" m_end="0" />
 *   </gates>
 *   <gates>
 *     <gate type="output" name="out_anom" msg_type="ADAnomalMsg" m_start="0" m_end="0" />
 *   </gates>
 *
 *   <paramsschema>
 *    element params {
 *
 *          element timescale{
 *              attribute val = {xsd:integer {1|5|15|30|60}}
 *          }
 *
 *          element learning_window{
 *              attribute duration = {xsd:integer} (Days)
 *          }
 *
 *          element guard_period{
 *              attribute duration = {xsd:integer} (Hours)
 *          }
 *
 *          element min_nr_active_users{
 *              attribute val = {xsd:integer}
 *          }
 *
 *          element detection_start_time{
 *              attribute val = {xsd:integer} (Linux timestamp)
 *          }
 *
 *          element res_output_file{
 *              attribute name = {string}
 *          }
 *
 *          element anom_output_file{
 *              attribute name = {string}
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
 *              <learning_window duration = "7"/>
 *
 *              <guard_period duration = "22"/>
 *
 *              <min_nr_active_users val = "50"/>
 *
 *              <detection_start_time val = "1333490460"/>
 *
 *              <detection_stop_time val = "1333490460"/>
 *
 *              <res_output_file name = "AnDet_Res"/>
 *
 *              <anom_output_file name = "AnDet_Anomal"/>
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
#include <HistoMsg.hpp>
#include <ADResultMsg.hpp>
#include <ADAnomalMsg.hpp>
#include <unordered_map>
#include <iostream>
#include <sstream>
#include <fstream>

//Anomaly codes table
#define NOT_ANOMALOUS 0
#define ANOMALOUS 1
#define NOT_ENOUGH_EL_IN_REF_SET 2
#define NOT_ENOUGH_ACTIVE_USERS_DET 3
#define NOT_ENOUGH_NOT_NULL_BINS_DET 4
#define NOT_ENOUGH_ACTIVE_USERS_LEARN 39
#define NOT_ENOUGH_NOT_NULL_BINS_LEARN 49
#define LEARNING_OK 99

#define EPSILON 0.000000000001 // = 1e-12 -> nr of UNIQUE users must be lower
                               // than 1e12 in order to have different values
                               // for 0 users and 1 user after the approximation!!!


namespace blockmon
{
    /* ALREADY DEFINED IN ADAnomalMsg.hpp
    typedef struct {
        uint64_t timestamp;
        uint16_t nr_unique_users;
        uint16_t PDF_size;
        vector<double> PDF;
        bool L_phase; //Learning phase = true, Detection phase = false
    }window_element;

    typedef vector<window_element> window_array;
    */
    typedef unordered_map<string, window_array> windows_hash_table;

    typedef struct{
        double L_div; //L_Divergences between each RefSet_Istep array PDF and the current PDF
        uint index; //Index in the element in the RefSet_Istep array
    }Divergence;

    class ADTest: public Block
    {
        int m_in_gate;
        int m_out_res_gate;
        int m_out_anom_gate;

        uint64_t m_current_agg_time;
        uint16_t m_timescale;            // 1,5,15,30,60
        uint m_window_size;             // in days
        uint m_n_histograms_in_window;  // num of histograms in the window
        uint m_guard_period;            // in hours
        uint m_guard_period_duration;   // duration in seconds of the guard period
        uint32_t m_min_active_users;    // minimun number of active users required
        uint64_t m_detection_start_timestamp;
        uint64_t m_stop_time;
        string m_res_file_name;
        string m_anom_file_name;
        uint64_t m_learning_start_time;
        uint16_t m_not_null_bins;        // number of not null bins of the current PDF
        bool m_Learning_phase;            // true if the current feature is in the Learning phase
        uint16_t m_anomaly_code;                    // anomaly code for the current PDF
        windows_hash_table m_windows_ht;

        vector<double> m_curr_PDF;
        vector<double> m_curr_CCDF;

        ofstream m_res_file, m_anom_file;

        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("ADTest:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }

    public:

        /**
         * @brief Constructor
         * @param name         The name of the source block
         * @param invocation   Invocation type of the block (Indirect, Direct, Async) . This block can only be directly invoked, and will ignore any contrary configuration.
         */
        ADTest(const std::string &name, invocation_type invocation) :
        Block(name, invocation),
        m_in_gate(register_input_gate("in_histo")),
        m_out_res_gate(register_output_gate("out_res")),
        m_out_anom_gate(register_output_gate("out_anom")),
        m_current_agg_time(0),
        m_timescale(0),
        m_window_size(0),
        m_n_histograms_in_window(0),
        m_guard_period(0),
        m_guard_period_duration(0),
        m_min_active_users(50),
        m_detection_start_timestamp(0),
        m_stop_time(99999999999),
        m_res_file_name(" "),
        m_anom_file_name(""),
        m_learning_start_time(0),
        m_not_null_bins(0),
        m_Learning_phase(true),
        m_anomaly_code(199),
        m_windows_ht(),
        m_curr_PDF(),
        m_curr_CCDF()
        {}

        ADTest(const ADTest &)=delete;
        ADTest& operator=(const ADTest &) = delete;
        ADTest(ADTest &&)=delete;
        ADTest& operator=(ADTest &&) = delete;

        /*
         * destructor
         */
        virtual ~ADTest()
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

            if(pugi::xml_node learn_win = n.child("learning_window"))
            {
                if(pugi::xml_attribute l_w = learn_win.attribute("duration"))
                {
                    m_window_size = l_w.as_uint();
                }
                else signal_error("learning window duration");
            }else signal_error("learning window");

            if(pugi::xml_node guard_per = n.child("guard_period"))
            {
                if(pugi::xml_attribute g_p = guard_per.attribute("duration"))
                {
                    m_guard_period = g_p.as_uint();
                }
                else signal_error("guard period duration");
            }else signal_error("guard period");

            if(pugi::xml_node min_usr = n.child("min_nr_active_users"))
            {
                if(pugi::xml_attribute min_nr_a_u = min_usr.attribute("val"))
                {
                    m_min_active_users = min_nr_a_u.as_uint();
                }
                else signal_error("minimum number active users value");
            }else signal_error("minimum number active users");

            if(pugi::xml_node det_start = n.child("detection_start_time"))
            {
                if(pugi::xml_attribute det_s_t = det_start.attribute("val"))
                {
                    m_detection_start_timestamp = det_s_t.as_uint();
                }
                else signal_error("detection start time value");
            }else signal_error("detection start time");

            if(pugi::xml_node stop_time = n.child("detection_stop_time"))
            {
                if(pugi::xml_attribute s_t = stop_time.attribute("val"))
                {
                    m_stop_time = s_t.as_uint();
                }
                else signal_error("detection stop time value");
            }else signal_error("detection stop time");

            if(pugi::xml_node res_out_file = n.child("res_output_file"))
            {
                if(pugi::xml_attribute r_out_file = res_out_file.attribute("name"))
                {
                    m_res_file_name = r_out_file.value();
                }else signal_error("Result output file name");
            }else signal_error("Result output file");

            if(pugi::xml_node anom_out_file = n.child("anom_output_file"))
            {
                if(pugi::xml_attribute a_out_file = anom_out_file.attribute("name"))
                {
                    m_anom_file_name = a_out_file.value();
                }else signal_error("Result output file name");
            }else signal_error("Result output file");


            // Learning start timestamp
            m_learning_start_time = m_detection_start_timestamp - m_window_size*24*60*60;
            // number of histograms in the window
            m_n_histograms_in_window = m_window_size*1440/m_timescale;
            // number of PDFs in the guard period
            uint32_t PDFs_in_guard_period = m_guard_period*60/m_timescale;
            /* evaluate the duration in seconds of the guard period. This value subtracted from the current time
             * will give the first timestamp to analyze in the detection phase */
            m_guard_period_duration = PDFs_in_guard_period*m_timescale*60;


            //Opening results text files
            //m_res_file.open (m_res_file_name, fstream::in | fstream::out | fstream::app);
            m_res_file.open (m_res_file_name, fstream::out);

            //Opening anomalies text files
            m_anom_file.open (m_anom_file_name, fstream::out);

        }

        /**
         * Helper function used to generate, for the current analyzed histogram,
         * a related ADResultMsg with the current timestamp, the current CCDF
         * and its AD Test results.
         * @param
         */
        void send_result_message(const HistoMsg* histogram, bool L_phase, float ARLB, float ARUB, float IDm, float EDm)
        {
            uint64_t timestamp = histogram->get_timestamp();
            string featID = histogram->get_featureID();

            std::shared_ptr<ADResultMsg> result_msg = std::make_shared<ADResultMsg>(timestamp, m_timescale, featID);
            result_msg.get()->set_nr_unique_users(histogram->get_unique_users());
            result_msg.get()->set_total_value(histogram->get_total_value());
            result_msg.get()->set_CCDF_size((histogram->get_histogram())->size());
            result_msg.get()->set_CCDF(m_curr_CCDF);
            result_msg.get()->set_phase(L_phase);
            result_msg.get()->set_AccReg_LowBound(ARLB);
            result_msg.get()->set_AccReg_UppBound(ARUB);
            result_msg.get()->set_Internal_Dispersion(IDm);
            result_msg.get()->set_External_Dispersion(EDm);
            result_msg.get()->set_Anomaly_code(m_anomaly_code);

            //STAMPARE ANCHE A VIDEO IL MESSAGGIO RESULT
            std::stringstream sss;
            //sss << result_msg.get()->to_string();

            //Sends the ticket out
            send_out_through(result_msg, m_out_res_gate);
            sss << "Result message sent out!\n";
            blocklog(sss.str(), log_info);

            //Writes the results to the output results file
            m_res_file << result_msg.get()->to_string_file();
            if(timestamp >= m_stop_time )
            {
                m_res_file.close();
                exit (1);
            }

        }

        /**
         * Helper function used to generate, for the current analyzed histogram,
         * a related ADAnomalMsg with the current timestamp, the current CCDF
         * and its Reference Set.
         * @param histogram the HistoMsg message containing the histogram info
         * @param ref_set the reference set array
         */
        void send_anomal_message(const HistoMsg* histogram, window_array *ref_set)
        {
            uint64_t timestamp = histogram->get_timestamp();
            string featID = histogram->get_featureID();
            uint16_t ref_set_size = ref_set->size();

            std::shared_ptr<ADAnomalMsg> anomal_msg = std::make_shared<ADAnomalMsg>(timestamp, m_timescale, featID);
            anomal_msg.get()->set_CCDF_size((histogram->get_histogram())->size());
            anomal_msg.get()->set_CCDF(m_curr_CCDF);
            anomal_msg.get()->set_RefSet_size(ref_set_size);
            anomal_msg.get()->set_RefSet(*ref_set);

            //STAMPARE ANCHE VIDEO IL MESSAGGIO ANOMAL
            std::stringstream sss;
            //sss << anomal_msg.get()->to_string();

            //Sends the ticket out
            send_out_through(anomal_msg, m_out_anom_gate);
            sss << "Anomal message sent out!\n";
            blocklog(sss.str(), log_info);

            //Writes the results to the output anomalies file
            m_anom_file << anomal_msg.get()->to_string_file();
            if(timestamp >= m_stop_time )
            {
                m_anom_file.close();
                exit (1);
            }
        }

        /**
         * Helper function used to generate, for the current analyzed histogram,
         * the related CCDF.
         * The function performs two normalizations and an approximation
         * in order to have normalized values which do not depend on the
         * number of zeros contained in the integer histogram
         * @param histog the integer vector representing the current histogram
         */
        void create_CCDF(vector<uint32_t> histog)
        {
            uint16_t Tot_num_users = 0;
            double n_dummy_users = 0.0;
            uint16_t n_empty_bins = 0;
            uint i;
            /* Counting the total number of users, including duplicates */
        for(i = 0; i<histog.size(); i++)
                Tot_num_users += histog[i];

        /* First Normalization */
            for(i=0; i<histog.size(); i++)
        {
                m_curr_PDF.push_back((double)histog[i]/(double)Tot_num_users);

                if(m_curr_PDF[i] == 0)
        {
                    /* Approximation */
            m_curr_PDF[i] = EPSILON;
            /* Significance meter: number of null bins in the histogram*/
            n_empty_bins ++;
        }
        n_dummy_users += m_curr_PDF[i];
            }

        /* Second Normalization: PDF(curr_real_histog)-> CDF-> CCDF */
        vector<double> CDF;
            for(i=0; i<histog.size(); i++)
        {
                m_curr_PDF[i] = m_curr_PDF[i]/n_dummy_users;

        if(i == 0) /*first bin*/
                    CDF.push_back(m_curr_PDF[i]);
        else
                    CDF.push_back(CDF[i-1] + m_curr_PDF[i]);

                m_curr_CCDF.push_back(1 - CDF[i]);
            }

            m_not_null_bins = histog.size() - n_empty_bins;
        }

        /**
         * Helper function used to update the windows hash table entry
         * (window array) pointed to by the iterator passed as parameter.
         * If in learning phase the function adds the current pdf to the end of
         * the window array containing the list of window_elements included in
         * the window of the current traffic feature.
         * If in detection phase the function removes the first (oldest) element
         * (window_element) from the array pointed to by the iterator, and add
         * a new element containing the current histogram (pdf).
         * @param w_it the windows hash table iterator pointing to the
         * windows hash table entry (<featiId, window_array> pair) of the
         * required traffic feature
         * @param histo_msg the current incoming HistoMsg
         * @param l_phase true if learning phase false if detection phase
         */
        void update_window_entry(windows_hash_table::iterator w_it, const HistoMsg* histo_msg, bool l_phase)
        {
            window_array* windows_entry = &(w_it->second);
            window_element w_el;

            w_el.timestamp = histo_msg->get_timestamp();
        w_el.nr_unique_users = histo_msg->get_unique_users();
        w_el.PDF = m_curr_PDF;
        w_el.PDF_size = w_el.PDF.size();
        if(l_phase == true)
                w_el.L_phase = true;
        else
            {
                w_el.L_phase = false;
                //removes the first (oldest) window element from the window array
                windows_entry->erase(windows_entry->begin());
            }
            //adds the current (newest) window element at the end of the array
            windows_entry->push_back(w_el);
        }

        /**
         * Helper function used to add a new windows entry
         * (window array) to the windows hash table.
         * The function creates a new window_element (new pair <featID, window_array>)
         * and adds it (completely empty) to the windows hash table
         * @param feature_id the feature id of the traffic feature to add
         * @return w_it the windows hash table iterator pointing to the
         * just created hash table entry
         */
        windows_hash_table::iterator insert_window_entry(string feature_id)
        {
            window_array new_array;
            m_windows_ht.insert(pair<string,window_array>(feature_id, new_array));
            windows_hash_table::iterator w_it = m_windows_ht.find(feature_id);
            return w_it;
    }

        /************************************************/
        /*********** UTILITY FUNCTIONS ******************/
        /************************************************/

        /* Divergence Compare */
        struct Div_compare {
            bool operator ()(Divergence const& i, Divergence const& j) const {
                return (i.L_div < j.L_div);
            }
        };

        /* Index Compare */
        struct Index_compare {
            bool operator ()(Divergence const& i, Divergence const& j) const {
                return (i.index < j.index);
            }
        };

        /*Kullback-Leibler Divergence D(p||q) function*/
        double KuLe_Divergence(vector<double>p, vector<double>q)
        {
            double  D_pq = 0;
            uint i;
            for(i=0; i < p.size(); i++)
                D_pq += p[i]*log2(p[i]/q[i]);

            return D_pq;
        }

        /*Entropy function*/
        double Entropy(vector<double> histo)
        {
            double Hp = 0;
            uint i;
            for(i=0; i<histo.size(); i++)
                Hp += histo[i]*log2(histo[i]);

            return -Hp;
        }

        /* Evaluates the L_Divergence given the PDFs (p and q)*/
         double L_Divergence(vector<double> p, vector<double>q)
        {
            double L_pq, D_pq, D_qp, H_p, H_q;
            D_pq = KuLe_Divergence(p,q);
            D_qp = KuLe_Divergence(q,p);
            H_p = Entropy(p);
            H_q = Entropy(q);
            L_pq = (D_pq/H_p + D_qp/H_q)/2;
            return L_pq;
        }

        /* This function searches in the vector the uint elements equal to the
         * passed value, and returns the number of occurrences found*/
        uint find_in_uint_vector(vector<uint> array, uint target)
        {
            uint count =0;
            uint i;
            for (i=0; i<array.size();i++)
                if(array[i] == target) count++;
            return count;
        }

        /*Evaluates the average of a double vector */
        double vector_mean(vector<double> vec)
        {
            double mean, sum = 0;
            uint i;
            for (i=0; i<vec.size(); i++)
                sum += vec[i];

            mean = (double)(sum/vec.size());
            return mean;
        }

        /*Evaluates the average of a double matrix */
        double double_matrix_mean(vector< vector<double> > mat)
        {
            double sum = 0;
            uint i, j;
            uint n_row = mat.size();
            uint n_col = mat[0].size();
            for(i=0; i<n_row; i++)
            {
                for(j=0; j<n_col; j++)
                    sum += mat[i][j];
            }
            return (double)(sum/(n_row*n_col));
        }

        /* Evaluates the max value of a double matrix and returns the indexes of
         * the max value found */
        void double_matrix_max(vector< vector<double> > matrix, uint *index_r, uint *index_c)
        {
            double max = -99999999;
            uint i,j;
            for(i=0; i<matrix.size(); i++)
            {
                for(j=0; j<matrix.size(); j++)
                {
                    if(matrix[i][j] > max)
                    {
                        max = matrix[i][j];
                        *index_r = i;
                        *index_c = j;
                    }
                }
            }
            return;
        }

        /* This function evaluates the p-th percentile of the values in the array
         * passed in input using LINEAR INTERPOLATION between the two nearest ranks. */
        double percentile_of_array(vector<double> v_vector, uint p)
        {
            uint i,k = 0;
            double v;
            sort(v_vector.begin(), v_vector.end());
            uint N = v_vector.size();
            vector<double> p_vector;
            double temp = 100/(double)N;

            for(i=0; i<N; i++)
                p_vector.push_back(temp*(i+1-0.5));

            if(p < p_vector[0])
            {
                v = v_vector[0];
                return v;
            }
            else if(p > p_vector[N-1])
            {
                v = v_vector[N-1];
                return v;
            }
            else
            {
                for(i=0;i<N;i++)
                    if(p >= p_vector[i]) k = i;

                double n = (double)N/100;
                v = ( v_vector[k]+n*(double)(p-p_vector[k])*(v_vector[k+1]-v_vector[k]) );
                return v;
            }
        }

        /************************************************/
        /************** RSIA FUNCTIONS ******************/
        /************************************************/

        /**
         * First step of Reference Set Identification Algorithm
         * given the element of the windows table corresponding to the current
         * feature, the current element and the lower bound timestamp of the
         * guard period, it returns the array containing the window elements
         * which pass the first step of the Reference Set Identification Algorithm
         * @param w_it iterator to the windows hash table entry corresponding to
         * the current feature
         * @param histo_msg the current incoming histogram message
         * @return the window array containing the window elements selected by the
         * first step of the Reference Set Identification Algorithm
         */

        window_array RSIA_stepI(windows_hash_table::iterator w_it, const HistoMsg* histo_msg)
        {
           /* Guard period lower bound is setted here, the I step of RSIA
            * starts from this bound (included) and goes until the oldest
            * timestamp in the window */
           uint64_t guard_period_low_bound = m_current_agg_time - m_guard_period_duration;

           window_array windows_entry = (w_it->second);
           window_element w_el, w_elem;
           window_array RS_Istep;
           vector<uint> indexList;

           double dif = 0.0;
           double sf = 0.000000000000000000; /* Slack Factor (goes from 0.0 to 0.5) */
           uint i;
           while ((sf <= 0.5) && (indexList.size() <= 200))
           {
               sf += 0.02;
               indexList.clear();
               for(i=0; i< windows_entry.size(); i++)
               {
                   w_el = windows_entry[i];
                   //until the last time interval included in the window and not
                   //in the guard period
                   if(w_el.timestamp <= guard_period_low_bound)
                   {
                       dif = abs( (double)histo_msg->get_unique_users() - (double)w_el.nr_unique_users);

                       if(dif < sf*(double)histo_msg->get_unique_users())
                       {
                           indexList.push_back(i);

                       }
                   }
               }
           }

           for(i=0; i<indexList.size(); i++)
           {
               w_elem = windows_entry[indexList[i]];
               RS_Istep.push_back(w_elem);
           }
           return RS_Istep;
        }


        /**
         * Second step of the Reference Set Identification algorithm.
         * Given the array containing the reference set obtained from the first step,
         * this function returns a new array with at most the 50 elements which
         * passed the second step of the RSIA, i.e. those PDFs with the minimum
         * divergence with respect to the current incoming PDF.
         * @param RefSet_Istep The reference set (window array) obtained after the I step
         * @param histo_msg the current incoming histogram message
         * @return the window array containing the window elements selected by the
         * second step of the Reference Set Identification Algorithm
         */
        window_array RSIA_stepII(window_array RefSet_Istep)
        {
            vector<Divergence> L_pq;
            window_array RefSet_IIStep;
            uint i;
            for(i = 0; i < RefSet_Istep.size(); i ++)
            {
                window_element w_el = RefSet_Istep[i];
                Divergence Div_el;
                Div_el.L_div = L_Divergence(m_curr_PDF, w_el.PDF);
                Div_el.index = i;
                L_pq.push_back(Div_el);
            }

            // Sorts the L_pq vector comparing the L_Divergences
            sort(L_pq.begin(), L_pq.end(), Div_compare());

            //Checks if the array obtained from the I step has less than 50 elements
            const uint RSI_size = RefSet_Istep.size();
            const uint min_allowed_el = 50;
            uint nr_of_elem = min(RSI_size, min_allowed_el);

            /* Only the first nr_of_elem (50 o less) elements with the smallest
             * L_Divergences pass to the RSIA III step */
            vector<Divergence> L_pq_sorted(L_pq.begin(), L_pq.begin()+nr_of_elem);

            /* Sorts the L_pq_sorted vector comparing the indexes */
            sort(L_pq_sorted.begin(), L_pq_sorted.end(), Index_compare());

            /* Fill in the result vector */
            for(i=0; i< L_pq_sorted.size(); i++)
            {
                Divergence Div_elem = L_pq_sorted[i];
                RefSet_IIStep.push_back(RefSet_Istep[Div_elem.index]);
            }

            return RefSet_IIStep;
        }
        /**
         * Third step of the Reference Set Identification Algorithm : PRUNING
         * @param RefSetII
         * @param histogram_msg
         * @param keep_index
         * @param closest_dist
         * @param dist_vec
         * @return the final reference set array
         */
        window_array RSIA_stepIII(window_array RefSetII, vector<uint>* keep_index,
                        vector< vector<double> >* closest_dist, vector<double>* dist_vec)
        {
            vector<uint> A, B, A_branch1, A_branch2, B_branch1, B_branch2;
            vector< vector<double> > D_reg, simm_D;
            window_array RefSet_final;

            uint N = RefSetII.size();
            uint i,j;
            double el;
            window_element l_el_i, l_el_j;

            vector<double> zero_double_vector;
            zero_double_vector.assign(N, 0.0);

            /* Initialization of , dist_vec and closest_dist */
            (*dist_vec).assign(N, 0.0);
            (*closest_dist).assign(N, zero_double_vector);

            /* Initialization of D_reg and simm_D*/
            D_reg.assign(N, zero_double_vector);  //Triangular matrix
            simm_D.assign(N, zero_double_vector); //Square matrix = D_reg + D_reg'

            for(i=0; i<N; i++)
            {
                l_el_i = RefSetII[i];
                for(j=0;j<N; j++)
                {
                    /* The matrices closest_dist and D_reg must be upper-triangular!!!!
                     * (the elements on of the diagonal and those under the
                     * diagonal must be 0 (if i>=j -> closest_dist[i][j] = 0)!!!
                     * The matrix simm_D is squared with null diagonal */
                    if(i < j)
                    {
                        l_el_j = RefSetII[j];
                        //Evaluates the L_Divergence between the ith & jth
                        //elements and puts it into the matrix closest_dist
                        el = L_Divergence(l_el_i.PDF, l_el_j.PDF);
                        (*closest_dist).at(i).at(j) = el;
                        //Populates the square matrix containing the elements of
                        //D_reg in both its parts above and below the diagonal
                        D_reg[i][j] = el;
                        simm_D[i][j] = el;
                        simm_D[j][i] = el;
                    }
                }
                (*dist_vec).at(i) = L_Divergence(l_el_i.PDF, m_curr_PDF);
            }

            uint index_i;
            uint index_j;
            double cost_branch1, cost_branch2;
            while((A.size() + B.size()) < N)
            {
                /* Finds the max value in the matrix D_reg (with dimension N)
                 * and its position (index_i, index_j) */
                double_matrix_max(D_reg, &index_i, &index_j);
                D_reg[index_i][index_j] = 0;
                //Checks if in the vector A there is the value index_i
                if(find_in_uint_vector(A, index_i) > 0)
                {
                    if((find_in_uint_vector(B, index_j) == 0) && (find_in_uint_vector(A, index_j) == 0) )
                        B.push_back(index_j);
                }else if(find_in_uint_vector(A, index_j) > 0)
                {
                    if((find_in_uint_vector(B, index_i) == 0) && (find_in_uint_vector(A, index_i) == 0) )
                        B.push_back(index_i);
                }else if(find_in_uint_vector(B, index_i) > 0)
                {
                    if((find_in_uint_vector(A, index_j) == 0) && (find_in_uint_vector(B, index_j) == 0) )
                        A.push_back(index_j);
                }else if(find_in_uint_vector(B, index_j) > 0)
                {
                    if((find_in_uint_vector(A, index_i) == 0) && (find_in_uint_vector(B, index_i) == 0) )
                        A.push_back(index_i);
                }else
                {
                    /*Copies all the values of A in A_branch1 and in A_branch2*/
                    for(i=0; i<A.size(); i++)
                    {
                        if(i < A_branch1.size())
                            A_branch1[i] = A[i];
                        else
                            A_branch1.push_back(A[i]);

                        if(i < A_branch2.size())
                            A_branch2[i] = A[i];
                        else
                            A_branch2.push_back(A[i]);
                    }
                    /*Append a new elements in A_branch1 and A_branch2*/
                    A_branch1.push_back(index_i);
                    A_branch2.push_back(index_j);

                    /*Copies all the values of B in B_branch1 and B_branch2*/
                    for(i=0; i<B.size(); i++)
                    {
                        if(i < B_branch1.size())
                            B_branch1[i] = B[i];
                        else
                            B_branch1.push_back(B[i]);

                        if(i < B_branch2.size())
                            B_branch2[i] = B[i];
                        else
                            B_branch2.push_back(B[i]);
                    }
                    /*Append a new element in B_branch1 and B_branch2*/
                    B_branch1.push_back(index_j);
                    B_branch2.push_back(index_i);

                    uint index_A, index_B;
                    vector< vector<double> > simm_D_branch1; // matrix A_branch1.size() x B_branch1.size()
                    /* Initialization of simm_D_branch1*/
                    vector<double> zero_double_v1;
                    zero_double_v1.assign(B_branch1.size(), 0.0);
                    simm_D_branch1.assign(A_branch1.size(), zero_double_v1);

                    for(i=0; i<A_branch1.size(); i++)
                    {
                        index_A = A_branch1[i];
                        for(j=0; j<B_branch1.size();j++)
                        {
                            index_B = B_branch1[j];
                            simm_D_branch1[i][j] = simm_D[index_A][index_B];
                        }
                    }

                    vector< vector<double> > simm_D_branch2; // matrix A_branch1.size() x B_branch1.size()
                    /* Initialization of simm_D_branch2*/
                    vector<double> zero_double_v2;
                    zero_double_v2.assign(B_branch2.size(), 0.0);
                    simm_D_branch2.assign(A_branch2.size(), zero_double_v2);

                    for(i=0; i<A_branch2.size(); i++)
                    {
                        index_A = A_branch2[i];
                        for(j=0; j<B_branch2.size();j++)
                        {
                            index_B = B_branch2[j];
                            simm_D_branch2[i][j] = simm_D[index_A][index_B];
                        }
                    }

                    cost_branch1 = double_matrix_mean(simm_D_branch1);
                    cost_branch2 = double_matrix_mean(simm_D_branch2);

                    if(cost_branch1 > cost_branch2)
                    {
                        //A = A_branch1;
                        for (i=0; i< A_branch1.size();i++)
                        {
                            if(i < A.size())
                                A[i] = A_branch1[i];
                            else
                                A.push_back(A_branch1[i]);
                        }

                        //B = B_branch1;
                        for (i=0;i<B_branch1.size();i++)
                        {
                            if(i < B.size())
                                B[i] = B_branch1[i];
                            else
                                B.push_back(B_branch1[i]);
                        }
                    }else
                    {
                        //A = A_branch2;
                        for (i=0; i< A_branch2.size();i++)
                        {
                            if(i < A.size())
                                A[i] = A_branch2[i];
                            else
                                A.push_back(A_branch2[i]);
                        }

                        //B = B_branch2;
                        for (i=0;i<B_branch2.size();i++)
                        {
                            if(i < B.size())
                                B[i] = B_branch2[i];
                            else
                                B.push_back(B_branch2[i]);
                        }
                    }
                }
            }

            sort(A.begin(), A.end());
            sort(B.begin(), B.end());

            //Cardinality gap between the two subsets
            if( abs( ((double)A.size() - (double)B.size())/((double)A.size() + (double)B.size()) ) > 0.1 )
            {
                if(A.size() < B.size())
                {   //keep_index = B;
                    for (i=0; i<B.size(); i++)
                        keep_index->push_back(B[i]);
                }else
                {   //keep_index = A;
                    for (i=0;i<A.size();i++)
                        keep_index->push_back(A[i]);
                }
            }else
            {
                for(i=0;i<N; i++)
                    keep_index->push_back(i);
            }

            window_element final_el;
            for(i=0; i<keep_index->size(); i++)
            {
                final_el = RefSetII[(*keep_index).at(i)];
                RefSet_final.push_back(final_el);
            }

            return RefSet_final;
        }

        /**
         *   Function to evaluate the test
         * @param RefSetIII_size final reference set size
         * @param closest_distance matrix containing the closest distances
         * @param dist_vec vector containing the distances
         * @param keep_index vector containing indexes
         * @param l_ENKLD_base reference to the lower bound of the acceptance region
         * @param u_ENKLD_base reference to the upper bound of the acceptance region
         * @param mean_ENKLD_base reference to the mean of internal dispersion
         * @param ENKLD_current reference to the mean of the external dispersion
         */
        void ENKL_test(uint RefSetIII_size, vector< vector<double> > closest_distance, vector<double> dist_vec, vector<uint> keep_index, double* l_ENKLD_base, double* u_ENKLD_base, double* mean_ENKLD_base, double* ENKLD_current)
        {
            vector< vector<double> > closest_dist;

            /* Initialization of closest_dist matrix */
            vector<double> dummy;
            dummy.assign(RefSetIII_size, 0.0);
            closest_dist.assign(RefSetIII_size,dummy);

            uint indexI, indexJ;
            uint i,j;

            for(i=0; i < RefSetIII_size; i++)
            {
                indexI = keep_index[i];
                for(j=0; j < RefSetIII_size; j++)
                {
                    /*The matrix must be upper-triangular!!!!
                     *(the elements of the diagonal and those
                     * under the diagonal must be 0 !!!*/
                    if(j<i+1)
                    {
                         closest_dist[i][j] = 0;
                    }
                    else
                    {
                        indexJ = keep_index[j];
                        closest_dist[i][j] = closest_distance[indexI][indexJ];
                    }
                }
            }

            /* Creates an array containing all the values different from 0
             * of the upper part of the upper-triangular matrix closest_dist */
            vector<double> closest_dist_vec;
            for(i=0; i<RefSetIII_size; i++)
            {
                for(j=0; j<RefSetIII_size; j++)
                {
                    if( (i < j) )//&& (closest_dist[i][j] != 0) ) dovrebbe bastare il controllo su i<j per escludere gli elementi diversi da 0 perché la matrice deveessere triangolare alta!
                        closest_dist_vec.push_back(closest_dist[i][j]);
                }
            }

            // Mean of divergences values (Internal Dispersion mean)
            *mean_ENKLD_base = vector_mean(closest_dist_vec);
            //upper bound percentile
            uint alpha = 99;
            //Acceptance region lower bound
            *l_ENKLD_base = percentile_of_array(closest_dist_vec, 100-alpha);
            //Acceptance region upper bound
            *u_ENKLD_base = percentile_of_array(closest_dist_vec, alpha);

            /* Evaluates the current metric value to compare with the reference
             * i.e. the mean of the external dispersion, to compare with the
             * upper bound of the acceptance region (that is the 99th
             * percentile of the Internal dispersion)*/
            vector<double> appo;
            for(i=0; i<keep_index.size(); i++)
                appo.push_back(dist_vec[keep_index[i]]);
            // External Dispersion mean
            *ENKLD_current = vector_mean(appo);

            if(*ENKLD_current < *u_ENKLD_base)
                //(Mean of External Dispersion < 99th percentile of Internal Dispersion)
                m_anomaly_code = NOT_ANOMALOUS;//Test passed ! Sample not anomalous
            else//(Mean of External Dispersion > 99th percentile of Internal Dispersion)
                m_anomaly_code = ANOMALOUS;    //Test not passed ! Sample anomalous!
        }

        /**
          * The actual Histogram Calculation function
          * Expects TicketMsg messages, otherwise it throws an Error exception
          * @param m the message to be checked */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int /* index */)
        {
            if(m->type() != MSG_ID(HistoMsg))
                throw std::runtime_error("ADTest: wrong message type");
            const HistoMsg* histogram_msg = static_cast<const HistoMsg* > (m.get());

            m_current_agg_time = histogram_msg->get_timestamp();

            /* Check start time bound*/
            if(m_current_agg_time < m_learning_start_time)
        return; // Algorithm not yet started!

            /* Current CCDF Generation: Normalization 1, approximation, normalization 2 */
            const vector<uint32_t>* histo_int = histogram_msg->get_histogram();
            create_CCDF(*histo_int);

            /* Check If the current traffic feature entry already exists
             * in the windows hash table, if not create (and leaves empty)
             * it and add it to the windows hash table. */
            windows_hash_table::iterator win_it = m_windows_ht.find(histogram_msg->get_featureID());
            if(win_it == m_windows_ht.end()) win_it = insert_window_entry(histogram_msg->get_featureID());

            /* Phase checking */
            if(win_it->second.size() < m_n_histograms_in_window) /* Window not yet completed */
                m_Learning_phase = true; /* Learning phase */
            else
                m_Learning_phase = false; /* Detection phase */

            /* ******************************************************* */
            /* ****************** LEARNING PHASE ********************* */
            /* ******************************************************* */
            if(m_Learning_phase == true)
            {
                std::stringstream sss;
                /* Significance checks*/
                if(histogram_msg->get_unique_users() <= m_min_active_users)
                {
                    sss << "Learning phase: Not enough active users. Histogram discarded! \n";
                    blocklog(sss.str(), log_info);
                    m_anomaly_code = NOT_ENOUGH_ACTIVE_USERS_LEARN;
                }
                else if(m_not_null_bins <= 5)
                {
                    sss << "Learning phase: Not enough not null bins. Histogram discarded! \n";
                    blocklog(sss.str(), log_info);
                    m_anomaly_code = NOT_ENOUGH_NOT_NULL_BINS_LEARN;
                }else
                {
                    m_anomaly_code = LEARNING_OK;
                    update_window_entry(win_it, histogram_msg, true);
                }
                send_result_message(histogram_msg, true, 0.0, 0.0, 0.0, 0.0);

            }else
            /* ******************************************************* */
        /* ***************** DETECTION PHASE ********************* */
        /* ******************************************************* */
            {
                double l_ENKLD_base = 0.0;//Lower Bound of Acceptance Region
                double u_ENKLD_base = 0.0;//Upper Bound of Acceptance Region (5th & 95th percentile of Internal Dispersions)
                double mean_ENKLD_base = 0.0; //Mean of Internal Dispersions
                double ENKLD_current = 0.0; //Current metric value Mean of External Dispersions

                window_array RefSetI, RefSetII, RefSetIII;

                std::stringstream sss;
                /* Significance checks*/
                if(histogram_msg->get_unique_users() <= m_min_active_users)
                {
                    sss << "Detection phase: Not enough active users. Histogram discarded! \n";
                    blocklog(sss.str(), log_info);
                    m_anomaly_code = NOT_ENOUGH_ACTIVE_USERS_DET;
                }
                else if(m_not_null_bins <= 5)
                {
                    sss << "Detection phase: Not enough not null bins. Histogram discarded! \n";
                    blocklog(sss.str(), log_info);
                    m_anomaly_code = NOT_ENOUGH_NOT_NULL_BINS_DET;
                }else // Preliminary checks passed !
                {
                    /* ****** Reference Set Identification Algorithm ****** */

                    /* I step */
                    RefSetI = RSIA_stepI(win_it, histogram_msg);
                    if(RefSetI.size() < 5)
                        m_anomaly_code = NOT_ENOUGH_EL_IN_REF_SET;
                    else
                    {
                        /* II step */
                        RefSetII = RSIA_stepII(RefSetI);

                        vector<uint> keep_index;
                        vector< vector<double> > closest_dist;
                        vector<double> dist_vec;

                        /* III step */
                        RefSetIII = RSIA_stepIII(RefSetII, &keep_index, &closest_dist, &dist_vec);


                        /****************** ANOMALY TEST **********************/
                        /* TEST ENKLD */
                        ENKL_test(RefSetIII.size(), closest_dist, dist_vec, keep_index, &l_ENKLD_base, &u_ENKLD_base, &mean_ENKLD_base, &ENKLD_current);
                    }
                }

                /* Update the window entry only if the current PDF has been
                 * declared not anomalous */
                if(m_anomaly_code == NOT_ANOMALOUS)
                    update_window_entry(win_it, histogram_msg, false);

                /* In whatever anomaly case we send out the result message */
                send_result_message(histogram_msg, false,l_ENKLD_base, u_ENKLD_base, mean_ENKLD_base, ENKLD_current);

                /* In case of anomaly due to Not enough elements in the Reference
                 * Set or due to not passing the ENKLD test, we have to generate
                 * and send out also the anomal_message*/
                if((m_anomaly_code == NOT_ENOUGH_EL_IN_REF_SET) || (m_anomaly_code == ANOMALOUS))
                    send_anomal_message(histogram_msg, &RefSetIII);
            }

            m_curr_PDF.clear();
            m_curr_CCDF.clear();
        }

    };
    REGISTER_BLOCK(ADTest,"ADTest");

}

