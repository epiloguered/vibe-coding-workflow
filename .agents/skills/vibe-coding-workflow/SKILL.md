---
name: vibe-coding-workflow
description: Create a new software project with a document-first Vibe Coding workflow. Use when the user asks Codex to start, scaffold, plan, or build a new project from an idea; asks to use a GitHub-hosted workflow to create a project; or explicitly invokes $vibe-coding-workflow. Interrogate the requirements before coding, decide whether each of the nine fixed project documents is enabled, scaffold every document, obtain confirmation, and then implement through a verified, progress-tracked plan. Do not use for a small isolated edit or bug fix in an established project unless the user explicitly requests the full workflow.
---

# Vibe Coding Workflow

Create a new project only after turning the user's idea into an explicit, reviewable contract. Keep the fixed document set, mark every document `ENABLED` or `DISABLED`, and never invent content for a disabled document.

## Required references

Read all four references before creating a project:

1. [interrogation.md](references/interrogation.md) — questioning method and readiness gate.
2. [document-rules.md](references/document-rules.md) — fixed documents and activation constraints.
3. [execution.md](references/execution.md) — generation order, implementation loop, and state updates.
4. [completion.md](references/completion.md) — verification and completion criteria.

## Workflow

1. Inspect any context the user already supplied. Do not ask for facts available from files, code, screenshots, or the environment.
2. Follow `references/interrogation.md`. Ask one highest-value question at a time until the readiness gate is satisfied.
3. Apply `references/document-rules.md` and present a nine-row activation table with status and reason.
4. Wait for the user to confirm the activation table and material assumptions. Do not write application code before confirmation.
5. Determine the target project directory. Refuse to overwrite an existing managed document unless the user explicitly requests an update and the existing content has been inspected.
6. Scaffold the fixed document set from `assets/templates/`:
   - On Windows, run `scripts/init-project.ps1`.
   - On macOS or Linux, run `scripts/init-project.sh`.
   - If script execution is unavailable, reproduce the same files with the available file-editing tool.
7. Replace every template marker. For disabled documents, retain only document control, the disable reason, the re-evaluation trigger, and a short statement that no specification is active.
8. Record the workflow repository URL, release version, and commit in the generated `AGENTS.md` when known. Never fabricate missing provenance.
9. Generate enabled documents in this exact order:
   `PRD.md` → `APP_FLOW.md` → `TECH_STACK.md` → `FRONTEND_GUIDELINES.md` → `BACKEND_STRUCTURE.md` → `IMPLEMENTATION_PLAN.md` → `AGENTS.md` → `progress.txt` → `lessons.md`.
10. Present the completed documents and implementation plan for confirmation.
11. Implement only after confirmation, following `references/execution.md`.
12. Declare completion only after satisfying `references/completion.md`.

## Non-negotiable rules

- Keep all nine managed filenames even when some are disabled.
- Treat document status as project state, not as a suggestion.
- Use exact, testable acceptance criteria.
- Keep dependency versions authoritative in manifests and lockfiles; do not duplicate them as competing truth.
- Keep database schemas authoritative in schema or migration files and API contracts authoritative in executable specifications or types.
- Update `progress.txt` at verified checkpoints and before handing work off.
- Add a lesson only for a confirmed, reusable failure pattern. Prefer a regression test, type rule, linter, or automation when it can prevent recurrence.
- Preserve user files and unrelated work. Never initialize a Git repository, install dependencies, publish, deploy, or create external resources without authorization from the user's request.

## Remote GitHub invocation

When this workflow is reached through a GitHub URL rather than an installed skill:

1. Treat the repository's `BOOTSTRAP.md` as the remote entry point.
2. Use the checked-out skill directory as the source of references, templates, and scripts.
3. Use temporary loading by default. Install into the user's skill directory only when the user asks to install it.
4. Do not copy the workflow repository's `.git` directory into the generated project.
