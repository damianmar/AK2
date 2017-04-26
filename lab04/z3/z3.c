#include <stdio.h>

char word[]  = "0123456789";
const int sting_length = 10;
const int key = 3;

int main()
{
	asm(
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
    
		);

	printf("%s", word);
	return 0;
}
