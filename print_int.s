
.text
.globl print_int
print_int:
    # rdi -> .

    movq $0, %r10
    movq $1, %r11
get_power:
    movq $0, %rdx
    movq %rdi, %rax
    cmpq %r11, %rax
    jl get_digit
    incq %r10
    imulq $10, %r11
    jmp get_power

# string: @rcx
    movq %rsp, %rcx
    movq %r10, %r12
    imulq $8, %r12
    addq %r12, %rsp

    movq %rcx, %r12
get_digit:
    movq $0, %rdx
    movq %rdi, %rax
    idivq $10

    addq $0x30, %rdx
    addq $8, %r12
    movq %rdx, (%r12)

    decq %r10
    testq %r10, %r10
    jz print
    jmp get_digit

print:
    movq $1, %rax
    movq $1, %rdi
    movq %rsp, %rsi
    movq %r10, %rcx
    syscall

    movq %rcx, %rsp
    ret