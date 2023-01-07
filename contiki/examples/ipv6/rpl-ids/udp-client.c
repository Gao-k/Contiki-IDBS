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
#include "net/rpl/rpl-private.h"
#include "net/rpl/rpl-icmp6.c"
// #include "getentropy.c"
// #include "blacklist.h"
#ifdef WITH_COMPOWER
#include "powertrace.h"
#endif

#ifndef POWERTRACE_ON
#define POWERTRACE_ON 0
#endif

#if POWERTRACE_ON
extern uint32_t all_cpu, all_lpm, all_transmit, all_listen, all_time;
#endif

#include <stdio.h>
#include <string.h>

#define UDP_CLIENT_PORT 8765
#define UDP_SERVER_PORT 5678

#define UDP_EXAMPLE_ID 190

#define UIP_IP_BUF ((struct uip_ip_hdr *)&uip_buf[UIP_LLH_LEN])
#define UIP_ICMP_BUF ((struct uip_icmp_hdr *)&uip_buf[uip_l2_l3_hdr_len])

#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"

#ifndef PERIOD
#define PERIOD 60
#endif

#define START_INTERVAL (15 * CLOCK_SECOND)
#define SEND_INTERVAL (PERIOD * CLOCK_SECOND)
#define SEND_TIME (random_rand() % (SEND_INTERVAL))
#define MAX_PAYLOAD_LEN 30
#define COLLECT_INTERVAL (300 * CLOCK_SECOND)

static struct uip_udp_conn *server_conn;
static struct uip_udp_conn *client_conn;
static uip_ipaddr_t server_ipaddr;
// static uip_ipaddr_t de_ipaddr;
int alarm = 0;
extern int rank;
extern int NUs;
extern int NUr;
extern int NIs_dis;
extern int NIs_dio;
extern int NIs_dao;
extern int NIr_dis;
extern int NIr_dio;
extern int NIr_dao;
extern int NIs;
extern int NIr;
extern int Neighbor;
extern int malicious_node;
extern uip_ipaddr_t nodeipaddr;

// Define the variable of UDP
int UDPSent=0;
int UDPRecv=0;
int prevUDPRecv = 0;
int prevUDPSent = 0;
// Define the variable of DIS
int DISSent = 0;
int DISRecv = 0;
int prevDISRecv = 0;
int prevDISSent = 0;

// Define the variable of DIO
int DIOSent = 0;
int DIORecv = 0;
int prevDIORecv = 0;
int prevDIOSent = 0;
int DIOCast = 0;
int prevDIOCast = 0;

// Define the variable of DAO
int DAOSent = 0;
int DAORecv = 0;
int prevDAORecv = 0;
int prevDAOSent = 0;

// Define the variable of ICMP
int ICMPSent = 0;
int ICMPRecv = 0;
int prevICMPRecv = 0;
int prevICMPSent = 0;
int count = 0;
int step = 0;

/*---------------------------------------------------------------------------*/
PROCESS(udp_client_process, "UDP client process");
AUTOSTART_PROCESSES(&udp_client_process);
/*---------------------------------------------------------------------------*/
// static void
// broadcast_recv(struct broadcast_conn *c, const linkaddr_t *from)
// {
//   printf("broadcast message received from %d.%d: '%s'\n",
//          from->u8[0], from->u8[1], (char *)packetbuf_dataptr());
// }
// static const struct broadcast_callbacks broadcast_call = {broadcast_recv};
// static struct broadcast_conn broadcast;
/*---------------------------------------------------------------------------*/
static void
tcpip_handler(void)
{
  // char *str;

  // if (uip_newdata())
  // {
  //   // printf("****************************\n");
  //   str = uip_appdata;
  //   str[uip_datalen()] = '\0';
  //   // printf("DATA recv '%s'\n", str);
  //   printf("DATA recv '%s' from sink\n", str);
  //   // printf("%d",UIP_IP_BUF->srcipaddr.u8[sizeof(UIP_IP_BUF->srcipaddr.u8) - 1]);
  //   // printf("\n");
  // }
  char *appdata;

  if (uip_newdata()) 
  {
    appdata = (char *)uip_appdata;
    appdata[uip_datalen()] = 0;
    printf("DATA recv '%s' from sink\n", appdata);
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
static void input_packet(void)
{
  int len = packetbuf_totlen();
  // uip_ip6addr(&de_ipaddr, 0xff02,0,0,0,0,0,0,0x001a);
  int code = UIP_ICMP_BUF->icode;
  // PRINT6ADDR(&UIP_IP_BUF->srcipaddr);
  // printf("receive:%d,%d\n",len,UIP_IP_BUF->proto);
  // const linkaddr_t *sender = packetbuf_addr(PACKETBUF_ADDR_SENDER);
  // printf("%d.%d,0.0.0.0.0.%d\n",sender->u8[0],sender->u8[1],sender->u8[7]);
  // if(uip_ipaddr_cmp(&de_ipaddr,&UIP_IP_BUF->destipaddr)){

  // }else{
    if (UIP_IP_BUF->proto == UIP_PROTO_ICMP6)
    {
      // ICMPRecv++;
      if (code == 0)
      {
        // printf("DIS");
        DISRecv++;
      }
      else if (code == 1)
      {
        // printf("DIO");
        DIORecv++;
      }
      else if (code == 2)
      {
        // printf("DAO");
        // PRINT6ADDR(&UIP_IP_BUF->srcipaddr);
        // printf("\n");
        DAORecv++;
      }
    }
    else
    {
      UDPRecv++;
      // printf("Recv UDP\n");
    }
  // }
  // printf("\n");
}
static void output_packet(void)
{
  // uip_ip6addr(&de_ipaddr, 0xff02,0,0,0,0,0,0,0x001a);
  int len = packetbuf_totlen();
  int code = UIP_ICMP_BUF->icode;
  // PRINT6ADDR(&UIP_IP_BUF->destipaddr);
  // printf("send:%d,%d\n",len,UIP_IP_BUF->proto);
  // if(uip_ipaddr_cmp(&de_ipaddr,&UIP_IP_BUF->destipaddr)){
  //   if(UIP_IP_BUF->proto == UIP_PROTO_ICMP6){
  //     if (code == 1)
  //     {
  //       DIOCast++;
  //     }
      
  //   }

  // }else{
    
    if (UIP_IP_BUF->proto == UIP_PROTO_ICMP6)
    {
      // printf("%d\n",UIP_IP_BUF->ttl);
      // ICMPSent++;
      if (code == 0)
      {
        // printf("DIS");
        DISSent++;
      }
      else if (code == 1)
      {
        // printf("DIO");
        // PRINT6ADDR(&UIP_IP_BUF->destipaddr);
        // printf("\n");
        DIOSent++;
      }
      else if (code == 2)
      {
        DAOSent++;
        // printf("DAO");
      }
    }
    else
    {
      UDPSent++;
      // printf("Send UDP\n");
    }
  // }
  // printf("\n");
}
RIME_SNIFFER(packet_sniffer, input_packet, output_packet);
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(udp_client_process, ev, data)
{
  static struct etimer periodic;
  static struct ctimer backoff_timer;
  static struct etimer stat_timeslot;
  static struct etimer send_timeslot;
  // uint32_t Energy;
  // PROCESS_EXITHANDLER(broadcast_close(&broadcast);)

  PROCESS_BEGIN();

  // cc2420_set_txpower(23);
  PROCESS_PAUSE();

  powertrace_start(SEND_INTERVAL);
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

  uint8_t r = (uint8_t)random_rand()%60;
  printf("r:%d\n",r);
  etimer_set(&periodic, SEND_INTERVAL);
  etimer_set(&stat_timeslot, COLLECT_INTERVAL);
  etimer_set(&send_timeslot, (r*CLOCK_SECOND) + COLLECT_INTERVAL);
  rime_sniffer_add(&packet_sniffer);
  // broadcast_open(&broadcast, 129, &broadcast_call);
  while (1)
  {
    
    PROCESS_YIELD();
    if (ev == tcpip_event)
    {
      tcpip_handler();
    }
    // printf("%lu\n",periodic.timer);
    // printf("%lu,%lu\n",periodic.timer.start,periodic.timer.interval);
    if (etimer_expired(&periodic))
    {
      etimer_reset(&periodic);
      step++;
      ctimer_set(&backoff_timer, SEND_TIME, send_packet, NULL);
      // printf("%lu,%lu\n",backoff_timer.etimer.timer.start,backoff_timer.etimer.timer.interval);
    }
    if (etimer_expired(&stat_timeslot))
    {
      etimer_reset(&stat_timeslot);
      count++;
      /*Get the rank of node*/
      rpl_dag_t *dag = rpl_get_any_dag();
      printf("My parent is:");
      PRINT6ADDR(rpl_get_parent_ipaddr(dag->preferred_parent));
      printf("%d",rpl_get_parent_ipaddr(dag->preferred_parent)->u8[sizeof(uip_ipaddr_t)-1]);
      printf("\n");
      rank = dag->rank;
      printf("My Rank:%d\n", rank);
      
      Neighbor = uip_ds6_nbr_num();
      // printf("The number of neighbors:%d\n",Neighbor);
      // printf("%lu\n",dag->instance->unicast_dio_timer.etimer.timer);
      // printf("%lu\n",dag->instance->dao_timer.etimer.timer.interval);
      // printf("%lu\n",dag->instance->dao_lifetime_timer.etimer.timer.interval);
      
      // NT = rpl_stats.resets - prevNT;
      // prevNT = rpl_stats.resets;
      // printf("Trickle resets number:%d\n", NT);

      /*Get the number of UDP packets*/
      NUs = UDPSent - prevUDPSent;
      prevUDPSent = UDPSent;
      printf("the number of sent UDP packets %d\n", NUs);
      NUr = UDPRecv - prevUDPRecv;
      prevUDPRecv = UDPRecv;
      printf("the number of recv UDP packets %d\n", NUr);

      /*Get the number of DIS packets*/
      NIs_dis = DISSent - prevDISSent;
      prevDISSent = DISSent;
      printf("the number of sent DIS packets %d\n", NIs_dis);
      NIr_dis = DISRecv - prevDISRecv;
      prevDISRecv = DISRecv;
      printf("the number of recv DIS packets %d\n", NIr_dis);

      /*Get the number of DIO packets*/
      NIs_dio = DIOSent - prevDIOSent;
      prevDIOSent = DIOSent;
      printf("the number of sent DIO packets %d\n", NIs_dio);
      NIr_dio = DIORecv - prevDIORecv;
      prevDIORecv = DIORecv;
      printf("the number of recv DIO packets %d\n", NIr_dio);
      // diocast = DIOCast - prevDIOCast;
      // prevDIOCast = DIOCast;
      // printf("the number of sent multicast DIO packets %d\n", diocast);

      /*Get the number of DAO packets*/
      NIs_dao = DAOSent - prevDAOSent;
      prevDAOSent = DAOSent;
      printf("the number of sent DAO packets %d\n", NIs_dao);
      NIr_dao = DAORecv - prevDAORecv;
      prevDAORecv = DAORecv;
      printf("the number of recv DAO packets %d\n", NIr_dao);

      /*Get the number of ICMP packets*/
      ICMPSent = (DISSent+DIOSent+DAOSent) - prevICMPSent;
      prevICMPSent = DISSent+DIOSent+DAOSent;
      NIs = ICMPSent;
      printf("the number of sent ICMP packets %d\n", NIs);
      ICMPRecv = (DISRecv+DIORecv+DAORecv) - prevICMPRecv;
      prevICMPRecv = DISRecv+DIORecv+DAORecv;
      NIr = ICMPRecv;
      printf("the number of recv ICMP packets %d\n", NIr);

      // printf("Routing entries: %u\n", uip_ds6_route_num_routes());
      // uip_ds6_route_t *route = uip_ds6_route_head();
      // while(route) {
      //   printf("Route ");
      //   PRINT6ADDR(&route->ipaddr);
      //   printf("/128 via ");
      //   PRINT6ADDR(uip_ds6_route_nexthop(route));
      //   printf("\n");
      //   route = uip_ds6_route_next(route);
      // }
      
      // if (count > 3)
      // {
      //   if(GetEntropy(NUs - 5, NUr) < 1 || GetEntropy(NIs,NIr) < 0.8)
      //   {
      //     alarm = 1;
      //     printf("There is abnormal!\n");
      //     uip_ds6_addr_t *addr;
      //     addr = uip_ds6_get_global(ADDR_PREFERRED);
      //     nodeipaddr = addr->ipaddr;
      //     printf("My ipaddr:");
      //     PRINT6ADDR(&nodeipaddr);
      //     printf("\n");
      //   }
      //   if(alarm){
      //     tru_output(server_ipaddr);
      //   }
      //   alarm = 0;
      //   // tru_output(server_ipaddr);
      // }
      // printf("the length of blacklist:%d\n",list_length(blacklist_table));
    }
    if (etimer_expired(&send_timeslot)){
      etimer_reset(&send_timeslot);
      if(count > 3){
        printf("send statistic message!\n");
        tru_output(&server_ipaddr);
        // add malicious node into blacklist
        struct blacklist *e;  
        for(e = list_head(blacklist_table);e!=NULL;e=e->next){
          if(e->id == malicious_node){
            list_remove(blacklist_table, e);
            memb_free(&mem, e);
          }
        }
        e = memb_alloc(&mem);
        e->next = NULL;
        e->id = malicious_node;
        if(e->id != 0){
          list_add(blacklist_table, e);
        }
        printf("the length of blacklist:%d and malicious node:%d\n",list_length(blacklist_table),malicious_node);

      }
    }
    // PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&periodic));
    // packetbuf_copyfrom("Hello", 6);
    // broadcast_send(&broadcast);
    // printf("broadcast message sent\n");
    if(step==30){
#if POWERTRACE_ON
    // Energy = (all_transmit * 19.5 + all_listen * 21.8 + all_cpu * 1.8 + all_lpm * 0.0545) * 3 / 4096 * 8;
    // printf("energy usage:%lu\n", Energy);
    printf("Energy:%lu,%lu,%lu,%lu,%lu\n",all_transmit, all_listen, all_cpu, all_lpm, all_time);
#endif
    }
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
