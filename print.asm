
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
	push ax
	push bx
	mov ah, 0x0e		; BIOS Teletype function
	mov bh,0			; Page 0
	mov bl, 0x07		; Text Attribute (light grey on black)
	int 0x10			; call BIOS intterupt 0x10
	pop bx
	pop ax
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prints a byte or word in hex format
; Assumes value is in DX and can be 32 bit value
; Set BX to number of bytes to use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printHex:
		shl bx,1			; multiply by 2 for nibbles
hexLoop:
		cmp bx,0			; if bx = 0 then exit
        jz hexFin 
        rol edx,4        ; Rotate the word to get first byte ready
        dec bx
        ; Swap 
        mov al,dl       ; copy byte into AL
		and al,0x0f		; clear high nibble
        
        ; Handle al first
        cmp al,0x0a
		jb nibLess
		add al,0x07
nibLess: 			 
		add al,0x30 
        call printChar
        jmp hexLoop
hexFin:
        ret


