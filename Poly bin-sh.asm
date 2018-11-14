global _start
section .text

_start:

sub ebx,ebx ; replacing xor with sub to zero out the register
push ebx    ; pushing ebx, 0 ontop of the stack
and ecx,ebx ; making use of ebx which is 0 to 'zero' out other regs
and edx,ecx ; zero'ing out edx
push 0x68732f2f ; //sh
push 0x6e69622f ; /bin
xchg ebx, eax ; eax is now 0
lea ebx,[esp] ; loading the strings into ebx
add al,0xb ; syscall 11
int 0x80 ; initate syscall
and eax,ecx ; zero out eax
lea eax,[ecx + 1] ; load 1 to eax
int 0x80 ; exit gracefuly
