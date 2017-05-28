.data
SYSREAD = 0
SYSWRITE = 1
SYSEXIT = 60
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
BUFLEN = 128
NUMBER = 5

error_msg: .ascii "Error\n"
not_prim_number: .ascii "Nie jest\n"
prim_number: .ascii "Jest\n"
.bss
.comm txtout, 512

#-1	-2	2	-4	-8	32
.text
.globl _start
_start:


#mov error_msg, %r15
#mov %r15, txtout

#movq $NUMBER, %rax
#movq $2, %rsi

#call prime_number

#movq $SYSWRITE, %rax
#movq $STDOUT, %rdi
#movq $txtout, %rsi
#movq $BUFLEN, %rdx
#syscall
############################################
mov error_msg, %r15
mov %r15, txtout

movq $NUMBER, %rax

call stack_multiply_function
f:
movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $txtout, %rsi
movq $BUFLEN, %rdx
syscall
###################################3


jmp end

#############################################################################





###########################Sprawdz czy jest liczba pierwsza###########################
prime_number:
cmp $2, %rax
jb write_not_prime_number

movq %rax, %r8
next_number:
movq $0, %rdx
movq %r8, %rax
cmp %rsi, %rax
je write_prime_number

div %rsi
inc %rsi

cmp $0, %rdx
je write_not_prime_number

jmp next_number

write_prime_number:
mov prim_number, %r15
mov %r15, txtout
jmp end_of_prime_number

write_not_prime_number:
mov not_prim_number, %r15
mov %r15, txtout
jmp end_of_prime_number

end_of_prime_number:
ret
###########################Sprawdz czy jest liczba pierwsza###########################
new_function:


ret
####################Oblicz iloczyn dwoch poprzednich na rejestrach####################
register_multiply_function:
movq %rax, %r8

cmp $1, %r8
je n1

cmp $2, %r8
je n2

movq %rax, %r9
dec %r9
movq %r9, %rax
call register_multiply_function
movq %r15, %r11
z:
movq %r9, %r10
dec %r10
movq %r10, %rax
call register_multiply_function
movq %r15, %r12
x:
imul %r11, %r12
movq %r12, %r15
jmp end_of_register_multiplier_function
c:



n1:
movq $-1, %r15
#movq $-1, txtout
jmp end_of_register_multiplier_function

n2:
movq $-2, %r15
#movq $-2, txtout
jmp end_of_register_multiplier_function

end_of_register_multiplier_function:
movq %r15, txtout
ret
####################Oblicz iloczyn dwoch poprzednich na rejestrach####################



####################Oblicz iloczyn dwoch poprzednich na rejestrach####################
stack_multiply_function:
movl %eax, %edi

push    %rbp
        movq    %rsp, %rbp
        push   %rbx
        subq    $24, %rsp
        movl    %edi, -20(%rbp)
        cmpl    $1, -20(%rbp)
        jne     .L2
        movl    $-1, %eax
        jmp     .L3
.L2:
        cmpl    $2, -20(%rbp)
        jne     .L4
        movl    $-2, %eax
        jmp     .L3
.L4:
        movl    -20(%rbp), %eax
        subl    $1, %eax
        movl    %eax, %edi
        call    stack_multiply_function
        movl    %eax, %ebx
        movl    -20(%rbp), %eax
        subl    $2, %eax
        movl    %eax, %edi
        call    stack_multiply_function
        imul    %ebx, %eax
        movq %rax, txtout
        d:
.L3:
        addq    $24, %rsp
        popq    %rbx
        popq    %rbp
 		
 		ret
#end_of_stack_multiplier_function:
#movq %r15, txtout
#ret
####################Oblicz iloczyn dwoch poprzednich na rejestrach####################




end:
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
