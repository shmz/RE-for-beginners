str_trim:
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	str	x0, [x29,24] ; 入力引数をローカルスタックにコピー
	ldr	x0, [x29,24] ; s
	bl	strlen
	str	x0, [x29,40] ; ローカルスタックのstr_len変数
	b	.L2
; メインループ開始
.L5:
	ldrb	w0, [x29,39]
; W0=c
	cmp	w0, 13       ; '\r'か？
	beq	.L3
	ldrb	w0, [x29,39]
; W0=c
	cmp	w0, 10       ; '\n'か？
	bne	.L4          ; そうでなければ終了へ
.L3:
	ldr	x0, [x29,40]
; X0=str_len
	sub	x0, x0, #1
; X0=str_len-1
	ldr	x1, [x29,24]
; X1=s
	add	x0, x1, x0
; X0=s+str_len-1
	strb	wzr, [x0]    ; s+str_len-1にバイト書き込み
; str_lenをデクリメント：
	ldr	x0, [x29,40]
; X0=str_len
	sub	x0, x0, #1
; X0=str_len-1
	str	x0, [x29,40]
; X0 (またはstr_len-1)をローカルスタックに保存
.L2:
	ldr	x0, [x29,40]
; str_len==0?
	cmp	x0, xzr
; そうなら終了へ
	beq	.L4
	ldr	x0, [x29,40]
; X0=str_len
	sub	x0, x0, #1
; X0=str_len-1
	ldr	x1, [x29,24]
; X1=s
	add	x0, x1, x0
; X0=s+str_len-1
; アドレスs+str_len-1のバイトをW0にロード
	ldrb	w0, [x0]
	strb	w0, [x29,39] ; ロードしたバイトを"c"に格納
	ldrb	w0, [x29,39] ; リロード
; ゼロバイトか？
	cmp	w0, wzr
; ゼロなら終了へ、そうでなければL5へ
	bne	.L5
.L4:
; sを返す
	ldr	x0, [x29,24]
	ldp	x29, x30, [sp], 48
	ret