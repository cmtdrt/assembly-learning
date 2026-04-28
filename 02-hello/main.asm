; expose the _start symbol to the linker so it knows where to start execution
global _start

; indicate the start of the data section
; in this section, all data is stored contiguously in memory
section .data
    message db "Hello, World!", 10 ; defines a sequence of bytes in memory containing the string ‘Hello, World!’ followed by a newline character (which is optional)
    message_end: ; label pointing to the adress after the end of the message (the next byte after the last byte of the message)

; indicate the start of executable code
section .text

_start:
    ; print "Hello, World!"
    mov rax, 1 ; 1 is the write system call (see: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
    mov rdi, 1 ; indicate where to write (1 = stdout, 2 = stderr)
    mov rsi, message ; pointer to the first byte of the message
    mov rdx, message_end - message ; length of the message -> difference between the address right after the end of the message and the address of the start of the message = a number of bytes
    syscall
    
    ; exit the program (see 01-exit/main.asm for more details)
    mov rax, 60
    mov rdi, 69
    syscall

    ; Notes:
    ; rax = we want to write something
    ; rdi = we write it to the standard output
    ; rsi = what we want to write --> it's the memory address of the first byte of the message
    ; rdx = length of the message --> how far we have to read in memory (from rsi) to know what to write
