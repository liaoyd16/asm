

.text
.globl get_fd
get_fd:
    # filename, mode -> fd
        #filename: %rdi
        #fd: %rax

open:
    movq $2, %rax
    # filename: rdi
    # access mode: %rsi
    syscall
    retq