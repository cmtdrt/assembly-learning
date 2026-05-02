global _start

section .text

_start:
    ; TODO : use a loop to print a pyramid of *'s
    ; example : 
    ; if we want to print a pyramid of 4 *'s, we will print :
    ; *
    ; **
    ; ***
    ; ****
    ; so we need to print 4 lines of *'s, each line having 1 more * than the previous line.
        
    exit:
        mov rax, 60
        mov rdi, 0
        syscall