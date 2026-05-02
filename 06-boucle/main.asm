global _start

section .text

_start:
    mov rbx, 8
    add rbx, 4

    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    mov rdx, 1
    syscall
        
    exit:
        mov rax, 60
        mov rdi, 0
        syscall