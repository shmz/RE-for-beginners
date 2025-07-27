str_trim:
	stp	x29, x30, [sp, -32]!
	add	x29, sp, 0
	str	x19, [sp,16]
	mov	x19, x0
; X19は常に"s"の値を保持
	bl	strlen
; X0=str_len
	cbz	x0, .L9        ; str_len==0ならL9（終了）へ
	sub	x1, x0, #1
; X1=X0-1=str_len-1
	add	x3, x19, x1
; X3=X19+X1=s+str_len-1
	ldrb	w2, [x19,x1]   ; アドレスX19+X1=s+str_len-1のバイトをロード
; W2=ロードされた文字
	cbz	w2, .L9        ; ゼロか？そうなら終了へジャンプ
	cmp	w2, 10         ; '\n'か？
	bne	.L15
.L12:
; メインループ本体。この時点でロードされた文字は常に10または13！
	sub	x2, x1, x0
; X2=X1-X0=str_len-1-str_len=-1
	add	x2, x3, x2
; X2=X3+X2=s+str_len-1+(-1)=s+str_len-2
	strb	wzr, [x2,1]    ; アドレスs+str_len-2+1=s+str_len-1にゼロバイト格納
	cbz	x1, .L9        ; str_len-1==0? そうなら終了へ
	sub	x1, x1, #1     ; str_len--
	ldrb	w2, [x19,x1]   ; アドレスX19+X1=s+str_len-1の次の文字をロード
	cmp	w2, 10         ; '\n'か？
	cbz	w2, .L9        ; ゼロなら終了へジャンプ
	beq	.L12           ; '\n'ならループ開始へジャンプ
.L15:
	cmp	w2, 13         ; '\r'か？
	beq	.L12           ; はい、ループ本体開始へジャンプ
.L9:
; "s"を返す
	mov	x0, x19
	ldr	x19, [sp,16]
	ldp	x29, x30, [sp], 32
	ret