section .data
    msg db "Hello world", 10

section .text
    global _start

_start:
    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    mov rsi, msg
    mov rdx, 12
    syscall

    mov rax, 60     ; sys_exit
    xor rdi, rdi
    syscall