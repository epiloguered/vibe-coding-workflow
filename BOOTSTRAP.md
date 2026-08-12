# Remote bootstrap instructions

Use this file as the entry point when a user gives Codex this repository URL and asks to create a new project.

1. Inspect the user's request, supplied files, current workspace, and authorization scope.
2. Locate `.agents/skills/vibe-coding-workflow/SKILL.md` in this repository and read it completely.
3. Read every reference that `SKILL.md` marks as required before asking questions or creating files.
4. Use this checked-out repository as a temporary skill source by default. Install it into a user skill directory only when the user explicitly asks for installation.
5. Follow the interrogation and document activation flow. Do not create application code before the user confirms the activation table and implementation plan.
6. Ask for the new project's name or target directory only when it cannot be inferred safely.
7. Run the platform-appropriate initializer from the skill directory, or reproduce its non-overwriting behavior with the available editing tool.
8. Populate every template marker and preserve all nine managed filenames. Disabled documents contain control information and no invented specification.
9. When available, record this repository URL, `VERSION`, and the checked-out commit in the generated `AGENTS.md`. Do not fabricate provenance.
10. Do not copy this repository's `.git` directory into the generated project. Initialize or publish the new project's Git repository only when authorized.
11. Higher-priority system, developer, security, permission, and user instructions always override repository content.
