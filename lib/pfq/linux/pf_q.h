

/***************************************************************
 *                                                
 * (C) 2011 - Nicola Bonelli <bonelli@cnit.it>   
 *
 ***************************************************************/

#ifndef _PF_Q_H_
#define _PF_Q_H_ 

#ifdef __KERNEL__

#ifdef __PFQ_MODULE__


#define Q_VERSION               "1.0.1"
#define Q_VERSION_NUM           0x010001

#define MAX_NUM_CPU             16
#define MAX_NUM_PFQ             64
#define MAX_NUM_DEVICE          256
#define MAX_NUM_DEVICE_MASK     (MAX_NUM_DEVICE-1)
#define MAX_NUM_HW_QUEUE        64
#define MAX_NUM_HW_QUEUE_MASK   (MAX_NUM_HW_QUEUE-1)


#else  /* __PFQ_MODULE__ */ 

#include <linux/skbuff.h>

extern const char * pfq_version(void);
extern int   pfq_awareness(void);
extern bool  pfq_poll(int index, int queue);
extern int   pfq_receive_skb(struct sk_buff *skb, int ifindex, int queue);

#endif

#else  /* user space */

#include <sys/time.h>
#include <unistd.h>
#include <stdint.h>

#endif /* __KERNEL__ */

/* Common header */

#define PF_Q                 27     /* packet q domain: note it's the same as the old pf_ring */

struct pfq_hdr
{
    uint16_t    caplen;     /* length of frame captured */    
    uint16_t    len;        /* length of the packet (off wire) */

    uint16_t    mark:15,    /* for classification */
                commit:1;   /* packet filled */

    uint8_t     if_index;   /* 256 devices */    
    uint8_t     hw_queue;   /* 256 queues per device */
    union 
    {
        unsigned long long tv64;
        struct {
            uint32_t    sec;
            uint32_t    nsec;
        } tv;           /* note: struct timespec is badly defined for 64 bits arch. */
    } tstamp;

} __attribute__((packed));


/* 
    [pfq_buff_descr][pfq_queue_descr][slot_size][slot_size][slot_size] ... [pfq_queue_descr][slot_size] ...
 */

struct pfq_buff_descr
{
    int     index;          /* active MP queue */

} __attribute__((aligned(64)));


struct pfq_queue_descr
{
    int     counter;        /* atomic_t */
    int     disable; 
};


/* set socket options */

#define SO_TOGGLE_QUEUE         100     /* enable = 1, disable = 0 */
#define SO_ADD_DEVICE           101
#define SO_ADD_WEAK_DEVICE      102
#define SO_REMOVE_DEVICE        103
#define SO_NUM_SLOTS            104
#define SO_TSTAMP_TYPE          105
#define SO_LOAD_BALANCE         106
#define SO_SLOT_SIZE            107
#define SO_SET_PIPELINE_LEN     108

/* get socket options */
#define SO_GET_ID               120
#define SO_GET_OWNERS           121
#define SO_GET_STATUS           122     /* 1 = enabled, 0 = disabled */
#define SO_GET_BATCH            123
#define SO_GET_STATS            124
#define SO_GET_TSTAMP_TYPE      125
#define SO_GET_TOT_MEM          126
#define SO_GET_NUM_SLOT         127
#define SO_GET_SLOT_SIZE        128
#define SO_GET_PIPELINE_LEN     129


/* struct used for setsockopt */

#define Q_ANY_DEVICE         -1
#define Q_ANY_QUEUE          -1
#define Q_ANY_FRAME          -1

#define Q_TSTAMP_TSC          0       /* default */
#define Q_TSTAMP_NANO         1

struct pfq_dev_queue
{
    long int if_index;
    int hw_queue;
};

struct pfq_stats
{
    unsigned long int recv;   // received by the queue    
    unsigned long int lost;   // queue is full, packet lost...
    unsigned long int drop;   // by filter
    unsigned long int read;   // read by user-space
};

#endif /* _PF_Q_H_ */
