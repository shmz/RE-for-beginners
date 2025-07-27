$SG3013	DB	'%d', 0aH, 00H

v$ = 8
arith_mean PROC
	mov	DWORD PTR [rsp+8], ecx   ; 第1引数
	mov	QWORD PTR [rsp+16], rdx  ; 第2引数
	mov	QWORD PTR [rsp+24], r8   ; 第3引数
	mov	eax, ecx                 ; sum = 第1引数
	lea	rcx, QWORD PTR v$[rsp+8] ; 第2引数へのポインタ
	mov	QWORD PTR [rsp+32], r9   ; 第4引数
	mov	edx, DWORD PTR [rcx]     ; 第2引数をロード
	mov	r8d, 1                   ; count=1
	cmp	edx, -1                  ; 第2引数は-1?
	je	SHORT $LN8@arith_mean    ; そうであれば終了
$LL3@arith_mean:
	add	eax, edx	         ; sum = sum + ロードした引数
	mov	edx, DWORD PTR [rcx+8]   ; 次の引数をロード
	lea	rcx, QWORD PTR [rcx+8]   ; その次の引数を指すようにポインタをシフト
	inc	r8d                      ; count++
	cmp	edx, -1                  ; ロードした引数は-1?
	jne	SHORT $LL3@arith_mean    ; そうでなければループ開始に戻る
$LN8@arith_mean:
; 商を計算
	cdq
	idiv	r8d
	ret	0
arith_mean ENDP

main	PROC
	sub	rsp, 56
	mov	edx, 2
	mov	DWORD PTR [rsp+40], -1
	mov	DWORD PTR [rsp+32], 15
	lea	r9d, QWORD PTR [rdx+8]
	lea	r8d, QWORD PTR [rdx+5]
	lea	ecx, QWORD PTR [rdx-1]
	call	arith_mean
	lea	rcx, OFFSET FLAT:$SG3013
	mov	edx, eax
	call	printf
	xor	eax, eax
	add	rsp, 56
	ret	0
main	ENDP