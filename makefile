MACHINE := NONE

ifeq ($(OS),Windows_NT)
	MACHINE := WIN32
else
	UNAME := $(shell uname -s)
	ifeq ($(UNAME),Linux)
		MACHINE :=Linux
	endif

endif
	


cr:
	nasm boot.asm -f bin -o boot_sec.bin
	qemu-system-x86_64.exe boot_sec.bin
c: 
	nasm boot32.asm -f bin -o boot_sec.bin -l boot_sec.lst
r:
	qemu-system-x86_64.exe boot_sec.bin
e:
	vim boot.asm
m:
	vim makefile	

b:
	@echo $(MACHINE)
ifeq ($(MACHINE),Linux)
	@echo "Running for LINUX"
	#bochs -qf ./bochsrc.linux
	bochs -qf ./bochsrc.linux
else
	@echo "Running for WIN32"
	bochsdbg -qf ./bochsrc.win
	#bochs -qf ./bochsrc.win
endif	

c1:
	nasm findx.asm -f bin -o boot_sec.bin
d: 
	bochsdbg.exe -qf bochsrc
i:
	@echo $(MACHINE)	
