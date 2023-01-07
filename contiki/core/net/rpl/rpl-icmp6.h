#include "lib/list.h"
#include "lib/memb.h"
extern int NodeID;
struct blacklist
{
  struct blacklist *next;
  const uip_ipaddr_t ipaddr;
};
LIST(blacklist_table);
MEMB(mem, struct blacklist,5);