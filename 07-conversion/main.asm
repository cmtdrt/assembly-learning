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
    mov r13, rax ; userResponse length

    ; If the input is 1 caracter long, it's only an enter so we print the message and exit
    cmp r13, 1 
    je print_only_enter

    ; Check if the input is a number
    mov r12, 0 ; index of the current character
    is_character_a_number:
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
        jmp is_character_a_number ; loop again

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

    ; userResponse still contains the input as a string (ASCII characters), so we need to convert it to an integer
    mov rax, 0 ; reset rax to 0 (it was set to 1 by the syscall)
    mov r12, 0 ; index of the current character
    convert_to_integer:
        cmp r12, r13 ; compare the index of the current character with the length of the input
        jge end_convert_to_integer ; if we have reached the end of the input (Enter character), we can stop the loop to ignore it.

        movzx rbx, byte [userResponse + r12] ; load the current character into rbx (and zero-extend it to 64 bits)
        sub rbx, '0' ; subtract the ASCII value of '0' to get the actual number (example: '32' - '0' = 32)
        imul rax, rax, 10 ; multiply the result by 10 to shift the digits to the left
        add rax, rbx ; add the actual number to the result
        inc r12
        jmp convert_to_integer ; loop again

    end_convert_to_integer:
        ; Multiply by 2 (just to prove that the conversion worked and we are working with a number)
        shl rax, 1 ; We could have used 'imul rax, rax, 2' instead, but this is an interesting way to do it.
                    ; It shifts the bits to the left by 1 position so it multiplies by 2. It's faster than imul btw.
                    ; Note that it works here only because we are working with positive and integer numbers.

        ; Convert the result back to a string so we can print it
        ; TODO : we need to convert to a String for every character in rax
        ; while rax > 0 :
            ; rdx = rax % 10     ; via div
            ; rax = rax / 10     ; via div (automatic)
            ; character = rdx + '0'
            ; push the character on the stack
        ; then pop the characters in userResponse in order

        ; Print the result
        mov rax, 1
        mov rdi, 1
        mov rsi, result_as_string ; FIXME 
        mov rdx, r13
        syscall

    exit:
        mov rax, 60
        xor rdi, rdi
        syscall

    ; Note: byte is used here because we need to specify that we are comparing a single byte (character) instead of a word (2 bytes), a double word (4 bytes) or a quad word (8 bytes).
