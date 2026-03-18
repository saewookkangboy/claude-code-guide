# Part 5: Git과 GitHub 워크플로우 완전 정복

Claude Code는 Git 및 GitHub와 완벽하게 통합됩니다. 파워 유저들은 이를 활용하여 코드 리뷰, 커밋, PR 생성까지 모두 자동화합니다.

## 5.1. Git과 GitHub CLI 프로 활용 (ykdojo Tip #9)

ykdojo는 Git과 GitHub CLI(gh)를 Claude Code와 결합하여 강력한 워크플로우를 만들었습니다.

**자동 커밋 메시지 생성**  
\> "변경 사항을 분석하고 적절한 커밋 메시지를 작성한 후 커밋해줘"  
Claude 실행: git diff 분석 → 커밋 메시지 생성 (예: "feat: Add user authentication middleware with JWT validation") → git add . && git commit -m "..."

**Draft PR 자동 생성**  
\> "현재 브랜치의 변경 사항으로 draft PR을 만들어줘. 제목은 변경 내용을 요약하고, 본문에는 주요 변경 사항을 리스트로 작성해줘."  
Claude 실행: gh pr create --draft --title "..." --body "..."

**PR 템플릿 활용:**  
.github/pull_request_template.md 파일을 만들어두면, Claude가 이를 참고하여 PR 본문을 작성합니다.  
예: ## 변경 사항, ## 테스트 방법, ## 체크리스트 (테스트 추가됨, 문서 업데이트됨, Breaking change 없음)

## 5.2. Git worktrees로 병렬 브랜치 작업 (ykdojo Tip #28)

여러 브랜치에서 동시에 작업해야 할 때, git worktree 를 사용하면 브랜치를 전환하지 않고 병렬로 작업할 수 있습니다.

**Git Worktree란?**  
하나의 저장소에서 여러 작업 디렉토리를 만들어, 각각 다른 브랜치를 체크아웃할 수 있는 기능입니다.

**사용 방법:**  
- 메인 프로젝트: ~/projects/myapp (main 브랜치)  
- Worktree 1: ~/projects/myapp-feature-auth (feature/auth 브랜치)  
- Worktree 2: ~/projects/myapp-hotfix (hotfix/critical-bug 브랜치)  
\> "git worktree를 사용하여 feature/auth 브랜치를 ../myapp-feature-auth에 체크아웃해줘"  
Claude 실행: git worktree add ../myapp-feature-auth feature/auth  

**워크플로우:**  
- 터미널 탭 1: ~/projects/myapp-feature-auth 에서 새 기능 개발  
- 터미널 탭 2: ~/projects/myapp-hotfix 에서 긴급 버그 수정  
- 터미널 탭 3: ~/projects/myapp 에서 메인 브랜치 유지  

**ykdojo의 조언:**  
"Worktree는 컨텍스트 스위칭 비용을 제거합니다. 브랜치를 전환할 때마다 node_modules를 다시 설치하거나, 빌드를 다시 실행할 필요가 없습니다."

## 5.3. 대화형 PR 리뷰 (ykdojo Tip #29)

Claude Code는 단순한 코드 생성기를 넘어, 훌륭한 코드 리뷰어입니다.

**PR 리뷰 워크플로우:**  
1. "gh pr checkout 123을 실행하고 이 PR의 변경 사항을 요약해줘"  
2. "이 PR이 어떤 문제를 해결하는지, 주요 변경 파일은 무엇인지 설명해줘"  
3. "src/auth/middleware.ts 파일의 변경점을 분석해줘. 보안 이슈나 성능 문제가 있는지 확인해줘"  
4. "이 변경에 대한 테스트가 충분한지 평가해줘"  
5. "이 로직을 더 효율적으로 바꿀 방법이 있을까?"  
6. "네가 제안한 개선 사항을 적용하고 테스트를 실행해줘"  

**ykdojo의 실제 사례:**  
한 PR에서 복잡한 인증 로직을 리뷰하던 중, Claude가 다음을 발견했습니다: 토큰 만료 시간 검증 로직의 타임존 버그, 불필요한 데이터베이스 쿼리 (N+1 문제), 에러 핸들링 누락. Claude는 이를 모두 수정하고, 테스트 코드까지 추가했습니다.

## 5.4. 승인된 명령어 감사 (ykdojo Tip #30)

Claude Code는 반복적인 명령어를 자동 승인하도록 설정할 수 있지만, 이는 위험할 수 있습니다. 실제로 한 사용자는 rm -rf tests/ patches/ plan/ ~/ 를 승인하여 홈 디렉토리를 삭제한 사례가 있습니다.

**cc-safe: 위험한 명령어 감사 도구**  
ykdojo가 만든 cc-safe 는 .claude/settings.json 파일을 스캔하여 위험한 승인 명령어를 감지합니다.

**설치 및 사용:**  
- npm install -g cc-safe  
- npx cc-safe . (현재 디렉토리 스캔)  
- npx cc-safe ~/projects (전체 프로젝트 폴더 스캔)  

**감지하는 위험 패턴:**  
sudo, rm -rf, chmod 777 / curl | sh, wget | bash / git reset --hard, git push --force / npm publish, docker run --privileged  

**출력 예시:**  
⚠ Found 3 risky approved commands: (예: Bash(rm -rf dist/), Bash(sudo npm install -g), Bash(curl https://install.sh | sh))  

**ykdojo의 조언:**  
"한 달에 한 번은 cc-safe 를 실행하여 승인된 명령어를 감사하세요. 특히 --dangerously-skip-permissions 모드를 자주 사용한다면 필수입니다."

---


---
↑ [목차로 돌아가기](../../README.md#toc)
