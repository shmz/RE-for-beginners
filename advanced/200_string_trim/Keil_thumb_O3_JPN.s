str_trim PROC
        PUSH     {r4,lr}
        MOVS     r4,r0
; R4=s
        BL       strlen        ; strlen() はR0から"s"の値を取得
; R0=str_len
        MOVS     r3,#0
; R3は常に0を保持
        B        |L0.24|
|L0.12|
        CMP      r1,#0xd       ; ロードしたバイトは'\r'か？
        BEQ      |L0.20|       
        CMP      r1,#0xa       ; ロードしたバイトは'\n'か？
        BNE      |L0.38|       ; いいえなら終了へジャンプ
|L0.20|
        SUBS     r0,r0,#1      ; R0-- またはstr_len--
        STRB     r3,[r2,#0x1f] ; アドレスR2+0x1F=s+str_len-0x20+0x1F=s+str_len-1に0を格納
|L0.24|
        CMP      r0,#0         ; str_len==0?
        BEQ      |L0.38|       ; はい？終了へジャンプ
        ADDS     r2,r4,r0      ; R2=R4+R0=s+str_len
        SUBS     r2,r2,#0x20   ; R2=R2-0x20=s+str_len-0x20
        LDRB     r1,[r2,#0x1f] ; アドレスR2+0x1F=s+str_len-0x20+0x1F=s+str_len-1のバイトをR1にロード
        CMP      r1,#0         ; ロードしたバイトは0か？
        BNE      |L0.12|       ; 0でないならループ開始へジャンプ
|L0.38|
; "s"を返す
        MOVS     r0,r4
        POP      {r4,pc}
        ENDP