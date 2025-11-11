; kernel.s - intel NASM i386  
; Kernel-loader 

BITS 32                                                            
section .text
    ;multiboot spec
    align 4
    dd 0x1BADB002           ; magic Multiboot
    dd 0x00                 ; flags                                    
    dd -(0x1BADB002 + 0x00) ; checksum
    global start                                                       
    extern kmain

start:                 
    cli                                                                     
    mov esp, stack_top      ; stackstate call kmain              
    jmp kmain               ; Running C Kernel loop  

.hang: 
    hlt 
    jmp .hang

section .bss
    resb 8192              ; reserves 8 KiB for stack 
stack_top:

section .note.GNU-stack    ; empty 

; nasm -f elf32 kernel.asm -o kernel.o && ld kernel.o -o kernel 

