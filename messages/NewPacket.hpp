/* Copyright (c) 2011, Consorzio Nazionale Interuniversitario 
 * per le Telecomunicazioni. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the name of Interuniversitario per le Telecomunicazioni nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
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

#ifndef _MESSAGES_NEWPACKET_HPP_
#define _MESSAGES_NEWPACKET_HPP_

#include <dissectors/packet.hpp>
#include <dissectors/dissector.hpp>

#include <SliceAllocator.hpp>

#include "Msg.hpp"
#include "ClassId.hpp"
#include "NetTypes.hpp"

#if defined(USE_SIMPLE_PACKET) || defined(USE_SLICED_PACKET)

namespace blockmon { 

    class NewPacket : public Msg
    {
    public:

        /** Runt packet missing full layer 2 header */
        static const uint16_t  kPktTypeRuntL2 = 0xFFF2;
        
        /** Runt IP packet missing full layer 3 header */
        static const uint16_t  kPktTypeRuntL3 = 0xFFF3;
        
        /** Runt IP packet missing full layer 4 header */
        static const uint16_t  kPktTypeRuntL4 = 0xFFF4;
        
        /** IPv4 packet */
        static const uint16_t  kPktTypeIP4 = 0x0800;
        
        /** 802.1q packet; temporary packet type used during MAC parsing */        
        static const uint16_t  kPktType1q  = 0x8100;
        
        /** IPv6 packet. Not yet supported. */
        static const uint16_t  kPktTypeIP6 = 0x86FF;

        static const uint8_t   kUDP = 17;
        static const uint8_t   kTCP = 6;

        static const uint8_t   kFIN = 0x01;
        static const uint8_t   kSYN = 0x02;
        static const uint8_t   kRST = 0x04;
        static const uint8_t   kPSH = 0x08;
        static const uint8_t   kACK = 0x10;
        static const uint8_t   kURG = 0x20;
        static const uint8_t   kECE = 0x40;
        static const uint8_t   kCWR = 0x80;

    public:

        NewPacket(uint16_t len, uint16_t caplen, uint32_t sec, uint32_t nsec, 
                  int msg_id = 0)
        : Msg(msg_id ? msg_id : MSG_ID(NewPacket))
        , slice_()
        , len_(len)
        , caplen_(caplen)
        , sec_(sec)
        , nsec_(nsec)
        #if !defined(USE_PACKET_FLOW)
        , flow_key_()
        #endif
        {}

        /** Forbids copy and move constructors.
	    */
        NewPacket(NewPacket const &other) = delete;

        /** Forbids copy and move assignment.
	    */
        NewPacket& operator=(NewPacket const &other) = delete;

    public:

        //////////////////////////////////////////////////////////
        // constructors...
        //

        template <typename ...Ts>
        static std::shared_ptr<NewPacket>
        SimplePacket(const_buffer<uint8_t> raw_packet, 
                     blockmon::slice_allocator<NewPacket, 
                                               #ifdef USE_PACKET_TAG
                                               net::TagBuffer, 
                                               #endif
                                               #ifdef USE_PACKET_FLOW
                                               blockmon::FlowKey,
                                               #endif
                                               net::payload> &alloc,
                     Ts&& ...args) // arguments passed to the NewPacket ctor: len, caplen, sec, nsec
        {
            // Note that slice_allocator does not perform value-initialization (only default-initialization). 
            // -> scalar types are not zero-initialized!
            
            auto slice = alloc.new_slice(std::forward<Ts>(args)...);

            auto this_packet = get<NewPacket>(slice);

            // setup the slice for this packet:
            //
            
            this_packet->slice_ = std::make_tuple(
                                                  #ifdef USE_PACKET_TAG
                                                  get<net::TagBuffer>(slice),
                                                  #endif
                                                  #ifdef USE_PACKET_FLOW
                                                  get<blockmon::FlowKey>(slice),
                                                  #endif
                                                  reinterpret_cast<net::ethernet *>(get<net::payload>(slice)),
                                                  undefinedptr,
                                                  undefinedptr,
                                                  undefinedptr,
                                                  undefinedptr,
                                                  undefinedptr);
            
#ifdef USE_PACKET_TAG
            // reset TagBuffer
            //
            memset(get<net::TagBuffer>(slice), 0, sizeof(net::TagBuffer));
            
            // setup the tagbuffer 
            //
            
            this_packet->set_tagbuf(mutable_buffer<char>(&get<net::TagBuffer>(slice)->front(), 
                                                          get<net::TagBuffer>(slice)->size()), 
                                    false);
#endif

            // copy the content of the packet...
            //

            memcpy(get<net::payload>(slice),
                   raw_packet.addr(),
                   std::min(net::payload::size_of(), raw_packet.len())
                   );

            // return a shared_ptr to the NewPacket
            //

            return alloc.bind_shared(this_packet);
        }

        //////////////////////////////////////////////////////////

        template <typename ...Ts>
        static std::shared_ptr<NewPacket>
        SlicedPacket(const_buffer<uint8_t> raw_packet,
                     blockmon::slice_allocator<NewPacket,
                                             #ifdef USE_PACKET_TAG
                                             net::TagBuffer,
                                             #endif
                                             #ifdef USE_PACKET_FLOW
                                             blockmon::FlowKey,
                                             #endif
                                             net::ethernet,
                                             net::ipv4,
                                             net::tcp,
                                             net::udp,
                                             net::icmp,
                                             net::payload> &alloc, Ts&& ... args) // : len, caplen, sec, nsec
        {
            // Note: slice_allocator does not perform value-initialization (only default-initialization). 
            // -> scalar types are not zero-initialized!
            
            auto slice = alloc.new_slice(std::forward<Ts>(args)...);

            auto this_packet = get<NewPacket>(slice);

            // parse the packet:
            //

            blockmon::slice<const net::ethernet,
                            const net::ipv4,
                            const net::tcp,
                            const net::udp,
                            const net::icmp,
                            const net::payload> parser { std::make_tuple(reinterpret_cast<const net::ethernet *>(raw_packet.addr()),
                                                         undefinedptr,
                                                         undefinedptr,
                                                         undefinedptr,
                                                         undefinedptr,
                                                         undefinedptr) };

#ifdef USE_PACKET_TAG
            // reset TagBuffer
            //
            
            memset(get<net::TagBuffer>(slice), 0, sizeof(net::TagBuffer));
            
            // setup the tagbuffer 
            //
            
            this_packet->set_tagbuf(mutable_buffer<char>(&get<net::TagBuffer>(slice)->front(), 
                                                          get<net::TagBuffer>(slice)->size()), 
                                    false);
#endif

            // setup the slice for this packet:
            //
            
            auto len = std::min(net::payload::size_of(), raw_packet.len());

            // copy the headers in the corresponding slices
            //
            
            if (len && net::get_header<const net::ethernet>(parser)) 
            {
                auto this_len = net::get_header<const net::ethernet>(parser)->size_of();
                if (len >= this_len) {
                    len -= this_len;  
                    memcpy(get<net::ethernet>(slice), net::get_header<const net::ethernet>(parser), this_len);
                }
                else len = 0;
            }
            else {
                get<net::ethernet>(slice) = NULL;
            }

            if (len && net::get_header<const net::ipv4>(parser)) 
            {
                auto this_len = net::get_header<const net::ipv4>(parser)->size_of();
                if (len >= this_len) {
                    len -= this_len;       
                    memcpy(get<net::ipv4>(slice), net::get_header<const net::ipv4>(parser), this_len);
                }
                else
                	len = 0;
            }
            else {
            	get<net::ipv4>(slice) = NULL;
            }

            if (len && net::get_header<const net::tcp>(parser)) 
            {
                auto this_len = net::get_header<const net::tcp>(parser)->size_of();
                if (len >= this_len) {
                    len -= this_len;
                    memcpy(get<net::tcp>(slice), net::get_header<const net::tcp>(parser), this_len); 
                }
                else
                	len = 0;
            }
            else {
            	get<net::tcp>(slice) = NULL;

                if (len && net::get_header<const net::udp>(parser)) 
                {
                    auto this_len = net::get_header<const net::udp>(parser)->size_of();
                    if (len >= this_len) {
                        len -= this_len;
                        memcpy(get<net::udp>(slice), net::get_header<const net::udp>(parser), this_len);
                    }
                    else len = 0;
                }
                else  {
                	get<net::udp>(slice) = NULL;
                    
                    if (len && net::get_header<const net::icmp>(parser)) 
                    {
                        auto this_len = net::get_header<const net::icmp>(parser)->size_of();
                        if (len >= this_len) 
                        {
                            len -= this_len;
                            memcpy(get<net::icmp>(slice), net::get_header<const net::icmp>(parser), this_len); 
                        }
                        else len = 0;
                    }  
                    else { get<net::icmp>(slice) = NULL;
                    }
                }
            }

            if (len && net::get_header<const net::payload>(parser))
            {
                memcpy(get<net::payload>(slice), net::get_header<const net::payload>(parser), len); 
            }                                                
            else
            {
                get<net::payload>(slice) = NULL;
            }                                                

            // save the slice in the current packet..
            //
            this_packet->slice_ = std::make_tuple( 
                                                  #ifdef USE_PACKET_TAG
                                                  get<net::TagBuffer>(slice),
                                                  #endif
                                                  #ifdef USE_PACKET_FLOW
                                                  get<blockmon::FlowKey>(slice),
                                                  #endif
                                                  get<net::ethernet>(slice),
                                                  get<net::ipv4>(slice),
                                                  get<net::tcp>(slice),
                                                  get<net::udp>(slice),
                                                  get<net::icmp>(slice),
                                                  get<net::payload>(slice));
            

            return alloc.bind_shared(this_packet);
        }
        
        //////////////////////////////////////////////////////////
        // clone!
        
        std::shared_ptr<Msg> clone() const 
        {
            throw std::runtime_error(std::string(__PRETTY_FUNCTION__ ).append(": not implemented"));
        }

        //////////////////////////////////////////////////////////
        // headers' accessors
        //

        template <typename Tp>
        Tp * get_header() 
        {
            return net::get_header<Tp>(slice_);
        }
        template <typename Tp>
        Tp const * get_header() const
        {
            return net::get_header<Tp>(slice_);
        }

        const void *iphdr() const 
        {
            return net::get_header<net::ipv4>(slice_);
        }
        
        const void *l4hdr() const 
        {
            auto udp = net::get_header<net::udp>(slice_);
            if (udp) {
                return udp;
            }                
            return net::get_header<net::tcp>(slice_);
        }
        
        const uint8_t *payload() const 
        {
            return reinterpret_cast<const uint8_t *>(net::get_header<net::payload>(slice_));
        }

        
        uint16_t payload_len() const
        {
            auto eth = net::get_header<net::ethernet>(slice_);
            auto ip  = net::get_header<net::ipv4>(slice_);
            auto udp = net::get_header<net::udp>(slice_);
            auto tcp = net::get_header<net::tcp>(slice_);
            auto icmp = net::get_header<net::icmp>(slice_);
            if(eth->proto()==kPktTypeIP4){
            	if(is_tcp())
            		return ip->tot_len_() - ip->size_of() - tcp->size_of();

            	if(is_udp())
            		return ip->tot_len_() - ip->size_of() - udp->size_of();

            	if(is_icmp())
            		return ip->tot_len_() - ip->size_of() - icmp->size_of();

            }

            return 0;
//            return caplen_ -
//                (eth  ? eth->size_of(): 0) -
//                ( ip  ? ip->size_of() : 0) -
//                (udp  ? udp->size_of() : 0) -
//                (tcp  ? tcp->size_of() : 0) -
//                (icmp ? icmp->size_of() : 0);
        }

        //////////////////////////////////////////////////////////
        // accessors 
        //

        uint16_t length() const
        {
            return len_;
        }

        uint16_t caplen() const
        {
            return caplen_;
        }

        struct timespec
        timestamp() const
        {
            return { sec_, nsec_ }; 
        }
        
        uint32_t timestamp_s() const {
            return sec_;
        }

        uint64_t timestamp_ms() const {
            return static_cast<uint64_t>(sec_)  * 1000 +
                   static_cast<uint64_t>(nsec_) / 1000000;
        }

        uint64_t timestamp_us() const {
            return static_cast<uint64_t>(sec_)  * 1000000 +
                   static_cast<uint64_t>(nsec_) / 1000;
        }
        
        uint16_t l3_protocol() const
        {
            return net::get_header<net::ethernet>(slice_)->ether_type_();
        }

        uint8_t l4_protocol() const 
        {
            return net::get_header<net::ipv4>(slice_)->protocol_();
        }

        ////////////////////////////////////////////////////////////
        
        // Not yet implemented or unused...
        //

        const uint8_t *base() const = delete;
        
        int mac_type() const = delete;
	
        uint8_t tcp_flags() const = delete;

        
        ////////////////////////////////////////////////////////////
        // IPv4
        //

        uint8_t ip_tos() const 
        {
            return net::get_header<net::ipv4>(slice_)->tos_();
        }

        uint8_t  ip_ttl() const 
        {
            return net::get_header<net::ipv4>(slice_)->ttl_();
        }
       
        uint32_t ip_src() const 
        {
            return net::get_header<net::ipv4>(slice_)->saddr;
        }

        uint32_t ip_dst() const 
        {
            return net::get_header<net::ipv4>(slice_)->daddr;
        }

        uint16_t ip_length() const 
        {
            return net::get_header<net::ipv4>(slice_)->tot_len_();
        }

        uint8_t ip_header_length() const
        {
            return net::get_header<net::ipv4>(slice_)->ihl_() << 2;
        }

        std::string
        ip_src_str() const
        {
            return net::get_header<net::ipv4>(slice_)->saddr_();
        }

        std::string
        ip_dst_str() const
        {
            return net::get_header<net::ipv4>(slice_)->daddr_();
        }

        ////////////////////////////////////////////////////////////
        // TCP
        //
        
        uint8_t tcp_header_length() const 
        {
            return net::get_header<net::tcp>(slice_)->doff_() << 2;
        }

        bool tcp_has_syn() const 
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->syn_() != 0);
        }
        
        bool tcp_has_ack() const 
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->ack_() != 0);
        }

        bool tcp_has_fin() const
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->fin_() != 0);
        }

        bool tcp_has_rst() const 
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->rst_() != 0);
        }

        bool tcp_has_psh() const
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->psh_() != 0);
        }

        bool tcp_has_urg() const
        {
            return is_tcp() && (net::get_header<net::tcp>(slice_)->urg_() != 0);
        }

        uint32_t tcp_seq() const 
        {
            return net::get_header<net::tcp>(slice_)->seq_();
        }

        uint32_t tcp_win() const
        {
            return net::get_header<net::tcp>(slice_)->window_();
        }

        bool tcp_ack(uint32_t& tcpack) const
        {
            auto tcp = net::get_header<net::tcp>(slice_);
            if (!tcp->ack_())
                return false;
            tcpack = tcp->ack_seq_();
            return true;
        }

        bool tcp_urg(uint8_t& tcpurg) const
        {
            auto tcp = net::get_header<net::tcp>(slice_);
            if (!tcp->urg_())
                return false;
            tcpurg = tcp->urg_ptr_();
            return true;
        }

        //////////////////////////////////////////////////////////////


        const FlowKey &key() const
        {
#if !defined(USE_PACKET_FLOW)
            if (!flow_key_) {
                flow_key_.src_ip4  = this->ip_src();
                flow_key_.dst_ip4  = this->ip_dst();
                flow_key_.src_port = this->src_port();
                flow_key_.dst_port = this->dst_port();
                flow_key_.proto    = this->l4_protocol();
            }
        
            return flow_key_;
#else
            if (!*net::get_header<blockmon::FlowKey>(slice_))
            {
                auto key = net::get_header<blockmon::FlowKey>(slice_);
                key->src_ip4  = this->ip_src();
                key->dst_ip4  = this->ip_dst();
                key->src_port = this->src_port();
                key->dst_port = this->dst_port();
                key->proto    = this->l4_protocol();
            }

            return *net::get_header<blockmon::FlowKey>(slice_);
#endif
        }   

        uint16_t udp_length() const
        {
            return net::get_header<net::udp>(slice_)->len_();
        }
        
        //////////////////////////////////////////////////////////
        // L3 predicates
        //

        template <uint16_t PROTO>
        bool is_ip_protocol() const
        {
            return net::get_header<net::ipv4>(slice_)->protocol_() == PROTO;
        }

        bool is_tcp() const 
        {
            if(l3_protocol()!=kPktTypeIP4)
            	return false;
            return net::get_header<net::ipv4>(slice_)->protocol_() == IPPROTO_TCP;
        }

        bool is_udp() const 
        {
        	if(l3_protocol()!=kPktTypeIP4)
        		return false;
            return net::get_header<net::ipv4>(slice_)->protocol_() == IPPROTO_UDP;
        }
        
        bool is_icmp() const
        {
            return net::get_header<net::ipv4>(slice_)->protocol_() == IPPROTO_ICMP;
        }

        //////////////////////////////////////////////////////////
        // udp/tcp ports accessors...
        //
        
        uint16_t src_port() const
        {
            if (is_udp())
                return net::get_header<net::udp>(slice_)->source_();
            if (is_tcp())
            	return net::get_header<net::tcp>(slice_)->source_();
                    throw std::runtime_error("NewPacket::src_port");
        }

        uint16_t dst_port() const
        {
        	if (is_udp())
				return net::get_header<net::udp>(slice_)->dest_();
			if (is_tcp())
				return net::get_header<net::tcp>(slice_)->dest_();
                    throw std::runtime_error("NewPacket::dst_port");
        }

        
        void dump_slice() const
        {
            std::cout << "slice ---\n";
            std::cout << "* eth : " << (void *)blockmon::get<0>(slice_) << std::endl;
            std::cout << "*  ip : " << (void *)blockmon::get<1>(slice_) << std::endl;
            std::cout << "* tcp : " << (void *)blockmon::get<2>(slice_) << std::endl;
            std::cout << "* udp : " << (void *)blockmon::get<3>(slice_) << std::endl;
            std::cout << "* icmp: " << (void *)blockmon::get<4>(slice_) << std::endl;
            std::cout << "* payl: " << (void *)blockmon::get<5>(slice_) << std::endl;
            std::cout << "* caplen: " << this->caplen_ << std::endl;
            std::cout << "* len: " << this->len_ << std::endl;
        }

    private:
        mutable net::packet_slice slice_;
        
        uint16_t              len_;
        uint16_t              caplen_;

        uint32_t              sec_;
        uint32_t              nsec_;

#if !defined(USE_PACKET_FLOW)        
        mutable FlowKey       flow_key_;
#endif

   };
    
    typedef NewPacket Packet;

} // namespace blockmon

#endif

#endif // _MESSAGES_NEWPACKET_HPP_
