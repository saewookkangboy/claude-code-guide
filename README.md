# Claude Guide — 바이브 코딩 프롬프트 키트

AI(Claude, Cursor 등)에게 일을 요청할 때 **어떤 말을 어떻게 쓰면 좋을지** 정리한 가이드와 템플릿 모음입니다.  
코드를 직접 잘 다루지 않으셔도, **복사해서 고쳐 쓰기**만 하시면 되어서 부담 없이 활용하실 수 있습니다.

---

## 이 저장소로 하실 수 있는 일

- **프롬프트 템플릿 쓰기**  
  기획, 기능 구현, UI·디자인, 리팩터링, 테스트, 문서화 등 **단계(Part)별로** 미리 만들어 둔 문장을 복사해, 괄호 부분만 수정해서 AI 채팅창에 붙여 넣으시면 됩니다.

- **Cursor에서 자동 적용**  
  이 저장소를 Cursor로 열어 두고 채팅하시면, **역할 / 상황 / 제약 / 출력** 구조를 AI가 알아서 해석하도록 설정되어 있습니다. 별도 설정 없이 같은 방식으로 요청하실 수 있습니다.

- **팀과 방식 통일**  
  팀원들이 같은 템플릿을 쓰면, “어떤 식으로 AI에게 요청해야 하지?” 하는 고민을 줄일 수 있고, 나온 결과도 비슷한 형태로 맞추기 쉽습니다.

---

## 사용 방법

### 1. Cursor에서 이 저장소를 연 뒤 채팅하기

저장소 폴더를 Cursor에서 연 상태로, 채팅창에 예를 들어 다음과 같이 적어 보세요.

- `[기획·설계] 새 기능 스코프 정리해줘.`  
- `[기능 구현] 로그인 폼 만들어줘.`  
- `[UI·스타일] 이 화면 미니멀하게 바꿔줘.`

앞에 **Part 이름**을 붙이면, 저장소에 들어 있는 규칙과 스킬이 자동으로 적용됩니다.

### 2. 템플릿을 복사해서 쓰기

**`prompts`** 폴더 안에 Part별 예시 문장이 들어 있습니다.  
원하시는 Part 파일을 열어서 **코드 블록(회색 상자) 안 내용 전체**를 복사한 뒤, `[ ]` 안이나 하이픈(`-`) 아래 항목만 프로젝트에 맞게 바꿔서 채팅창에 붙여 넣으시면 됩니다.

- 기획·설계 → `prompts/part1-planning.md`
- 기능 구현 → `prompts/part2-implementation.md`
- UI·스타일 → `prompts/part3-ui-style.md`
- 리팩터링 → `prompts/part4-refactoring.md`
- 테스트·디버깅 → `prompts/part5-test-debug.md`
- 문서화 → `prompts/part6-documentation.md`
- 빈 칸 채워 쓰기 → `prompts/template-blank.md`
- 한 줄로 짧게 쓸 때 → `prompts/one-liner.md`

### 3. 터미널에서 템플릿 내용 보기

터미널을 쓰시는 분은 아래처럼 실행하시면 해당 Part의 템플릿 내용이 출력됩니다. 복사해서 쓰시면 됩니다.

```bash
./scripts/show-prompt.sh 1    # 기획·설계
./scripts/show-prompt.sh 2    # 기능 구현
./scripts/show-prompt.sh 3    # UI·스타일
./scripts/show-prompt.sh 4    # 리팩터링
./scripts/show-prompt.sh 5    # 테스트·디버깅
./scripts/show-prompt.sh 6    # 문서화
./scripts/show-prompt.sh blank # 빈 칸 템플릿
./scripts/show-prompt.sh one  # 한 줄 프롬프트
```

숫자(1~6), `blank`, `one` 만 바꿔서 사용하시면 됩니다.

---

## 저장소 구조

```
claude_guide/
├── .cursor/
│   ├── rules/
│   │   └── vibe-coding-prompt-structure.mdc   # AI가 항상 참고하는 규칙 (역할/상황/제약/출력)
│   └── skills/
│       └── vibe-coding/
│           └── SKILL.md                       # 바이브 코딩 적용 방법 안내
├── docs/
│   └── 0.2-part-vibe-coding-prompt-guide.md   # Part별 가이드 요약
├── prompts/                                    # ← 여기서 복사해서 쓰시면 됩니다
│   ├── part1-planning.md                       # 기획·설계용 예시
│   ├── part2-implementation.md                 # 기능 구현용 예시
│   ├── part3-ui-style.md                       # UI·스타일용 예시
│   ├── part4-refactoring.md                    # 리팩터링용 예시
│   ├── part5-test-debug.md                     # 테스트·디버깅용 예시
│   ├── part6-documentation.md                  # 문서화용 예시
│   ├── template-blank.md                       # 공통 빈 칸 템플릿
│   └── one-liner.md                            # 한 줄 프롬프트 모음
├── scripts/
│   └── show-prompt.sh                          # Part 번호로 템플릿 내용 출력
├── 0.2-part-vibe-coding-prompt-guide.md       # 전체 가이드 (상세 설명)
└── README.md                                   # 이 문서
```

- **쓰실 때마다 보시면 되는 곳:** `prompts/` 폴더, 그리고 필요하면 `0.2-part-vibe-coding-prompt-guide.md`
- **Cursor가 알아서 읽는 곳:** `.cursor/rules/`, `.cursor/skills/` (수정하지 않으셔도 됩니다)
- **템플릿을 터미널로 보고 싶을 때:** `scripts/show-prompt.sh`

---

## 역할별로 이렇게 활용해 보세요

### 개발자 분들

- **일상 작업:** 기능 하나 넣을 때, 리팩터링할 때, 테스트·버그 잡을 때 `prompts/` 에서 해당 Part 파일을 열어 블록을 복사해 쓰시면 됩니다.
- **새 프로젝트에 적용:** 이 저장소를 그대로 복사하거나 서브모듈로 넣어 두시고, `.cursor/` 와 `prompts/`, `scripts/show-prompt.sh` 만 가져가시면 다른 프로젝트에서도 같은 방식으로 사용하실 수 있습니다.
- **한 줄로 빠르게:** `prompts/one-liner.md` 또는 `./scripts/show-prompt.sh one` 으로 짧은 문장을 복사해 조금만 수정해서 쓰시면 됩니다.

### 마케터·기획·비개발자 분들

- **기획 단계:** “이런 기능을 넣고 싶은데, 필요한 화면/API가 뭔지 정리해줘” 같은 요청을 하고 싶으시면 `prompts/part1-planning.md` 의 예시를 복사해, 괄호 안만 바꿔서 AI에게 보내 보세요.
- **문서·설명문:** README나 사용자용 안내 문구를 부탁할 때는 `prompts/part6-documentation.md` 예시를 참고하시면 됩니다.
- **코드는 잘 모르겠을 때:** Part 이름(`[기획·설계]`, `[문서화]` 등)만 붙이고, “이거 해줘”라고만 적어도 AI가 구조에 맞춰 이해하도록 되어 있으니, 부담 갖지 않으셔도 됩니다.

### PM(프로덕트 매니저) 분들

- **스코프·우선순위:** “이 기능 범위와 필요한 작업 목록만 짧게 정리해줘”라고 하실 때 `part1-planning.md` 템플릿을 쓰시면, API/화면/플로우 관점으로 정리된 답을 받기 좋습니다.
- **개발팀과 말 맞추기:** 팀에 이 저장소를 공유해 두시면, “역할/상황/제약/출력” 같은 표현으로 요청할 수 있어서, PM이 작성한 요청문을 개발자가 그대로 AI에 넣어서 구현 단계로 이어가기 쉽습니다.
- **문서화·회의록:** 제품 설명이나 정리 문서를 부탁할 때는 `part6-documentation.md` 를 참고하시면 됩니다.

---

## 정리

- **복사해서 쓰는 것만** 기억하시면 됩니다. `prompts/` 폴더에서 고르시고, `[ ]` 와 항목만 수정해서 채팅창에 붙여 넣으세요.
- Cursor를 쓰시면 이 저장소를 연 채로 채팅하는 것만으로도 규칙이 적용되니, **별도 설정은 필요 없습니다.**
- 팀에서 함께 쓰시면 요청 방식이 통일되어, 결과도 더 일관되게 받으실 수 있습니다.

궁금한 점이 있으시면 저장소 안의 `0.2-part-vibe-coding-prompt-guide.md` 에 조금 더 자세한 설명이 있으니 참고해 보시면 좋겠습니다. 도움이 되길 바랍니다.

---

## 라이선스

문서와 스크립트는 프로젝트 정책에 따릅니다.
