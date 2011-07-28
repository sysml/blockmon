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

#ifndef __FIVE_TUPLE_H__
#define __FIVE_TUPLE_H__

#include<Buffer.hpp>

#include<linux/if_ether.h>
#include<linux/ip.h>
#include<linux/udp.h>
#include<netinet/tcp.h>
#include<arpa/inet.h>
#include<stdint.h>

struct five_tuple
{
    uint32_t d_ip;
    uint32_t s_ip;
    uint16_t d_port;
    uint16_t s_port;
    uint16_t proto;
    five_tuple():
    d_ip(0),
    s_ip(0),
    d_port(0),
    s_port(0),
    proto(0)
    {}

};       

static void parse_buffer(const bm::const_buffer<char> & buff, five_tuple& tup)
{
    int len_left=buff.len()-sizeof(ethhdr);
    if(len_left<0)
        return;

    const ethhdr* eth=(const ethhdr*) buff.addr();
    const iphdr* ip;
    if(eth->h_proto==ETH_P_IP)
    {
        ip=(const iphdr*)(eth+1);
    }
    else if (eth->h_proto==ETH_P_8021Q)
    {
        len_left-=4;
        if(len_left<0)
            return;

        ip=(const iphdr*)((const char*)(eth+1)+4);//skip vlan tag
    }
    else
        return;
    len_left-=sizeof(iphdr);
    if(len_left<0)
        return;

    tup.d_ip=ntohl(ip->daddr);
    tup.s_ip=ntohl(ip->saddr);
    tup.proto=htons(ip->protocol);
    if(tup.proto==6)//tcp
    {
        len_left-=sizeof(tcphdr);
        if(len_left<0)
            return;
        const tcphdr* tcp=(const tcphdr*) (ip+1);
        tup.s_port=ntohs(tcp->source);
        tup.d_port=ntohs(tcp->dest);
    }
    else if(tup.proto==17)//udp
    {
        len_left-=sizeof(udphdr);
        if(len_left<0)
            return;
        const udphdr* udp=(const udphdr*) (ip+1);
        tup.s_port=ntohs(udp->source);
        tup.d_port=ntohs(udp->dest);
    }
}
#endif
