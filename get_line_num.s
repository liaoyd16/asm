
.bss
    .lcomm BUFFER, 512

.text
.globl get_line_num
get_line_num:
    counter_init:
        pushq $0       #;counter
        movq (%rsp), %r11

    L0:
        read:                   #; BUFFER, r13
            movq $0, %rax
            #fd: %rdi
            movq $BUFFER, %rsi
            movq $512, %rdx
            syscall
            movq %rax, %r13

        movq (%rsp), %r11
        count_LF:               #; @(%rsp))
            init:
                movq $BUFFER, %r10
                decq %r10           #;ptr
                movq %r13, %r12     #;downcount
            L1:
                check:
                    testq %r12, %r12
                    jz return
                    decq %r12
                iter:
                    incq %r10
                count:
                    cmpb $0x0A, (%r10)
                    jne L1
                    incq (%rsp)
                    jmp L1

            movq (%rsp), %r11

        check_finish:             #; %ah, %al
            # finish:
            # case 1: %r13 < 512
            # case 2: (%r10) == NULL
            cmpq $512, %r13
            setl %al
            cmpq $0, (%r10)
            sete %ah
            or %ah, %al
            testb %al, %al
            jz L0

    return:
        movq (%rsp), %rax
        addq $8, %rsp
        retq
