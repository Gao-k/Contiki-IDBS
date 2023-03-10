/*
 * Copyright (c) 2007, Swedish Institute of Computer Science.
 * All rights reserved.
 *
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

/**
 * \file
 *         Example of how the collect primitive works.
 * \author
 *         Adam Dunkels <adam@sics.se>
 */

#include "contiki.h"
#include "lib/random.h"
#include "net/rime/rime.h"
#include "net/rime/collect.h"
#include "dev/leds.h"
#include "dev/button-sensor.h"

#include "net/netstack.h"

#include <stdio.h>

static struct collect_conn tc;
static uint32_t data_rcvd_num_at_sink, total_generated_num;

struct data_msg_t{
	int8_t src_grade;
	linkaddr_t	src_addr; //indicate that the current node is the source who generates the packet or not.
	clock_time_t	gen_or_rcv_time; //generated or received time
	clock_time_t	delay;
	//uint16_t 	local_rtimer_second; //RTIMER_SECOND
};
static uint8_t node_type;
enum{
	NOUSE,
		
	/*node type*/
	SINK_NODE, /*node type: sink*/
	SENSOR_NODE, /*node type: sensor*/

	TYPE_DATA, /*data packet*/
};
struct data_hdr_t {
  uint8_t dispatch; 
  uint8_t type;/*typedef unsigned char   uint8_t;*/
  //uint8_t len;
};

/*---------------------------------------------------------------------------*/
PROCESS(example_collect_process, "Test collect process");
AUTOSTART_PROCESSES(&example_collect_process);
/*---------------------------------------------------------------------------*/
static void
recv(const linkaddr_t *originator, uint8_t seqno, uint8_t hops)
{
  //printf("Sink got message from %d.%d, seqno %d, hops %d: len %d \n", originator->u8[0], originator->u8[1], seqno, hops, packetbuf_datalen());
//	 (char *)packetbuf_dataptr());

	struct data_msg_t data_msg;
	//packet = queuebuf_new_from_packetbuf();
	memcpy(&data_msg, packetbuf_dataptr(), sizeof(struct data_msg_t));
	data_msg.delay = clock_time() - data_msg.gen_or_rcv_time;
	if(data_msg.delay<0)
	{
		data_msg.delay = -data_msg.delay;
	}
	data_rcvd_num_at_sink++;
	printf("%lu R %u.%u Grade: %d Seqno %d Latency: %ld Num: 1 TotalRcvdNum: %lu\n", 
		clock_time(), data_msg.src_addr.u8[0],data_msg.src_addr.u8[1], hops,seqno,data_msg.delay, data_rcvd_num_at_sink);

}
/*---------------------------------------------------------------------------*/
static const struct collect_callbacks callbacks = { recv };
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(example_collect_process, ev, data)
{
  static struct etimer periodic;
  static struct etimer et;
  
  static uint16_t total_data_num;
  static int retx_limit;
  PROCESS_BEGIN();
  
  data_rcvd_num_at_sink = 0;
  total_generated_num = 0;
  
  total_data_num = 30000; /*initialize the total data num*/
  retx_limit = 10;  /*retx limit*/
  
  node_type = SENSOR_NODE;
  collect_open(&tc, 130, COLLECT_ROUTER, &callbacks);

  if(linkaddr_node_addr.u8[0] == 1 &&
     linkaddr_node_addr.u8[1] == 0) {
	printf("I am sink\n");
	node_type = SINK_NODE;
	collect_set_sink(&tc, 1);
  }

  /* Allow some time for the network to settle. */
  //etimer_set(&et, 120 * CLOCK_SECOND);
  //PROCESS_WAIT_UNTIL(etimer_expired(&et));

  while(1) {

	//etimer_set(&et, random_rand() % (10 * CLOCK_SECOND));
  	//PROCESS_WAIT_UNTIL(etimer_expired(&et));
    /* Send a packet every 10, 20, or 30 seconds. */
    if(etimer_expired(&periodic)) {
      etimer_set(&periodic, CLOCK_SECOND * (30+random_rand()%5));
      //etimer_set(&et, random_rand() % (CLOCK_SECOND * 10));
    }

    PROCESS_WAIT_EVENT();


    //if(etimer_expired(&et) && node_type == SENSOR_NODE && total_data_num > 0) {
	if(node_type == SENSOR_NODE && total_data_num > 0) {
      static linkaddr_t oldparent;
      const linkaddr_t *parent;

      //printf("Sending\n");


	  /*********************************************************************/
	  /*preparing data message*/
	  struct data_msg_t data_msg;
	  data_msg.gen_or_rcv_time = clock_time(); /*data generation time or receiving time*/
      //data_msg.src_grade = pri_attribute.grade;
	  data_msg.delay = 0;
	  linkaddr_copy(&data_msg.src_addr,&linkaddr_node_addr);
	  
	  
      packetbuf_clear();
      //packetbuf_set_datalen(sprintf(packetbuf_dataptr(), "%s", "Hello") + 1);
	  packetbuf_set_datalen(sizeof(struct data_msg_t));
	  memcpy(packetbuf_dataptr(),&data_msg,sizeof(struct data_msg_t));
	  /*********************************************************************/
	  total_generated_num ++;
	  printf("%lu G %u.%u TotalGenNum %lu\n",clock_time(), linkaddr_node_addr.u8[0],linkaddr_node_addr.u8[1],total_generated_num);
	  
      collect_send(&tc, retx_limit); //max retx is set to 0 (previously, it is 15
      total_data_num--;
	  
      parent = collect_parent(&tc);
      if(!linkaddr_cmp(parent, &oldparent)) {
        if(!linkaddr_cmp(&oldparent, &linkaddr_null)) {
          //printf("#L %d 0\n", oldparent.u8[0]);
        }
        if(!linkaddr_cmp(parent, &linkaddr_null)) {
          //printf("#L %d 1\n", parent->u8[0]);
        }
        linkaddr_copy(&oldparent, parent);
      }
    }

  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
