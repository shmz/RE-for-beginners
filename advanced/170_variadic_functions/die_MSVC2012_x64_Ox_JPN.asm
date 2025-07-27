fmt$ = 48
die	PROC
	; シャドウスペースに最初の4つの引数を保存
	mov	QWORD PTR [rsp+8], rcx
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+32], r9
	sub	rsp, 40
	lea	rdx, QWORD PTR fmt$[rsp+8] ; 第1引数へのポインタを渡す
	; RCXはまだdie()の第1引数（フォーマット文字列）を指している
	; よってvprintf()はRCXから直接それを取得する
	call	vprintf
	xor	ecx, ecx
	call	exit
	int	3
die	ENDP