;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Print routines for 32 bit protected mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[bits 32]

VIDEO_MEMORY        equ 0xb8000
VIDEO_MEMORY_SIZE   equ 0xfa0
WHITE_ON_BLACK      equ 0x0f
WHITE_ON_BLUE       equ 0x1f
BLUE_ON_GRAY        equ 0x0A



COLOR_BLACK         equ 0x000000
COLOR_BLUE          equ 0x0000AA
COLOR_GREEN         equ 0x00AA00
COLOR_CYAN          equ 0x00AAAA
COLOR_RED           equ 0xAA0000
COLOR_PURPLE        equ 0xAA00AA
COLOR_BROWN         equ 0xAA5500
COLOR_GRAY          equ 0xAAAAAA
COLOR_LT_BLUE       equ 0x5555FF

cls:
    pusha  
    mov eax, VIDEO_MEMORY_SIZE-1
    mov edx, VIDEO_MEMORY
    mov al,0x20                 ; Space character
    mov ah,WHITE_ON_BLUE
clsloop:
    mov [edx],ax
    dec ebx
    add edx, 2
    cmp ebx,0
    jne clsloop
    popa
    ret
    
print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLUE

	cmp al, 0
	je print_string_pm_done

	mov [edx], ax

	add ebx, 1
	add edx, 2

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
