// kernel.h - c99 clang i386  
// main constants and kernel functions

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BUFFER 0xB8000UL
#define VGA_COLOR_BLACK 0 
#define VGA_COLOR_WHITE 7
#define VGA_COLOR_RED 4
#define VGA_COLOR_GREEN 2
#define VGA_COLOR_BLUE 1
#define VGA_COLOR(vga_fg, vga_bg) (((vga_bg & 0x0F) << 4) | (vga_fg & 0x0F))

typedef struct {
    unsigned char character;
    unsigned char attribute;
} __attribute__((packed)) vga_char;


void kmain(void);
void kprint(const char fmt[]);