#include <stdio.h>
 

char word[] = "abcd0123456789"; 
int key = 3;
int stringLength = 10;

int main(void)
{

    asm(
    "mov $0, %%rbx \n" 
    "decrypt: \n" 
 
    "mov (%0, %%rbx, 1), %%al \n"

    "cmp $'0', %%al \n"
    "jb end_of_decrypt \n"

    "cmp $'9', %%al \n"
    "ja end_of_decrypt \n"

    "add key, %%al \n"
    "cmp $'9', %%al \n"
    "jbe end_of_decrypt \n"
    "movb %%al, %%cl \n"
    "sub $10, %%al \n"
    "jmp end_of_decrypt \n"
    
 
    "end_of_decrypt: \n"
    "movb %%al, (%0, %%rbx, 1) \n"
    "inc %%rbx \n"
    "cmp stringLength, %%rbx \n" 

    "jl decrypt \n" 

    : 
    :"r"(&word)
    :"%rax", "%rbx"
    );
 
 
    printf("Wynik: %s\n", word);
 
    return 0;
}
