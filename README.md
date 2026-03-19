# Claude Guide — 바이브 코딩 프롬프트 키트

**Part별 바이브 코딩** 가이드를 Git 저장소로 정리하고, Cursor/Claude Code에서 바로 쓸 수 있도록 규칙·템플릿·스킬 형태로 구성한 키트입니다. 프로덕션 개발에서 복사해 쓰거나 팀과 공유할 수 있습니다.

## 구조

```
.
├── .cursor/
│   ├── rules/
│   │   └── vibe-coding-prompt-structure.mdc   # 항상 적용: 역할/상황/제약/출력 해석
│   └── skills/
│       └── vibe-coding/
│           └── SKILL.md                       # 바이브 코딩 스킬 (언제/어떻게 적용할지)
├── docs/
│   └── 0.2-part-vibe-coding-prompt-guide.md   # 요약 가이드 (상세는 루트 md 참고)
├── prompts/                                    # 복사용 프롬프트 (Part별)
│   ├── part1-planning.md
│   ├── part2-implementation.md
│   ├── part3-ui-style.md
│   ├── part4-refactoring.md
│   ├── part5-test-debug.md
│   ├── part6-documentation.md
│   ├── template-blank.md                      # 공통 빈 칸 템플릿
│   └── one-liner.md                           # 한 줄 프롬프트 (복사용)
├── scripts/
│   └── show-prompt.sh                         # Part 번호로 템플릿 내용 출력
├── 0.2-part-vibe-coding-prompt-guide.md       # 전체 가이드 (원본)
└── README.md
```

## 빠르게 쓰기

1. **Cursor에서**  
   - 이 저장소를 연 채로 채팅 시 `[기능 구현] …`, `[기획·설계] …` 처럼 Part와 함께 역할/상황/제약/출력을 적으면, 규칙과 스킬이 자동으로 적용됩니다.
2. **템플릿 복사**  
   - `prompts/part2-implementation.md` 등에서 블록을 복사해 `[ ]`와 항목만 수정해 사용합니다.
3. **터미널에서 템플릿 보기**  
   - `./scripts/show-prompt.sh 2` → 기능 구현용 프롬프트 출력  
   - `./scripts/show-prompt.sh blank` → 공통 빈 칸 템플릿 출력  

## 프로덕션에서 쓰는 방법

- **이 리포를 서브모듈/복사**  
  프로젝트 루트에 `.cursor/rules`, `.cursor/skills`, `prompts/`, `scripts/show-prompt.sh` 만 가져와도 됩니다. Cursor가 해당 프로젝트에서 규칙·스킬을 읽습니다.
- **팀 공유**  
  같은 리포를 클론한 뒤 Cursor로 열면, 모두 동일한 바이브 코딩 구조를 사용할 수 있습니다.
- **한 줄 프롬프트**  
  `prompts/one-liner.md` 또는 `./scripts/show-prompt.sh one` 으로 짧게 쓸 때 활용할 수 있습니다.

## 라이선스

문서와 스크립트는 프로젝트 정책에 따릅니다.
