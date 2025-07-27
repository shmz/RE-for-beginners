; RDI=a1
; RSI=a2
; RDX=cnt
f:
	test	rdx, rdx  ; cnt==0? その場合は終了
	je	.L1
; "a2"の最後の要素のアドレスを計算してRDXに格納
	lea	rax, [0+rdx*4]
; RAX=RDX*4=cnt*4
	sal	rdx, 5
; RDX=RDX<<5=cnt*32
	sub	rdx, rax
; RDX=RDX-RAX=cnt*32-cnt*4=cnt*28
	add	rdx, rsi
; RDX=RDX+RSI=a2+cnt*28
.L3:
	mov	eax, DWORD PTR [rsi]
	add	rsi, 28
	add	rdi, 12
	mov	DWORD PTR [rdi-12], eax
	cmp	rsi, rdx
	jne	.L3
.L1:
	rep ret