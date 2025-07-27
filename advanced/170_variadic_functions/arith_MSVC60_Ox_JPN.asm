_v$ = 8
_arith_mean PROC NEAR
	mov	eax, DWORD PTR _v$[esp-4] ; 第1引数をsumに読み込み
	push	esi
	mov	esi, 1		          ; count=1
	lea	edx, DWORD PTR _v$[esp]   ; 第1引数のアドレス
$L838:
	mov	ecx, DWORD PTR [edx+4]    ; 次の引数をロード
	add	edx, 4                    ; 次の引数へのポインタをシフト
	cmp	ecx, -1                   ; -1か？
	je	SHORT $L856               ; そうであれば終了
	add	eax, ecx                  ; sum = sum + ロードした引数
	inc	esi                       ; count++
	jmp	SHORT $L838
$L856:
; 商を計算

	cdq
	idiv	esi
	pop	esi
	ret	0
_arith_mean ENDP

$SG851	DB	'%d', 0aH, 00H

_main	PROC NEAR
	push	-1
	push	15
	push	10
	push	7
	push	2
	push	1
	call	_arith_mean
	push	eax
	push	OFFSET FLAT:$SG851 ; '%d'
	call	_printf
	add	esp, 32
	ret	0
_main	ENDP