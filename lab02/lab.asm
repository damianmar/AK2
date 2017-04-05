.data
SYS_WRITE = 1
SYS_FORK = 2
SYSREAD = 0
SYSWRITE = 4
SYSOPEN = 2
SYSCLOSE = 6
SYS_CREAT = 8
SYS_LSEEK = 19
STDOUT = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
READ_MODE = 0
WRITE_MODE = 1
PERM = 0
FIRST_NUMB = 0xFFFFFFFFFFFFFFFF
SECOND_NUMB = 0xFFFFFFFFFFFFFFFF
file_in: .ascii "file_in.txt\0"
file_out: .ascii "file_out.txt\0"
BUFFER_SIZE = 17

.bss
.comm text_in, BUFFER_SIZE
.comm text_out, 64
.comm sum, 17
.comm fileDescriptor, 8
.comm in 8

.text
.globl _start
_start:
######################################odczyt#####################
movq $SYSOPEN, %rax				#otworzenie pliku
movq $file_in, %rdi
movq $READ_MODE, %rsi
movq $PERM, %rdx
syscall
movq %rax, %r8

movq $SYSREAD, %rax				#przeczytanie pliku
movq %r8, %rdi
movq $text_in, %rsi
movq $BUFFER_SIZE, %rdx
syscall
zatrzymaj:
								# Zamknięcie pliku
mov $SYSCLOSE, %rax
mov %r8, %rdi
mov $0, %rsi
mov $0, %rdx
syscall
kaczka:
######################################odczyt#####################


#######################odczytanie wartosci#######################

#######################odczytanie wartosci#######################
#########################konwesja do hex#########################
movq $0, %r10
movq $0, %rcx
mov $32, %edi
mov $1, %edx
convertToHex:
mov text_in(, %edi, 1), %rcx
sub $30, %rcx
#mul %edx, %rcx
mnozenie:
add %rcx, %r10
dec %edi
cmp $0, %edi
ja convertToHex
wynik:
#########################konwesja do hex#########################
############################dodawanie############################
clc
movq $FIRST_NUMB, %r11
movq $SECOND_NUMB, %r12
adc %r11, %r12
mov %r12, sum

jc is_carry
mov $0, %r9
movb $0x30, text_out(, %r9, 1)
jmp no_carry
is_carry:
movb $0x31, text_out(, %r9, 1)
no_carry:
############################dodawanie############################
#######################zapis hex do ascii#######################
mov $18, %edi
mov $0, %rsi
dec %rsi

start_hex_to_ascii:
movq $0, %rbx
movq $0, %rcx
movb sum(, %rsi, 1), %al

#movb $0xA8, %al
movb %al, %bl
movb %al, %cl

shr $4, %bx
shl $4, %cx
movb $0, %ch
shr $4, %cx

addb $0x30, %bl
addb $0x30, %cl

cmp $0x39, %bl
jle next_sign
add $0x7, %bl

next_sign:
cmp $0x39, %cl
jle end_of_hex_to_ascii
add $0x7, %cl

end_of_hex_to_ascii:
#mov $2, %r9
movb %cl, text_out(, %edi, 1)#%r9, 1)
dec %edi
mov %bl, text_out(, %edi, 1) #%r9, 1)
#dec %r9
dec %edi
inc %rsi

cmp $0, %edi
ja start_hex_to_ascii
#######################zapis hex do ascii#######################
##############################zapis##############################
movq $SYSOPEN, %rax				#otworzenie pliku
movq $file_out, %rdi
movq $WRITE_MODE, %rsi
movq $PERM, %rdx
syscall
movq %rax, %r8

movq $SYS_WRITE, %rax				#zapisanie do pliku
movq %r8, %rdi
movq $text_out, %rsi
movq $BUFFER_SIZE, %rdx
syscall

mov $SYSCLOSE, %rax					# Zamknięcie pliku
mov %r8, %rdi
mov $0, %rsi
mov $0, %rdx
syscall
##############################zapis##############################
################################zakonczenie#####################
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
################################zakonczenie#####################
