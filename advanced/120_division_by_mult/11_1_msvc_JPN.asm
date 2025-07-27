_a$ = 8             ; size = 4
_f    PROC
    push   ebp
    mov    ebp, esp
    mov    eax, DWORD PTR _a$[ebp]
    cdq            ; EAXの符号をEDX:EAXに拡張
    mov    ecx, 9
    idiv   ecx
    pop    ebp
    ret    0
_f  ENDP