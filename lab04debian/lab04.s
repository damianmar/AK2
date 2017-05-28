.data

SYSEXIT = 60
EXIT_SUCCESS = 0
DUCK = 14

dec_int: .ascii "%d",  
flo_point: .ascii "%f",  
 
.bss
.comm numb1, 8
.comm numb2, 8
.comm bool1, 8
.comm result, 8
 
.text
.globl main
main:

movq $2, numb1
movq $0, numb2
movq $0, bool1
mov $0, %rax
mov $numb1, %rdi
mov $bool1, %rsi
movss numb2, %xmm0
call fun

cvtps2pd %xmm0, %xmm0

qwe:
mov $1, %rax 
mov $flo_point, %rdi 
sub $8, %rsp 

call printf  
add $8, %rsp 

mov $0, %rax
mov $dec_int, %rdi
mov $numb1, %rsi
call scanf
a:



s:
mov $0, %rax 
           
mov $dec_int, %rdi 
movq $DUCK, %rsi
call printf 


q:
mov $0, %rax
mov $flo_point, %rdi
mov $numb2, %rsi
call scanf
w:
mov $0, %rax
mov $dec_int, %rdi
mov $bool1, %rsi
call scanf
e:

mov $1, %rax # Ilość argumentów zmiennoprzecinkowych
             # - przesyłany jest jeden parametr w rejestrze XMM0
             # jeśli było by ich więcej musiały by one zostać
             # umieszczone w kolejnych rejestrach XMM
movq $numb1, %rdi # Czyszczenie rejestru RDI - do jego młodszych
movss numb2, %xmm0  # Przeniesienie drugiego parametru
movq $bool1, %rsi             # czterech bajtów wpisana zostanie wartość

      r:                # - typu zmiennoprzecinkowego do rejestru XMM0
call fun          # Wywołanie funkcji
t:
cvtps2pd %xmm0, %xmm0 # Konwersja wyniku na double aby możliwe było
                      # wyświetlenie go przez funkcje printf
movss %xmm0, result




mov $1, %rax # Przesyłamy jeden parametr zmiennoprzecinkowy
             # - liczbę do wyświetlenia (w rejestrze XMM0)
mov $flo_point, %rdi # Pierwszy parametr typu całkowitego
                    # - format w jakim wyświetlona ma zostać liczba
sub $8, %rsp # Workaround, aby printf nie zmienił wartości
             # ostatniej komórki na stosie. Jest to potrzebne tylko
             # przy wyświetlaniu liczb zmiennoprzecinkowych.
             # Wskaźnik na stos należy przesunąć o wielokrotność
             # liczby 8 równą ilości parametrów ZP (8*RAX).
call printf  # Wywołanie funkcji printf
add $8, %rsp # Workaround -||-


end:
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
