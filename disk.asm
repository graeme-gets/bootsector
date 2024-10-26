;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function to read from the disk
;load DHsectors to ES:BX from drive DL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

diskLoad:
    push dx

    mov ah,0x02         ; BIOS read sector function
    mov al,dh           ; Read DH sectors
    mov ch,0x00         ; Select cylinder 0
    mov dh,0x00
    mov cl,0x02         ; Start  reading from second sector - ie after boot sector

    int 0x13            ; BIOS interrupt

    jc disk_error_BIOS

    pop dx
    cmp dh,al           ; if AL (sectors read) != DH (sectors ecpected) 
    jne disk_error_SECT      
    ret

disk_error_BIOS:
        mov si, DISK_ERROR_BIOS
        call printString
        jmp $

disk_error_SECT:
        mov si, DISK_ERROR_SECT
        call printString
        jmp $

; Variables
DISK_ERROR_BIOS: db "Disk BIOS error!", 0xa, 0xd, 0
DISK_ERROR_SECT: db "Disk sector error!", 0xa, 0xd, 0
