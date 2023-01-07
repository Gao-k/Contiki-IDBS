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
#include "contiki-lib.h"
#include "contiki-net.h"
#include "net/ip/uip.h"
#include "net/rpl/rpl.h"
#include "net/netstack.h"
#include "dev/button-sensor.h"
#include "dev/leds.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
// #include "blacklist.h"
#include "rpl-icmp6.c"

#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"

#define UIP_IP_BUF ((struct uip_ip_hdr *)&uip_buf[UIP_LLH_LEN])

#define UDP_CLIENT_PORT 8765
#define UDP_SERVER_PORT 5678
#define UDP_EXAMPLE_ID 190

#define COLLECT_INTERVAL (300 * CLOCK_SECOND)
#define MAX_PAYLOAD_LEN 60
static struct uip_udp_conn *server_conn;
static struct uip_udp_conn *client_conn;
extern int Rank;
extern int NodeID;
extern int new_data;
extern int malicious_node;
int sum = 0;
int pre_length = 0;
int length = 0;
int alarm = 0;

PROCESS(udp_server_process, "UDP server process");
AUTOSTART_PROCESSES(&udp_server_process);
/*---------------------------------------------------------------------------*/
static void
tcpip_handler(void)
{
  char *appdata;

  if (uip_newdata()) 
  {
    appdata = (char *)uip_appdata;
    appdata[uip_datalen()] = 0;
    PRINTF("DATA recv '%s' from ", appdata);
    PRINTF("%d",
           UIP_IP_BUF->srcipaddr.u8[sizeof(UIP_IP_BUF->srcipaddr.u8) - 1]);
    PRINTF("\n");
#if SERVER_REPLY
    PRINTF("DATA sending reply\n");
    uip_ipaddr_copy(&server_conn->ripaddr, &UIP_IP_BUF->srcipaddr);
    uip_udp_packet_send(server_conn, "Reply", sizeof("Reply"));
    uip_create_unspecified(&server_conn->ripaddr);
#endif
  }
}
/*---------------------------------------------------------------------------*/
static void
print_local_addresses(void)
{
  int i;
  uint8_t state;

  PRINTF("Server IPv6 addresses: ");
  for (i = 0; i < UIP_DS6_ADDR_NB; i++)
  {
    state = uip_ds6_if.addr_list[i].state;
    if (state == ADDR_TENTATIVE || state == ADDR_PREFERRED)
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
extern uip_ipaddr_t Nodeipaddr;
// static void
// send_blacklist(uip_ipaddr_t *addr)
// {
//   char buf[MAX_PAYLOAD_LEN];
//   struct blacklist *e;
//   e = list_head(blacklist_table);
// #define PRINT_DET 1
// #if PRINT_DET
// 	printf("Sending blacklist to %d!\n",addr->u8[sizeof(uip_ipaddr_t) - 1]);

//   while(e != NULL){
//     // memcpy(buffer + pos, &e->ipaddr, 16);
//     // pos = pos + 16;
//     printf("the ID of malicious node:%d\n",e->ipaddr.u8[sizeof(uip_ipaddr_t) - 1]);
//     // set32(buffer,pos,count);
//     // pos = pos + 2;
//     e=e->next;
//   }
// #endif
//   sprintf(buf,"The length of blacklist:%d", list_length(blacklist_table));
//   uip_udp_packet_sendto(server_conn, buf, strlen(buf),
//                         &addr, UIP_HTONS(UDP_CLIENT_PORT));
//   // uip_ds6_nbr_t *nbr = nbr_table_head(ds6_neighbors);
//   // while(nbr != NULL){
//   //   uip_udp_packet_sendto(server_conn, buf, strlen(buf),
//   //                       &nbr->ipaddr, UIP_HTONS(UDP_CLIENT_PORT));
//   // }
// }
// static void abnormal_analysis(void)
// {
//   // printf("Receiving statistic message (Rank:%d NumChild:%d NumUdp:%d) about %d ",Rank, NumChild, NumUdp, NodeID);
//   // PRINT6ADDR(&Nodeipaddr);
//   // printf("\n");
// }
// static void
// broadcast_recv(struct broadcast_conn *c, const linkaddr_t *from)
// {
//   printf("broadcast message received from %d.%d: '%s'\n",
//          from->u8[0], from->u8[1], (char *)packetbuf_dataptr());
// }
// static const struct broadcast_callbacks broadcast_call = {broadcast_recv};
// static struct broadcast_conn broadcast;
static void
send_abnormal(uip_ipaddr_t *addr)
{
  char buf[MAX_PAYLOAD_LEN];
  //send malicious node meaasge!
  printf("--------------------\n");
  // printf("Malicious node:%d\n",malicious_node);
  sprintf(buf, "%d is malicious node!", malicious_node);
  uip_udp_packet_sendto(client_conn, buf, strlen(buf),
                        &addr, UIP_HTONS(UDP_SERVER_PORT));
}
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(udp_server_process, ev, data)
{
  uip_ipaddr_t ipaddr;
  struct uip_ds6_addr *root_if;
  static struct etimer timeslot;
  static struct etimer alarm_timeslot;
  static uip_ds6_route_t *r;
  static uip_ipaddr_t *nexthop;
  // PROCESS_EXITHANDLER(broadcast_close(&broadcast);)

  PROCESS_BEGIN();

  PROCESS_PAUSE();

  SENSORS_ACTIVATE(button_sensor);

  PRINTF("UDP server started\n");

#if UIP_CONF_ROUTER
  /* The choice of server address determines its 6LoPAN header compression.
 * Obviously the choice made here must also be selected in udp-client.c.
 *
 * For correct Wireshark decoding using a sniffer, add the /64 prefix to the 6LowPAN protocol preferences,
 * e.g. set Context 0 to aaaa::.  At present Wireshark copies Context/128 and then overwrites it.
 * (Setting Context 0 to aaaa::1111:2222:3333:4444 will report a 16 bit compressed address of aaaa::1111:22ff:fe33:xxxx)
 * Note Wireshark's IPCMV6 checksum verification depends on the correct uncompressed addresses.
 */

#if 0
/* Mode 1 - 64 bits inline */
   uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 1);
#elif 1
  /* Mode 2 - 16 bits inline */
  uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0x00ff, 0xfe00, 1);
#else
  /* Mode 3 - derived from link local (MAC) address */
  uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 0);
  uip_ds6_set_addr_iid(&ipaddr, &uip_lladdr);
#endif

  uip_ds6_addr_add(&ipaddr, 0, ADDR_MANUAL);
  root_if = uip_ds6_addr_lookup(&ipaddr);
  if (root_if != NULL)
  {
    rpl_dag_t *dag;
    dag = rpl_set_root(RPL_DEFAULT_INSTANCE, (uip_ip6addr_t *)&ipaddr);
    uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 0);
    rpl_set_prefix(dag, &ipaddr, 64);
    PRINTF("created a new RPL dag with ID:");
    PRINT6ADDR(&dag->dag_id);
    printf("\n");
  }
  else
  {
    PRINTF("failed to create a new RPL DAG\n");
  }
#endif /* UIP_CONF_ROUTER */

  print_local_addresses();

  /* The data sink runs with a 100% duty cycle in order to ensure high 
     packet reception rates. */
  NETSTACK_MAC.off(1);

  server_conn = udp_new(NULL, UIP_HTONS(UDP_CLIENT_PORT), NULL);
  if (server_conn == NULL)
  {
    PRINTF("No UDP connection available, exiting the process!\n");
    PROCESS_EXIT();
  }
  udp_bind(server_conn, UIP_HTONS(UDP_SERVER_PORT));

  PRINTF("Created a server connection with remote address ");
  PRINT6ADDR(&server_conn->ripaddr);
  PRINTF(" local/remote port %u/%u\n", UIP_HTONS(server_conn->lport),
         UIP_HTONS(server_conn->rport));
  etimer_set(&timeslot, 300 * CLOCK_SECOND);
  etimer_set(&alarm_timeslot, 0.1 * CLOCK_SECOND);
  
  // broadcast_open(&broadcast, 129, &broadcast_call);
  while (1)
  {
    PROCESS_YIELD();
    // printf("%d\n",new_data);
    if (ev == tcpip_event)
    {
      tcpip_handler();
    }
    else if (ev == sensors_event && data == &button_sensor)
    {
      PRINTF("Initiaing global repair\n");
      rpl_repair_root(RPL_DEFAULT_INSTANCE);
    }
    // if(new_data > 0){
    //   printf("Receiving statistic message (Rank:%d NumChild:%d NumUdp:%d) about %d ",Rank, NumChild, NumUdp, NodeID);
    //   PRINT6ADDR(&Nodeipaddr);
    //   printf("\n");
    //   new_data = -1;
    // }
    // printf("%d\n",new_data);
    // printf("%d\n",zzc);
    // int i;
    // for(i=0;i<10;i++)
    // {
    //   printf("%d--",Count[i]);
    //   if(Count[i] > 0){
    //     sum++;
    //   }
    // }
    // if(sum > 0){
    //   packetbuf_copyfrom(Count,sizeof(Count));
    //   broadcast_send(&broadcast);
    //   printf("broadcast message sent\n");
    // }
    // printf("\n");
    // printf("the length of blacklist:%d\n",list_length(blacklist_table));
    // if(etimer_expired(&timeslot)){
    //   etimer_reset(&timeslot);
    //   int delt;
    //   length = list_length(blacklist_table);
    //   delt = length - pre_length;
    //   pre_length = length;
    //   // packetbuf_copyfrom("Hello", 6);
    //   // broadcast_send(&broadcast);
    //   // printf("broadcast message sent\n");
    //   if(delt > 0)
    //   {
    //     uip_ds6_nbr_t *nbr = nbr_table_head(ds6_neighbors);
    //     while(nbr != NULL){
    //         send_blacklist(&nbr->ipaddr);
    //         nbr = nbr_table_next(ds6_neighbors, nbr);
    //     }
    //   }
    // }
    //Print the route
    // if (new_data > 0)
    // {
    //   // printf("new_data:%d\n", new_data);
    //   // uip_ds6_route_t *r;
    //   // uip_ipaddr_t *nexthop;
    //   // uip_ipaddr_t *local_child;
    //   // for (r = uip_ds6_route_head();r != NULL;r = uip_ds6_route_next(r))
    //   // {

    //   // }
    //   for (r = uip_ds6_route_head();r != NULL;r = uip_ds6_route_next(r))
    //   {
    //     sum++;
    //     nexthop = uip_ds6_route_nexthop(r);
    //     // printf("--------%d---------\n",nexthop->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //     // printf("********%d*********\n",r->next->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //     if(r->next->ipaddr.u8[sizeof(uip_ipaddr_t)-1] == malicious_node){
    //       // printf("send to %d\n",r->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //       // alarm_output(&r->ipaddr,malicious_node);
    //     }
    //     printf("Route:%d---->%d\n",r->ipaddr.u8[sizeof(uip_ipaddr_t)-1],nexthop->u8[sizeof(uip_ipaddr_t)-1]);
    //     // printf("%d\n",uip_ds6_route_lookup(&r->ipaddr)->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //     // local_child = &r->ipaddr;
    //     // PRINT6ADDR(&r->ipaddr);
    //     // printf("\n");
    //     // send_abnormal(&r->ipaddr);
    //     // alarm_output(&r->ipaddr,malicious_node);
    //     // PROCESS_YIELD();
    //     // PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&alarm_timeslot));
    //     // new_data = 0;
    //   }
    //   printf("---------------%d-------------\n",sum);
    //   // r = uip_ds6_route_head();
    //   // printf("%d\n",malicious_node);
    //   // alarm_output(&r->ipaddr,malicious_node);
    //   new_data = 0;
    //   uip_ds6_nbr_t *nbr;
    //   for(nbr = nbr_table_head(ds6_neighbors);
    //     nbr != NULL;
    //     nbr = nbr_table_next(ds6_neighbors, nbr)) {
    //     /* process nbr here */
    //     printf("%d\n",nbr->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //   }
    // }
    // if (etimer_expired(&alarm_timeslot)){
    //   alarm++;
    //   etimer_reset(&alarm_timeslot);
    //   if(alarm > 4){
    //     uip_ds6_route_t *r;
    //     r = uip_ds6_route_head();
    //     // for (r = uip_ds6_route_head();r != NULL;r = uip_ds6_route_next(r))
    //     // {
    //     //   alarm_output(&r->ipaddr,malicious_node);
    //     // }
    //     while (r != NULL){
    //       // alarm_output(&r->ipaddr,malicious_node);
    //       r = uip_ds6_route_next(r);
    //     }
    //   }
    // }
    
    // if(new_data > 0){
    //   r = uip_ds6_route_head();
    //   // while(r != NULL){
    //   alarm_output(&r->ipaddr,malicious_node);
    //   printf("send to %d\n",r->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //   r = uip_ds6_route_next(r);
    //   // PROCESS_YIELD();
    //   // PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&alarm_timeslot));
    //   // }
    //   alarm_output(&r->ipaddr,malicious_node);
    //   printf("send to %d\n",r->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //   r = uip_ds6_route_next(r);
    //   alarm_output(&r->ipaddr,malicious_node);
    //   printf("send to %d\n",r->ipaddr.u8[sizeof(uip_ipaddr_t)-1]);
    //   new_data = -1;
    // }
    
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
