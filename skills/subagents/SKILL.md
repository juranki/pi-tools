---
name: subagents
description: Spawn isolated pi subagents for parallel or delegated tasks. Use when work can be split into independent subtasks, when you want parallel execution, when a task needs a different model, or when isolation from the current context is valuable.
---

# Subagents

Spawn a subagent with:

```bash
pi -p --no-session [model flags] "task prompt"
```

`-p` (print mode) runs non-interactively and exits. `--no-session` keeps it ephemeral. The subagent inherits the current working directory and picks up `AGENTS.md` context files — add `--no-context-files` to suppress that.

## Model Selection

Three tiers. Match the task — don't default to the strongest for everything.

**Fast** — extraction, classification, summarization, formatting, mechanical transforms:
```
--provider github-copilot --model gpt-5.4-mini
```

**Capable** — complex reasoning, architecture decisions, hard bugs, multi-step analysis:
```
--provider amazon-bedrock --model eu.anthropic.claude-opus-4-7
```
For the hardest problems, add `--thinking medium` or `--thinking high`.

**Balanced** — moderate coding, review, analysis where fast isn't enough but capable is overkill. No single clear winner here; `github-copilot/claude-sonnet-4.6` is a reasonable default, `github-copilot/gpt-5.4` is an alternative:
```
--provider github-copilot --model claude-sonnet-4.6
```

Specify model with `--provider <name> --model <id>`.

## Invocation Patterns

### Single subagent

```bash
pi -p --no-session --provider github-copilot --model gpt-5.4-mini "summarize /path/to/file.ts in one sentence"
```

Output goes to stdout; the bash tool captures it as the tool result.

### Parallel subagents

Use temp files — `$(cmd &)` doesn't capture background output:

```bash
pi -p --no-session --provider github-copilot --model gpt-5.4-mini "task 1" > /tmp/sub1.txt &
pi -p --no-session --provider github-copilot --model gpt-5.4-mini "task 2" > /tmp/sub2.txt &
wait
```

Read `/tmp/sub1.txt` and `/tmp/sub2.txt`

## Structuring Subagent Prompts

Subagents are isolated — they don't share the parent's conversation. Pass context explicitly.

A good subagent prompt is **self-contained** — the subagent must be able to complete it without needing to ask anything:

- State the goal explicitly
- Point to all files it needs
- Specify the output format you expect
- Keep scope narrow — one clear deliverable

Bad: `"refactor the codebase"`  
Good: `"read /src/auth/login.ts and extract the token validation logic into a pure function. Output only the new function, no surrounding code."`

## When to Use Subagents

**Good fits:**
- Independent parallel tasks (e.g., analyze 5 files simultaneously)
- Cheaper model for bulk/mechanical work (extraction, classification, summarization)
- Task needs a different thinking level than the current session
- Generating multiple alternatives in parallel (see design-an-interface skill)
- Work that shouldn't pollute the current context window

**Poor fits:**
- Tasks that depend on intermediate results from each other (sequential dependencies)
- Tasks that need back-and-forth clarification
- Anything that needs shared mutable state
