# 부록: 빠른 참조 가이드

## 필수 명령어 치트시트

| 명령어 | 설명 |
|--------|------|
| /init | 프로젝트 CLAUDE.md 자동 생성 |
| /usage | 토큰 사용량 및 한도 확인 |
| /context | 컨텍스트 윈도우 사용 현황 |
| /clear | 대화 내용 지우기 (별칭: /reset, /new) |
| /stats | 사용 통계 및 활동 그래프 |
| /branch [name] | 대화 분기 (별칭: /fork) |
| /effort [low\|medium\|high\|max\|auto] | 모델 노력 수준 (max는 Opus 4.6, 현재 세션만) |
| /compact [instructions] | 대화 압축 (선택적 집중 지시) |
| /cost | 토큰 사용 통계 |
| /copy [N] | 마지막(또는 N번째) 응답 클립보드 복사 |
| /clone | 대화 복제 |
| /half-clone | 대화 반복제 (컨텍스트 절반 줄이기) |
| /export | 대화 내역 마크다운으로 내보내기 |
| /sandbox | 권한 경계 설정 |
| /mcp | MCP 서버 관리 |
| /permissions | 승인된 명령어 관리 |
| /vim | Vim 모드 활성화 |
| /release-notes | 최신 릴리스 노트 확인 |

## 키보드 단축키 치트시트

| 단축키 | 기능 |
|--------|------|
| !command | Bash 명령어 즉시 실행 |
| Esc Esc | 대화/코드 되감기 |
| Ctrl+R | 역방향 검색 (명령어 히스토리) |
| Ctrl+S | 프롬프트 임시 저장 |
| Shift+Tab (×2) | Plan 모드 토글 |
| Alt+P / Option+P | 모델 전환 |
| Ctrl+O | Verbose 모드 토글 |
| Tab / Enter | 프롬프트 제안 수락 |
| Ctrl+B | 백그라운드로 보내기 |
| Ctrl+G | 외부 에디터로 편집 |

## CLI 플래그 치트시트

| 플래그 | 설명 |
|--------|------|
| -p "prompt" | Headless 모드 (비대화형) |
| --continue | 마지막 세션 이어가기 |
| --resume | 세션 목록에서 선택 |
| --resume name | 이름으로 세션 재개 |
| --teleport id | 웹 세션 로컬로 가져오기 |
| --chrome | Chrome 통합 모드 |
| --dangerously-skip-permissions | YOLO 모드 (위험) |

이 책의 모든 내용은 **2026년 3월** 기준으로 보강되었으며, Claude Code는 지속적으로 업데이트됩니다. 최신 정보는 공식 문서(https://code.claude.com/docs)를 참조하세요.

© 2025-2026 Based on works by ykdojo and Ado Kukic.

↑ [목차로 돌아가기](https://github.com/saewookkangboy/claude-code-guide/blob/main/README.md#user-content-toc)
