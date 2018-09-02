
.text
.globl _start
_start:
    movq $100, %rdi
    call print_int