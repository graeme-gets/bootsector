[bits 16]

; Switch tp protected mode

switch_to_pm:
	cli
	
	lgdt [gdt_descriptor]
	
	mov eax,cr0
	or eax, 0x1
	mov cr0,eax

	jmp CODE_SEG:init_pm


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

	call BEGIN_PM
	
