.data

SYSEXIT = 60
EXIT_SUCCESS = 0

dec_int: .ascii "%d",  
flo_point: .ascii "%f",  
 
.bss
.comm numb1, 8
.comm numb2, 8
.comm bool1, 8
 
.text
.globl _start
_start:

mov $0, %rax
mov $dec_int, %rdi
mov $numb1, %rsi
call scanf

mov $1, %rax
mov $flo_point, %rdi
mov $numb2, %rsi
call scanf

#mov $0, %rax
#mov $dec_int, %rdi
#mov $bool1, %rsi
#call scanf





end:
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
