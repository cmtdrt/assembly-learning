global _start

_start:
    ; TODO: 
    ; 1) Ask the user for the filename to write in
    ; 2) Check if the file already exists
    ; 3) If the file doesn't exists, create it
    ; 2) Else, create a random content to write in the file using getrandom syscall
    ; 3) Write the content in the file
    ; 4) Read the content of the file
    ; 5) Print the content in the terminal

    ; getrandom
    mov rax, 318        ; syscall number for getrandom
    mov rdi, buffer     ; where to store the random bytes
    mov rsi, 10         ; how many bytes to generate
    mov rdx, 0          ; flags (0 = no flags)
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall