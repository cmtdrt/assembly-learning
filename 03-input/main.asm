; This program reads input from the user and prints it in the terminal.

global _start

section .data
    message db "Enter a message : "
    message_length: equ $ - message ; calculate the length of the message so we can directly pass it to rdx when calling the write syscall

; this section is used to store uninitialized data (like a buffer for user input)
section .bss    
    userResponse resb 100 ; reserve 100 bytes for the user response

section .text 

_start:

    ; print 'Enter a message : ' in terminal (see 02-hello/main.asm for more details)
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_length
    syscall

    ; Read input from the user
    mov rax, 0 ; 0 is the read system call (see: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
    mov rdi, 0 ; indicate where to read (0 = stdin --> keyboard)
    mov rsi, userResponse ; pointer to the buffer which will store the user response
    syscall
    mov rbx, rax ; store the number of bytes read in rbx

    ; print the user response in terminal (see 02-hello/main.asm for more details)
    mov rax, 1
    mov rdi, 1
    mov rsi, userResponse
    mov rdx, rbx ; length of the user response (so we only print the right number of bytes, not the whole buffer of 100 bytes)
    syscall

    ; exit the program (see 01-exit/main.asm for more details)
    mov rax, 60
    mov rdi, 0
    syscall