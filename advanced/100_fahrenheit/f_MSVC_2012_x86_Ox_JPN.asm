$SG4228	DB	'華氏温度を入力してください:', 0aH, 00H
$SG4230	DB	'%lf', 00H
$SG4231	DB	'入力の解析中にエラーが発生しました', 0aH, 00H
$SG4233	DB	'エラー：正しくない温度です！', 0aH, 00H
$SG4234	DB	'摂氏: %lf', 0aH, 00H
__real@c071100000000000 DQ 0c071100000000000r	; -273
__real@4040000000000000 DQ 04040000000000000r	; 32
__real@4022000000000000 DQ 04022000000000000r	; 9
__real@4014000000000000 DQ 04014000000000000r	; 5

_fahr$ = -8	; size = 8
_main	PROC
	sub	esp, 8
	push	esi
	mov	esi, DWORD PTR __imp__printf
	push	OFFSET $SG4228		; '華氏温度を入力してください:'
	call	esi			; call printf()
	lea	eax, DWORD PTR _fahr$[esp+16]
	push	eax
	push	OFFSET $SG4230		; '%lf'
	call	DWORD PTR __imp__scanf
	add	esp, 12	
	cmp	eax, 1
	je	SHORT $LN2@main
	push	OFFSET $SG4231		; '入力の解析中にエラーが発生しました'
	call	esi	; call printf()
	add	esp, 4
	push	0
	call	DWORD PTR __imp__exit
$LN9@main:
$LN2@main:
	movsd	xmm1, QWORD PTR _fahr$[esp+12]
	subsd	xmm1, QWORD PTR __real@4040000000000000 ; 32
	movsd	xmm0, QWORD PTR __real@c071100000000000 ; -273
	mulsd	xmm1, QWORD PTR __real@4014000000000000 ; 5
	divsd	xmm1, QWORD PTR __real@4022000000000000 ; 9
	comisd	xmm0, xmm1
	jbe	SHORT $LN1@main
	push	OFFSET $SG4233		; 'エラー：正しくない温度です！'
	call	esi		; call printf()
	add	esp, 4
	push	0
	call	DWORD PTR __imp__exit
$LN10@main:
$LN1@main:
	sub	esp, 8
	movsd	QWORD PTR [esp], xmm1
	push	OFFSET $SG4234		; '摂氏: %lf'
	call	esi			; call printf()
	add	esp, 12
	; return 0 - by C99 standard
	xor	eax, eax
	pop	esi
	add	esp, 8
	ret	0
$LN8@main:
_main	ENDP