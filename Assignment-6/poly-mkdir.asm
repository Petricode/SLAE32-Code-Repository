global _start

section .text
_start:

jmp short label1

label2:
pop esi ; pop the string stored in the stack to esi
push 0x27 ; pushing syscall mkdir into stack
pop eax ; poping the value of the syscall into eax
lea ebx,[esi] ; load string into ebx
push word 0x1ed ; set file privlage 
pop ecx ; file privlage now stored into ecx
int 0x80 ; everything is set, initate system call!
push 0x1 ; pushing 1 into eax for exit syscall
pop eax ; 1 stored into eax
sub ebx,ebx ; clearing ebx to return 0
int 0x80 ; exit gracefuly


label1:


call label2
str1 db 0x68,0x61,0x63,0x6B,0x65,0x64 ; stored filename
