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

#define UDP_CLIENT_PORT 8765
#define UDP_SERVER_PORT 5678

#define UDP_EXAMPLE_ID  190

#define UIP_IP_BUF       ((struct uip_ip_hdr *)&uip_buf[UIP_LLH_LEN])
#define UIP_ICMP_BUF     ((struct uip_icmp_hdr *)&uip_buf[uip_l2_l3_hdr_len])

#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"

#ifndef PERIOD
#define PERIOD 60
#endif

#define START_INTERVAL		(15 * CLOCK_SECOND)
#define SEND_INTERVAL		(PERIOD * CLOCK_SECOND)
#define SEND_TIME		(random_rand() % (SEND_INTERVAL))
#define MAX_PAYLOAD_LEN		30
#define COLLECT_INTERVAL (300 * CLOCK_SECOND)

static struct uip_udp_conn *client_conn;
static uip_ipaddr_t server_ipaddr;
extern int rank;
extern int Nudp;
extern int Ndis;
extern int Ndio;
extern int Ndao;
extern int Nnbr;
extern int Nchild;

//Statistic the number of DIS packets
int prevDISRecv = 0;
int prevDISSent = 0;
int DISSent = 0;
int DISRecv = 0;
int dissent = 0;
int disrecv = 0;
//Statistic the number of DIO packets
int prevDIORecv = 0;
int prevDIOSent = 0;
int DIOSent = 0;
int DIORecv = 0;
int diosent = 0;
int diorecv = 0;
//Statistic the number of DAO packets
int prevDAORecv = 0;
int prevDAOSent = 0;
int DAOSent = 0;
int DAORecv = 0;
int daosent = 0;
int daorecv = 0;
//Statistic the number of UDP packets
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

  if(uip_newdata()) {
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
                        &server_ipaddr, UIP_HTONS(1234));
}
/*---------------------------------------------------------------------------*/
static void
set_global_address(void)
{
  uip_ipaddr_t ipaddr;

  uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 0);
  uip_ds6_set_addr_iid(&ipaddr, &uip_lladdr);
  uip_ds6_addr_add(&ipaddr, 0, ADDR_AUTOCONF);
  uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0, 0x00ff, 0xfe00, 1);
}
/*---------------------------------------------------------------------------*/
//N is the number of node(11)
static int Count[15] = {0};
static int preCount[15] = {0};
static int Child[15] = {0};
static void input_packet(void)
{
  // int len = packetbuf_totlen();
  // printf("receive:%d,%d\n",len,UIP_IP_BUF->proto);
  if(UIP_IP_BUF->proto == UIP_PROTO_ICMP6){

  }else{
    UDPRecv++;
    int id = UIP_IP_BUF->srcipaddr.u8[sizeof(uip_ipaddr_t)-1];
    Count[id]++;
  }
}
static void output_packet(void)
{
  // int len = packetbuf_totlen();
  // PRINT6ADDR(&UIP_IP_BUF->destipaddr);
  int code = UIP_ICMP_BUF->icode;
  // printf("send:%d,%d\n",len,UIP_ICMP_BUF->icode);
  if(UIP_IP_BUF->proto == UIP_PROTO_ICMP6){
    if(code == 0){
      // printf("DIS");
      DISSent++;
    }else if(code == 1){
      // printf("DIO");
      DIOSent++;
    }else if (code == 2){
      DAOSent++;
      // printf("DAO");
    }
  }else{
    UDPSent++;
    // printf("UDP");
  }
  // printf("\n");
}
RIME_SNIFFER(packet_sniffer, input_packet, output_packet);
/*---------------------------------------------------------------------------*/
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
  
  set_global_address();

  PRINTF("UDP client process started\n");

  /* new connection with remote host */
  client_conn = udp_new(NULL, UIP_HTONS(1234), NULL); 
  if(client_conn == NULL) {
    PRINTF("No UDP connection available, exiting the process!\n");
    PROCESS_EXIT();
  }
  udp_bind(client_conn, UIP_HTONS(UDP_CLIENT_PORT)); 

  PRINTF("Created a connection with the server ");
  PRINT6ADDR(&client_conn->ripaddr);
  PRINTF(" local/remote port %u/%u\n",
	UIP_HTONS(client_conn->lport), UIP_HTONS(client_conn->rport));

  etimer_set(&periodic, SEND_INTERVAL);
  etimer_set(&timeslot, COLLECT_INTERVAL);
  rime_sniffer_add(&packet_sniffer);
  while(1) {
    PROCESS_YIELD();
    if(ev == tcpip_event) {
      tcpip_handler();
    }
    
    if(etimer_expired(&periodic)) {
      etimer_reset(&periodic);
      ctimer_set(&backoff_timer, SEND_TIME, send_packet, NULL);

#if WITH_COMPOWER
      if (print == 0) {
	powertrace_print("#P");
      }
      if (++print == 3) {
	print = 0;
      }
#endif

    }
    if (etimer_expired(&timeslot))
    {
      etimer_reset(&timeslot);
      count++;
      /*Get the rank of node*/
      rpl_dag_t *dag = rpl_get_any_dag(); 
      printf("My parent is:");
      PRINT6ADDR(rpl_get_parent_ipaddr(dag->preferred_parent));
      printf("\n");
      rank = dag->rank;
      printf("My Rank:%d\n",rank);

      /*Get the number of neighbors*/
      Nnbr = uip_ds6_nbr_num();
      printf("the number of latest neighbor %d\n", Nnbr);

      /*Get the number of total child*/
      int i;
      int num = 0;
      for(i=2;i<15;i++)
      {
        Child[i] = Count[i] - preCount[i];
        preCount[i] = Count[i];
        if(Child[i]>0){
          num++;
        }
      }
      Nchild = num;
      printf("the number of latest total child %d\n", Nchild);

      /*Get the number of sent DIS packets*/
      dissent = DISSent - prevDISSent;
      prevDISSent = DISSent;
      Ndis = dissent;
      printf("the number of sent DIS packets %d\n",Ndis);

      /*Get the number of sent DIO packets*/
      diosent = DIOSent - prevDIOSent;
      prevDIOSent = DIOSent;
      Ndio = diosent;
      printf("the number of sent DIO packets %d\n",Ndio);

      /*Get the number of sent DAO packets*/
      daosent = DAOSent - prevDAOSent;
      prevDAOSent = DAOSent;
      Ndao = daosent;
      printf("the number of sent DAO packets %d\n",Ndao);

      /*Get the number of sent UDP packets*/
      udpsent = UDPSent - prevUDPSent;
      prevUDPSent = UDPSent;
      Nudp = udpsent;
      printf("the number of sent UDP packets %d\n",Nudp);
      if(count > 2)
      {
        tru_output(server_ipaddr);
      }
      
    }
    
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
