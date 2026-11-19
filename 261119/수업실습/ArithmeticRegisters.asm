

.386
.model flat, stdcall
option casemap:none

includelib msvcrt.lib
includelib kernel32.lib
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

printf PROTO C :PTR BYTE, :VARARG
scanf PROTO C :PTR BYTE, :VARARG
ExitProcess PROTO :DWORD

.data
    msg1 db "Input A: ", 0
    msg2 db "Input B: ", 0
    fmt db "%hd", 0

    msgAdd db "ADD: %d", 13, 10, 0
    msgSub db "SUB: %d", 13, 10, 0
    msgMul db "MUL: %d", 13, 10, 0
    msgDiv db "DIV: %d", 13, 10, 0

    msgAX db "AX: %d", 13, 10, 0
    msgBX db "BX: %d", 13, 10, 0
    msgCX db "CX: %d", 13, 10, 0
    msgDX db "DX: %d", 13, 10, 0

    msgError db "Division error", 13, 10, 0

    num1 dw ?
    num2 dw ?

    regAX dw ?
    regBX dw ?
    regCX dw ?
    regDX dw ?

.code
main PROC

    ; Input
    invoke printf, ADDR msg1
    invoke scanf, ADDR fmt, ADDR num1

    invoke printf, ADDR msg2
    invoke scanf, ADDR fmt, ADDR num2

    cmp num2, 0
    je division_error

    cmp num1, -32768
    jne calculate
    cmp num2, -1
    je division_error

calculate:

    ; Addition
    mov ax, num1
    add ax, num2
    mov regAX, ax

    ; Subtraction
    mov ax, num1
    sub ax, num2
    mov regBX, ax

    ; Multiplication
    mov ax, num1
    imul num2
    mov regCX, ax

    ; Division
    mov ax, num1
    cwd
    idiv num2
    mov regDX, ax

    ; Register values
    mov ax, regAX
    mov bx, regBX
    mov cx, regCX
    mov dx, regDX

    ; Print calculation results
    movsx eax, regAX
    invoke printf, ADDR msgAdd, eax

    movsx eax, regBX
    invoke printf, ADDR msgSub, eax

    movsx eax, regCX
    invoke printf, ADDR msgMul, eax

    movsx eax, regDX
    invoke printf, ADDR msgDiv, eax

    ; Print saved registers
    movsx eax, regAX
    invoke printf, ADDR msgAX, eax

    movsx eax, regBX
    invoke printf, ADDR msgBX, eax

    movsx eax, regCX
    invoke printf, ADDR msgCX, eax

    movsx eax, regDX
    invoke printf, ADDR msgDX, eax

    invoke ExitProcess, 0

division_error:
    invoke printf, ADDR msgError
    invoke ExitProcess, 1

main ENDP
END main
