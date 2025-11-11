// mlibc.c - c99 clang i386 
// main functions of libc like printf
#include "stdio.h"

extern int sys_write(int fd, const void *buf, size_t count);
extern void sys_exit(int exit_code);

int write(int fd, const void *buf, size_t count) {
    return sys_write(fd, buf, count);
}

void exit(int exit_code) {
    sys_exit(exit_code);
}

// TODO: sys_read, sys_open, sys_close, sys_exit, sys_brk/sbrk

/* simple itoa for %d */
static void itoa(int v, char *buf) {
    char tmp[12];
    int i = 0, neg = 0;
    if (v < 0) { neg = 1; v = -v; }
    if (v == 0) { buf[0]='0'; buf[1]=0; return; }
    while (v) { tmp[i++] = '0' + (v % 10); v /= 10; }
    if (neg) tmp[i++]='-';
    int j=0;
    while (i--) buf[j++]=tmp[i];
    buf[j]=0;
}

/* minimal printf impl with %s, %d support */
int printf(const char *fmt, ...) {
    const char **argp = (const char**)&fmt;
    char out[512];
    int outi = 0;
    argp++; /* points to first variadic arg */
    while (*fmt) {
        if (*fmt == '%') {
            fmt++;
            if (*fmt == 's') {
                const char *s = *argp++;
                while (*s) out[outi++] = *s++;
            } else if (*fmt == 'd') {
                int v = *(int*)argp++;
                char num[12];
                itoa(v, num);
                char *p = num;
                while (*p) out[outi++] = *p++;
            } else {
                out[outi++] = *fmt;
            }
        } else {
            out[outi++] = *fmt;
        }
        fmt++;
    }
    /* write out */
    out[outi] = 0;
    write(1, out, outi);
    return outi;
}

/* bump allocator */
static char heap[65536];
static size_t heap_off = 0;
void *malloc(size_t n) {
    if (heap_off + n > sizeof(heap)) return 0;
    void *r = &heap[heap_off];
    heap_off += (n + 3) & ~3;
    return r;
}
void free(void *p) { (void)p; /* no-op */ }