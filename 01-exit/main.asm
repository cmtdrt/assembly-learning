; This program gracefully exits the program with a given exit code.

; expose the _start symbol to the linker so it knows where to start execution
global _start

; indicate the start of executable code
section .text

_start:
    mov rax, 60 ; 60 is the exit system call
    mov rdi, 69 ;69 is the exit code, we can choose any number
    syscall
    ; to check if the program exited with the right exit code
    ; we can use 'echo $?' and it should show 69
    ; for syscalls, see: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/