; This program prints a pyramid of stars '*'
global _start

section .data
    star db "*"
    newline db 10 ; in ASCII, 10 is the newline character

section .text

_start:
    mov rbx, 1
    loop_line:
        mov r12, 0 ; see below for more details about why we use r12 and not another register
        loop_star:
            cmp r12, rbx
            jge print_newline
            
            ; print a star
            mov rax, 1
            mov rdi, 1
            mov rsi, star
            mov rdx, 1 ; star is always 1 byte long so we can hardcode it's length
            syscall

            inc r12 ; increment r12 by 1
            jmp loop_star
        
        ; print a newline character
        print_newline:
            mov rax, 1
            mov rdi, 1
            mov rsi, newline
            mov rdx, 1 ; newline is always 1 byte long so we can hardcode it's length
            syscall

        inc rbx ; increment rbx by 1
        cmp rbx, 5 ; compare rbx with 5
        jle loop_line ; jump to loop_start if rbx <= 5

    ; exit the program 
    mov rax, 60
    xor rdi, rdi ; apparently it's the same as mov rdi, 0 but it's more efficient to set a register to 0 like this
    syscall

; Note: I tried to use rcx instead of r12 (because I'm used to using rbx and rcx to store data) but it didn't work, 
; Instead of this :
; *
; **
; ***
; ****
; *****
;
; I got this:
; *
; *
; *
; *
; *
;
; The reason why is that the syscall instruction destroys the content of certain registers, including rcx.
; The kernel uses it to store the memory address of the next instruction to execute after a syscall (so it knows where to go right after the syscall).
; That's why we have to use a callee-saved register (RBX, RBP, R12-R15) to be sure that the value stays how it should be even after a syscall.