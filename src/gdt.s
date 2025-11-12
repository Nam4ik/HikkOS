; gdt.s - intel NASM i386 
; global descriptor table

global gdt_init

section .data

; Structure of gdt:
;    0: NULL
;    1: Code segment (privileges 0)
;    2: Data (privileges 0)

gdt:
    ; Zero descriptor : Index = 0
    dd 0x00000000
    dd 0x00000000
    ; Code segment (for privileges 0, 32b): Index = 1
    dd 0x0000FFFF
    dd 0x00CF9A00
    ; Data segment (for Privileges 0, 32b): Index = 2
    dd 0x0000FFFF
    dd 0x00CF9200


gdt_info:
    dw gdt_info - gdt - 1   ; GDT size 
    dd gdt                  ; GDT addr


section .text


gdt_init:
    lgdt [gdt_info]         

    mov ax, 0x10          
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    jmp 0x08:.reload_cs     


.reload_cs:
    ret
