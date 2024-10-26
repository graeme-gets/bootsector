all:
	nasm boot.asm -f bin -o boot_sec.bin
	qemu-system-x86_64.exe boot_sec.bin
c: 
	nasm boot.asm -f bin -o boot_sec.bin
r:
	qemu-system-x86_64.exe boot_sec.bin
e:
	vim boot.asm
m:
	vim makefile	
b:
	bochs

c1:
	nasm findx.asm -f bin -o boot_sec.bin
