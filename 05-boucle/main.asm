global _start

section .data
    message db "Enter your age : "
    message_length: equ $ - message

    minor_message db "Hold my beer !", 10
    minor_message_length: equ $ - minor_message

    not_minor_message db "Have a beer !", 10
    not_minor_message_length: equ $ - not_minor_message

section .bss    
    userResponse resb 100

section .text 

_start:

    ; print 'Enter your age : ' in terminal (see 02-hello/main.asm for more details)
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_length
    syscall

    ; Read input from the user (see 03-input/main.asm for more details)
    mov rax, 0
    mov rdi, 0
    mov rsi, userResponse
    syscall

    mov al, [userResponse]
    sub al, '0'
    
    movzx rbx, al   ; convert 8 bits to 64 bits

    ; TODO : Actuellement on peut parser seulement les chiffres (1 caractère), on va devoir utiliser une boucle pour parser les nombres de plusieurs caractères.
    
    ; condition 'if/else' (see 04-condition/main.asm for more details)
    cmp rbx, 5
    jl minor ; if the age is less than 18, jump to the minor label
    
    not_minor:
        mov rax, 1
        mov rdi, 1
        mov rsi, not_minor_message
        mov rdx, not_minor_message_length
        syscall
        jmp exit

    minor:
        mov rax, 1
        mov rdi, 1
        mov rsi, minor_message
        mov rdx, minor_message_length
        syscall

    ; exit the program (see 01-exit/main.asm for more details)
    exit:
        mov rax, 60
        mov rdi, 0
        syscall