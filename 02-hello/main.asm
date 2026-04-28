; expose the _start symbol to the linker so it knows where to start execution
global _start

; indicate the start of executable code
section .text

_start:
    ; incoming