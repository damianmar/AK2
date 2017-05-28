#include <stdio.h>


//const int string_length = 10;
//const int key = 3;
char word[]  = "0123456789";

int main(void)
{
	asm(
		"movq $0, %%rdx \n"
		"decrypt: \n"
		"mov word(%0, %%rdx, 1), %%bl \n"
		"add $3, %%bl \n"
		"movb %%bl, word(%0, %%rdx, 1) \n"
		"inc %%rdx \n"
		"cmp $10, %%rdx \n"
		"jl decrypt \n"

		:
		:"r"(&word)
    	:"%rax", "%rbx", "%rcx", "%rdx"
    
		);

	printf("%s", word);
	return 0;
}
/*	asm(
		"movl $0, %rax \n"
		"decrypt: \n"
		"movb word(%0, %%edx, 1), %%bh \n"
		"add $key, %%bh \n"
		"movb %%bh, word(, %%edx, 1) \n"
		"inc %%edx \n"
		"cmp ,string_length %%edx\n"
		"je decrypt \n"
		:
		:"r"(&word), "t"(string_length), "y"(key)
    	:"%rax", "%rbx", "%rcx", "%rdx"
    
		);*/