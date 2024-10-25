;
; A Simple Boot sector to print a message
;

[org 0x7c00]

	mov si, BOOT_MSG
	call printString
	mov al,0xAF
	call printHex
	jmp end

printString:
	lodsb				; Load the byte at address in SI to AL and Inc SI
	cmp al,0			; check for end of line
	je printStringEnd
	call printChar
	jmp printString
printStringEnd:
	ret


printChar:
	; Call BIOS Routing to print
	mov ah, 0x0e		; BIOS Teletype function
	mov bh,0			; Page 0
	mov bl, 0x07		; Text Attribute (light grey on black)
	int 0x10			; call BIOS intterupt 0x10
	ret


printHex:
		; Print Hi nibble first
		mov ah,0x1 		; set High Byte as Flag
		push ax
		shr al,4
CALCHEX:
		cmp al,0x0a
		jb LESS
		add al,0x07
LESS: 			 
		add al,0x30 

		call printChar
		pop ax
		cmp ah, 0x0
		jz	ENDHEX
		mov ah,0x0
		push ax

		and al,0x0F
		jmp CALCHEX

ENDHEX:
		ret


		
end:
	cli
	hlt	

	

BOOT_MSG: db 'Loading osGG-x86', 0

;
; Padding Bios and Magic number

	times 510-($-$$) db 0

dw 0xaa55
