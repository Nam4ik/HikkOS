# HikkOS 
J4Fun unix-like i386 OS written on Rust, C and NASM. 

**Tech-FAQ**: 
- **libc**: Our implementation of libc: `mlibc` - microlibc. 
- **tech's and language standarts**: We are using C99 and i386 NASM. 

## language-choosing policy
- **ASM** - we use it only when it is necessary or important to directly interact with libc, the assembler is welcome, but not always. 

- **С** - main kernel and utils language

- **Rust** - only in critical places for memory, it is minimally used because it has a large number of dependencies embedded in the object file.

## Philosophy 
**Minimalism, practicality and stability - in these few words, we can paraphrase our ideas.**
