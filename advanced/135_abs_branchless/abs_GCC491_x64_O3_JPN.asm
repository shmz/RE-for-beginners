my_abs:
	mov	edx, edi
	mov	eax, edi
	sar	edx, 31
; 入力値の符号がマイナスの場合、EDXは0xFFFFFFFF
; 入力値の符号がプラス（0を含む）の場合、EDXは0
; 以下の2つの命令はEDXが0xFFFFFFFFの場合のみ効果がある
; EDXが0の場合は何もしない
	xor	eax, edx
	sub	eax, edx
	ret