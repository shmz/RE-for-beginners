mov	esi, 1
...	; ESIに触れないコード
dec	esi
...	; ESIに触れないコード
cmp	esi, 0
jz	real_code
; 偽の荷物
real_code: