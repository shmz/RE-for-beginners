str_trim:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
; for()の最初の部分はここから始まる
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	strlen
	mov	QWORD PTR [rbp-8], rax   ; str_len
; for()の最初の部分はここで終わる
	jmp	.L2
; for()の本体はここから始まる
.L5:
	cmp	BYTE PTR [rbp-9], 13     ; c=='\r'?
	je	.L3
	cmp	BYTE PTR [rbp-9], 10     ; c=='\n'?
	jne	.L4
.L3:
	mov	rax, QWORD PTR [rbp-8]   ; str_len
	lea	rdx, [rax-1]             ; EDX=str_len-1
	mov	rax, QWORD PTR [rbp-24]  ; s
	add	rax, rdx                 ; RAX=s+str_len-1
	mov	BYTE PTR [rax], 0        ; s[str_len-1]=0
; for()の本体はここで終わる
; for()の第3部分はここから始まる
	sub	QWORD PTR [rbp-8], 1     ; str_len--
; for()の第3部分はここで終わる
.L2:
; for()の第2部分はここから始まる
	cmp	QWORD PTR [rbp-8], 0     ; str_len==0?
	je	.L4                      ; その場合は終了
; 第2条件をチェックし、"c"をロード
	mov	rax, QWORD PTR [rbp-8]   ; RAX=str_len
	lea	rdx, [rax-1]             ; RDX=str_len-1
	mov	rax, QWORD PTR [rbp-24]  ; RAX=s
	add	rax, rdx                 ; RAX=s+str_len-1
	movzx	eax, BYTE PTR [rax]      ; AL=s[str_len-1]
	mov	BYTE PTR [rbp-9], al     ; ロードした文字を"c"に格納
	cmp	BYTE PTR [rbp-9], 0      ; ゼロか？
	jne	.L5                      ; はい？ その場合は終了
; for()の第2部分はここで終わる
.L4:
; "s"を返す
	mov	rax, QWORD PTR [rbp-24]  
	leave
	ret