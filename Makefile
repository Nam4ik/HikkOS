# C COMPILER SETTINGS  
CC = clang 
CFLAGS = -target i386-unknown-none -ffreestanding -mno-sse -mno-mmx -mno-80387 -mno-red-zone -c -std=c99 -Wall -Wextra

# NASM settings  
ASM = nasm 
NASMFLAGS = -f elf32 

# LINKER 
LD = ld 
LDFLAGS = -m elf_i386 -T linker.ld 

# Dirs 
SRCDIR = src 
OBJDIR = obj 
BINDIR = bin 

# Source files
CSRC = $(wildcard $(SRCDIR)/*.c)
ASMSRC = $(wildcard $(SRCDIR)/*.s) $(wildcard $(SRCDIR)/mlibc/*.s)

# Rust sources can be added later, e.g., $(wildcard $(SRCDIR)/*.rs)

# Object files
COBJ = $(CSRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
ASMOBJ = $(ASMSRC:$(SRCDIR)/%.s=$(OBJDIR)/%.o)
# ROBJ = $(RSRC:$(SRCDIR)/%.rs=$(OBJDIR)/%.o) for rust later 

# Target result  
TARGET = $(BINDIR)/kernel.elf

# Create directories
$(OBJDIR):
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR)/mlibc

$(BINDIR):
	mkdir -p $(BINDIR)

# Compile C files
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@

# Compile ASM files (ASM)
$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(ASM) $(NASMFLAGS) $< -o $@

# Compile ASM files in subdirectories like mlibc
$(OBJDIR)/mlibc/%.o: $(SRCDIR)/mlibc/%.s | $(OBJDIR)
	$(ASM) $(NASMFLAGS) $< -o $@

# Link all objects into the final executable
$(TARGET): $(COBJ) $(ASMOBJ) | $(BINDIR)
	$(LD) $(LDFLAGS) -o $@ $^

# Clean build files
clean:
	rm -rf $(OBJDIR) $(BINDIR)

# Phony targets
.PHONY: all clean
