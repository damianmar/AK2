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
FIRST_NUMB = 0x7FFFFFFFFFFFFFFF
#SECOND_NUMB = 
file_in: .ascii "file_in.txt\0"
file_out: .ascii "file_out.txt\0"
BUFFER_SIZE = 64

.bss
.comm text_in, BUFFER_SIZE
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
######################################odczyt#####################
#################################wypisanie do konsoli############
#mov %rax %text
#movq $SYS_WRITE, %rax				#wypisanie do konsoli
#movq $STDOUT, %rdi
#movq $text_in, %rsi
#movq $BUFFER_SIZE, %rdx
#syscall
#################################wypisanie do konsoli############
##############################zapis##############################
movq $SYSOPEN, %rax				#otworzenie pliku
movq $file_out, %rdi
movq $WRITE_MODE, %rsi
movq $PERM, %rdx
syscall
movq %rax, %r8

movq $SYS_WRITE, %rax				#zapisanie do pliku
movq %r8, %rdi
movq $text_in, %rsi
movq $BUFFER_SIZE, %rdx
syscall

mov $SYSCLOSE, %rax					# Zamknięcie pliku
mov %r8, %rdi
mov $0, %rsi
mov $0, %rdx
syscall
##############################zapis##############################
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
movq $FIRST_NUMB, %r11
movq $FIRST_NUMB, %r12
dod1:
adc %r11, %r12
dod2:
movq $SYS_WRITE, %rax				#wypisanie do konsoli
movq $STDOUT, %rdi
movq %r11, %rsi
movq $BUFFER_SIZE, %rdx
syscall

movq $SYS_WRITE, %rax				#wypisanie do konsoli
movq $STDOUT, %rdi
movq %r12, %rsi
movq $BUFFER_SIZE, %rdx
syscall
dod3:
############################dodawanie############################
################################zakonczenie#####################
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
################################zakonczenie#####################
