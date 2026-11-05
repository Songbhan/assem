# 🎓 MASM 학번 및 이름 출력 프로그램 (x86 Assembly)

Visual Studio 환경에서 **Microsoft Macro Assembler (MASM)**를 사용하여 콘솔 창에 학번과 이름을 출력하는 가장 단순한 형태의 x86 어셈블리 프로그램입니다. C 표준 라이브러리(`printf`)를 연결하여 코드 라인을 최소화했습니다.

## 📌 주요 특징
- 복잡한 Windows API 대신 C `printf` 함수를 사용하여 직관적인 출력 구현
- `exit` 호출 대신 `ret` 명령어를 통한 깔끔한 함수 종료 및 스택 정리
- 외부 라이브러리(`msvcrt.lib`, `legacy_stdio_definitions.lib`) 자동 링킹으로 빌드 에러 방지

---

## 💻 소스 코드 (`main.asm`)

```assembly
.386
.model flat, c
option casemap :none

; 빌드 오류 방지를 위한 표준 라이브러리 연결
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

    ret ; 프로그램 종료
main ENDP
END
```

---

## 🛠️ Visual Studio 환경 설정 및 실행 방법

프로그램을 정상적으로 빌드하고 실행하려면 Visual Studio에서 아래 설정을 정확히 완료해야 합니다.

### 1. 빌드 커스터마이제이션 활성화
1. Visual Studio에서 **C++ 빈 프로젝트(Empty Project)**를 생성합니다.
2. 우측 솔루션 탐색기에서 **프로젝트 이름 우클릭 ➡️ 빌드 종속성(Build Dependencies) ➡️ 빌드 커스터마이제이션(Build Customizations...)**을 클릭합니다.
3. **`masm (.targets, .props)`** 체크박스를 활성화하고 확인을 누릅니다.

### 2. 소스 파일 추가 및 항목 형식 변경
1. 프로젝트에 `main.asm` 파일을 생성하고 위의 소스 코드를 붙여넣습니다.
2. `main.asm` 파일 우클릭 ➡️ **속성(Properties)**으로 이동합니다.
3. **일반(General) ➡️ 항목 형식(Item Type)**을 **`Microsoft Macro Assembler`**로 변경하고 적용합니다.

### 3. 플랫폼 구성 및 하위 시스템 설정 (중요)
- **플랫폼 설정:** Visual Studio 상단 툴바에서 빌드 대상을 반드시 **`x86`** (32비트)으로 설정합니다. (`x64`에서는 링크 에러가 발생합니다.)
- **링커 하위 시스템 확인:** 
  1. 프로젝트 우클릭 ➡️ **속성(Properties)**으로 이동합니다.
  2. **링커(Linker) ➡️ 시스템(System)** 메뉴를 선택합니다.
  3. **하위 시스템(Subsystem)** 항목이 **`콘솔(/SUBSYSTEM:CONSOLE)`**로 설정되어 있는지 확인합니다.

### 4. 빌드 및 실행
- 콘솔 창이 결과를 표시한 후 바로 닫히지 않도록 반드시 **`Ctrl + F5` (디버그하지 않고 시작)** 키를 눌러 실행합니다.

---

## 🖥️ 출력 결과

```text
학번: 2023764047
이름: 한송빈

C:\Users\...\main.exe(프로세스 ...)이(가) 종료되었습니다(코드가 0인 경우).
이 창을 닫으려면 아무 키나 누르십시오...
```
