
.bss
    .lcomm BUFFER, 512

.text
.globl get_line
get_line:
    # fd / store, size -> len
    # fd: %rdi
    # store: %rsi
    # size: %rdx

    movq $0, %rax   # syscall no
    # fd: %rdi
    movq $BUFFER, %rsi # buffer
    movq $512, %rdx # size
    syscall

    movq $BUFFER, %r10 # ptr
    movq $0, %r11      # cnt
# do
traverse:
    testb (%r10), (%r10)
    jz return
    incq %r10
    incq %r11
    jmp traverse

return:
    # store: %rsi
    movq %r11, %rax # len
    retq