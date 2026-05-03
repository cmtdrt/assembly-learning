; This program adds two numbers and prints the result. Note that it only works for results between 0 and 9. 
; (printing multiple digits needs more steps, we'll see that later)

global _start

; since we will overwrite the value later without setting a default value, we declare add_result in bss section
section .bss
    add_result resb 1 ; Since it's bss section we can't set a default value, so we can't use '10' for a newline character
                      ; we'll create a 'newline' label in data section to solve this problem.

section .data
    newline db 10 ; in ASCII, 10 is the newline character

section .text
_start:
    ; add the numbers and store the result in add_result
    add_numbers:
        mov rbx, 5 ; rbx = 5
        add rbx, 4 ; rbx = rbx + 4 = 9
        add rbx, '0' ; convert the number to ASCII (terminal only displays ASCII characters) -> check notes below for more details.
        mov [add_result], bl ; we use bl because it's the lower 8 bits of rbx (1 byte long, perfect for add_result)

    ; print the result in the terminal (see 02-hello/main.asm for more details)
    print_result:
        mov rax, 1
        mov rdi, 1
        mov rsi, add_result
        mov rdx, 1 ; add_result is always 1 byte long so we can hardcode it's length
        syscall
    
    ; simply print a newline character so it's easier to read the result.
    print_newline:
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1 ; newline is always 1 byte long so we can hardcode it's length
        syscall

    ; exit the program (see 01-exit/main.asm for more details)
    exit:
        mov rax, 60
        mov rdi, 0
        syscall

; Notes:
; add rbx, '0' converts rbx value into ASCII. It's works because numbers in ASCII are consecutive and start at 48. (0=48, 1=49 etc.)
; so if we add 48 (ASCII of '0') to our number, we will get it's ASCII value.

; Oh, little bit of humility, here's the exact python version of this program:
; print(5 + 4)
