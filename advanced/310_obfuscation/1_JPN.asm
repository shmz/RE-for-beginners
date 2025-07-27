xor	esi, 011223344h	; ガベージ
add	esi, eax	; ガベージ
add	eax, ebx
mov	edx, eax	; ガベージ
shl	edx, 4		; ガベージ
mul	ecx
xor	esi, ecx	; ガベージ