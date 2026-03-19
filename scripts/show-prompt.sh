#!/usr/bin/env bash
# Part별 프롬프트 템플릿을 터미널에 출력한다.
# 사용법: ./scripts/show-prompt.sh [part number 1-6]
# 예: ./scripts/show-prompt.sh 2  → part2-implementation.md 내용 출력

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROMPTS_DIR="$ROOT/prompts"

usage() {
  echo "Usage: $0 [1|2|3|4|5|6|blank|one]"
  echo "  1 = 기획·설계 (part1-planning.md)"
  echo "  2 = 기능 구현 (part2-implementation.md)"
  echo "  3 = UI·스타일 (part3-ui-style.md)"
  echo "  4 = 리팩터링 (part4-refactoring.md)"
  echo "  5 = 테스트·디버깅 (part5-test-debug.md)"
  echo "  6 = 문서화 (part6-documentation.md)"
  echo "  blank = 공통 빈 칸 템플릿 (template-blank.md)"
  echo "  one = 한 줄 프롬프트 (one-liner.md)"
  exit 1
}

case "${1:-}" in
  1) cat "$PROMPTS_DIR/part1-planning.md" ;;
  2) cat "$PROMPTS_DIR/part2-implementation.md" ;;
  3) cat "$PROMPTS_DIR/part3-ui-style.md" ;;
  4) cat "$PROMPTS_DIR/part4-refactoring.md" ;;
  5) cat "$PROMPTS_DIR/part5-test-debug.md" ;;
  6) cat "$PROMPTS_DIR/part6-documentation.md" ;;
  blank) cat "$PROMPTS_DIR/template-blank.md" ;;
  one) cat "$PROMPTS_DIR/one-liner.md" ;;
  *) usage ;;
esac
