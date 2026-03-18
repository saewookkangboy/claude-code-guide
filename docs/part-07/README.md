# Part 7: 시스템 최적화와 자동화

파워 유저들은 Claude Code 자체를 최적화하고, 반복 작업을 자동화하여 생산성을 극한까지 끌어올립니다.

## 7.1. 시스템 프롬프트 슬림화 (ykdojo Tip #33)

Claude Code의 모든 행동은 수만 토큰에 달하는 거대한 시스템 프롬프트에 의해 결정됩니다. ykdojo는 이 시스템 프롬프트를 직접 수정하여 19k 토큰에서 10k 이하로 절반 가까이 줄이는 데 성공했습니다.

**왜 시스템 프롬프트를 줄여야 하는가?**  
- 더 많은 코드 파일과 대화 기록을 컨텍스트에 담을 수 있음  
- 응답 속도 향상 (처리할 토큰이 적음)  
- 비용 절감 (토큰 사용량 감소)  

**ykdojo의 58가지 패치:**  
ykdojo는 58개의 패치를 통해 다음을 제거했습니다:  
1. 장황한 예시: 도구 설명에 포함된 불필요하게 긴 예시  
2. 반복적인 지시: 여러 곳에서 반복되는 동일한 지시사항  
3. 과도한 안전 경고: 너무 자주 반복되는 경고 메시지  
4. 사용하지 않는 도구 설명: 거의 사용되지 않는 도구의 긴 설명  

**패치 적용 방법:**  
```bash
# ykdojo의 저장소 클론
git clone https://github.com/ykdojo/claude-code-tips.git
cd claude-code-tips
# 패치 적용 스크립트 실행
./scripts/apply-patches.sh
```  

**⚠ 경고: 전문가의 영역**  
시스템 프롬프트를 잘못 수정하면 Claude의 성능이 심각하게 저하될 수 있습니다. 충분한 이해 없이 시도하지 마세요.  

**ykdojo의 조언:**  
"처음에는 제가 공유한 패치를 그대로 적용해보세요. 효과를 확인한 후, 자신만의 패치를 만들어보세요."

## 7.2. 장시간 작업을 위한 수동 지수 백오프 (ykdojo Tip #34)

장시간 실행되는 작업(예: 대용량 데이터 처리, 복잡한 빌드)을 Claude에게 맡길 때, 매 초마다 상태를 확인하면 비효율적입니다. 지수 백오프(Exponential Backoff) 전략을 사용하세요.

**지수 백오프란?**  
처음에는 짧은 간격으로 확인하고, 점차 간격을 늘려가는 방식입니다.  
- 1분 후 확인  
- 2분 후 확인  
- 4분 후 확인  
- 8분 후 확인  
- …  

**실전 프롬프트:**  
\> "대용량 CSV 파일(10GB)을 처리하는 스크립트를 실행해줘. 지수 백오프 방식으로 진행 상황을 확인해줘. 처음 1분 후, 그 다음 2분 후, 4분 후, 8분 후 확인해."  
# Claude가 실행: 1. 스크립트 실행 2. 1분 대기 후 상태 확인 3. 2분 대기 후 상태 확인 4. 작업 완료 시까지 반복  

**ykdojo의 조언:**  
"이 방법은 토큰을 절약하고, Claude가 다른 작업을 병렬로 수행할 수 있게 해줍니다."

## 7.3. 백그라운드에서 bash 명령 및 에이전트 실행 (ykdojo Tip #35)

장시간 실행되는 명령어나 에이전트를 백그라운드로 보내고, Claude가 다른 작업을 계속할 수 있게 합니다.

**Ctrl+B: 백그라운드로 보내기**  
명령어가 실행 중일 때 Ctrl+B 를 누르면 백그라운드로 이동합니다. Claude는 BashOutput 도구를 사용하여 나중에 상태를 확인할 수 있습니다.

**서브에이전트 백그라운드 실행:**  
\> "security-auditor 에이전트를 백그라운드에서 실행하여 전체 코드베이스를 스캔해줘. 완료되면 알려줘."  
# Claude가: 1. 서브에이전트 백그라운드 실행 2. 메인 작업 계속 진행 3. 주기적으로 서브에이전트 상태 확인 4. 완료 시 결과 수집  

**병렬 서브에이전트 활용:**  
\> "대규모 코드베이스를 분석해야 해. 3개의 서브에이전트를 백그라운드에서 실행하여 각각 다른 모듈을 분석하도록 해줘."  
# Claude가: Agent 1: /src/auth 모듈 분석, Agent 2: /src/api 모듈 분석, Agent 3: /src/database 모듈 분석 — 모두 병렬로 실행  

## 7.4. 자동화의 자동화 (ykdojo Tip #36)

ykdojo는 이를 "Automation of automation"이라고 부릅니다. 이는 워크플로우 자체를 자동화하여 개발자가 더 높은 수준의 추상화에 집중할 수 있게 만드는 에이전틱 개발의 핵심 철학입니다.

**ykdojo의 자동화 여정:**  
1. Level 1: ChatGPT에서 코드를 복사하여 터미널에 붙여넣기  
2. Level 2: ChatGPT 플러그인(Kaguya)을 만들어 자동 실행  
3. Level 3: Claude Code 사용으로 터미널 통합  
4. Level 4: 음성 전사 시스템 구축으로 타이핑 자동화  
5. Level 5: CLAUDE.md로 반복 지시 자동화  
6. Level 6: 커스텀 슬래시 명령어로 워크플로우 자동화  
7. Level 7: Skills로 Claude의 자동 판단 자동화  
8. Level 8: Hooks로 규칙 강제 자동화  

**ykdojo의 철학:**  
"같은 작업을 2-3번 반복하는 것은 괜찮습니다. 하지만 그 이상 반복한다면, 자동화할 방법을 찾으세요. 그리고 그 자동화 과정 자체도 자동화하세요."

## 7.5. Headless 모드로 CI/CD 통합 (Ado Tip #29)

Claude Code는 대화형 도구를 넘어, CI/CD 파이프라인에 통합할 수 있는 강력한 CLI 도구입니다.

**Headless 모드 사용법:**  
```bash
# 기본 사용
claude -p "Fix the lint errors"
# 파이프라인 통합
git diff | claude -p "Explain these changes"
# JSON 출력
echo "Review this PR" | claude -p --json
```  

**CI/CD 통합 예시: GitHub Actions**  
`.github/workflows/claude-review.yml` 예시: PR이 열리거나 동기화될 때 checkout → Claude Code 설치 → `git diff origin/main...HEAD | claude -p "Review this PR and identify potential issues" > review.md` → actions/github-script로 review.md 내용을 PR 코멘트로 등록  

**Ado의 조언:**  
"Headless 모드는 AI를 파이프라인에 통합합니다. -p 플래그는 비대화형으로 실행하고 stdout으로 직접 출력합니다."

---


---
↑ [목차로 돌아가기](../../README.md#toc)
