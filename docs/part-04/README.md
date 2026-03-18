# Part 4: 컨텍스트 관리의 예술

컨텍스트는 AI의 작업 기억입니다. 이를 효과적으로 관리하는 것은 Claude Code 마스터리의 핵심입니다.

## 4.1. 선제적 컨텍스트 압축 (ykdojo Tip #2)

대화가 길어지면 컨텍스트가 가득 차서 성능이 저하됩니다. ykdojo는 HANDOFF.md 기법으로 이를 해결합니다.

**HANDOFF.md 워크플로우:**  
1. 대화가 50k 토큰 이상 사용 중일 때 → "/context로 현재 사용량 확인"  
2. "지금까지의 작업 내용을 HANDOFF.md 파일로 정리해줘. 다음 에이전트가 이 파일만 읽고 작업을 이어갈 수 있도록 시도한 것, 성공한 것, 실패한 것, 다음 단계를 명확히 작성해줘."  
3. "/clear" → 새 세션 시작  
4. "@HANDOFF.md 이 파일을 읽고 작업을 이어가줘"  

**HANDOFF.md 예시:**  
- # 프로젝트: Stripe 결제 통합  
- ## 목표: Stripe Checkout을 사용한 일회성 결제 시스템 구현  
- ## 완료된 작업: Stripe SDK 설치, 엔드포인트 구현, 라우팅  
- ## 시도했지만 실패한 것: Webhook 서명 검증 (로컬 테스트 불가 → ngrok 필요)  
- ## 현재 문제: Webhook 이벤트 처리 미완성, DB 결제 기록 저장 필요  
- ## 다음 단계: ngrok 노출, Webhook URL 등록, payment_intent.succeeded 핸들러, payments 테이블 저장  

## 4.2. 터미널 탭으로 멀티태스킹 (ykdojo Tip #25)

하나의 대화에서 여러 작업을 섞으면 컨텍스트가 오염됩니다. ykdojo는 3-4개의 터미널 탭을 동시에 열어 각각 독립적인 작업을 수행합니다.

**탭 분리 전략:**

| 탭 | 용도 | 예시 |
|----|------|------|
| 탭 1 | 메인 개발 작업 | 새 기능 구현 |
| 탭 2 | 버그 수정 | 긴급 핫픽스 |
| 탭 3 | 리서치 및 실험 | 새로운 라이브러리 테스트 |
| 탭 4 | DevOps 및 배포 | CI/CD 디버깅 |

**ykdojo의 조언:**  
"각 탭은 독립적인 '두뇌'입니다. 작업을 섞지 마세요. 한 탭에서 인증 시스템을 작업하다가 갑자기 UI 디자인을 요청하면, Claude는 혼란스러워합니다."

## 4.3. 대화 복제 및 반복제 (ykdojo Tip #26)

현재 대화를 유지하면서 다른 접근 방식을 시도하고 싶을 때, 대화 복제 기능을 사용합니다.

**Clone: 전체 복제**  
\> /clone  
현재 대화의 모든 내용을 새로운 UUID로 복제합니다. 첫 메시지에 [CLONED Jan 15 14:30] 태그가 추가되어 복제본임을 알 수 있습니다.  
사용 사례: A 방식과 B 방식 비교 실험, 위험한 변경 전 백업, 팀원과 공유 스냅샷  

**Half-Clone: 반복제 (컨텍스트 절반 줄이기)**  
\> /half-clone  
대화의 후반부만 유지하고 전반부는 삭제합니다. 컨텍스트 사용량을 절반으로 줄이면서 최근 작업은 유지합니다.  
사용 사례: 대화가 너무 길어 성능 저하 시, 초기 실험은 불필요하고 현재 구현만 중요할 때  

**설치 방법 (ykdojo의 dx 플러그인 사용):**  
claude plugin marketplace add ykdojo/claude-code-tips  
claude plugin install dx@ykdojo  
이제 /dx:clone 과 /dx:half-clone 명령어를 사용할 수 있습니다.  

## 4.4. /context로 X-Ray 비전 (Ado Tip #12)

/context 명령어는 컨텍스트 윈도우의 X-Ray입니다. 무엇이 공간을 차지하는지 정확히 보여줍니다.

**출력 예시:**  
Context Usage: 87,432 / 200,000 tokens (43.7%)  
Breakdown: System Prompt, MCP Servers (supabase-mcp, playwright-mcp, firecrawl-mcp), Memory Files (CLAUDE.md), Skills, Conversation History  

**최적화 전략:**  
1. MCP 정리: 사용하지 않는 MCP는 /mcp 로 비활성화  
2. CLAUDE.md 간소화: 불필요한 설명 제거  
3. 대화 압축: /clear 또는 HANDOFF.md 사용  

**Ado의 조언:**  
"일반적으로 10개 미만의 MCP와 80개 미만의 활성 도구를 유지하는 것이 최적입니다."

## 4.5. realpath로 절대 경로 얻기 (ykdojo Tip #27)

다른 디렉토리의 파일을 Claude에게 알려줄 때, 상대 경로 대신 절대 경로를 사용하면 혼란을 방지할 수 있습니다.

**잘못된 방법:**  
\> "../../config/database.ts 파일을 확인해줘"  

**올바른 방법:**  
\> !realpath ../../config/database.ts  
→ /Users/ykdojo/projects/myapp/config/database.ts  
\> "@/Users/ykdojo/projects/myapp/config/database.ts 이 파일을 확인해줘"

---


---
↑ [목차로 돌아가기](../../#toc)
