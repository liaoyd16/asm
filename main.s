
.text
.globl _start
_start:
    # input: argv[1], argv[2]

    ##############################
    # get fd
    # argv[1], rw -> fd1
    # argv[2], rw -> fd2
        # argv[1]: %rsp->%rdi
        # argv[2]: %rsp->%rdi
        # rw: %rsi
        # fd1: %r8
        # fd2: %r9

    popq %rdi

    popq %rdi
    movq $000000, %rsi #read only
    call get_fd
    movq %rax, %r8

    popq %rdi
    movq $000001, %rsi #write only
    call get_fd
    movq %rax, %r9


    # get line num 
    # fd1 -> num
        # fd1: %rdi
        # num: %rax

    movq %r8, %rdi
    call get_line_num


    # print line num
    # num / fd2 -> .
        # num: %rdi
        # fd2: %rsi
    movq %rax, %rdi
    call print_int


    ##############################
    # get line:
    # fd / store, size -> len
        # fd: %rdi
        # store: %rsi
        # size: %rdx

    movq %r8, %rdi
    movq $512, %rdx

    call get_line


    # print_int
    # x -> .
        # x: %rdi

    movq %rax, %rdi
    call print_int


    # print first line
    # line -> .
        # line: %rsi
        # %rax = $1

    movq $1, %rax
    movq %rdi, %rdx
    movq $1, %rdi
    syscall
