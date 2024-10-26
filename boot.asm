;
; A Simple Boot sector to print a message
;


[org 0x7c00]

	mov si, BOOT_MSG
	call printString
	mov bx,0x04        ; two byte value 
	mov edx,0xabcd1234
	call printHex
	jmp end


end:
	cli
	hlt	

	

BOOT_MSG: db 'Loading osGG-x86', 0

; Includes
%include "print.asm"

;
; Padding Bios and Magic number

	times 510-($-$$) db 0

dw 0xaa55
