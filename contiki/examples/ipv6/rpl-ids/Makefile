all: udp-client udp-server grayhole-attacker
# APPS=servreg-hack
CONTIKI=../../..
CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"
TARGET_LIBFILES += -lm
# APPS+=powertrace
WITH_COMPOWER = 1
ifdef WITH_COMPOWER
APPS+=powertrace
CFLAGS+= -DCONTIKIMAC_CONF_COMPOWER=1 -DWITH_COMPOWER=1 -DQUEUEBUF_CONF_NUM=4
endif

ifdef SERVER_REPLY
CFLAGS+=-DSERVER_REPLY=$(SERVER_REPLY)
endif
ifdef PERIOD
CFLAGS+=-DPERIOD=$(PERIOD)
endif

CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include
