;
;Asimplebootsectorprogramthatdemonstratessegmentoffsetting
;
    mov ah,0x0e          ;int10/ah=0eh->scrollingteletypeBIOSroutine
    mov al,[the_secret]
    int 0x10                 ;DoesthisprintanX?
    mov bx,0x7c0             ;Can’tsetdsdirectly,sosetbx
    mov ds,bx                ;thencopybxtods.
    mov al,[the_secret]
    int 0x10                 ;DoesthisprintanX?
    mov al,[es:the_secret]   ;TelltheCPUtousethees(notds)segment.
    int 0x10                 ;DoesthisprintanX?
    mov bx,0x7c0
    mov es,bx
    mov al,[es:the_secret]
    int 0x10                 ;DoesthisprintanX?
    jmp $                       ;Jumpforever.
    the_secret:
    db"X"
    ;PaddingandmagicBIOSnumber.
    times 510-($-$$) db 0
    dw 0xaa55