str_trim:
	push	rbx
	mov	rbx, rdi
; RBXは常に"s"になる
	call	strlen
; str_len==0をチェックし、そうであれば終了
	test	rax, rax
	je	.L9
	lea	rdx, [rax-1]
; RDXは常にstr_len-1の値を含む、str_lenではない
; よってRDXはバッファインデックス変数のようなもの
	lea	rsi, [rbx+rdx]      ; RSI=s+str_len-1
	movzx	ecx, BYTE PTR [rsi] ; 文字をロード
	test	cl, cl
	je	.L9                 ; ゼロであれば終了
	cmp	cl, 10
	je	.L4
	cmp	cl, 13              ; '\n'でも'\r'でもなければ終了
	jne	.L9
.L4:
; これは奇妙な命令。ここではRSI=s-1が必要
; MOV RSI, EBX / DEC RSIで取得可能
; ただしこれは1つではなく2つの命令
	sub	rsi, rax
; RSI = s+str_len-1-str_len = s-1
; メインループ開始
.L12:
	test	rdx, rdx
; アドレスs-1+str_len-1+1 = s-1+str_len = s+str_len-1にゼロを格納
	mov	BYTE PTR [rsi+1+rdx], 0  
; str_len-1==0をチェック。そうであれば終了。
	je	.L9
	sub	rdx, 1                   ; str_len--と同等
; アドレスs+str_len-1で次の文字をロード
	movzx	ecx, BYTE PTR [rbx+rdx]  
	test	cl, cl                   ; ゼロか？ その場合は終了
	je	.L9
	cmp	cl, 10                   ; '\n'か？
	je	.L12
	cmp	cl, 13                   ; '\r'か？
	je	.L12
.L9:
; "s"を返す
	mov	rax, rbx
	pop	rbx
	ret