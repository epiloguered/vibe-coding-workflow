# Repository Instructions

## Purpose

Maintain a portable Codex Skill that creates new projects through requirement interrogation, a fixed nine-document contract, verified implementation planning, progress handoff, and reusable lessons.

## Required Invariants

- Keep the skill name and directory exactly `vibe-coding-workflow`.
- Keep all nine template filenames listed in `README.md`.
- Keep templates, Windows initialization, and macOS initialization behavior equivalent.
- Never make an initializer overwrite an existing managed file by default.
- Keep detailed workflow rules in the skill references instead of duplicating them throughout the repository.
- Do not commit credentials, tokens, machine-specific paths, or generated test output.

## Verification

After changing skill instructions, templates, or initialization scripts, run:

```text
python tests/validate_repository.py
pwsh -File tests/test-init-project.ps1        # Windows
bash tests/test-init-project.sh               # macOS/Linux
```

Also run the official Skill Creator `quick_validate.py` against `.agents/skills/vibe-coding-workflow` when it is available.

## Release Discipline

- Update `VERSION` for a deliberate release.
- Keep the generated project provenance fields compatible with prior versions.
- Treat changes to activation rules, filenames, or generation order as workflow-contract changes.
