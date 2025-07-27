c$ = 8
toupper	PROC
	mov	BYTE PTR [rsp+8], cl
	movsx	eax, BYTE PTR c$[rsp]
	cmp	eax, 97
	jl	SHORT $LN2@toupper
	movsx	eax, BYTE PTR c$[rsp]
	cmp	eax, 122
	jg	SHORT $LN2@toupper
	movsx	eax, BYTE PTR c$[rsp]
	sub	eax, 32
	jmp	SHORT $LN3@toupper
	jmp	SHORT $LN1@toupper	; コンパイラの成果物
$LN2@toupper:
	movzx	eax, BYTE PTR c$[rsp]	; 不要なキャスト
$LN1@toupper:
$LN3@toupper:				; コンパイラの成果物
	ret	0
toupper	ENDP