
.data
ifname:
    .ascii "input.txt"
    len = .-ifname
ofname:
    .ascii "output.txt"
    len = .-ofname


.text
.globl _start
_start:
################################

input:
    movq $ifname, %rdi #read only
    movq $000000, %rsi
    call get_fd
    movq %rax, %r8

output:
    movq $ofname, %rdi #write only
    movq $000001, %rsi
    call get_fd
    movq %rax, %r9

get_line_number:
    movq %r8, %rdi
    call get_line_num

print_integer:
    movq %rax, %rdi
    movq %r9, %rsi
    call print_int


################################

print_lines:

    get_lines:          #; -> rax, rbx
        movq %r8, %rdi
        movq $512, %rsi # <=512
        call get_line
        movq %rax, %rdx
        movq %rbx, %rbp

    print_int:
        movq %rdx, %rdi
        movq $1, %rsi
        call print_int

    print_a_line:
        movq $1, %rax
        movq $1, %rdi
        movq %rbp, %rsi
        #;movq %rdx, %rdx
        syscall

    check:
        testq $-1, %rdi
        jne print_lines

################################

exit:
    movq $60, %rax
    movq $0, %rdi
    syscall