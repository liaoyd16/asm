
.data
ifname:
    .ascii "./input.txt\0" #;!!!!\0!!!!
    len = .-ifname
ofname:
    .ascii "./output.txt\0"
    len = .-ofname


.text
.globl _start
_start:

input:
    movq $ifname, %rdi #read only
    movq $000000, %rsi
    call get_fd
    movq %rax, %r8

print_lines:
    movq $0, %r14

    get_a_line:          #; rdi, rsi; r14 -> rax, rbx
        movq %r8, %rdi
        movq $512, %rsi  #; <=512
        call get_line
        movq %rax, %rdx
        movq %rbx, %rbp

    print_integer:
        movq %rdx, %rdi
        movq $1, %rsi
        pushq %rdx
        call print_int
        popq %rdx

    print_a_line:
        movq $1, %rax
        movq $1, %rdi
        movq %rbp, %rsi
        # movq %rdx, %rdx
calling:
        syscall

    # check:
    #     testq $-1, %rdi
    #     jne get_a_line

################################

exit:
    movq $60, %rax
    movq $0, %rdi
    syscall
