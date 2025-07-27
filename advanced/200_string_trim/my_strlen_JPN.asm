; RCX = 入力文字列へのポインタ
; RAX = 現在の文字列長
        xor     rax, rax
label:
        cmp     byte ptr [rcx+rax], 0
        jz      exit
        inc     rax
        jmp     label
exit:
; RAX = 文字列長