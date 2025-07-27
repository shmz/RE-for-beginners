_key$ = 8                ; size = 4
_len$ = 12               ; size = 4
_hash$ = 16              ; size = 4
_crc    PROC
    mov    edx, DWORD PTR _len$[esp-4]
    xor    ecx, ecx ; i はECXに格納される
    mov    eax, edx
    test   edx, edx
    jbe    SHORT $LN1@crc
    push   ebx
    push   esi
    mov    esi, DWORD PTR _key$[esp+4] ; ESI = key
    push   edi
$LL3@crc:

; 32ビットレジスタのみを使ってバイトを扱う。key+iアドレスからのバイトをEDIに格納

    movzx  edi, BYTE PTR [ecx+esi] 
    mov    ebx, eax ; EBX = (hash = len)
    and    ebx, 255 ; EBX = hash & 0xff

; XOR EDI, EBX (EDI=EDI^EBX) - この操作は各レジスタの32ビット全てを使う
; しかし他のビット（8-31）は常にクリアされているので問題ない
; これらがクリアされているのは、EDIに関しては上記のMOVZX命令によって行われ、
; EBXの上位ビットは上記のAND EBX, 255命令でクリアされるため（255 = 0xff）

    xor    edi, ebx

; EAX=EAX>>8; 24-31ビットは§\IT{どこからも}§取得されずクリアされる
    shr    eax, 8

; EAX=EAX^crctab[EDI*4] - crctab[]テーブルからEDI番目の要素を選択
    xor    eax, DWORD PTR _crctab[edi*4]
    inc    ecx            ; i++
    cmp    ecx, edx       ; i<len ?
    jb     SHORT $LL3@crc ; yes
    pop    edi
    pop    esi
    pop    ebx
$LN1@crc:
    ret    0
_crc    ENDP