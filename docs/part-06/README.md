# Part 6: 고급 기능 - MCP, Hooks, Agents

이제 Claude Code를 단순한 코딩 도우미에서 벗어나, 여러분의 명령을 수행하는 강력한 AI 에이전트 팀으로 만들어주는 고급 기능들을 탐험할 차례입니다.

## 6.1. MCP: 외부 세계와의 연결 (Ado Tip #19, #20, #21, #22)

MCP(Model Context Protocol)는 Claude가 외부 서비스 및 API와 직접 통신할 수 있도록 만드는 프로토콜입니다.

**MCP 서버 설치:**  
- Playwright MCP (브라우저 자동화): claude mcp add -s user playwright npx @playwright/mcp@latest  
- Supabase MCP (데이터베이스 직접 쿼리): claude mcp add -s user supabase npx @supabase/mcp@latest  
- Firecrawl MCP (웹 크롤링): claude mcp add -s user firecrawl npx @firecrawl/mcp@latest  

**Supabase MCP 활용 사례 (Ado Tip #19):**  
\> "Supabase 데이터베이스의 users 테이블에서 지난 7일간 가입한 사용자 수를 조회해줘"  
Claude가 직접 SQL 실행 (SELECT COUNT(*) FROM users WHERE created_at >= NOW() - INTERVAL '7 days'), 결과 예: 1,234명  

**Firecrawl MCP 활용 사례 (Ado Tip #20):**  
\> "https://example.com의 모든 제품 페이지를 크롤링하고, 제품명과 가격을 CSV 파일로 저장해줘"  
Claude가 웹사이트 크롤링 → 제품 정보 추출 → products.csv 생성  

**Playwright MCP 활용 사례 (Ado Tip #21):**  
\> "Playwright를 사용하여 로그인 폼을 테스트해줘. 잘못된 비밀번호 입력 시 에러 메시지가 표시되는지 확인해"  
Claude가 브라우저 실행, 로그인 페이지 접속, 잘못된 비밀번호 입력, 에러 메시지 확인, 스크린샷 저장  

**⚠ MCP 성능 최적화 (ykdojo의 경고):**  
MCP는 강력하지만, 활성화된 MCP가 많아질수록 컨텍스트 윈도우를 많이 차지합니다. ykdojo는 다음을 권장합니다: 10개 미만의 MCP 서버, 80개 미만의 활성 도구, 사용하지 않는 MCP는 /mcp 로 비활성화  

## 6.2. Hooks: 규칙의 강제 (Ado Tip #24)

Hooks는 특정 이벤트 발생 시 자동으로 실행되는 셸 명령어입니다. 이는 AI의 확률적 행동에 결정론적 제어를 추가합니다.

**Hook 종류:**  
PreToolUse (도구 실행 전, 위험한 명령어 차단), PostToolUse (도구 실행 후, 로그/알림), PermissionRequest (권한 요청 시, 자동 승인/거부), Notification (Claude 알림 시, 외부 시스템 통합), SubagentStart/SubagentStop (서브에이전트 시작/종료 시, 모니터링/결과 수집)  

**실전 예시: tmux 없이 장시간 명령어 경고**  
hooks.PreToolUse에서 TOOL_NAME=='Bash' && ! $TMUX 일 때 "⚠ Warning: Long-running command without tmux" 출력  

**실전 예시: 위험한 명령어 차단**  
PreToolUse에서 TOOL_INPUT에 'rm -rf /' 포함 시 "BLOCKED: Dangerous command", exit 1  

**Ado의 조언:**  
"Hooks는 AI에게 '가드레일'을 제공합니다. 확률적으로 실수할 수 있는 AI에게 절대적인 규칙을 강제할 수 있습니다."

---

## 6.3. Skills: 재사용 가능한 지식 (Ado Tip #25)

Skills는 재사용 가능한 지식 조각입니다. Claude가 필요할 때 자동으로 호출하거나, 사용자가 수동으로 호출할 수 있습니다.

**Skill 생성 예시: Google 번역 링크**  
~/.claude/skills/google-translate/skill.md 에서: When the user asks how to pronounce a word in a specific language, generate a Google Translate link. Format: https://translate.google.com/?sl=auto&tl={target_language}&text={word}. Example: "How do you pronounce 'hello' in Korean?" → 링크 생성. 이제 Claude는 발음 질문을 받으면 자동으로 이 스킬을 사용합니다.

**ykdojo의 Reddit Fetch Skill:**  
ykdojo는 Reddit 콘텐츠를 가져오는 스킬을 만들어, Gemini CLI를 통해 Reddit을 크롤링하도록 했습니다. 이 스킬은 /dx 플러그인에 포함되어 있습니다.

## 6.4. Agents: 전문화된 서브에이전트 (Ado Tip #26)

Agents(서브에이전트)는 특정 작업에 전문화된 독립적인 AI 프로세스입니다. 메인 Claude가 작업을 위임할 수 있습니다.

**서브에이전트의 특징:** 각자 독립적인 200k 컨텍스트 윈도우, 병렬 실행 가능, 전문화된 시스템 프롬프트, 작업 완료 후 결과를 메인 에이전트에게 반환  

**실전 예시: TDD 가이드 에이전트**  
\> "tdd-guide 에이전트를 실행하여 이 함수에 대한 테스트를 작성해줘"  
Claude가 tdd-guide 서브에이전트 실행: 함수 분석, 테스트 케이스 설계, 테스트 코드 작성, 결과 반환  

**실전 예시: 보안 감사 에이전트**  
\> "security-auditor 에이전트를 실행하여 이 코드베이스의 보안 취약점을 찾아줘"  
SQL 인젝션, XSS, 하드코딩된 비밀번호 검사, 보고서 생성  

**Ado의 비유:**  
"산타는 모든 선물을 혼자 포장하지 않습니다. 엘프들이 있죠. 서브에이전트는 Claude의 엘프입니다."

## 6.5. Plugins: 기능 번들 (Ado Tip #27)

Plugins는 Hooks, Skills, Agents, MCP 서버를 하나의 패키지로 묶어 배포하고 설치하는 방법입니다.

**플러그인 설치:**  
/plugin search frontend → /plugin install frontend-design@anthropic  

**ykdojo의 dx 플러그인:**  
claude plugin marketplace add ykdojo/claude-code-tips  
claude plugin install dx@ykdojo  
포함: /dx:gha \<url\> (GitHub Actions 실패 분석), /dx:handoff (HANDOFF.md 생성), /dx:clone, /dx:half-clone, reddit-fetch 스킬  

## 6.6. CLAUDE.md vs Skills vs Slash Commands vs Plugins (ykdojo Tip #31)

이 기능들은 비슷해 보이지만, 각각의 목적과 사용 시점이 다릅니다.

| 기능 | 로딩 시점 | 주요 사용자 | 토큰 효율성 | 사용 사례 |
|------|-----------|-------------|-------------|-----------|
| CLAUDE.md | 모든 대화 시작 시 | 개발자 | 낮음 (항상 로드) | 프로젝트 설명, 코딩 스타일, 금지 사항 |
| Skills | 필요 시 자동 | Claude | 높음 (필요 시만) | 특정 작업 자동화 (번역, 크롤링 등) |
| Slash Commands | 수동 호출 시 | 개발자 | 높음 (호출 시만) | 반복 작업 (커밋, PR 생성 등) |
| Plugins | 설치 시 | 개발자 | - | 여러 기능을 하나로 묶어 배포 |

**ykdojo의 조언:**  
"Skills와 Slash Commands는 원래 다른 의도로 설계되었지만, 결국 통합되었습니다. Skills는 Claude가 사용하도록, Slash Commands는 개발자가 사용하도록 만들어졌습니다."

---


---
↑ [목차로 돌아가기](../../README.md#toc)
