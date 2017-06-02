.data
SYSREAD = 0
SYSWRITE = 1
SYSEXIT = 60
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
BUFLEN = 512

.bss
.comm numb1, 512
.comm numb2, 512
.comm kaczka, 1024
.comm jajko, 1024
.comm buff, 1024

.text
.globl _start
_start:

##################################################wczytanie pierwszej liczby##################################################
movq $SYSREAD, %rax
movq $STDIN, %rdi
movq $numb1, %rsi
movq $BUFLEN, %rdx
syscall


movq %rax, %r10
dec %r10

movq %r10, %rdi
movq $1, %rax
movq $10, %rbx
L0:
cmp $1, %rdi
je L1
dec %rdi
mulq %rbx
jmp L0
L1:

movq %rax, %rbx #mull
movq $0, %rdi #iterator
movq $0, %rcx #score

convertToDecimalNumber:
movq $0, %rax
movb numb1(,%rdi,1), %al

subq $'0', %rax
mulq %rbx 
add %rax, %rcx
inc %rdi
movq %rbx, %rax
movq $10, %r15
divq %r15
movq %rax, %rbx
cmpq %r10, %rdi
jl convertToDecimalNumber

movq %rcx, numb1
##################################################wczytanie pierwszej liczby##################################################

##################################################wczytanie drugiej liczby##################################################
movq $SYSREAD, %rax
movq $STDIN, %rdi
movq $numb2, %rsi
movq $BUFLEN, %rdx
syscall


movq %rax, %r10
dec %r10

movq %r10, %rdi
movq $1, %rax
movq $10, %rbx
L2:
cmp $1, %rdi
je L3
dec %rdi
mulq %rbx
jmp L2
L3:

movq %rax, %rbx #mull
movq $0, %rdi #iterator
movq $0, %rcx #score

convertToDecimalNumber2:
movq $0, %rax
movb numb2(,%rdi,1), %al

subq $'0', %rax
mulq %rbx 
add %rax, %rcx
inc %rdi
movq %rbx, %rax
movq $10, %r15
divq %r15
movq %rax, %rbx
cmpq %r10, %rdi
jl convertToDecimalNumber2

movq %rcx, numb2
##################################################wczytanie drugiej liczby##################################################

############################################rozklad na czynniki pierwszej liczby############################################
movq $0, %rdi
movq $2, %rcx
movq numb1, %r8

nextStepFactorization:
cmp numb1, %rcx
ja endOfFactorization

movq $0, %rdx
movq %r8, %rax

div %rcx
cmp $0, %rdx
je save

inc %rcx
jmp nextStepFactorization

save:
movq %rax, %r8
movw %cx, kaczka(,%rdi,2)
inc %rdi
movb $0000, kaczka(,%rdi,2)
inc %rdi
jmp nextStepFactorization

endOfFactorization:
############################################rozklad na czynniki pierwszej liczby############################################
############################################rozklad na czynniki drugiej liczby############################################
movq $0, %rdi
movq $2, %rcx
movq numb2, %r8

nextStepFactorization2:
cmp numb2, %rcx
ja endOfFactorization2

movq $0, %rdx
movq %r8, %rax

div %rcx
cmp $0, %rdx
je save2

inc %rcx
jmp nextStepFactorization2

save2:
movq %rax, %r8
movw %cx, jajko(,%rdi,2)
inc %rdi
movb $0000, jajko(,%rdi,2)
inc %rdi
jmp nextStepFactorization2

endOfFactorization2:
############################################rozklad na czynniki drugiej liczby############################################
e:
movq $0, %rdi
movq $0, %rdx
nextStepFinalFunction:
cmp $1024, %rdi
je end
movw kaczka(,%rdi,2), %bx
r:
movw jajko(,%rdi,2), %cx
a:
cmp %bx, %cx
je save3

inc %rdi
jmp nextStepFinalFunction

save3:
movw %bx, buff(,%rdx,2)
q:
inc %rdx
inc %rdi
w:
jmp nextStepFinalFunction

end:
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
