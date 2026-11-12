
# 어셈블리어를 이용한 5개 숫자의 평균 계산

## 1. 프로그램 소개

Visual Studio에서 MASM 어셈블리어를 이용하여
사용자로부터 5개의 정수를 입력받고,
입력된 숫자의 평균을 계산하여 출력하는 프로그램이다.

## 2. 개발 환경

- 개발 도구: Visual Studio 2022
- 프로그래밍 언어: Assembly (MASM)
- 실행 환경: Windows x86 (32비트)
- 입출력 함수: scanf, printf

## 3. 소스 코드

파일명: average.asm

```asm
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

    ; 숫자 5개 입력
    push OFFSET num5
    push OFFSET num4
    push OFFSET num3
    push OFFSET num2
    push OFFSET num1
    push OFFSET fmtIn
    call scanf
    add esp, 24

    ; 입력 확인
    cmp eax, 5
    jne input_error

    ; 다섯 숫자 합산
    fild DWORD PTR num1
    fiadd DWORD PTR num2
    fiadd DWORD PTR num3
    fiadd DWORD PTR num4
    fiadd DWORD PTR num5

    ; 평균 계산
    fidiv DWORD PTR count

    ; 결과 저장
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
```

## 4. 프로그램 동작 원리

1. 사용자에게 5개의 정수를 입력받는다.
2. 입력받은 숫자를 각각 메모리에 저장한다.
3. FPU 명령어를 이용하여 5개의 숫자를 더한다.
4. 합계를 5로 나누어 평균을 계산한다.
5. 계산된 평균을 소수점 둘째 자리까지 출력한다.

### 주요 명령어

- push: 데이터를 스택에 저장
- scanf: 사용자 입력 처리
- fild: 정수 데이터를 FPU에 로드
- fiadd: 정수 덧셈 수행
- fidiv: 정수로 나눗셈 수행
- fstp: 계산 결과를 메모리에 저장
- printf: 계산 결과 출력

## 5. 실행 방법

1. Visual Studio 2022를 실행한다.
2. C++ 빈 프로젝트를 생성한다.
3. 실행 플랫폼을 x86으로 설정한다.
4. 프로젝트의 Build Customizations에서 MASM을 활성화한다.
5. average.asm 파일을 추가한다.
6. 링커의 SubSystem을 Console로 설정한다.
7. Ctrl + F5를 눌러 실행한다.

## 6. 실행 결과

### 실행 예시 1

입력값: 10, 20, 30, 40, 50

```text
Enter 5 numbers: 10 20 30 40 50
Average = 30.00
```

### 실행 예시 2

입력값: 1, 2, 3, 4, 6

```text
Enter 5 numbers: 1 2 3 4 6
Average = 3.20
```


## 7. 결론

본 프로그램은 MASM 어셈블리어를 이용하여
5개의 정수를 입력받고 평균을 계산하는 프로그램이다.

scanf와 printf 함수를 이용하여 입출력을 처리하였으며,
FPU의 덧셈 및 나눗셈 명령어를 활용하여
소수점을 포함한 평균값을 계산하도록 구현하였다.
```
