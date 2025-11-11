ENTRY(_start) 

SECTIONS
{
    /* kernel load 1 MiB (0x100000) */
    . = 0x100000;

    /* .text - exec */
    .text : ALIGN(4K)
    {
        /* *(.text.startup) */     
        *(.text)            
    }

    /* .rodata - consts */
    .rodata : ALIGN(4K)
    {
        *(.rodata*)         
    }

    /* .data - initialised data and vars */
    .data : ALIGN(4K)
    {
        *(.data)            
    }

    /* .bss - uninitialised data */
    .bss : ALIGN(4K)
    {
        *(.bss)             
        *(COMMON)           
    }

    /* .bss stop symbol for kernel */
    _kernel_end = .;
}
