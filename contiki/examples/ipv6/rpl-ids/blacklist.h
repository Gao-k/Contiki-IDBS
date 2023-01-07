#include "lib/list.h"
#include "lib/memb.h"

#include "net/ip/uip-debug.h"

typedef struct blacklist {
  struct blacklist *next;
  int id;
}blacklist_t;

LIST(blacklist_table);
MEMB(mem, blacklist_t, 8);