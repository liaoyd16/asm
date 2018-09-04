
.bss
    .equ NUMBER_SIZE, 512
    .lcomm NUMBER_DATA, NUMBER_SIZE

.text
.globl print_int
print_int: # rdi -> .
    get_power_init:         # ->r10
        movq $0, %r10
        movq $1, %r11
    get_power:
        movq $0, %rdx
        movq %rdi, %rax
        cmpq %r11, %rax
        jl zero
        incq %r10
        imulq $10, %r11
        jmp get_power

    zero:
        testq %r10, %r10
        jnz get_digit_init
        movq $1, %r10

    get_digit_init:         # iter: r12, counter: r14
        movq $NUMBER_DATA, %r12
        addq %r10, %r12
        movq %r10, %r14
    get_digit:
     division:
        movq $0, %rdx
        movq %rdi, %rax
        movq $10, %r13
        divq %r13
     substr:
        movq %rax, %rdi
     store:
        addq $0x30, %rdx
        decq %r12
        movb %dl, (%r12)
     control:
        decq %r14
        testq %r14, %r14
        jz print
        jmp get_digit

    print:
        movq $1, %rax
        movq %rsi, %rdi
        movq $NUMBER_DATA, %rsi
        movq %r10, %rdx
        syscall

    _return:
        retq
