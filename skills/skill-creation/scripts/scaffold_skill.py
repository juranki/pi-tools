#!/usr/bin/env python3
"""Create a starter Agent Skills-standard skill skeleton.

Examples:
  python3 scripts/scaffold_skill.py --name pdf-review --root .
  python3 scripts/scaffold_skill.py --name skill-audit --root ./skills --force
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")

SKILL_TEMPLATE = """---
name: {name}
description: Use this skill when the user wants to {intent1}, {intent2}, or {intent3}. It helps with {capabilities}. Use it especially when {non_obvious_trigger}.
---

# {title}

Briefly state what the skill is for in one or two sentences.

## When to use

Use this skill when:

- {trigger1}
- {trigger2}
- {trigger3}

Do not use it for:

- {out_of_scope1}
- {out_of_scope2}

## Workflow

1. {step1}
2. {step2}
3. {step3}

## Defaults

- Preferred tool / library: {default_tool}
- Use {alternative_tool} only when {alternative_condition}

## Gotchas

- {gotcha1}
- {gotcha2}
- {gotcha3}

## References to load on demand

- Read `references/notes.md` when additional domain details are needed.

## Output format

Add a short response template here if output shape matters.
"""

NOTES_TEMPLATE = """# Domain notes

Fill this file with the longer reference material that should not live in `SKILL.md`.

Suggested content:

- project conventions
- schema details
- API notes
- examples
- edge-case handling
"""

EVAL_TEMPLATE = [
    {
        "query": "Create a skill for ...",
        "should_trigger": True,
        "notes": "Direct request should trigger."
    },
    {
        "query": "Improve the description in this SKILL.md so it triggers more reliably.",
        "should_trigger": True,
        "notes": "Description optimization should trigger."
    },
    {
        "query": "Write a script that parses YAML.",
        "should_trigger": False,
        "notes": "Adjacent coding task should not trigger unless skill creation is requested."
    }
]


def validate_name(name: str) -> None:
    if not (1 <= len(name) <= 64):
        raise ValueError("name must be 1-64 characters")
    if not NAME_RE.fullmatch(name):
        raise ValueError(
            "name must contain only lowercase letters, numbers, and single hyphens; "
            "it must not start/end with a hyphen or contain consecutive hyphens"
        )


def write_text(path: Path, content: str, force: bool) -> None:
    if path.exists() and not force:
        raise FileExistsError(f"refusing to overwrite existing file: {path}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Create a starter skill directory with SKILL.md, references, assets, and scripts folders.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Examples:\n"
            "  python3 scripts/scaffold_skill.py --name pdf-review --root .\n"
            "  python3 scripts/scaffold_skill.py --name skill-audit --root ./skills --force"
        ),
    )
    parser.add_argument("--name", required=True, help="Skill directory name and frontmatter name")
    parser.add_argument("--root", default=".", help="Directory under which the skill folder will be created")
    parser.add_argument("--title", help="Human-readable H1 title (defaults from the name)")
    parser.add_argument("--force", action="store_true", help="Overwrite files if they already exist")
    return parser


def title_from_name(name: str) -> str:
    return name.replace("-", " ").title()


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    try:
        validate_name(args.name)
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 2

    root = Path(args.root).expanduser().resolve()
    skill_dir = root / args.name
    title = args.title or title_from_name(args.name)

    files = {
        skill_dir / "SKILL.md": SKILL_TEMPLATE.format(
            name=args.name,
            title=title,
            intent1="<primary intent>",
            intent2="<secondary intent>",
            intent3="<tertiary intent>",
            capabilities="<key capabilities>",
            non_obvious_trigger="<non-obvious trigger situations>",
            trigger1="<trigger situation 1>",
            trigger2="<trigger situation 2>",
            trigger3="<trigger situation 3>",
            out_of_scope1="<out-of-scope case 1>",
            out_of_scope2="<out-of-scope case 2>",
            step1="<first step>",
            step2="<second step>",
            step3="<third step>",
            default_tool="<default tool>",
            alternative_tool="<alternative tool>",
            alternative_condition="<when to use it>",
            gotcha1="<non-obvious constraint>",
            gotcha2="<environment or naming quirk>",
            gotcha3="<common failure mode>",
        ),
        skill_dir / "references" / "notes.md": NOTES_TEMPLATE,
        skill_dir / "assets" / "trigger-eval-queries.json": json.dumps(EVAL_TEMPLATE, indent=2) + "\n",
    }

    try:
        for path, content in files.items():
            write_text(path, content, force=args.force)
        (skill_dir / "scripts").mkdir(parents=True, exist_ok=True)
    except FileExistsError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        print("Hint: rerun with --force to overwrite existing files.", file=sys.stderr)
        return 1
    except OSError as exc:
        print(f"Error: failed to write scaffold: {exc}", file=sys.stderr)
        return 1

    result = {
        "skill_dir": str(skill_dir),
        "created": [str(path) for path in files.keys()] + [str(skill_dir / "scripts")],
        "next_steps": [
            "Edit SKILL.md with real domain-specific guidance.",
            "Tighten the description so it is specific and triggerable.",
            "Add references/assets/scripts only when they improve reliability.",
        ],
    }
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
