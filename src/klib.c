#include <stddef.h>

/* C-part of kernel memory stat */
static struct kstat_memory {
    size_t used;
    size_t free;
    size_t total;
}; 

