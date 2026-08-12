#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--dry-run] TARGET_PATH\n' "$(basename "$0")"
}

dry_run=false
if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=true
  shift
fi

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 2
fi

target_path=$1
script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
skill_directory=$(cd "$script_directory/.." && pwd)
template_directory="$skill_directory/assets/templates"

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

if [[ ! -d "$template_directory" ]]; then
  printf 'Template directory not found: %s\n' "$template_directory" >&2
  exit 1
fi

for file_name in "${managed_files[@]}"; do
  if [[ ! -f "$template_directory/$file_name" ]]; then
    printf 'Required template not found: %s\n' "$template_directory/$file_name" >&2
    exit 1
  fi
done

if [[ "$dry_run" == false ]]; then
  mkdir -p "$target_path"
fi

created=()
skipped=()

for file_name in "${managed_files[@]}"; do
  destination_path="$target_path/$file_name"
  if [[ -e "$destination_path" ]]; then
    skipped+=("$file_name")
    continue
  fi

  if [[ "$dry_run" == false ]]; then
    cp "$template_directory/$file_name" "$destination_path"
  fi
  created+=("$file_name")
done

join_by_comma() {
  local IFS=', '
  printf '%s' "$*"
}

printf 'Target: %s\n' "$target_path"
printf 'Mode: %s\n' "$([[ "$dry_run" == true ]] && printf 'dry-run' || printf 'write')"
printf 'Created (%s): %s\n' "${#created[@]}" "$(join_by_comma "${created[@]}")"
printf 'Skipped existing (%s): %s\n' "${#skipped[@]}" "$(join_by_comma "${skipped[@]}")"
