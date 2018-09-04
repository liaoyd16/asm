
.bss
    .lcomm BUFFER, 512
    .lcomm ANS, 512

.text
.globl get_line
get_line:
    
    bran:
        cmpq %r14, %rsi
        jle check

    read:                       #; BUFFER[0:r14] -> BUFFER[0:%rsi/r14]
        movq $0, %rax
        # fd: %rdi = %rdi
        pushq %rsi              # rdx = rsi-end
        subq %r14, %rsi
        movq %rsi, %rdx
        movq $BUFFER, %rsi      # rsi = BUFFER+end
        addq %r14, %rsi
        syscall

        popq %rsi
        addq %rsi, %r14

    check:                      #; trunc@%rsi 
        checkLoopInit:
            movq $BUFFER, %r10
            movq %rsi, %r11
        checkLoop:
            iter0:
                testq %r11, %r11
                jz shift
                decq %r11
            enter:
                cmpb $0x0A, (%r10)
                je copy
                cmpb $0x0, (%r10)
                je copy
            incre:
                incq %r10
                jmp checkLoop

    err:                        #; no trunc
        movq $-1, %rax
        movq $0, %rbx
        retq

    copy:                       #; BUFFER[0:rsi) -> ANS
        subq $BUFFER, %r10
        movq %r10, %rsi
        movq $ANS, %r12
        movq $BUFFER, %r10
        movq %rsi, %r11
        copyLoop:
            iter2:
                testq %r11, %r11
                jz shift
                decq %r11
            assign1:
                movb (%r10), %al
                movb %al, (%r12)
            iter3:
                incq %r10
                incq %r12
                jmp copyLoop

    shift:                      #; B[rsi:end) -> B[0:end-rsi)
        pushq %r14
        subq %rsi, %r14
        movq %r14, %r11
        popq %r14
        decq %r11

        movq $BUFFER, %r12
        movq $BUFFER, %r10
        addq %rsi, %r10
        incq %r10
        shiftLoop:
            iter4:
                testq %r11, %r11
                jz return
                decq %r11
            assign2:
                movb (%r10), %bl
                movb %bl, (%r12)
            iter5:
                incq %r10
                incq %r12

        movq $BUFFER, %rax
        movb (%rax), %bl


    movq %r12, %r14

    return:
        movq %rsi, %rax
        movq $ANS, %rbx
        retq
