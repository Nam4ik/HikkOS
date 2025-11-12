#include "kernel.h"
#include "gdt.h" 

unsigned int vga_pointer_x; 
unsigned int vga_pointer_y; 

/* syscalls */
void vga_char_put(unsigned int x, unsigned int y, unsigned const char character, unsigned const char attr, ...) {
    vga_char* vga_buffer = (vga_char*)VGA_BUFFER; 

    if (x >= VGA_WIDTH || y >= VGA_HEIGHT) return;
    unsigned int index = y * VGA_WIDTH + x;
    vga_buffer[index].character = character;
    vga_buffer[index].attribute = attr;

}

void vga_clear_screen(unsigned char attribute) {
    for (unsigned int y = 0; y < VGA_HEIGHT; y++) {
        for (unsigned int x = 0; x < VGA_WIDTH; x++) {
            vga_char_put(x, y, ' ', attribute); 
        }
    }
}

/* minimal VGA printf functions analogue */
void kprint(const char fmt[]) {
    vga_clear_screen(VGA_COLOR(VGA_COLOR_WHITE, VGA_COLOR_BLACK));

    for(int i = 0; i < fmt; i++) {
        if(fmt[i] == '\n') {
            if (vga_pointer_y >= VGA_HEIGHT) { 
                vga_pointer_y = 0;
         }
            else { 
                vga_pointer_y++;
            }
            vga_pointer_x = 0;
            continue;
        }
        vga_char_put(vga_pointer_x, vga_pointer_y, fmt[i], VGA_COLOR(VGA_COLOR_WHITE, VGA_COLOR_BLACK));
        vga_pointer_x++; 
    }
}

/* 
   kernel entry point 
   TODO: Syscall wrappers
*/
void kmain(void)
{   
    kprint("Starting initialising kern..."); 
    gdt_init(); 
    kprint("Successfully initialised global descriptor table."); 
    
    /* infinte kernel cycle */
    for (;;)
    {
     kprint("Kernel started.");
    }
}
