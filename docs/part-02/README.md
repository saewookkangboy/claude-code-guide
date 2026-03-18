# Part 2: 기초부터 탄탄하게 - 환경 설정과 필수 명령어

이 장에서는 Claude Code의 세계로 들어서는 첫 단계를 넘어, 여러분과 AI가 최상의 시너지를 낼 수 있도록 작업 환경을 최적화하는 파워 유저들의 초기 설정법을 중심으로 기초를 다집니다.

## 2.1. 커스텀 상태 라인으로 모든 것을 한눈에 (ykdojo Tip #4)

ykdojo가 가장 먼저 소개하는 팁은 커스텀 상태 라인(Custom Status Line)입니다. 이는 터미널 하단에 실시간으로 중요한 정보를 표시하는 기능으로, 파워 유저들이 가장 먼저 설정하는 항목입니다.

**기본 상태 라인의 문제점:**  
기본 상태 라인은 최소한의 정보만 표시합니다. 하지만 실전에서는 다음 정보들이 실시간으로 필요합니다:
- 현재 토큰 사용량 및 남은 한도
- Git 브랜치 및 변경 사항 상태
- 현재 작업 디렉토리
- 활성화된 MCP 서버 수
- 현재 사용 중인 모델

**ykdojo의 커스텀 상태 라인 설정:**  
ykdojo는 자신의 GitHub 저장소에 status-line.sh 스크립트를 공개했습니다. 이 스크립트는 다음을 표시합니다:

`~/project (main*) | Tokens: 45k/200k | Opus 4.6 | MCP: 3 active`

**설치 방법:**
```bash
# 1. 저장소 클론
git clone https://github.com/ykdojo/claude-code-tips.git
# 2. 스크립트 심볼릭 링크 생성
ln -s $(pwd)/claude-code-tips/scripts/status-line.sh ~/.claude/scripts/status-line.sh
# 3. Claude Code 재시작
```

**커스터마이징:**  
~/.claude/settings.json 에서 상태 라인 형식을 직접 정의할 수도 있습니다:
```json
{
  "statusLine": {
    "format": "{{dir}} {{git}} | {{tokens}} | {{model}}",
    "updateInterval": 1000
  }
}
```

**Ado의 /statusline 명령어 (Ado Tip #13):**  
Ado는 /statusline 명령어를 통해 대화형으로 상태 라인을 커스터마이징하는 방법을 소개합니다. 이 명령어를 실행하면 Claude가 사용 가능한 변수들을 보여주고, 원하는 형식을 대화로 설정할 수 있습니다.

---

## 2.2. 필수 슬래시 명령어 마스터 (ykdojo Tip #5, Ado Tip #1, #14, #15)

Claude Code의 진정한 힘은 슬래시 명령어에서 나옵니다. 이 명령어들은 AI와의 대화를 넘어, 시스템을 직접 제어하고 정보를 즉시 얻을 수 있게 해줍니다.

**Tier 1: 생존 필수 명령어**

| 명령어 | 설명 | 사용 시점 |
|--------|------|------------|
| /usage | 현재 토큰 사용량과 리셋 시간을 시각적으로 표시 | 매 세션 시작 시, 대화가 길어질 때 |
| /clear | 대화 내용을 깨끗이 지우고 새로운 컨텍스트로 시작 | 컨텍스트 오염 시, 새 작업 시작 시 |
| /stats | GitHub 스타일 활동 그래프, 즐겨찾는 모델, 연속 사용일 등 분석 | 주간 회고 시, 사용 패턴 분석 시 |
| /context | 컨텍스트 윈도우 사용 현황 X-Ray | 성능 저하 느낄 때, 최적화 필요 시 |

**Tier 2: 생산성 향상 명령어**

| 명령어 | 설명 | 사용 시점 |
|--------|------|------------|
| /chrome | 크롬 브라우저 통합 시작 | 웹 스크래핑, UI 테스트, 디버깅 |
| /mcp | MCP 서버 목록 및 활성화/비활성화 | MCP 관리, 컨텍스트 최적화 |
| /permissions | 승인된 명령어 목록 및 관리 | 보안 감사, 위험한 명령어 제거 |
| /export | 대화 내역을 마크다운으로 내보내기 | 문서화, 팀 공유, 학습 자료 |

**2026년 추가·변경 명령어 (v2.1.76+)**  
| 명령어 | 설명 | 사용 시점 |
|--------|------|------------|
| /branch [name] | 현재 대화에서 분기한 새 세션 생성. `/fork`는 동일 기능 별칭 | 다른 접근 시도 시 원본 대화 유지 |
| /effort [low\|medium\|high\|max\|auto] | 모델 노력 수준 설정. `max`는 현재 세션만(Opus 4.6). 인자 없으면 현재 값 표시. 응답 중에도 즉시 반영 | 복잡한 분석 시 high/max, 단순 작업 시 low |
| /compact [instructions] | 대화를 압축하고 선택적으로 집중 지시 추가 | 컨텍스트 비우기 전 요약 보존 |
| /cost | 토큰 사용 통계. 플랜별 상세는 공식 문서 참조 | 비용·사용량 확인 |
| /copy [N] | 마지막 응답을 클립보드로. N 지정 시 N번째 최신 응답. 코드 블록 있으면 선택 UI | 생성 코드 빠르게 복사 |
| /diff | 커밋되지 않은 변경 사항을 대화형 diff 뷰어로 표시 | 변경 검토 시 |

**! Prefix: 즉시 실행의 마법 (Ado Tip #1)**  
! 접두사를 붙이면 Claude의 처리 없이 즉시 셸 명령을 실행하고 결과를 컨텍스트에 주입합니다. 이는 토큰 낭비를 방지하고 속도를 높입니다.

**예시:**
- 일반적인 방법 (느림, 토큰 낭비): "git status를 실행해줘" → Claude가 실행 후 결과 표시
- ! Prefix 방법 (빠름, 효율적): `!git status` → 즉시 결과 표시, Claude는 결과만 읽음

**Ado의 조언:**  
"! Prefix는 제가 가장 자주 사용하는 기능입니다. !git diff, !npm test, !docker ps 등 간단한 상태 확인에 완벽합니다."

---

## 2.3. CLAUDE.md: AI를 위한 프로젝트 설명서 (Ado Tip #2, #3, ykdojo Tip #16)

CLAUDE.md 파일은 AI를 위한 프로젝트 설명서이자 행동 지침입니다. Claude는 이 파일을 최우선으로 참고하여 프로젝트의 기술 스택, 코딩 스타일, 주요 라이브러리, 그리고 해서는 안 될 일들을 파악합니다.

**/init: AI가 스스로 온보딩 (Ado Tip #2)**  
새 프로젝트에서 /init 명령어를 실행하면, Claude가 코드베이스를 분석하여 CLAUDE.md 의 초안을 자동으로 생성해줍니다.

**실제 예시:**  
\> /init  
Claude가 생성한 CLAUDE.md 예시:

```markdown
# Project: E-commerce Platform
## Tech Stack
- **Frontend**: Next.js 14, React 18, TailwindCSS
- **Backend**: Node.js, Express, PostgreSQL
- **ORM**: Drizzle
- **Authentication**: NextAuth.js
- **Payment**: Stripe
## Project Structure
- `/app`: Next.js app directory (routes, layouts)
- `/components`: Reusable React components
- `/lib`: Utility functions, database client
- `/api`: Backend API routes
## Coding Standards
- Use TypeScript strict mode
- Prefer server components over client components
- Use async/await instead of .then()
- Always validate user input with Zod
## DO NOT
- Never commit .env files
- Never use any type in TypeScript
- Never bypass authentication checks
- Never expose API keys in client code
## Common Commands
- npm run dev: Start development server
- npm run build: Build for production
- npm run db:push: Push schema changes to database
```

**Memory Updates: 실시간 메모리 업데이트 (Ado Tip #3)**  
CLAUDE.md 를 직접 편집하지 않고, 자연어로 지시하여 업데이트할 수 있습니다.

예: \> Update Claude.md: always use bun instead of npm  
Claude가 CLAUDE.md 를 자동으로 수정합니다 (Common Commands에서 bun으로 변경 등).

**간결함의 미학 (ykdojo Tip #16)**  
ykdojo는 CLAUDE.md 를 최대한 간결하고 명확하게 유지하라고 조언합니다.

**나쁜 예 (장황함):**  
## Authentication  
Our authentication system is built using NextAuth.js, which is a complete authentication solution for Next.js applications. It provides a flexible and secure way to add authentication to your app. We use the Credentials provider to authenticate users with email and password. The session strategy is set to JWT... (이하 생략)

**좋은 예 (간결함):**  
## Authentication  
- NextAuth.js with Credentials provider  
- JWT session strategy  
- **DO NOT**: Bypass auth checks, expose session secrets  

**ykdojo의 조언:**  
"처음에는 CLAUDE.md 없이 시작하세요. 같은 말을 반복하게 되면 그때 추가하세요. 과도한 정보는 컨텍스트를 낭비합니다."

---

## 2.4. 터미널 별칭으로 빠른 접근 (ykdojo Tip #6)

파워 유저들은 타이핑을 최소화하기 위해 터미널 별칭을 적극 활용합니다. ykdojo가 사용하는 별칭들을 소개합니다.

**~/.zshrc 또는 ~/.bashrc에 추가:**
```bash
# Claude Code 기본 별칭
alias c='claude'
alias cc='claude --continue'   # 마지막 대화 이어가기
alias cr='claude --resume'     # 대화 목록에서 선택
alias ch='claude --chrome'     # 크롬 통합 모드
# Git 관련 별칭 (Claude와 함께 사용)
alias gb='git branch'
alias gco='git checkout'
alias gst='git status'
alias gd='git diff'
# 빠른 종료
alias q='exit'
```

**사용 예시:**  
기존 방법: `$ claude --continue`, `$ claude --chrome`  
별칭 사용: `$ cc`, `$ ch`

**ykdojo의 조언:**  
"하루에 수십 번 실행하는 명령어라면, 별칭을 만드세요. 타이핑 시간이 쌓이면 엄청난 차이를 만듭니다."

---

## 2.5. 세션 관리: 대화를 잃지 않는 법 (Ado Tip #4, #16, #17, #18)

Claude Code는 모든 대화를 자동으로 저장하지만, 효과적으로 관리하지 않으면 나중에 찾기 어렵습니다. Ado가 소개하는 세션 관리 기술을 익히면, 과거의 작업을 쉽게 이어갈 수 있습니다.

**Continue Where You Left Off (Ado Tip #4)**  
`$ claude --continue` 또는 `$ c -c`  
마지막으로 작업하던 대화를 즉시 이어갑니다. 컴퓨터를 재부팅하거나, 다른 작업을 하다가 돌아왔을 때 유용합니다.

**Named Sessions: 세션에 이름 붙이기 (Ado Tip #16)**  
대화 중에 /rename 명령어를 사용하여 세션에 의미 있는 이름을 붙일 수 있습니다.  
\> /rename auth-system-refactor  
이제 이 세션을 이름으로 재개할 수 있습니다: `$ claude --resume auth-system-refactor`

**Ado의 조언:**  
"중요한 작업은 항상 이름을 붙이세요. '2026-01-15 14:30'보다 'stripe-integration'이 훨씬 기억하기 쉽습니다."

**Claude Code Remote: 원격 세션 (Ado Tip #17)**  
웹 브라우저에서 시작한 Claude Code 세션을 로컬 터미널로 가져올 수 있습니다.  
`$ claude --teleport <session_id>`  
세션 ID는 웹 UI에서 확인할 수 있습니다. 활용: 외출 중 웹에서 작업 시작 후 집에서 터미널로 이어가기, 팀원이 웹에서 시작한 세션을 로컬에서 디버깅할 때.

**/export: 대화 내역 내보내기 (Ado Tip #18)**  
\> /export  
현재 대화 내역을 마크다운 파일로 내보냅니다. 팀원과 공유(Slack, Notion 등), 문서화(프로젝트 위키), 학습 자료, 블로그 포스트 작성에 활용할 수 있습니다. 내보낸 파일에는 세션명, 날짜, 모델, User/Claude 대화가 포함됩니다.

---


---
↑ [목차로 돌아가기](https://github.com/saewookkangboy/claude-code-guide/blob/main/README.md#user-content-toc)
