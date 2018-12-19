global _start
 
section .text
_start:

xor ebx, ebx ; clear ebx
push ebx ;null terminator
push dword 0x766d2f6e ;"vm/n"
push dword 0x69622f2f ;"ib//"
mov ebx,esp ;ebx has now pointer to the filename
xor eax,eax ; clear eax
push eax ; null terminator
push dword 0x6f6f6f66; ooof, old file name
mov ecx,esp; pointer to string ooof
push eax; null terminated
push dword 0x72616162; baar, new file name
mov edi,esp; edi has pointer to baar string
push eax; null terminator
push edi; baar
push ecx; fooo
push ebx; //bin/mv
mov ecx, esp; pointer to //bin/mv fooo baar string
mov al,0xb ;exev syscall
int 0x80 ;initate syscall
