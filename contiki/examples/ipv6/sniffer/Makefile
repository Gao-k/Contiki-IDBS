CONTIKI = ../../..
CONTIKI_PROJECT = sniffer

CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"

ifdef PERIOD
CFLAGS+=-DPERIOD=$(PERIOD)
endif

CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include