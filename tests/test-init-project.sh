#!/usr/bin/env bash
set -euo pipefail

managed_files=(
  AGENTS.md
  PRD.md
  APP_FLOW.md
  TECH_STACK.md
  FRONTEND_GUIDELINES.md
  BACKEND_STRUCTURE.md
  IMPLEMENTATION_PLAN.md
  progress.txt
  lessons.md
)

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repository=$(cd "$script_directory/.." && pwd)
initializer="$repository/.agents/skills/vibe-coding-workflow/scripts/init-project.sh"
temp_parent=${TMPDIR:-/tmp}
test_root=$(mktemp -d "$temp_parent/vibe-workflow-test.XXXXXX")

cleanup() {
  case "$test_root" in
    "$temp_parent"/vibe-workflow-test.*) rm -rf "$test_root" ;;
    *) printf 'Refusing to remove unexpected test path: %s\n' "$test_root" >&2 ;;
  esac
}
trap cleanup EXIT

bash "$initializer" "$test_root"

for file_name in "${managed_files[@]}"; do
  [[ -f "$test_root/$file_name" ]] || {
    printf 'Missing initialized file: %s\n' "$file_name" >&2
    exit 1
  }
done

actual_count=$(find "$test_root" -maxdepth 1 -type f | wc -l | tr -d ' ')
[[ "$actual_count" == "9" ]] || {
  printf 'Expected 9 files, found %s\n' "$actual_count" >&2
  exit 1
}

printf '\nPRESERVE_EXISTING_CONTENT\n' >> "$test_root/PRD.md"
before_hash=$(shasum -a 256 "$test_root/PRD.md" | awk '{print $1}')
second_run=$(bash "$initializer" "$test_root")
after_hash=$(shasum -a 256 "$test_root/PRD.md" | awk '{print $1}')

[[ "$before_hash" == "$after_hash" ]] || {
  printf 'Initializer overwrote an existing managed file.\n' >&2
  exit 1
}
[[ "$second_run" == *"Skipped existing (9)"* ]] || {
  printf 'Second run did not report all managed files as skipped.\n' >&2
  exit 1
}

printf 'Shell initializer test passed.\n'
