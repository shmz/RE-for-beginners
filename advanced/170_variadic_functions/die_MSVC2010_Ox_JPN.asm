_fmt$ = 8
_die	PROC
	; 第1引数（フォーマット文字列）をロード
	mov	ecx, DWORD PTR _fmt$[esp-4]
	; 第2引数へのポインタを取得
	lea	eax, DWORD PTR _fmt$[esp]
	push	eax 		; ポインタを渡す
	push	ecx
	call	_vprintf
	add	esp, 8
	push	0
	call	_exit
$LN3@die:
	int	3
_die	ENDP