[org 0x7c00]

	mov bp, 0x9000
	mov sp, bp

	mov si, MSG_REAL_MODE
	call printString

	call switch_to_pm

	jmp $

%include "print.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switchPM.asm"

MSG_REAL_MODE db "Starting in 16-Bit Mode",0

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	jmp $

;MSG_REAL_MODE db "Starting in 16-Bit Mode",0
MSG_PROT_MODE db "Success! We are in 32 bit protected mode",0

	times 510-($-$$) db 0
	dw 0xaa55
