$SG2751	DB	'first element %d', 0aH, 00H
$SG2752	DB	'second element %d', 0aH, 00H
$SG2753	DB	'last element %d', 0aH, 00H
$SG2754	DB	'array[-1]=%02X, array[-2]=%02X, array[-3]=%02X, array[-4'
	DB	']=%02X', 0aH, 00H

_fakearray$ = -24		; size = 4
_random_value$ = -20	; size = 4
_array$ = -16		; size = 10
_i$ = -4		; size = 4
_main	PROC
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	DWORD PTR _random_value$[ebp], 287454020 ; 11223344H
	; fakearray[]をarray[]の1バイト前に設定
	lea	eax, DWORD PTR _array$[ebp]
	add	eax, -1 ; eax=eax-1
	mov	DWORD PTR _fakearray$[ebp], eax
	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $LN3@main
	; array[]を0..9で埋める
$LN2@main:
	mov	ecx, DWORD PTR _i$[ebp]
	add	ecx, 1
	mov	DWORD PTR _i$[ebp], ecx
$LN3@main:
	cmp	DWORD PTR _i$[ebp], 10
	jge	SHORT $LN1@main
	mov	edx, DWORD PTR _i$[ebp]
	mov	al, BYTE PTR _i$[ebp]
	mov	BYTE PTR _array$[ebp+edx], al
	jmp	SHORT $LN2@main
$LN1@main:
	mov	ecx, DWORD PTR _fakearray$[ebp]
	; ecx=fakearray[0]のアドレス、ecx+1はfakearray[1]またはarray[0]
	movzx	edx, BYTE PTR [ecx+1]
	push	edx
	push	OFFSET $SG2751 ; 'first element %d'
	call	_printf
	add	esp, 8
	mov	eax, DWORD PTR _fakearray$[ebp]
	; eax=fakearray[0]のアドレス、eax+2はfakearray[2]またはarray[1]
	movzx	ecx, BYTE PTR [eax+2]
	push	ecx
	push	OFFSET $SG2752 ; 'second element %d'
	call	_printf
	add	esp, 8
	mov	edx, DWORD PTR _fakearray$[ebp]
	; edx=fakearray[0]のアドレス、edx+10はfakearray[10]またはarray[9]
	movzx	eax, BYTE PTR [edx+10]
	push	eax
	push	OFFSET $SG2753 ; 'last element %d'
	call	_printf
	add	esp, 8
	; array[]の前の値を見つけるためにarray[0]へのポインタから4、3、2、1を減算
	lea	ecx, DWORD PTR _array$[ebp]
	movzx	edx, BYTE PTR [ecx-4]
	push	edx
	lea	eax, DWORD PTR _array$[ebp]
	movzx	ecx, BYTE PTR [eax-3]
	push	ecx
	lea	edx, DWORD PTR _array$[ebp]
	movzx	eax, BYTE PTR [edx-2]
	push	eax
	lea	ecx, DWORD PTR _array$[ebp]
	movzx	edx, BYTE PTR [ecx-1]
	push	edx
	push	OFFSET $SG2754 ; 'array[-1]=%02X, array[-2]=%02X, array[-3]=%02X, array[-4]=%02X'
	call	_printf
	add	esp, 20
	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP