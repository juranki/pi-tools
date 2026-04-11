---
name: skill-creation
description: Use this skill when creating, refining, reviewing, or scaffolding an Agent Skills-standard skill. It helps turn concrete domain expertise into a compliant skill by defining scope, writing a triggerable description, structuring SKILL.md, deciding when to use references/assets/scripts, and preparing templates or eval cases.
compatibility: Works in Agent Skills-compatible clients. The scaffold script requires Python 3.
---

# Skill Creation

Use this skill to create or improve a reusable Agent Skills-standard skill.

The goal is not to generate generic advice. The goal is to convert concrete expertise, project conventions, working procedures, edge cases, and output formats into a skill the agent can load reliably.

## Core rules

1. Start from real expertise.
   - Prefer real task traces, corrections, runbooks, examples, schemas, existing scripts, review comments, and project docs.
   - If the user has not provided enough domain-specific material, ask targeted questions before drafting the skill.
2. Scope the skill as one coherent unit of work.
   - Avoid making the skill too broad.
   - Avoid making it so narrow that several skills must load together for one routine task.
3. Optimize for progressive disclosure.
   - Keep `SKILL.md` focused on the instructions the agent should always load.
   - Move longer reference material to `references/`.
   - Put templates and static examples in `assets/`.
   - Add `scripts/` only when a reusable command or script meaningfully improves reliability.
4. Be explicit where the workflow is fragile, but do not over-prescribe everything.
   - Give defaults instead of long menus of options.
   - Capture non-obvious gotchas directly in `SKILL.md`.
5. Write the description for triggering.
   - The description decides when the skill activates.
   - It should describe user intent, when to use the skill, and important boundaries.

## Workflow

### 1) Gather source material

Collect the raw material that makes the skill valuable:

- successful task steps
- corrections and repeated mistakes
- required tools, commands, or APIs
- input and output formats
- project conventions
- edge cases and failure modes
- examples of real user requests

If needed, use [assets/skill-brief-template.md](assets/skill-brief-template.md) to structure the intake.

### 2) Define the skill boundary

Before writing files, state clearly:

- what this skill does
- when it should be used
- what it should not cover
- whether it needs scripts, references, assets, or only a small `SKILL.md`

If the boundary is fuzzy, read [references/best-practices.md](references/best-practices.md).

### 3) Draft the frontmatter

Create spec-compliant frontmatter:

- `name` must match the parent directory
- `name` must be lowercase letters, numbers, and hyphens only
- `description` should be specific and triggerable
- add `compatibility` only when environment requirements matter

If you are writing or revising the description, read [references/description-guidance.md](references/description-guidance.md).

### 4) Draft `SKILL.md`

Write concise instructions that teach a reusable procedure.

Prefer this structure:

- short statement of purpose
- when to use the skill
- step-by-step workflow
- defaults and approved tools
- gotchas / non-obvious constraints
- output template when formatting matters
- pointers to `references/` or `assets/` only when needed

Do not pad the file with generic background the agent already knows.

### 5) Decide whether to add support files

Use:

- `references/` for detailed docs that should load on demand
- `assets/` for templates, examples, schemas, and eval query files
- `scripts/` for reusable commands or automation

If you need scripts or one-off commands, read [references/scripts-guidance.md](references/scripts-guidance.md).

### 6) Scaffold when useful

To create a starter skill directory, run:

```bash
python3 scripts/scaffold_skill.py --name <skill-name> --root .
```

This creates a spec-compliant skeleton with starter files.

You can also adapt [assets/SKILL-template.md](assets/SKILL-template.md) directly.

### 7) Review before finalizing

Check that the draft:

- uses a coherent scope
- contains concrete, project-specific guidance
- keeps `SKILL.md` concise
- uses relative paths from the skill root
- includes gotchas where mistakes are easy to make
- uses templates when output shape matters
- has a strong description
- keeps support files focused

If triggering accuracy matters, create eval queries from [assets/trigger-eval-queries.template.json](assets/trigger-eval-queries.template.json).

## When to load reference files

- Read [references/best-practices.md](references/best-practices.md) when deciding what belongs in the skill, how much detail to include, or how to encode gotchas and templates.
- Read [references/description-guidance.md](references/description-guidance.md) when writing or debugging the `description` field.
- Read [references/scripts-guidance.md](references/scripts-guidance.md) before adding bundled scripts or complex commands.
- Read [assets/skill-brief-template.md](assets/skill-brief-template.md) when the user needs help gathering source material.
- Read [assets/SKILL-template.md](assets/SKILL-template.md) when drafting a new `SKILL.md`.

## Output expectations

When using this skill to create or revise another skill, produce:

1. the skill directory path and name
2. the final `SKILL.md`
3. any support files actually needed
4. a short note explaining why each support file exists
5. a brief validation checklist covering name, description, scope, and support-file usage
