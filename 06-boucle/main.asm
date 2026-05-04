global _start

section .data
    star db "*", 10
    star_length: equ $ - star

section .text

_start:
    mov rbx, 1

    ; while rbx <= 5, print a star and increment rbx by 1
    loop_start:
        print_star:
            mov rdi, 1
            mov rax, 1
            mov rsi, star
            mov rdx, star_length
            syscall

        inc rbx ; increment rbx by 1

        cmp rbx, 5 ; compare rbx with 5
        jle loop_start ; jump to loop_start if rbx <= 5
        
    exit:
        mov rax, 60
        mov rdi, 0
        syscall