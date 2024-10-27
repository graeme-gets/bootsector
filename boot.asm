;
; A Simple Boot sector to print a message
;


[org 0x7c00]

; Start Up

mov [BOOT_DRIVE], dl		; BIOS stores our boot drive in DL,so it’s	best to remember this for later.

	mov si, BOOT_MSG
	call printString
	mov cl,0x02        ; two byte value 
	mov edx,0x1234
	call printHex
	mov si, NEW_LINE
	call printString
	
	

	; read from disk
	
	mov bp,0x8000				; set stack safely out of the way
	mov sp, bp

	mov bx, 0x9000				; Load 5 sectors to 0x0000(ES):0x9000(BX) from boot disk
	mov dh, 5			
	mov dl, [BOOT_DRIVE]
	call diskLoad

	mov dx, [0x9000]			; PRIN TTH EFIRST LOADED WORD
	mov cx,2					; print two bytes
	call printHex

	mov dx, [0x9000 + 512]		; prin tdata that came form 2nd sector
	mov cx,2
	call printHex
	jmp end


end:
	cli
	hlt	

	



; Includes
%include "print.asm"
%include "disk.asm"


;GLOBAL VERIABLES
BOOT_MSG: db 'Loading osGG-x86', 0xa, 0xd, 0
BOOT_DRIVE: db 0


; Padding Bios and Magic number

	times 510-($-$$) db 0

	dw 0xaa55

	times 256 dw 0xdada
	times 256 dw 0xface
