#ifndef __PROJECT_CONF_H__
#define __PROJECT_CONF_H__

#undef NETSTACK_CONF_MAC
#define NETSTACK_CONF_MAC     nullmac_driver /*csma_driver*/

#undef NETSTACK_CONF_RDC
#define NETSTACK_CONF_RDC     primac_driver//primac_board_driver//

#undef NETSTACK_CONF_FRAMER
#define NETSTACK_CONF_FRAMER framer_802154   
  
#undef	CC2420_CONF_AUTOACK 
#define CC2420_CONF_AUTOACK 	0
    
#define PRIMAC_CONF_COMPOWER	1

/*Reduce the size of contiki*/
#undef COLLECT_NBR_TABLE_CONF_MAX_NEIGHBORS
#define COLLECT_NBR_TABLE_CONF_MAX_NEIGHBORS      0 
#undef QUEUEBUF_CONF_NUM
#define QUEUEBUF_CONF_NUM		0 
//#undef PROCESS_CONF_NO_PROCESS_NAMES
//#define PROCESS_CONF_NO_PROCESS_NAMES 1 //to disable the name strings from being stored 
#undef UIP_CONF_TCP
#define UIP_CONF_TCP 0 
#undef	UIP_CONF_UDP 
#define UIP_CONF_UDP 0

#ifdef CC2420_CONF_CHANNEL
#undef CC2420_CONF_CHANNEL 
#define CC2420_CONF_CHANNEL              26  
#endif /* CC2420_CONF_CHANNEL */

#define ADCSC_SUPPORT CMD_ADCSC_SUPPORT   
#define SF CMD_SF 

#define DATA_TX_SUPPORT CMD_DATA_TX_SUPPORT 
#define TOTAL_DATA_NUM  CMD_TOTAL_DATA_NUM 
#define DATA_INTERVAL	CMD_DATA_INTERVAL
#define RETX_LIMIT		CMD_RETX_LIMIT// 11/*retransmission limit: =0: no limit; >0: transmission times, i.e., (RETX_LIMIT-1) retransmissions*/
#define	MAX_DATA_QUEUE_BUFS	CMD_MAX_DATA_QUEUE_BUFS //15

#define ADDRESS_FREE_SUPPORT CMD_ADDRESS_FREE_SUPPORT 
#define NODES_NUM_PER_GRADE  CMD_NODES_NUM_PER_GRADE
#define PROC_GRADE_BASED_ON_ADDR_SUPPORT CMD_PROC_GRADE_BASED_ON_ADDR_SUPPORT
#if	PROC_GRADE_BASED_ON_ADDR_SUPPORT
	#define	ID_FOR_Z_ONE		CMD_ID_FOR_Z_ONE
	#define	ID_FOR_Z_TWO		CMD_ID_FOR_Z_TWO
	#define	ID_FOR_Z_THREE		CMD_ID_FOR_Z_THREE
	#define	ID_FOR_Z_FOUR		CMD_ID_FOR_Z_FOUR
	#define	ID_FOR_Z_FIVE		CMD_ID_FOR_Z_FIVE
	
	#define	ID_FOR_MICAZ_ONE	CMD_ID_FOR_MICAZ_ONE
	#define	ID_FOR_MICAZ_TWO	CMD_ID_FOR_MICAZ_TWO
	#define	ID_FOR_MICAZ_THREE	CMD_ID_FOR_MICAZ_THREE
	#define	ID_FOR_MICAZ_FOUR	CMD_ID_FOR_MICAZ_FOUR
	#define	ID_FOR_MICAZ_FIVE	CMD_ID_FOR_MICAZ_FIVE
#endif
#define PERIODIC_CYCLES			CMD_PERIODIC_CYCLES 
#define	MAX_ACTIVE_CYCLES		CMD_MAX_ACTIVE_CYCLES
#define	RCV_GRADE_NUM_TO_SET	CMD_RCV_GRADE_NUM_TO_SET
#define	START_GRADE				CMD_START_GRADE
/*GEN_DATA_IN_R: 1: generate data in R status; 0: generate data in function pri_qsend_packet;*/
#define	GEN_DATA_IN_R	CMD_GEN_DATA_IN_R

#define PRI_SYNC_SUPPORT CMD_PRI_SYNC_SUPPORT 
#define RANDOM_DRIFT_IN_COOJA_SUPPORT CMD_RANDOM_DRIFT_IN_COOJA_SUPPORT
  
#define CROSS_PLATFORM_SUPPORT	CMD_CROSS_PLATFORM_SUPPORT 
#define	IS_COOJA_SIM	CMD_IS_COOJA_SIM    

#endif /*__PROJECT_CONF_H__*/
