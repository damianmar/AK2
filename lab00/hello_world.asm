.data				#sekcja zainicjowanych stalych
SYSREAD = 0
SYSWRITE = 1
SYSEXIT = 60
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

buf: .ascii "Hello, world!\n"	#bufor
buf_len = .-buf

.text
.globl _start

_start:				#sekcja kodu

movq $SYSWRITE, %rax		#zdefiniowanie funkcji write typu ssize_t
movq $STDOUT, %rdi		#zdefiniowanie wyjścia (miejsca zapisu)
movq $buf, %rsi			#zdefiniowanie bufora (miejsce skad zostana pobrane dane do zapisania)
movq $buf_len, %rdx		#zdefiniowanie dlugosci bufora
syscall				#wywolanie funkcji systemowej

movq $SYSEXIT, %rax		#zdefiniowanie funkcji _exit typu void
movq $EXIT_SUCCESS, %rdi	#zdefiniowanie statusu (sukces)
syscall				#wywolanie funkcji systemowej
