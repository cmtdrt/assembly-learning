global _start

section .data
    message db "Enter a number between 0 and 9 : "
    message_length: equ $ - message

    above_5_message db "You are above 5 !", 10
    above_5_message_length: equ $ - above_5_message

    equal_5_message db "You are equal to 5 !", 10
    equal_5_message_length: equ $ - equal_5_message

    below_5_message db "You are below 5 !", 10
    below_5_message_length: equ $ - below_5_message

section .bss    
    userResponse resb 100

section .text 

_start:

    ; print 'Enter a number between 0 and 9 : ' in terminal (see 02-hello/main.asm for more details)
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

    ; We use AL (8 bits) because it allows us to read and process the input one byte (character) at a time instead of loading an entire memory block (with rbx for example --> 64 bits).
    mov al, [userResponse]  ; if user type 1, then al will be 49 (ASCII code of '1') --> response's first byte value thanks to [] which allow us to access the value of the memory address
    sub al, '0' ; since '0' in ASCII is 48, we need to subtract 48 to get the actual number --> we now have al = 1
    
    movzx rax, al   ; convert 8 bits to 64 bits
    mov rbx, rax ; store the age in rbx, we could have used rax directly but it's good practice to use rbx to store values since rax is often used for system calls.
    
    ; compare the value of rbx with 5, depending on the result we will jump to the corresponding label.
    cmp rbx, 5
    je equal_5 ; if the age is equal to 5, jump to the equal_5 label
    jl below_5 ; if the age is less than 18, jump to the minor label
    
    above_5:
        mov rax, 1
        mov rdi, 1
        mov rsi, above_5_message
        mov rdx, above_5_message_length
        syscall
        jmp exit

    equal_5:
        mov rax, 1
        mov rdi, 1
        mov rsi, equal_5_message
        mov rdx, equal_5_message_length
        syscall
        jmp exit

    below_5:
        mov rax, 1
        mov rdi, 1
        mov rsi, below_5_message
        mov rdx, below_5_message_length
        syscall

    ; exit the program (see 01-exit/main.asm for more details)
    exit:
        mov rax, 60
        mov rdi, 0
        syscall