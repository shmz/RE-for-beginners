str_trim PROC
        PUSH     {r4,lr}
; R0=s
        MOV      r4,r0
; R4=s
        BL       strlen       ; strlen() はR0から"s"の値を取得
; R0=str_len
        MOV      r3,#0
; R3は常に0を保持
|L0.16|
        CMP      r0,#0        ; str_len==0?
        ADDNE    r2,r4,r0     ; (str_len!=0の場合) R2=R4+R0=s+str_len
        LDRBNE   r1,[r2,#-1]  ; (str_len!=0の場合) R1=アドレスR2-1=s+str_len-1のバイトをロード
        CMPNE    r1,#0        ; (str_len!=0の場合) ロードしたバイトを0と比較
        BEQ      |L0.56|      ; str_len==0またはロードしたバイトが0なら終了へジャンプ
        CMP      r1,#0xd      ; ロードしたバイトは'\r'か？
        CMPNE    r1,#0xa      ; (ロードしたバイトが'\r'でない場合) ロードしたバイトは'\n'か？
        SUBEQ    r0,r0,#1     ; (ロードしたバイトが'\r'または'\n'の場合) R0-- またはstr_len--
        STRBEQ   r3,[r2,#-1]  ; (ロードしたバイトが'\r'または'\n'の場合) R3 (ゼロ)をアドレスR2-1=s+str_len-1に格納
        BEQ      |L0.16|      ; ロードしたバイトが'\r'または'\n'だった場合ループ開始へジャンプ
|L0.56|
; "s"を返す
        MOV      r0,r4
        POP      {r4,pc}
        ENDP