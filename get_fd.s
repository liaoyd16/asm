
.text
.globl get_fd
get_fd:
 open:
    movq $2, %rax
    # filename: rdi
    # access mode: %rsi
    syscall
    retq
    