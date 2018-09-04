as -gtabs -o get_fd.o get_fd.s;
as -gtabs -o debug.o debug.s;
as -gtabs -o print_int.o print_int.s;
as -gtabs -o get_line_num.o get_line_num.s;
as -gtabs -o get_line.o get_line.s;
ld -o run debug.o get_fd.o print_int.o get_line_num.o get_line.o;

# gdb run;