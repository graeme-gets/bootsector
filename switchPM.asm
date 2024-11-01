;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Routine to switch from 16 Real Mode into 
; 32 bit protected mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[bits 16]
switch_to_pm:
	cli                         ; Clear interrupt flag
	lgdt [gdt_descriptor]       ; Load the GDT descriptor
	
	mov eax,cr0                 ; Set the proteced mode flag
	or eax, 0x1
	mov cr0,eax

	jmp CODE_SEG:init_pm        ; Jump to the new CODE segment as per the GDT


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 32 MODE Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[bits 32]

; Initialise registers and the stack once in PM
init_pm:
	mov ax, DATA_SEG	; Move old Segments to DATA_SEG defined in GDT
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	; Update stack point to top of free space
	mov esp, ebp		

	call BEGIN_PM       ; Call the begining of main code 
	
