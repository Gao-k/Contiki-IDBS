/*
 * Copyright (c) 2006, Swedish Institute of Computer Science.
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
 *         A very simple Contiki application showing how Contiki programs look
 * \author
 *         Adam Dunkels <adam@sics.se>
 */

#include "contiki.h"
#include "powertrace.h"
#include "lib/random.h"
#include "net/netstack.h"
#include "net/rime/rime.h"

#include <stdio.h> /* For printf() */

//#ifndef  DATA_INTERVAL
//	#define DATA_INTERVAL	2
//#endif
/*---------------------------------------------------------------------------*/
PROCESS(hello_world_process, "ADC: Hello world process");
AUTOSTART_PROCESSES(&hello_world_process);
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(hello_world_process, ev, data)
{
  PROCESS_BEGIN();

  //powertrace_start(CLOCK_SECOND * 2); 
  
  printf("Hello, world\n");
  //printf("DATA_INTERVAL = %u.\n",DATA_INTERVAL);
#if DATA_TX_SUPPORT && !GEN_DATA_IN_R
  if(!(linkaddr_node_addr.u8[0] == 1 && linkaddr_node_addr.u8[1] == 0)) ///not sink
  {
	  static struct etimer periodic;
	  static struct etimer et;
	  /* Allow some time for the network to settle. */
	  etimer_set(&et, (60*3*CLOCK_SECOND));/*for micaz, the time cannot be set to beyond 255*/
	  PROCESS_WAIT_UNTIL(etimer_expired(&et));
	  etimer_set(&et, (60*3*CLOCK_SECOND));
	  PROCESS_WAIT_UNTIL(etimer_expired(&et));
	  //etimer_set(&periodic, CLOCK_SECOND * (random_rand()%(60)));
	  while(1)
	  {
		  if(etimer_expired(&periodic)) 
		  {
			  etimer_set(&periodic, CLOCK_SECOND * (DATA_INTERVAL));// + random_rand()%10);
			  //etimer_set(&et, random_rand() % (CLOCK_SECOND * 10));
   		  } 
		  PROCESS_WAIT_EVENT();
		  NETSTACK_RDC.send(NULL,NULL);
	  }
  }
 #endif
  
  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
