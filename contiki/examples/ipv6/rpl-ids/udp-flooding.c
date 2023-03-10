/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the Institute nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * This file is part of the Contiki operating system.
 *
 */

#include "contiki.h"
#include "lib/random.h"
#include "sys/ctimer.h"
#include "net/ip/uip.h"
#include "net/rpl/rpl.h"
#include "net/ipv6/uip-ds6.h"
#include "net/ip/uip-udp-packet.h"
#include "net/rime/rime.h"
#include "sys/ctimer.h"
#ifdef WITH_COMPOWER
#include "powertrace.h"
#endif
#include <stdio.h>
#include <string.h>
#include "dev/button-sensor.h"

#define UDP_CLIENT_PORT 8765
#define UDP_SERVER_PORT 5678

#define UDP_EXAMPLE_ID 190

#define UIP_IP_BUF ((struct uip_ip_hdr *)&uip_buf[UIP_LLH_LEN])

#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"

#ifndef PERIOD
#define PERIOD 60
#endif

#define START_INTERVAL (15 * CLOCK_SECOND)
#define SEND_INTERVAL (PERIOD * CLOCK_SECOND)
#define SEND2_INTERVAL (30 * CLOCK_SECOND)
#define SEND_TIME (random_rand() % (SEND_INTERVAL))
#define MAX_PAYLOAD_LEN 30
#define COLLECT_INTERVAL (300 * CLOCK_SECOND)

static struct uip_udp_conn *client_conn;
static uip_ipaddr_t server_ipaddr;
extern int rank;
static int counter = 0; // counting rounds to activate attack
extern int Nudp;
extern int Nchild;
int flooding_flag;

int prevUDPRecv = 0;
int prevUDPSent = 0;
int UDPSent = 0;
int UDPRecv = 0;
int udpsent = 0;
int udprecv = 0;
int count = 0;
/*---------------------------------------------------------------------------*/
PROCESS(udp_client_process, "UDP client process");
AUTOSTART_PROCESSES(&udp_client_process);
/*---------------------------------------------------------------------------*/
static void
tcpip_handler(void)
{
    char *str;

    if (uip_newdata())
    {
        str = uip_appdata;
        str[uip_datalen()] = '\0';
        printf("DATA recv '%s'\n", str);
    }
}
/*---------------------------------------------------------------------------*/
static void
send_packet(void *ptr)
{
    static int seq_id;
    char buf[MAX_PAYLOAD_LEN];

    seq_id++;
    PRINTF("DATA send to %d 'Hello %d'\n",
           server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1], seq_id);
    sprintf(buf, "Hello %d from the client", seq_id);
    uip_udp_packet_sendto(client_conn, buf, strlen(buf),
                          &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
}
/*---------------------------------------------------------------------------*/
static void
send_flooding_packet(void *ptr)
{
    static int seq_id;
    char buf[MAX_PAYLOAD_LEN];

    seq_id++;
    PRINTF("DATA send to %d 'Hello %d'\n",
           server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1], seq_id);
    sprintf(buf, "Hello %d from the client", seq_id);
    int i;
    for(i=0;i<2;i++){
        uip_udp_packet_sendto(client_conn, buf, strlen(buf),
                            &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
    }
}
/*---------------------------------------------------------------------------*/
static void
print_local_addresses(void)
{
    int i;
    uint8_t state;

    PRINTF("Client IPv6 addresses: ");
    for (i = 0; i < UIP_DS6_ADDR_NB; i++)
    {
        state = uip_ds6_if.addr_list[i].state;
        if (uip_ds6_if.addr_list[i].isused &&
            (state == ADDR_TENTATIVE || state == ADDR_PREFERRED))
        {
            PRINT6ADDR(&uip_ds6_if.addr_list[i].ipaddr);
            PRINTF("\n");
            /* hack to make address "final" */
            if (state == ADDR_TENTATIVE)
            {
                uip_ds6_if.addr_list[i].state = ADDR_PREFERRED;
            }
        }
    }
}
/*---------------------------------------------------------------------------*/
static void
set_global_address(void)
{
    uip_ipaddr_t ipaddr;

    uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 0);
    uip_ds6_set_addr_iid(&ipaddr, &uip_lladdr);
    uip_ds6_addr_add(&ipaddr, 0, ADDR_AUTOCONF);

    /* The choice of server address determines its 6LoPAN header compression.
     * (Our address will be compressed Mode 3 since it is derived from our link-local address)
     * Obviously the choice made here must also be selected in udp-server.c.
     *
     * For correct Wireshark decoding using a sniffer, add the /64 prefix to the 6LowPAN protocol preferences,
     * e.g. set Context 0 to aaaa::.  At present Wireshark copies Context/128 and then overwrites it.
     * (Setting Context 0 to aaaa::1111:2222:3333:4444 will report a 16 bit compressed address of aaaa::1111:22ff:fe33:xxxx)
     *
     * Note the IPCMV6 checksum verification depends on the correct uncompressed addresses.
     */

#if 0
/* Mode 1 - 64 bits inline */
   uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 1);
#elif 1
    /* Mode 2 - 16 bits inline */
    uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0, 0x00ff, 0xfe00, 1);
#else
    /* Mode 3 - derived from server link-local (MAC) address */
    uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0x0250, 0xc2ff, 0xfea8, 0xcd1a); // redbee-econotag
#endif
}
/*---------------------------------------------------------------------------*/
// N is the number of node(11)
static int Count[11] = {0};
static int preCount[11] = {0};
static int Child[11] = {0};
static void input_packet(void)
{
    // int len = packetbuf_totlen();
    // printf("receive:%d,%d\n",len,UIP_IP_BUF->proto);
    if (UIP_IP_BUF->proto == UIP_PROTO_ICMP6)
    {
    }
    else
    {
        UDPRecv++;
        int id = UIP_IP_BUF->srcipaddr.u8[sizeof(uip_ipaddr_t) - 1];
        Count[id]++;
    }
}
static void output_packet(void)
{
    // int len = packetbuf_totlen();
    // printf("send:%d,%d\n",len,UIP_IP_BUF->proto);
    if (UIP_IP_BUF->proto == UIP_PROTO_ICMP6)
    {
    }
    else
    {
        UDPSent++;
    }
}
RIME_SNIFFER(packet_sniffer, input_packet, output_packet);
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(udp_client_process, ev, data)
{
    static struct etimer periodic;
    static struct ctimer backoff_timer;
    static struct etimer timeslot;

#if WITH_COMPOWER
    static int print = 0;
#endif

    PROCESS_BEGIN();

    PROCESS_PAUSE();

    set_global_address();

    PRINTF("UDP client process started\n");

    print_local_addresses();

    /* new connection with remote host */
    client_conn = udp_new(NULL, UIP_HTONS(UDP_SERVER_PORT), NULL);
    if (client_conn == NULL)
    {
        PRINTF("No UDP connection available, exiting the process!\n");
        PROCESS_EXIT();
    }
    udp_bind(client_conn, UIP_HTONS(UDP_CLIENT_PORT));

    PRINTF("Created a connection with the server ");
    PRINT6ADDR(&client_conn->ripaddr);
    PRINTF(" local/remote port %u/%u\n",
           UIP_HTONS(client_conn->lport), UIP_HTONS(client_conn->rport));

#if WITH_COMPOWER
    powertrace_sniff(POWERTRACE_ON);
#endif

    SENSORS_ACTIVATE(button_sensor);
    etimer_set(&periodic, SEND_INTERVAL);
    etimer_set(&timeslot, COLLECT_INTERVAL);
    rime_sniffer_add(&packet_sniffer);
    while (1)
    {
        PROCESS_YIELD();
        if ((ev == sensors_event) && (data == &button_sensor))
        {
            if (flooding_flag)
            {
                printf("Flooding deactivated!!!\n");
                flooding_flag = 0;
            }
            else
            {
                printf("Flooding activated!!!\n");
                flooding_flag = 1;
            }
        }

        if (ev == tcpip_event)
        {
            tcpip_handler();
        }

        if (etimer_expired(&periodic))
        {
            etimer_reset(&periodic);
            if(flooding_flag == 1){
                ctimer_set(&backoff_timer, SEND_TIME, send_flooding_packet, NULL);
            }else{
                ctimer_set(&backoff_timer, SEND_TIME, send_packet, NULL);
            }
            // ctimer_set(&backoff_timer, SEND_TIME, send_packet, NULL);
#if WITH_COMPOWER
            if (print == 0)
            {
                powertrace_print("#P");
            }
            if (++print == 3)
            {
                print = 0;
            }
#endif
        }
        if (etimer_expired(&timeslot))
        {
            etimer_reset(&timeslot);
            counter++;
            printf("%d\n",counter);
            count++;
            if(counter == 5)
            {
                flooding_flag = 1;
                printf("Flooding activated\n");
            }
            /*Get the rank of node*/
            rpl_dag_t *dag = rpl_get_any_dag();
            printf("My parent is:");
            PRINT6ADDR(rpl_get_parent_ipaddr(dag->preferred_parent));
            printf("\n");
            rank = dag->rank;
            printf("My Rank:%d\n", rank);

            /*Get the number of total child*/
            int i;
            int num = 0;
            for (i = 2; i < 11; i++)
            {
                Child[i] = Count[i] - preCount[i];
                preCount[i] = Count[i];
                if (Child[i] > 0)
                {
                    num++;
                }
            }
            Nchild = num;
            printf("the number of latest total child %d\n", Nchild);

            /*Get the number of sent packets*/
            udpsent = UDPSent - prevUDPSent;
            prevUDPSent = UDPSent;
            Nudp = udpsent;
            printf("the number of sent packets %d\n", Nudp);
            if (count > 2)
            {
                tru_output(server_ipaddr);
            }
        }
    }

    PROCESS_END();
}
/*---------------------------------------------------------------------------*/
