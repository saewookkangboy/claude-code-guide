# Part 9: 브라우저 통합과 웹 자동화

Claude Code는 브라우저를 직접 제어하여 웹 스크래핑, UI 테스트, 디버깅을 수행할 수 있습니다.

## 9.1. 네이티브 브라우저 통합 (Ado Tip #32)

Claude Code는 Chrome과 직접 통합되어, 브라우저를 제어하고 상호작용할 수 있습니다.

**Chrome 확장 설치:**  
1. https://claude.ai/chrome 방문  
2. Chrome 확장 프로그램 설치  
3. Claude Code 실행: claude --chrome  

**가능한 작업:**  
페이지 탐색, 버튼 클릭 및 폼 작성, 콘솔 에러 읽기, DOM 검사, 스크린샷 촬영  

**실전 예시: 버그 재현 및 수정**  
\> "localhost:3000으로 이동하여 로그인 버튼을 클릭해줘. 콘솔에 에러가 있는지 확인하고, 있다면 코드를 수정해줘."  
# Claude가: 1. 브라우저에서 localhost:3000 열기 2. 로그인 버튼 찾기 및 클릭 3. 콘솔 에러 확인 (예: "Uncaught TypeError: Cannot read property 'email' of undefined") 4. 코드에서 해당 부분 찾기 5. 수정: user?.email로 옵셔널 체이닝 추가 6. 브라우저 새로고침하여 수정 확인  

**Ado의 조언:**  
"'버그를 수정하고 작동하는지 확인해줘'가 이제 하나의 프롬프트로 가능합니다."

## 9.2. Playwright MCP (Ado Tip #21)

네이티브 브라우저 통합으로 접근이 어려운 동적 웹사이트(JavaScript 기반)와 상호작용이 필요할 때 Playwright MCP를 사용합니다.

**설치:**  
claude mcp add -s user playwright npx @playwright/mcp@latest  

**Playwright의 장점:**  
헤드리스 브라우저 지원 (백그라운드 실행), 여러 브라우저 지원 (Chrome, Firefox, Safari), 네트워크 요청 가로채기, 파일 다운로드 자동화  

**실전 예시: E2E 테스트 자동화**  
\> "Playwright를 사용하여 전체 사용자 여정을 테스트해줘: 1. 회원가입 2. 로그인 3. 제품 검색 4. 장바구니 추가 5. 결제. 각 단계마다 스크린샷을 저장해줘."  
# Claude가 Playwright로 전체 시나리오 실행  

## 9.3. Gemini CLI를 대체 수단으로 (ykdojo Tip #23)

Claude의 네이티브 브라우저나 Playwright로도 접근이 막힌 웹사이트가 있을 때, Gemini CLI를 대체 수단으로 사용할 수 있습니다.

**Gemini CLI 설치:**  
npm install -g @google/generative-ai-cli  
export GOOGLE_API_KEY=your_api_key  

**ykdojo의 Reddit 리서치 워크플로우:**  
\> "Gemini CLI를 사용하여 Reddit의 r/programming에서 'Claude Code' 관련 게시물을 찾고 요약해줘"  
# Claude가 tmux 세션에서 Gemini CLI 실행 → Gemini가 Reddit 크롤링 및 분석 → 결과를 Claude에게 반환 → Claude가 요약 및 정리  

**멀티 모델 오케스트레이션:**  
\> "이 코드를 Claude Opus로 작성하고, Gemini로 코드 리뷰를 받은 후, GPT-4로 최종 최적화를 해줘"  
# Claude Code가 여러 AI 모델을 조율하여 작업 수행  

**ykdojo의 조언:**  
"핵심은 Claude Code의 부드러운 UI/UX입니다. 여러 CLI를 수동으로 전환하고 복사-붙여넣기하는 대신, Claude Code가 모든 것을 조율하는 중앙 인터페이스가 됩니다."

---


---
↑ [목차로 돌아가기](https://github.com/saewookkangboy/claude-code-guide/blob/main/README.md#user-content-toc)
