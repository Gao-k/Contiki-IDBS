#include "contiki.h"
#include "lib/list.h"
#include "lib/memb.h"
#include "net/ip/uip-debug.h"
struct blacklist
{
  struct blacklist *next;
  const int id;
};
LIST(blacklist_table);
MEMB(mem, struct blacklist,10); 