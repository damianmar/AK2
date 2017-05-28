.data
SYSREAD = 0
SYSWRITE = 1
SYSEXIT = 60
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
BUFLEN = 512
KEY = -2
MINNUMB = '0'
MAXNUMB = '9'
MINLETT = 'a'
MAXLETT = 'z'

.bss
.comm txtin, 512
.comm txtout, 512
.comm key, 128

.text
.globl _start
_start:
movq $SYSREAD, %rax				#wczytanie tekstu
movq $STDIN, %rdi
movq $txtin, %rsi
movq $BUFLEN, %rdx
syscall

#movq $SYSREAD, %rax				#wczytanie klucza
#movq $STDIN, %rdi
#movq $key, %rsi
#movq $BUFLEN, %rdx
#syscall

						#petla deszyfrujaca
dec %rax
movl $0, %edi

decrypt_loop:
movb txtin(, %edi, 1), %bh

cmp $MINNUMB, %bh
movb %bh, txtout (, %edi, 1)
jb next_step

cmp $MAXNUMB, %bh
jb decrypt_number

cmp $MINLETT, %bh
movb %bh, txtout (, %edi, 1)
jb next_step

cmp $MAXLETT, %bh
jp decrypt_letter


decrypt_letter:					#deszyfracja
movb %bh, %ch
sub $KEY, %ch
cmp %ch, $MINLETT
ja decrypt

jmp decrypt

decrypt_number:


jmp decrypt

decrypt:
add $KEY, %bh
movb %bh, txtout (, %edi, 1)

next_step:
inc %edi
cmp %eax, %edi
jl decrypt_loop

movb $'\n', txtout (, %edi, 1)



movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $txtout, %rsi
movq $BUFLEN, %rdx
syscall


movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
