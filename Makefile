default: build

.PHONY: clean

run: os.iso
	qemu-system-x86_64 -cdrom os.iso

build: os.iso

os.iso: kernel.bin grub.cfg
	mkdir -p isofiles/boot/grub
	cp grub.cfg isofiles/boot/grub
	cp kernel.bin isofiles/boot/
	grub-mkrescue -o os.iso isofiles

kernel.bin: multiboot_header.o boot.o linker.ld
	x86_64-pc-elf-ld --nmagic --output=kernel.bin --script=linker.ld multiboot_header.o boot.o

multiboot_header.o: multiboot_header.asm
	nasm -f elf64 multiboot_header.asm

boot.o: boot.asm
	nasm -f elf64 boot.asm

clean:
	rm -f multiboot_header.o
	rm -f boot.o
	rm -f kernel.bin
	rm -rf isofiles
	rm -r os.iso
