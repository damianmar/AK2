.data
control_word: .short 0
justAStrangeThing: .short 
iterator: .quad
number: .quad
score: .quad

.text

.global checkRounding, setRounding, countFunction
.type checkRounding, @function
.type setRounding, @function
.type countFunction, @function

checkRounding:
    push    %rbp
    mov     %rsp, %rbp

    #pobranie rejstru kontrolnego
    movq     $0, %rax
    fstcw   control_word            
    movw     control_word, %ax      
 
    shl $4, %rax
    shr $14, %rax

 
    mov     %rbp, %rsp
    pop     %rbp
    ret


setRounding:
    push    %rbp
    mov     %rsp, %rbp

    #pobranie rejstru kontrolnego
    movq     $0, %rax
    fstcw   control_word
    fwait            
    movw     control_word, %ax      
 
    and $0xF3FF, %ax
    shl $10, %rdi
    addq %rdi, %rax


    movq %rax, control_word
    fldcw control_word
 
    mov     %rbp, %rsp
    pop     %rbp
    ret

countFunction:
    push    %rbp
    mov     %rsp, %rbp

    #movsd   %xmm0, (%rsp)
    #fldl    (%rsp)
    movsd %xmm0, number
    fldl number
    fld1
    fld1
    fld1
    fld1
                                        #n - %rdi, x - ST(4), ST(0-3) - miejsce na licznik, mianownik i wynik i wynik tmp
    movq $0, %rsi

    nextStepCountFunction:
    cmp %rsi, %rdi
    je endCountFunction
    
    cmp $0, %rsi
    je endStep
     q:                   #licznik pomnożony
    movq %rsi, iterator
    fldl  iterator
    fmul %st(1)
    fxch %st(1)
    fstpl justAStrangeThing
     w:                   #mianownik pomnożony
    fld %st(4)
    fxch %st(2)
    fmul %st(2)
    fxch %st(2)
    fstpl justAStrangeThing
     e:                  #wynik tmp obliczony
    fld %st(0)
    fdiv %st(0), %st(2)
    fxch %st(3)
    fstpl justAStrangeThing
      r:                  #dodanie tmp do wyniku
    fld %st(3)
    fadd %st(3)
    fxch %st(4)
    fstpl justAStrangeThing
t:


    endStep:
    inc %rsi
    jmp nextStepCountFunction

    endCountFunction:

    fxch %st(3)
    fstpl   score
    p:
    movsd   score, %xmm0
o:
    mov     %rbp, %rsp
    i:
    pop     %rbp
    u:
    ret
