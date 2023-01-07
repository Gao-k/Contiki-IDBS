#include "contiki.h"
#include "contiki-lib.h"
#include "contiki-net.h"
#include "lib/random.h"
#include "sys/ctimer.h"
#include "net/ip/uip.h"
#include "net/rpl/rpl.h"
#include "net/ipv6/uip-ds6.h"
#include "net/ip/uip-udp-packet.h"
#include "net/rime/rime.h"
#include "net/rpl/rpl-private.h"
#include "net/netstack.h"
// #include "getentropy.c"

#include <stdio.h>
#include <string.h>

#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"

static uip_ipaddr_t broadcast_ipaddr;
static uip_ipaddr_t local_ipaddr;

#define UIP_IP_BUF       ((struct uip_ip_hdr *)&uip_buf[UIP_LLH_LEN])
#define UIP_ICMP_BUF ((struct uip_icmp_hdr *)&uip_buf[uip_l2_l3_hdr_len])

PROCESS(sniffer_process,"sniffer process");
AUTOSTART_PROCESSES(&sniffer_process);
//
static void input_packet(void)
{
    
    if(UIP_IP_BUF->proto == UIP_PROTO_ICMP6){
        PRINT6ADDR(&UIP_IP_BUF->srcipaddr);
        printf(",");
        PRINT6ADDR(&UIP_IP_BUF->destipaddr);
        printf(",");
        if(UIP_ICMP_BUF->icode == 0){
            printf("DIS");
        }else if(UIP_ICMP_BUF->icode == 1){
            printf("DIO");
        }else if(UIP_ICMP_BUF->icode == 2){
            printf("DAO");
        }
    }else{
        PRINT6ADDR(&UIP_IP_BUF->srcipaddr);
        printf(",");
        PRINT6ADDR(&UIP_IP_BUF->destipaddr);
        printf(",");
        printf("UDP");
    }
}
static void output_packet(void)
{
}
RIME_SNIFFER(packet_sniffer, input_packet, output_packet);
/*---------------------------------------------------------------------------*/

PROCESS_THREAD(sniffer_process, ev, data)
{
    PROCESS_BEGIN();
    
    /*Entering promiscuous mode so that the radio accepts all frames*/
    radio_value_t radio_rx_mode;
    NETSTACK_RADIO.get_value(RADIO_PARAM_RX_MODE, &radio_rx_mode);
    NETSTACK_RADIO.set_value(RADIO_PARAM_RX_MODE, radio_rx_mode & (~RADIO_RX_MODE_ADDRESS_FILTER));

    rime_sniffer_add(&packet_sniffer);


    PROCESS_END();
}