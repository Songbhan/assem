.386
.model flat, c
option casemap :none

; 빌드 오류를 막기 위해 필요한 표준 라이브러리 연결
includelib     msvcrt.lib
includelib     legacy_stdio_definitions.lib

; printf 함수 선언
EXTERN printf : PROC

.data
    msg_id   BYTE "학번: 2023764047", 0Ah, 0
    msg_name BYTE "이름: 한송빈", 0Ah, 0

.code
main PROC
    ; 1. 학번 출력
    push offset msg_id
    call printf
    add esp, 4

    ; 2. 이름 출력
    push offset msg_name
    call printf
    add esp, 4

    ret ; main 함수 종료 (exit 호출 대신 ret 하나로 깔끔하게 종료)
main ENDP
END
