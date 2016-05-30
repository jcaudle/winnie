default: build

.PHONY: clean

run: build/os.iso
	qemu-system-x86_64 -cdrom build/os.iso

build: build/os.iso

build/os.iso: build/kernel.bin grub.cfg
	mkdir -p build/isofiles/boot/grub
	cp grub.cfg build/isofiles/boot/grub
	cp build/kernel.bin build/isofiles/boot/
	grub-mkrescue -o build/os.iso build/isofiles

build/kernel.bin: build/multiboot_header.o build/boot.o linker.ld
	x86_64-pc-elf-ld --nmagic --output=build/kernel.bin --script=linker.ld build/multiboot_header.o build/boot.o

build/multiboot_header.o: multiboot_header.asm
	mkdir -p build
	nasm -f elf64 multiboot_header.asm -o build/multiboot_header.o

build/boot.o: boot.asm
	mkdir -p build
	nasm -f elf64 boot.asm -o build/boot.o

clean:
	rm -rf build
