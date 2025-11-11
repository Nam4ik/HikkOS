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


CSRC = $(wildcard $(SRCDIR)/*.c)
ASMSRC_SUBDIRS = $(wildcard $(SRCDIR)/mlibc/*.s) 
ASMSRC = $(wildcard $(SRCDIR)/*.s)


COBJ = $(CSRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
ASMOBJ_SUBDIRS = $(ASMSRC_SUBDIRS:$(SRCDIR)/mlibc/%.s=$(OBJDIR)/mlibc/%.o)
ASMOBJ = $(ASMSRC:$(SRCDIR)/%.s=$(OBJDIR)/%.o)
ALL_OBJ = $(COBJ) $(ASMOBJ) $(ASMOBJ_SUBDIRS)

TARGET = $(BINDIR)/kernel.elf

$(OBJDIR):
	mkdir -p $(OBJDIR)/mlibc 
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled $< to $@"

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(ASM) $(NASMFLAGS) $< -o $@
	@echo "Assembled $< to $@"

$(OBJDIR)/mlibc/%.o: $(SRCDIR)/mlibc/%.s | $(OBJDIR) 
	$(ASM) $(NASMFLAGS) $< -o $@
	@echo "Assembled $< to $@"

$(TARGET): $(ALL_OBJ) | $(BINDIR)
	$(LD) $(LDFLAGS) -o $@ $^
	@echo "Linked $@"

clean:
	rm -rf $(OBJDIR) $(BINDIR)
	@echo "Cleaned build directories."

.PHONY: all clean

# Default target
all: $(TARGET)
	@echo "Build completed: $(TARGET)"