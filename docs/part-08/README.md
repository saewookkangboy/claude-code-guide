# Part 8: 컨테이너와 샌드박스

안전한 실험과 위험한 작업을 위한 격리 환경 구축 방법을 다룹니다.

## 8.1. 컨테이너로 위험한 작업 격리 (ykdojo Tip #37)

--dangerously-skip-permissions 플래그는 매우 편리하지만 위험합니다. ykdojo는 이를 "보호되지 않은 성관계"에 비유하며, 컨테이너라는 안전장치를 사용할 것을 강력히 권장합니다.

**Docker 컨테이너 설정:**  
ykdojo는 자신의 저장소에 Dockerfile 과 설정 스크립트를 공개했습니다.

```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl git tmux vim nodejs npm python3 python3-pip
RUN curl -fsSL https://claude.ai/install.sh | sh
RUN npm install -g @google/generative-ai-cli
WORKDIR /workspace
CMD ["/bin/bash"]
```  

**컨테이너 실행:**  
```bash
docker build -t claude-sandbox .
docker run -it --rm -v $(pwd):/workspace -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY claude-sandbox
# 컨테이너 안에서: claude --dangerously-skip-permissions
```  

**고급: 워커 Claude 오케스트레이션**  
로컬 메인 Claude가 tmux로 컨테이너 안 "워커" Claude에게 작업 지시·결과 수집.  
\> "Docker 컨테이너를 실행하고, 그 안에서 Claude Code를 --dangerously-skip-permissions 모드로 실행해줘. tmux로 워커 Claude에게 '전체 코드베이스를 분석하고 보안 취약점을 찾아줘'라고 지시해줘."  

**ykdojo의 실제 사례:**  
새 버전 출시 시 시스템 프롬프트 패치 업데이트를 컨테이너 안 Claude에게 맡김: minified JS 분석, 변수 매핑, 패치 생성·테스트·수정, 문서 업데이트. 메인 Claude는 최종 결과만 검토.

## 8.2. Sandbox 모드와 권한 관리 (Ado Tip #30)

/sandbox 명령어로 한 번 경계를 정의하면, Claude가 그 안에서 자유롭게 작업합니다.

**설정 예시:**  
\> /sandbox → "npm install, npm test, git status, git diff를 자동 승인해줘"  

**와일드카드:**  
\> "mcp__server__* 패턴의 모든 MCP 서버 도구를 자동 승인해줘"  

**Ado의 조언:**  
"Sandbox는 속도와 보안을 동시에 제공합니다. 신뢰할 수 있는 작업에는 Sandbox를, 실험적인 작업에는 컨테이너를 사용하세요."

## 8.3. YOLO 모드: 위험을 감수할 때 (Ado Tip #31)

`claude --dangerously-skip-permissions` — 모든 권한 요청에 자동 "예".

**사용할 때:** 컨테이너 안 실험, 장시간 자율 작업(예: Reddit 리서치), 신뢰할 수 있는 반복 작업.  

**절대 사용 금지:** 호스트에서 직접 실행, 중요한 데이터 디렉토리, 프로덕션 환경.

---


---
↑ [목차로 돌아가기](../../#toc)
