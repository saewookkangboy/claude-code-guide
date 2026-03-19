# Claude Code 완전 가이드: 70가지 파워 팁

> Claude Code CLI와 AI 에이전트 개발을 위한 실전 가이드.  
> ykdojo(Anthropic 해커톤 우승자)와 Ado Kukic(Anthropic DevRel)의 70+ 팁을 한곳에 모았습니다.  
> **기준 버전**: 2026년 3월 (Claude Code v2.1.76+, Claude Opus 4.6)

---

## 이 저장소는 무엇인가요?

- **한 권으로 읽는 가이드**: Claude Code 환경 설정, 생산성 팁, Git 워크플로우, MCP·Hooks·Agents, 컨테이너·브라우저 연동, 실전 사례까지 **70가지 이상 팁**을 정리한 문서입니다.
- **바이브 코딩 키트**: AI에게 요청할 때 바로 쓸 수 있는 **프롬프트 템플릿**과 Cursor용 규칙·스킬이 포함되어 있습니다.
- **두 가지 읽기 방식**을 지원합니다. 아래 파일 구조와 읽는 방법을 참고하세요.

---

## 어떻게 읽나요?

| 읽기 방식 | 대상 | 장점 |
|-----------|------|------|
| **한 파일로 쭉 읽기** | [`Claude_Code_완전_가이드_70가지_팁.md`](Claude_Code_완전_가이드_70가지_팁.md) | 전체 목차·내용 검색이 쉬움 |
| **Part별로 나눠 읽기** | [`docs/`](docs/) 폴더의 Part 0~13, 맺음말, 부록 | 원하는 주제만 골라서 읽기 좋음 |

바이브 코딩·프롬프트 구조를 먼저 보고 싶다면 → [0.2-part-vibe-coding-prompt-guide.md](0.2-part-vibe-coding-prompt-guide.md)  
실제로 복사해 쓸 **프롬프트 문장**만 필요하다면 → [`prompts/`](prompts/) 폴더

---

## 저장소 파일 구조

```
claude-code-guide/
├── README.md                           ← 현재 문서 (저장소 안내)
├── Claude_Code_완전_가이드_70가지_팁.md  ← [한 권 전체 본문] 70+ 팁 통합본
├── 0.2-part-vibe-coding-prompt-guide.md ← [바이브 코딩] Part별 프롬프트 구조·복사용 예시
│
├── docs/                               ← [Part별로 읽기] 각 Part가 폴더로 구분됨
│   ├── README.md                       ← Part 목차 및 링크 모음
│   ├── part-00/  README  프롬프트 엔지니어링·바이브 코딩
│   ├── part-01/  README  에이전틱 개발자의 사고방식
│   ├── part-02/  README  환경 설정과 필수 명령어
│   ├── part-03/  README  생산성 극대화 기술
│   ├── part-04/  README  컨텍스트 관리
│   ├── part-05/  README  Git·GitHub 워크플로우
│   ├── part-06/  README  MCP, Hooks, Agents
│   ├── part-07/  README  시스템 최적화·자동화
│   ├── part-08/  README  컨테이너·샌드박스
│   ├── part-09/  README  브라우저·웹 자동화
│   ├── part-10/  README  실전 활용 사례
│   ├── part-11/  README  고급 패턴·철학
│   ├── part-12/  README  고급 기능·SDK
│   ├── part-13/  README  학습 로드맵·다음 단계
│   ├── closing/  README  맺음말
│   └── appendix/ README  부록: 빠른 참조
│
├── prompts/                            ← [복사용 프롬프트] Part별 실전 템플릿
│   ├── README.md                       ← 프롬프트 파일 목록·용도 안내
│   ├── part1-planning.md
│   ├── part2-implementation.md
│   ├── part3-ui-style.md
│   ├── part4-refactoring.md
│   ├── part5-test-debug.md
│   ├── part6-documentation.md
│   ├── template-blank.md
│   └── one-liner.md
│
├── scripts/                            ← 유틸 스크립트
│   └── show-prompt.sh
│
└── .cursor/                            ← Cursor 전용 (규칙·스킬)
    ├── rules/
    └── skills/
```

---

## Part별 빠른 링크 (docs/)

| Part | 제목 | 링크 |
|------|------|------|
| 0 | 프롬프트 엔지니어링·바이브 코딩 | [docs/part-00/README.md](docs/part-00/README.md) |
| 1 | 에이전틱 개발자의 사고방식 | [docs/part-01/README.md](docs/part-01/README.md) |
| 2 | 환경 설정·필수 명령어 | [docs/part-02/README.md](docs/part-02/README.md) |
| 3 | 생산성 극대화 기술 | [docs/part-03/README.md](docs/part-03/README.md) |
| 4 | 컨텍스트 관리 | [docs/part-04/README.md](docs/part-04/README.md) |
| 5 | Git·GitHub 워크플로우 | [docs/part-05/README.md](docs/part-05/README.md) |
| 6 | MCP, Hooks, Agents | [docs/part-06/README.md](docs/part-06/README.md) |
| 7 | 시스템 최적화·자동화 | [docs/part-07/README.md](docs/part-07/README.md) |
| 8 | 컨테이너·샌드박스 | [docs/part-08/README.md](docs/part-08/README.md) |
| 9 | 브라우저·웹 자동화 | [docs/part-09/README.md](docs/part-09/README.md) |
| 10 | 실전 활용 사례 | [docs/part-10/README.md](docs/part-10/README.md) |
| 11 | 고급 패턴·철학 | [docs/part-11/README.md](docs/part-11/README.md) |
| 12 | 고급 기능·SDK | [docs/part-12/README.md](docs/part-12/README.md) |
| 13 | 학습 로드맵·다음 단계 | [docs/part-13/README.md](docs/part-13/README.md) |
| — | 맺음말 | [docs/closing/README.md](docs/closing/README.md) |
| — | 부록: 빠른 참조 | [docs/appendix/README.md](docs/appendix/README.md) |

---

## 바이브 코딩·프롬프트 활용

- **구조와 예시**: [0.2-part-vibe-coding-prompt-guide.md](0.2-part-vibe-coding-prompt-guide.md) — 역할·상황·제약·출력 형태와 Part별 복사용 프롬프트.
- **바로 쓸 문장**: [`prompts/`](prompts/) — 기획, 구현, UI, 리팩터링, 테스트·디버깅, 문서화용 템플릿과 한 줄 프롬프트.
- **Cursor에서**: `.cursor/rules/`, `.cursor/skills/` 에 바이브 코딩 관련 규칙·스킬이 있으면 해당 프로젝트에서 자동 적용됩니다.

---

## 출처·저작권

- **기반 자료**: ykdojo (Anthropic 해커톤 우승자), Ado Kukic (Anthropic DevRel, "Advent of Claude").
- **공식 문서**: [code.claude.com/docs](https://code.claude.com/docs)  
© 2025–2026 Based on works by ykdojo and Ado Kukic.
