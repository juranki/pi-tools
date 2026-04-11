# Scripts guidance

Derived from:
- https://agentskills.io/skill-creation/using-scripts
- https://agentskills.io/specification

## Decide whether you need a script

Use a one-off command when:

- an existing tool already solves the task
- the command is short and reliable
- there is little room for argument mistakes

Use a bundled script when:

- the command is complex
- the workflow is reused often
- correctness depends on argument handling or post-processing
- you want one tested interface instead of repeated ad-hoc shell commands

## One-off command rules

- Pin versions when using package runners such as `npx`, `uvx`, or similar tools.
- State prerequisites in `SKILL.md`.
- Use the `compatibility` field only when environment requirements are important enough to deserve frontmatter.
- If the command becomes long, fragile, or hard to remember, move it into `scripts/`.

## Referencing bundled scripts

List scripts in `SKILL.md` so the agent knows they exist.

Use relative paths from the skill root, for example:

```bash
python3 scripts/process.py --input results.json
bash scripts/validate.sh config.yaml
```

Do not rely on absolute paths.

## Script interface rules

### 1. Non-interactive only

Agents run in non-interactive shells.

Do not require:

- prompts
- menus
- confirmations
- password entry
- TTY interaction

Take input through:

- flags
- environment variables
- stdin

### 2. Provide `--help`

`--help` is how an agent learns the interface.

Include:

- what the script does
- required arguments
- optional flags
- valid values
- one or two examples

### 3. Write helpful errors

Bad:

- `Error: invalid input`

Better:

- what was wrong
- what values are allowed
- what to run instead

### 4. Prefer structured stdout

Agents and command-line tools work best with structured output.

Prefer:

- JSON
- CSV
- TSV

Keep diagnostics on stderr.

That separation makes scripts easier to compose and retry.

## Self-contained scripts

If possible, make scripts runnable without a separate install step.

Patterns called out in the docs include:

- Python with inline metadata / dependencies
- Deno with `npm:` or `jsr:` imports
- Bun with version-pinned imports
- Ruby with `bundler/inline`

For Python, `uv run` is a strong default when available.

## Good defaults for skill scripts

Use these habits when you create a script for a skill:

- keep the interface small
- make required flags obvious
- keep stdout parseable
- print progress to stderr
- use stable exit codes
- prefer idempotent behavior when practical
- pin dependency versions where possible

## Minimal checklist

Before adding a script, confirm:

- a script is actually better than a one-off command
- the script is referenced from `SKILL.md`
- the path is relative to the skill root
- the interface is non-interactive
- `--help` is useful
- errors are actionable
- data and diagnostics are separated
- dependencies and prerequisites are documented
