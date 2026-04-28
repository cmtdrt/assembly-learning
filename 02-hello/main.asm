; expose the _start symbol to the linker so it knows where to start execution
global _start

; indicate the start of the data section
section .data
    message db "Hello, World!", 10 ; 10 is the newline character (it's optional)

; indicate the start of executable code
section .text

_start:
    ; print "Hello, World!"
    mov rax, 1 ; 1 is the write system call
    mov rdi, 1 ; indicate where to write (1 = stdout, 2 = stderr)
    mov rsi, message ; pointer to the first byte of the message
    mov rdx, 14 ; length of the message -> 13 + 1 for the newline character (10)
    syscall
    
    ; exit the program (check 01-exit/main.asm for more details)
    mov rax, 60
    mov rdi, 69
    syscall

    ; Notes:
    ; rax = we want to write something
    ; rdi = we write it to the standard output
    ; rsi = what we want to write --> it's the memory address of the first byte of the message
    ; rdx = length of the message --> how far we have to read in memory (from rsi) to know what to write
