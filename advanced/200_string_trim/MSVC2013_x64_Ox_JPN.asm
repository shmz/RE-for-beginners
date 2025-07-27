s$ = 8
str_trim PROC

; RCXは第1関数引数で、常に文字列へのポインタを保持している
	mov	rdx, rcx
; これはstrlen()関数がここでインライン化されている:
; RAXを0xFFFFFFFFFFFFFFFF (-1)に設定
	or	rax, -1
$LL14@str_trim:
	inc	rax
	cmp	BYTE PTR [rcx+rax], 0
	jne	SHORT $LL14@str_trim
; 入力文字列の長さはゼロ？ その場合は終了:
	test	rax, rax
	je	SHORT $LN15@str_trim
; RAXは文字列の長さを保持
	dec	rcx
; RCX = s-1
	mov	r8d, 1
	add	rcx, rax
; RCX = s-1+strlen(s)、つまり文字列の最後の文字のアドレス
	sub	r8, rdx
; R8 = 1-s
$LL6@str_trim:
; 文字列の最後の文字をロード:
; そのコードが13または10の場合ジャンプ:
	movzx	eax, BYTE PTR [rcx]
	cmp	al, 13
	je	SHORT $LN2@str_trim
	cmp	al, 10
	jne	SHORT $LN15@str_trim
$LN2@str_trim:
; 最後の文字のコードは13または10
; この場所にゼロを書き込む:
	mov	BYTE PTR [rcx], 0
; 最後の文字のアドレスをデクリメント
; 今消去された文字の前の文字を指すようになる:
	dec	rcx
	lea	rax, QWORD PTR [r8+rcx]
; RAX = 1 - s + 現在の最後の文字のアドレス
; これにより最初の文字に到達したか判定でき、そうであれば停止する必要がある
	test	rax, rax
	jne	SHORT $LL6@str_trim
$LN15@str_trim:
	mov	rax, rdx
	ret	0
str_trim ENDP