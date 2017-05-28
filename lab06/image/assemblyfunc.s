


.global AssemblyFunc
.type AssemblyFunc, @function

AssemblyFunc:
    push    %rbp
    mov     %rsp, %rbp


    
    movq %rdi, %mm0
	movq %rsi, %mm1
	movq %rdx, %mm2

	paddd %mm1, %mm0
	paddd %mm2, %mm0

	movq %mm0, %rax
	movq $3, %rcx
	movq $0, %rdx
	div %rcx
	#div %rcx, %mm0

	#movq %mm0, %rax

    mov     %rbp, %rsp
    pop     %rbp

ret
