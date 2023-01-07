#ifndef __PROJECT_CONF_H__
#define __PROJECT_CONF_H__



#undef NETSTACK_CONF_MAC
#define NETSTACK_CONF_MAC     csma_driver

#undef NETSTACK_CONF_RDC
#define NETSTACK_CONF_RDC     contikimac_driver /*nullrdc_driver*/ /*sicslowmac_driver, cxmac_driver, contikimac_driver*/

#undef NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE
#define NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE 8 /*modified by fei tong : from 8 to 20*/

#undef CC2420_CONF_AUTOACK
#define CC2420_CONF_AUTOACK              0

#undef CONTIKIMAC_CONF_WITH_PHASE_OPTIMIZATION
#define CONTIKIMAC_CONF_WITH_PHASE_OPTIMIZATION		1

#endif /*__PROJECT_CONF_H__*/
