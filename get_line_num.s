
.bss
    .lcomm BUFFER, 512

.text
.globl get_line_num
get_line_num:
    # fd, (RDONLY) -> num
    movq $3, %rax
    movq %rdi, %rbx
    movq $BUFFER, %rcx
    movq $512, %rdx
    syscall

    movq $BUFFER, %r10 #ptr
    movq $0, %r11      #cnt
# do
    testb (%r10), (%r10)
    jz return

    movq $1, %r11
traverse:
    testb (%r10), (%r10)
    jz return
    incq %r10
    incq %r11
    jmp traverse

# while (ptr) is not 0x0A

return:
    movq %r11, %rax
    retq