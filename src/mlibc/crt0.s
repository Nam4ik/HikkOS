; crt0.asm — intel NASM i386 
BITS 32
global _start

extern main
extern _exit   ; _exit implemented in as `sys_exit` call 

section .text
_start:
    ; Stack on ELF: [argc][argv_ptr][envp_ptr...]
    mov eax, [esp]        ; argc
    mov ebx, esp
    add ebx, 4            ; pointer to argv[0]
    push eax              ; argc
    push ebx              ; argv (pointer)
    call main
    add esp, 8
    push eax              ; return code
    call _exit
