# Part 3: 생산성을 극대화하는 핵심 기술

이 장에서는 타이핑 시간을 줄이고, 정보 전달 속도를 높이며, 반복 작업을 자동화하는 파워 유저들의 핵심 기술을 다룹니다. 이 기술들을 익히면 Claude Code와의 협업 속도가 2배 이상 빨라집니다.

## 3.1. 음성으로 코딩하기 (ykdojo Tip #7)

ykdojo가 가장 혁신적이라고 평가하는 기술은 음성 코딩입니다. 타이핑보다 말이 훨씬 빠르기 때문입니다. 평균적으로 사람은 분당 40단어를 타이핑하지만, 분당 150단어를 말할 수 있습니다. 이는 3.75배의 속도 차이입니다.

**ykdojo의 커스텀 음성 전사 시스템**  
ykdojo는 Claude Code를 사용하여 자신만의 음성 전사 시스템을 구축했습니다. 이 시스템은:
1. 키보드 단축키(예: Cmd+Shift+Space)를 누르면 녹음 시작
2. 다시 누르면 녹음 종료 및 전사 시작
3. 전사된 텍스트를 현재 커서 위치에 자동 삽입

**사용 가능한 도구들:**

| 도구 | 플랫폼 | 특징 | 가격 |
|------|--------|------|------|
| superwhisper | macOS | 로컬 처리, 빠름, 정확함 | $30 일회성 |
| MacWhisper | macOS | OpenAI Whisper 기반 | 무료/프리미엄 |
| ykdojo's Custom Tool | macOS | Claude Code로 제작, 완전 커스터마이징 | 오픈소스 |
| Windows Speech Recognition | Windows | 내장, 무료 | 무료 |

**음성 코딩 워크플로우 예시:**  
[음성] "Claude, 사용자 인증 미들웨어를 만들어줘. JWT 토큰을 검증하고, 유효하지 않으면 401 에러를 반환해. Express.js를 사용하고, TypeScript로 작성해줘."  
[Claude가 즉시 코드 생성]

**ykdojo의 조언:**  
"약간의 발음 오류나 문법 실수는 Claude가 맥락으로 이해하므로 완벽할 필요 없습니다. 생각의 흐름을 끊지 않고 바로 말하세요."

**음성 코딩이 특히 유용한 상황:**  
- 복잡한 요구사항을 설명할 때  
- 여러 단계의 작업을 한 번에 지시할 때  
- 손이 피곤하거나 손목 터널 증후군이 있을 때  
- 산책하거나 이동 중일 때  

## 3.2. 터미널 출력 추출의 기술 (ykdojo Tip #8)

Claude가 생성한 긴 출력(예: 테스트 결과, 로그 분석, 코드 리뷰)을 효율적으로 추출하고 활용하는 방법입니다.

**방법 1: pbcopy/pbpaste (macOS/Linux)**  
- "마지막 출력을 pbcopy로 복사해줘"  
- 또는 `!claude -r | tail -n 50 | pbcopy`

**방법 2: VS Code로 바로 열기**  
- "이 코드를 temp.ts 파일로 저장하고 VS Code로 열어줘"  
- Claude가 cat > temp.ts 후 code temp.ts 실행

**방법 3: GitHub Desktop으로 변경 사항 검토**  
- "GitHub Desktop을 열어줘" 또는 `!open -a "GitHub Desktop"`  
- GitHub Desktop에서 변경된 파일들을 시각적으로 검토하고, 원하지 않는 변경 사항은 되돌릴 수 있습니다.

**ykdojo의 워크플로우:**  
1. Claude에게 코드 작성 요청  
2. GitHub Desktop으로 변경 사항 검토  
3. 문제가 있으면 특정 파일만 되돌리기  
4. Claude에게 "이 파일만 다시 수정해줘"라고 요청  

## 3.3. Cmd+A/Ctrl+A: 전체 선택의 힘 (ykdojo Tip #19)

웹 페이지나 문서의 내용을 빠르게 컨텍스트에 넣고 싶을 때, Cmd+A (macOS) 또는 Ctrl+A (Windows/Linux)로 전체를 선택하고 복사하여 Claude Code에 붙여넣으세요.

**실제 사례: 접근이 막힌 웹사이트**  
ykdojo는 Claude의 네이티브 브라우저로 접근이 막힌 웹사이트의 내용을 가져오기 위해 Gemini CLI를 사용했습니다.  
워크플로우: 1) "Gemini CLI를 사용하여 https://example.com의 내용을 가져와줘" 2) Gemini가 가져온 내용을 Cmd+A로 전체 선택 3) Claude Code에 붙여넣기 → "이 내용을 분석해서 핵심 정보를 요약해줘"

**또 다른 활용: 긴 문서 요약**  
PDF나 웹 페이지의 내용을 전체 복사한 후 → "이 논문의 핵심 내용을 3개의 불릿 포인트로 요약해줘"

## 3.4. 마크다운과 Notion 활용 (ykdojo Tip #20, #21)

**Tip #20: 마크다운 활용**  
Claude Code는 마크다운을 완벽하게 지원합니다. 복잡한 구조의 정보를 전달할 때 마크다운을 사용하면 Claude가 더 정확하게 이해합니다.

예시:  
다음 API 엔드포인트를 구현해줘:  
## POST /api/users  
- **Request Body**: { name: string, email: string }  
- **Response**: { id: number, name: string, email: string, createdAt: string }  
- **Validation**: name은 2-50자, email은 유효한 형식  
- **Error Cases**: 400 유효성 검사 실패, 409 이메일 중복  

**Tip #21: Notion으로 링크 보존**  
Slack이나 다른 곳에서 링크가 포함된 텍스트를 복사하여 Claude Code에 직접 붙여넣으면 링크가 사라집니다. 하지만 Notion에 먼저 붙여넣은 후, Notion에서 복사하면 마크다운 형식으로 변환되어 링크가 보존됩니다.  
워크플로우: Slack에서 링크 포함 메시지 복사 → Notion 페이지에 붙여넣기 → Notion에서 다시 복사 → Claude Code에 붙여넣기 → 링크가 마크다운 형식으로 유지됨  

## 3.5. 키보드 단축키 완전 정복 (Ado Tip #5, #6, #7, #8, ykdojo Tip #22)

파워 유저들은 마우스를 거의 사용하지 않습니다. 모든 작업을 키보드로 처리합니다.

**필수 단축키 (Ado의 추천)**

| 단축키 | 기능 | 사용 시점 |
|--------|------|------------|
| Esc Esc | 대화/코드 되감기 (Undo) | 잘못된 변경 즉시 되돌리기 |
| Ctrl+R | 역방향 검색 (명령어 히스토리) | 이전에 사용한 프롬프트 재사용 |
| Ctrl+S | 프롬프트 임시 저장 (Stash) | 작성 중인 프롬프트를 나중을 위해 보관 |
| Tab / Enter | 프롬프트 제안 수락 | Claude가 제안한 다음 작업 즉시 실행 |

**Double Esc: 되감기의 마법 (Ado Tip #5)**  
Claude가 잘못된 코드를 작성했거나, 원하지 않는 파일을 삭제했을 때, Esc 를 두 번 빠르게 누르면 마지막 작업을 되돌립니다. 이는 Git의 git reset --hard HEAD~1 과 유사하지만, 훨씬 빠르고 안전합니다.

**Ctrl+R: 역방향 검색 (Ado Tip #6)**  
터미널의 Ctrl+R 처럼, Claude Code에서도 이전에 사용한 프롬프트를 검색할 수 있습니다. (reverse-i-search): auth → "auth"가 포함된 이전 프롬프트들이 표시됨.

**Prompt Stashing: 프롬프트 임시 저장 (Ado Tip #7)**  
긴 프롬프트를 작성하던 중, 갑자기 다른 작업을 해야 할 때 Ctrl+S 로 임시 저장할 수 있습니다. 나중에 다시 Ctrl+S 를 누르면 저장된 프롬프트가 복원됩니다.

**Prompt Suggestions: 다음 작업 예측 (Ado Tip #8)**  
Claude는 현재 컨텍스트를 바탕으로 다음에 할 작업을 예측하여 제안합니다. 제안이 표시되면 Tab 또는 Enter 를 눌러 즉시 수락할 수 있습니다. 예: 코드 작성 후 "이 코드에 대한 테스트를 작성할까요?" [Tab to accept] → 즉시 테스트 작성 시작  

## 3.6. Vim 모드로 프롬프트 편집 (Ado Tip #23)

Vim 사용자라면 /vim 명령어로 Vim 모드를 활성화할 수 있습니다. 이제 프롬프트 입력 박스에서 Vim 키 바인딩을 사용할 수 있습니다.

**Vim 모드에서 사용 가능한 명령:**  
- hjkl : 커서 이동  
- w , b : 단어 단위 이동  
- 0 , $ : 줄 시작/끝으로 이동  
- dd : 줄 삭제  
- yy : 줄 복사  
- p : 붙여넣기  
- i , a : 삽입 모드  
- Esc : 일반 모드  

**Ado의 조언:**  
"Vim 사용자라면 이 기능 없이는 살 수 없을 겁니다. 긴 프롬프트를 편집할 때 특히 유용합니다."

## 3.7. 입력 박스 탐색 및 편집 (ykdojo Tip #24)

Vim을 사용하지 않더라도, Claude Code의 입력 박스는 일반적인 터미널/readline 단축키를 지원합니다.

**탐색 단축키:**

| 단축키 | 기능 |
|--------|------|
| Ctrl+A | 줄 시작으로 이동 |
| Ctrl+E | 줄 끝으로 이동 |
| Option+Left/Right (Mac) | 단어 단위 이동 |
| Alt+Left/Right (Linux/Windows) | 단어 단위 이동 |

**편집 단축키:**

| 단축키 | 기능 |
|--------|------|
| Ctrl+W | 이전 단어 삭제 |
| Ctrl+U | 커서부터 줄 시작까지 삭제 |
| Ctrl+K | 커서부터 줄 끝까지 삭제 |
| Ctrl+C / Ctrl+L | 현재 입력 지우기 |
| Ctrl+G | 외부 에디터에서 프롬프트 편집 |

**Ctrl+G: 외부 에디터로 편집**  
매우 긴 프롬프트를 작성해야 할 때, Ctrl+G 를 누르면 $EDITOR 환경 변수에 설정된 에디터(Vim, VS Code 등)가 열립니다. 에디터에서 작성을 마치고 저장하면, 내용이 Claude Code 입력 박스에 자동으로 삽입됩니다.  
설정: ~/.zshrc 또는 ~/.bashrc에 `export EDITOR=vim` (또는 code, nano, nvim 등)

**이미지 붙여넣기:**  
- Mac: Ctrl+V (주의: Cmd+V가 아님)  
- Linux: Ctrl+V  
- Windows: Alt+V  

**여러 줄 입력:**  
가장 간단한 방법: \ 입력 후 Enter → 새 줄 생성  
또는 /terminal-setup 으로 터미널별 설정 확인 (Mac Terminal.app에서는 Option+Enter)

---


---
↑ [목차로 돌아가기](../../#toc)
