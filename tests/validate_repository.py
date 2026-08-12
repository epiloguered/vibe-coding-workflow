from __future__ import annotations

import re
import sys
from pathlib import Path


MANAGED_FILES = (
    "AGENTS.md",
    "PRD.md",
    "APP_FLOW.md",
    "TECH_STACK.md",
    "FRONTEND_GUIDELINES.md",
    "BACKEND_STRUCTURE.md",
    "IMPLEMENTATION_PLAN.md",
    "progress.txt",
    "lessons.md",
)

REQUIRED_REFERENCES = (
    "interrogation.md",
    "document-rules.md",
    "execution.md",
    "completion.md",
)


def require(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def main() -> int:
    repository = Path(__file__).resolve().parents[1]
    skill = repository / ".agents" / "skills" / "vibe-coding-workflow"
    templates = skill / "assets" / "templates"
    references = skill / "references"
    errors: list[str] = []

    skill_file = skill / "SKILL.md"
    require(skill_file.is_file(), f"Missing {skill_file}", errors)
    if skill_file.is_file():
        skill_text = skill_file.read_text(encoding="utf-8")
        frontmatter = re.match(r"\A---\n(.*?)\n---\n", skill_text, re.DOTALL)
        require(frontmatter is not None, "SKILL.md has invalid frontmatter", errors)
        if frontmatter:
            metadata = frontmatter.group(1)
            require(
                re.search(r"^name:\s*vibe-coding-workflow\s*$", metadata, re.MULTILINE)
                is not None,
                "SKILL.md has the wrong name",
                errors,
            )
            description = re.search(r"^description:\s*(.+)$", metadata, re.MULTILINE)
            require(
                description is not None and len(description.group(1).strip()) >= 80,
                "SKILL.md description is missing or too vague",
                errors,
            )
        require("TODO" not in skill_text, "SKILL.md still contains TODO text", errors)
        for reference_name in REQUIRED_REFERENCES:
            require(
                f"references/{reference_name}" in skill_text,
                f"SKILL.md does not route to {reference_name}",
                errors,
            )

    for reference_name in REQUIRED_REFERENCES:
        reference_path = references / reference_name
        require(reference_path.is_file(), f"Missing reference {reference_path}", errors)
        if reference_path.is_file():
            require(
                len(reference_path.read_text(encoding="utf-8").strip()) > 100,
                f"Reference is unexpectedly empty: {reference_path}",
                errors,
            )

    actual_templates = {
        path.name for path in templates.iterdir() if path.is_file()
    } if templates.is_dir() else set()
    require(
        actual_templates == set(MANAGED_FILES),
        "Template set differs from the fixed nine documents: "
        f"expected={sorted(MANAGED_FILES)}, actual={sorted(actual_templates)}",
        errors,
    )

    for file_name in MANAGED_FILES:
        template_path = templates / file_name
        if not template_path.is_file():
            continue
        template_text = template_path.read_text(encoding="utf-8")
        for marker in (
            "{{STATUS}}",
            "{{ENABLE_REASON}}",
            "{{DISABLE_REASON}}",
            "{{RE_EVALUATE_WHEN}}",
            "{{LAST_UPDATED}}",
        ):
            require(
                marker in template_text,
                f"{file_name} is missing control marker {marker}",
                errors,
            )

    for relative_path in (
        Path("README.md"),
        Path("BOOTSTRAP.md"),
        Path("VERSION"),
        Path(".github/workflows/validate.yml"),
        Path(".agents/skills/vibe-coding-workflow/agents/openai.yaml"),
        Path(".agents/skills/vibe-coding-workflow/scripts/init-project.ps1"),
        Path(".agents/skills/vibe-coding-workflow/scripts/init-project.sh"),
    ):
        require((repository / relative_path).is_file(), f"Missing {relative_path}", errors)

    version = (repository / "VERSION").read_text(encoding="utf-8").strip()
    require(
        re.fullmatch(r"\d+\.\d+\.\d+", version) is not None,
        f"VERSION is not semantic versioning: {version!r}",
        errors,
    )

    if errors:
        print("Repository validation failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print(
        "Repository validation passed: "
        f"skill metadata, {len(REQUIRED_REFERENCES)} references, "
        f"and {len(MANAGED_FILES)} templates are valid."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
