; X0=a1
; X1=a2
; X2=cnt
f:
	cbz	x2, .L1            ; cnt==0? 終了する
; "a1"配列の最後の要素を計算
	add	x2, x2, x2, lsl 1
; X2=X2+X2<<1=X2+X2*2=X2*3
	mov	x3, 0
	lsl	x2, x2, 2
; X2=X2<<2=X2*4=X2*3*4=X2*12
.L3:
	ldr	w4, [x1],28        ; X1でロード、X1に28を加算（後置インクリメント）
	str	w4, [x0,x3]        ; X0+X3=a1+X3に格納
	add	x3, x3, 12         ; X3をシフト
	cmp	x3, x2             ; 終了？
	bne	.L3
.L1:
	ret