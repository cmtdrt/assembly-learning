; This program reads an input from the user, converts it to an integer if possible (handle errors), 
; does a little calculation with it and converts the result back to a string to print it.

global _start

section .data
    message db "Enter a number : "
    message_length: equ $ - message

    not_a_number_message db "The input is not a number", 10
    not_a_number_message_length: equ $ - not_a_number_message

    only_enter_message db "The input is only an enter", 10
    only_enter_message_length: equ $ - only_enter_message

    valid_input_message db "Valid input", 10
    valid_input_message_length: equ $ - valid_input_message

section .bss
    userResponse resb 100

section .text

_start:

    ; print 'Enter a number : '
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_length
    syscall

    ; Read input from the user
    mov rax, 0
    mov rdi, 0
    mov rsi, userResponse ; pointer to the buffer which will store the user response
    syscall
    mov rbx, rax ; userResponse length

    ; If the input is 1 caracter long, it's only an enter so we print the message and exit
    cmp rbx, 1 
    je print_only_enter

    ; Check if the input is a number
    mov r12, 0 ; index of the current character
    for_each_char:
        ; if char is \n (Enter key, so basically the last character), it's a valid input
        cmp byte [userResponse + r12], 10 ; Check below for more details about why we use byte here.
        je valid_input

        ; if char is below '0' (ASCII code 48), it's not a number
        cmp byte [userResponse + r12], '0'
        jl not_a_number
        
        ; if char is above '9' (ASCII code 57), it's not a number
        cmp byte [userResponse + r12], '9'
        jg not_a_number

        inc r12 ; increment the index
        jmp for_each_char ; loop again

    print_only_enter:
        mov rax, 1
        mov rdi, 1
        mov rsi, only_enter_message
        mov rdx, only_enter_message_length
        syscall
        jmp exit
   
    not_a_number:
        mov rax, 1
        mov rdi, 1
        mov rsi, not_a_number_message
        mov rdx, not_a_number_message_length
        syscall
        jmp exit
    
    valid_input:
        mov rax, 1
        mov rdi, 1
        mov rsi, valid_input_message
        mov rdx, valid_input_message_length
        syscall

    exit:
    mov rax, 60
    xor rdi, rdi
    syscall

    ; Note: byte is used here because we need to specify that we are comparing a single byte (character) instead of a word (2 bytes), a double word (4 bytes) or a quad word (8 bytes).

 ; TODO: 
    ; 1) Read input from the user
    ; 2) Convert the input to an integer
    ; 3) Check if the integer is a valid number (= handle errors)
    ; 4) Do a little calculation with the integer (x * 2 for example)
    ; 5) Print "The result is : <result>"
