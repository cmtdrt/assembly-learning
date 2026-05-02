; This program adds two numbers and prints the result. Note that it only works for results between 0 and 9. 
; (printing multiple digits needs more steps, we'll see that later)

global _start

section .data
    add_result db 0 , 10; set to 0 but it's not important because we will overwrite it later
    add_result_length: equ $ - add_result

section .text

_start:
    ; add the numbers and store the result in add_result
    add_numbers:
        mov rbx, 5 ; rbx = 5
        add rbx, 4 ; rbx = rbx + 4 = 9
        add rbx, '0' ; convert the number to ASCII (terminal only displays ASCII characters)
        mov [add_result], bl ; we use bl because it's the lower 8 bits of rbx (if we use rbx, it would be the whole 64 bits)

    ; print the result in the terminal (see 02-hello/main.asm for more details)
    print_result:
        mov rax, 1
        mov rdi, 1
        mov rsi, add_result
        mov rdx, add_result_length
        syscall

    ; exit the program (see 01-exit/main.asm for more details)
    exit:
        mov rax, 60
        mov rdi, 0
        syscall