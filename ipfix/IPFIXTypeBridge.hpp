/* Copyright (c) 2011-2012 ETH Zürich. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of ETH Zürich nor the names of other contributors 
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
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY 
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * @file
 *
 * Defines the IPFIXTypeBridge interface, which is implemented by type bridges.
 * A type bridge knows about a set of Msg subclasses, and a set of Templates,
 * and uses the libfc cursor interface to read and write Msgs. Used by
 * the IPFIXSource and IPFIXExporter blocks.
 * 
 * @author Brian Trammell <trammell@tik.ee.ethz.ch>
 * @author Stephan Neuhaus <neuhaust@tik.ee.ethz.ch>
 */

#ifndef IPFIXTYPEBRIDGE_H
#define IPFIXTYPEBRIDGE_H

#include <vector>

// Blockmon includes
#include "Block.hpp"
#include "Msg.hpp"

// IPFIX includes
#include "Collector.h"
#include "Exporter.h"
#include "InfoElement.h"
#include "RecordReceiver.h"
#include "MatchTemplate.h"

namespace blockmon {

/**
 * Interface for IPFIX Type Bridges. 
 *
 * A Type Bridge handles export and collection of a Msg type or a set
 * of related Msg types via the libfc IPFIX random-access (record)
 * interface. Implement a bridge by implementing the canExport(),
 * prepareExporter(), exportMsg(), prepareCollector(), and
 * receiveRecord() (from IPFIX::RecordReceiver) methods.
 *
 * @section HOW TO IMPORT/EXPORT YOUR MSG VIA IPFIX
 *
 * So you've written a Msg type and you want to import or export it
 * via IPFIX, hm? OK, here are step-by-step instructions on how to get
 * this to work.
 *
 * Your Msg will likely contain a number of data members that you wish
 * to import or export.  For illustration purposes, we will assume
 * that they are called "sourceIPv4Address", "payloadBuffer", and
 * "domainName", and that they have the respective C++ types uint32_t,
 * uint8_t*, and std::string.  In other words:
 *
 * @code
 * class MyMsg : public Msg {
 * private:
 *   uint32_t sourceIpv4Address;
 *   uint8_t* payloadBuffer;
 *   size_t buffer_size;
 *   std::string domainName;
 *
 * public:
 *   MyMsg(uint32 sourceIPv4Address,
 *         uint8_t* payloadBuffer, size_t buffer_size,
 *         std::string&  domainName);
 *
 *   uint32_t getSourceIPv4Address() const;
 *   const uint8_t* getPayloadBuffer() const;
 *   size_t getPayloadBufferSize() const;
 *   const std::string& getDomainName() const;
 *
 *   void setSourceIPv4Address(uint32_t);
 *   void setPayloadBuffer(const uint8_t*, size_t);
 *   void setDomainName(const std::string&);

 *   ...
 * };
 * @endcode
 *
 * For import and export, you need a data structure that bridges
 * between your implementation and IPFIX.  You need an IPFIX type
 * bridge. The first order of the day is therefore to write a skeleton
 * for your bridge:
 *
 * @code
 * #ifndef _IPFIXMYBRIDGE_H_
 * #  define _IPFIXMYBRIDGE_H_
 *
 * #  include "IPFIXTypeBridge.hpp"
 * #  include "IPFIXTypeRegistry.hpp"
 * #  include <MatchTemplate.h>
 * #  include <InfoElement.h>
 *
 * namespace blockmon {
 *   class IPFIXMyBridge : public IPFIXTypeBridge {
 *     IPFIX::MatchTemplate m_my_mtmpl;
 * 
 *   public:
 *     IPFIXMyBridge();
 *
 *     void prepareExporter(IPFIX::Exporter& e) {
 *       defaultPrepareExporter(e);
 *     }
 *
 *     bool canExport (std::shared_ptr<const Msg>& m);
 *       
 *     void exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e);
 *       
 *     void prepareCollector(IPFIX::Collector& c, OutGate& g) {
 *       defaultPrepareCollector(c, g);
 *     }
 *
 *     void receiveRecord();
 *   };
 * } // namespace blockmon
 *
 * #endif // _IPFIXMYBRIDGE_H_
 * @endcode
 *
 * Put that in ipfix/IPFIXMyBridge.hpp. Now it's time to
 * implement these member functions. So open up your editor on
 * ipfix/IPFIXMyBridge.cpp. and start with this skeleton:
 *
 * @code
 * #include "IPFIXMyBridge.hpp"
 * #include "MyMsg.hpp"
 *
 * namespace blockmon {
 * } // namespace blockmon
 * @endcode
 *
 * First, we tackle the constructor. The constructor must do three
 * things: (1) initialise the base class, IPFIXTypeBridge, (2)
 * initialise member variables, and (3) find (and possibly install)
 * the correct Information Elements in the Information Model.
 * 
 * The base class is initialised by passing the name of the Msg type
 * to the base class.  The only member variable in the skeleton is
 * m_my_mtmpl, which needs no initialisation (the default
 * constructor is called by, erm, default).  That leaves the
 * Information Elements (IEs).
 *
 * If the IEs are already present in the information model (for
 * example if the IE name is "sourceIPv4Address" and the
 * InfoModel::instance() has been initialised with defaultIPFIX()), it
 * is enough to give the name; otherwise an IE specification must be
 * given.  Luckily that is pretty easy to do. In our example, we have
 * "sourceIPv4Address", which is already known, and "payloadBuffer",
 * and "domainName", which are not. So your constructor could look
 * like this:
 *
 * @code
 * IPFIXMyBridge::IPFIXMyBridge()
 *     : IPFIXTypeBridge("my") {
 *   declareIEVec("sourceIPv4Address",
 *                "payloadBuffer(35501/101)<octetArray>[v]",
 *                "domainName(35501/103)<octetArray>[v]",
 *                (const char*)0);
 * }
 * @endcode
 *
 * (This is not a tutorial on how to write IE specs. If you don't know
 * what these specifications above mean, please consult 
 * draft-ietf-ipfix-ie-doctors)
 *
 * Next we need to tell the exporter if we can export a certain
 * Msg. In this case, that's easy, since we can only export MyMsg's:
 *
 * @code
 * bool IPFIXMyBridge::canExport (std::shared_ptr<const Msg>& m) {
 *   return m->type() == MSG_ID(MyMsg);
 * }
 * @endcode
 *
 * Next, we need to export the Msg to IPFIX.  That's pretty easy too,
 * we just tell the IPFIXTypeBridge which IE has what value:
 *
 * @code
 * void IPFIXMyBridge::exportMsg(std::shared_ptr<const Msg>& m,
 *                               IPFIX::Exporter& e) {
 *    std::shared_ptr<const MyMsg> msg
 *      = std::dynamic_pointer_cast<const MyMsg>(m);
 *
 *    e.setTemplate(m_tid);
 *    e.beginRecord();
 *    e.reserveVarlen(m_ievec[1], msg->getPayloadBufferSize());
 *    e.reserveVarlen(m_ievec[2], msg->getDomainName().length());
 *    e.commitVarlen();
 *    e.putValue(m_ievec[0], static_cast<uint32_t>(msg->getSourceIPv4Address());
 *    e.putValue(m_ievec[1], msg->getPayloadBuffer(),
 *               msg->getPayloadBufferSize())
 *    e.putValue(m_ievec[2], msg->getDomainName());
 *    e.exportRecord();
 * }
 * @endcode
 *
 * All variable-length Information Elements must have their values reserved
 * and committed before any values are put in the record, so that the
 * exporter knows the offset to each information element and can flush
 * any buffers beforehand that would be overflowed by the export.
 * 
 * Now, let's go into the opposite direction, importing a value from
 * IPFIX:
 *
 * @code
 * void IPFIXMyBridge::receiveRecord() {
 *   uint32_t sourceIPv4Address;
 *   uint32_t bufferSize;
 *   uint8_t* buffer;
 *   std::string domainName;
 *
 *   assert(getValue(m_ievec[0], sourceIPv4Address));
 *   assert(getValue(m_ievec[1], bufferSize));
 *
 *   buffer = new uint8_t[bufferSize];
 *
 *   assert(getValue(m_ievec[2], buffer, bufferSize));
 *   assert(getValue(m_ievec[3], domainName);
 *
 *   std::shared_ptr<MyMsg> m =
 *     std::make_shared<MyMsg>(sourceIPv4Address,
 *                             buffer, bufferSize,
 *                             domainName);
 *   sendMsg(std::move(m));
 * }
 * @endcode
 *
 * The getValue() function returns true or false, depending on
 * whether the IE was found in the current IPFIX record.  You can use
 * this to extract optional fields from an IPFIX record.
 *
 * And that's it! See, it wasn't so bad, was it?
 */

    class IPFIXTypeBridge : public IPFIX::RecordReceiver {

    private:

        std::string m_type_name;
        OutGate* m_gate;

        bool declareIEVec(
                std::vector<const IPFIX::InfoElement*>& v,
                const char* spec1,
                va_list args);

    protected:
        std::vector<const IPFIX::InfoElement*>  m_ievec;
        uint16_t                                m_tid;
        IPFIX::MatchTemplate                    m_mtmpl;

        IPFIXTypeBridge(const std::string& type_name):
            m_type_name(type_name),
            m_gate(NULL),
            m_tid(0) {}

        void setGate(OutGate& g) {
            m_gate = &g;
        }

        void sendMsg(std::shared_ptr<const Msg>&& m) const {
            if (m_gate) m_gate->deliver(std::move(m));
        }

        /**
         * Variadic function taking a list of partial or full
         * IE specifiers. Information elements not already in the model
         * will be added (assuming a full specifier is present). The resulting
         * cached IE pointers can be accessed through m_ievec. Should be 
         * called in derived member constructors if used, and the return value
         * checked.
         *
         * @return false if an IE lookup or model addition failed
         */

        bool declareIEVec(const char* spec1, ...);

        /**
         * Variadic function taking a list of partial or full
         * IE specifiers. Information elements not already in the model
         * will be added (assuming a full specifier is present). Caches IE 
         * pointers in the supplied vector; used when a bridge needs
         * multiple IE vectors (i.e., for multiple templates). Should be 
         * called in derived member constructors if used, and the return value
         * checked.
         *
         * @return false if an IE lookup or model addition failed
         */

        bool declareIEVec(std::vector<const IPFIX::InfoElement*>& v,
                          const char* spec1, ...);

        /**
        * The default implementation of exporter preparation, creates a 
        * single template using all the InfoElements in m_ievec 
        * (declared by declareIEVec in the constructor) in order, and 
        * stores the ID of this template in m_tid. Call from prepareExporter
        * unless the bridge requires multiple templates.
        * 
        * @param e exporter to prepare
        */
        void defaultPrepareExporter(IPFIX::Exporter& e);

        /**
        * The default implementation of collector preperation, registers 
        * the bridge as receiver for a match template, stored in m_mtmpl,
        * using all the InfoElements in m_ievec 
        * (declared by declareIEVec() in the constructor). Call from
        * prepareCollector() unless the bridge requires alternation (multiple
        * match templates) or other custom preparation. Bridges supporting
        * optional values can use the three-argument form of 
        * defaultPrepareCollector() instead.
        * 
        * @param c collector to prepare
        * @param g gate through which messages will be sent
        */
        void defaultPrepareCollector(IPFIX::Collector& c, OutGate& g);

       /**
        * The default implementation of collector preperation, registers 
        * the bridge as receiver for a match template, stored in m_mtmpl,
        * using the InfoElements in m_ievec listed in match_indices. Call from
        * prepareCollector() unless the bridge requires alternation (multiple
        * match templates) or other custom preparation. Bridges supporting
        * optional values can use the three-argument form of 
        * defaultPrepareCollector() instead.
        * 
        * @param c collector to prepare
        * @param g gate through which messages will be sent
        * @param match_indices indices into m_ievec which must be
        *                      present in received templates
        */
        void defaultPrepareCollector(IPFIX::Collector& c, OutGate& g,
                                     std::vector<int> match_indices);

    public:

        /**
         * Prepare an exporter to export records from this bridge,
         * by creating and registering WireTemplates for export.
         *
         * Must be implemented by subclasses, which can generally just
         * delegate this to defaultPrepareExporter().
         * 
         * @param e exporter to prepare
         */
         virtual void prepareExporter(IPFIX::Exporter& e) = 0;

        /**
        * Examine a Message to see if it can be exported using this Bridge.
        * This method generally examines the message's msg_type() to determine this.
        * 
        * @param m message to examine
        * @return true if the message can be exported by this bridge
        */

        virtual bool canExport (std::shared_ptr<const Msg>& m) = 0;

        /**
         * Export a message to a given exporter. This exporter will already
         * have been prepared by this bridge using prepareExporter(), and the
         * Message already checked using canExport(). Can use
         * either the exportStruct() or exportRecord() interfaces provided by
         * Exporter.
         * 
         * @param m message to export
         * @param e exporter to use
         */

        virtual void exportMsg(std::shared_ptr<const Msg>& m, IPFIX::Exporter& e) = 0;
        
        /**
         * Prepare a collector to receive records using this bridge,
         * by registering the bridge as a reciever for a minimal match
         * template and caching the gate through which blockmon::Msg
         * instances will be sent.
         *
         * Must be implemented by subclasses, which can generally just
         * delegate this to defaultPrepareCollector()).
         *
         * @param c collector to prepare
         * @param g gate through which messages will be sent
         */

        virtual void prepareCollector(IPFIX::Collector& c, OutGate& g) = 0;
        
        /**
         * Return the typename by which this bridge is known; this
         * matches the datatype name attribute in parameters for the
         * IPFIXExporter and IPFIXSource blocks, and is used by default
         * implementations as the template name for the template ID 
         * registry. The type name is set in the constructor.
         * 
         * @return type name.
         */
        const std::string& typeName() const {
            return m_type_name;
        }
    };

}

#endif
