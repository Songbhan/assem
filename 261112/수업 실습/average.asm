
.386
.model flat, C
.stack 4096

includelib libcmt.lib
includelib legacy_stdio_definitions.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.data
    msg     db "Enter 5 numbers: ", 0
    fmtIn   db "%d %d %d %d %d", 0
    fmtOut  db "Average = %.2f", 13, 10, 0
    errMsg  db "Invalid input!", 13, 10, 0

    num1    dd 0
    num2    dd 0
    num3    dd 0
    num4    dd 0
    num5    dd 0

    count   dd 5
    avg     REAL8 0.0

.code
PUBLIC main
main PROC

    ; 입력 안내문 출력
    push OFFSET msg
    call printf
    add esp, 4

    ; 정수 5개 입력
    push OFFSET num5
    push OFFSET num4
    push OFFSET num3
    push OFFSET num2
    push OFFSET num1
    push OFFSET fmtIn
    call scanf
    add esp, 24

    ; 입력 개수 확인
    cmp eax, 5
    jne input_error

    ; 5개 숫자의 합 계산
    fild DWORD PTR num1
    fiadd DWORD PTR num2
    fiadd DWORD PTR num3
    fiadd DWORD PTR num4
    fiadd DWORD PTR num5

    ; 합계를 5로 나누기
    fidiv DWORD PTR count

    ; 평균 저장
    fstp QWORD PTR avg

    ; 평균 출력
    push DWORD PTR [avg+4]
    push DWORD PTR [avg]
    push OFFSET fmtOut
    call printf
    add esp, 12

    xor eax, eax
    ret

input_error:
    push OFFSET errMsg
    call printf
    add esp, 4

    mov eax, 1
    ret

main ENDP
END
