# Part 12: 고급 기능과 SDK

최신 기능과 개발자를 위한 SDK를 다룹니다.

## 12.1. Extended Thinking (Ado Tip #28)

**Ultrathink 키워드:**  
\> "ultrathink: 이 아키텍처 결정의 장단점을 깊이 분석해줘"  
ultrathink 키워드를 포함하면, Claude는 응답하기 전에 최대 32k 토큰을 내부 추론에 할당합니다. 복잡한 아키텍처 결정이나 까다로운 디버깅에 유용합니다.

**MAX_THINKING_TOKENS 설정:**  
```json
{ "thinking": { "maxTokens": 5000 } }
```  
이 설정이 있으면 ultrathink 키워드보다 우선합니다.

**API에서 Extended Thinking 사용:**  
thinking: { type: "enabled", budget_tokens: 5000 }  
Claude는 thinking 블록에 단계별 추론을 표시합니다.

## 12.2. LSP 통합 (Ado Tip #29)

Language Server Protocol (LSP)는 Claude에게 IDE 수준의 코드 인텔리전스를 제공합니다.

**LSP가 제공하는 것:**  
즉시 진단(각 편집 후 에러와 경고), 코드 탐색(정의로 이동, 참조 찾기, 호버 정보), 언어 인식(타입 정보 및 문서)  

**실전 효과:**  
\> "이 함수를 리팩토링해줘"  
# LSP 없이: Claude가 코드를 수정하고, 실행해봐야 에러 발견  
# LSP 있음: Claude가 수정하는 즉시 타입 에러 감지 및 수정  

## 12.3. Claude Agent SDK (Ado Tip #30)

Claude Code의 에이전트 루프, 도구, 컨텍스트 관리를 SDK로 사용할 수 있습니다.

**10줄로 에이전트 만들기:**  
```javascript
import { query } from '@anthropic-ai/claude-agent-sdk';
for await (const msg of query({
  prompt: "Generate markdown API docs for all public functions in src/",
  options: { allowedTools: ["Read", "Write", "Glob"], permissionMode: "acceptEdits" }
})) {
  if (msg.type === 'result') console.log("Docs generated:", msg.result);
}
```  

**활용 사례:**  
커스텀 CI/CD 파이프라인에 AI 에이전트 통합, 사내 도구에 Claude Code 기능 임베딩, 특수한 워크플로우를 위한 전용 에이전트 개발  

## 12.4. 팀 설정과 공유 워크플로우 (Ado Tip #31)

**팀 설정 공유:**  
.claude/team-settings.json 에 permissions, hooks, mcpServers(예: company-db) 정의. 팀 저장소에 .claude/ 폴더를 커밋하여 모든 팀원이 동일한 설정을 사용하도록 합니다.

---


---
↑ [목차로 돌아가기](https://github.com/saewookkangboy/claude-code-guide/blob/main/README.md#user-content-toc)
