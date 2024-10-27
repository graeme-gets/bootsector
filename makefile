cr:
	nasm boot.asm -f bin -o boot_sec.bin
	qemu-system-x86_64.exe boot_sec.bin
c: 
	nasm boot.asm -f bin -o boot_sec.bin -l boot_sec.lst
r:
	qemu-system-x86_64.exe boot_sec.bin
e:
	vim boot.asm
m:
	vim makefile	
b:
	bochs -qf bochsrc 

c1:
	nasm findx.asm -f bin -o boot_sec.bin
d: 
	bochsdbg.exe -qf bochsrc 