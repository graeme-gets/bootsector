;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Simple Bootloader for x86 systems
; - intial boot set up
; - switch into 32 bit protected mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;[org 0x7c00]
KERNEL_OFFSET equ 0x1000    ; Memory offset for Kernel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start up in 16 bit real mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov [BOOT_DRIVE], dl    ; Save boot drive

	mov bp, 0x9000			; Set up stack pointer
	mov sp, bp

	mov si, MSG_REAL_MODE		; Print REAl MODE message
	call printString

    call load_kernel

	call switch_to_pm		; Initiate the switch to Protected mode

	jmp $				; Infinite loop - Should never get here

%include "print16.asm"
%include "disk.asm"
%include "gdt.asm"
%include "print32.asm"
%include "switchPM.asm"

[bits 16]

load_kernel:
    mov si, MSG_LOAD_KERNEL
    call printString

    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl,[BOOT_DRIVE]
    call diskLoad

    ret

MSG_REAL_MODE db "Starting in 16-Bit Mode",0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Protected Mode code 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BEGIN_PM:
	; TODO: clear screen (direct write to memory
    call cls
	mov ebx, MSG_PROT_MODE		; Print Message
	call print_string_pm

    call KERNEL_OFFSET

	jmp $

BOOT_DRIVE db 0
MSG_PROT_MODE db "Success! We are in 32 bit protected mode",0xa,0xd, 0
MSG_LOAD_KERNEL db "Loading Kernel",0xa,0xd,0

	times 510-($-$$) db 0
	dw 0xaa55
