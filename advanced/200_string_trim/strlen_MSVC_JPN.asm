; RCX = 入力文字列へのポインタ
; RAX = 現在の文字列長
	or	rax, -1
label:
	inc	rax
	cmp	BYTE PTR [rcx+rax], 0
	jne	SHORT label
; RAX = 文字列長