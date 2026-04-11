# Best practices for skill creation

Derived from:
- https://agentskills.io/skill-creation/best-practices
- https://agentskills.io/specification

## 1. Start from real expertise

Do not build a skill from generic background knowledge alone.

High-value source material includes:

- successful task traces
- user corrections to prior agent attempts
- internal docs and runbooks
- API specs, schemas, and config files
- code review comments
- bug fixes and incident writeups
- examples of real inputs and outputs

Useful extraction questions:

- What exact steps led to success?
- What did the agent get wrong before correction?
- What tools or APIs should be preferred by default?
- What edge cases or constraints are easy to miss?
- What does good output look like?

## 2. Refine with execution, not just drafting

The first draft is usually too generic, too long, or too broad.

After drafting:

- run the skill on real tasks
- inspect execution traces, not only final answers
- note false positives, missed triggers, and wasted steps
- convert recurring corrections into explicit guidance
- remove instructions that do not improve outcomes

A practical refinement loop:

1. draft
2. test on real tasks
3. record mistakes and friction
4. revise
5. repeat

## 3. Spend context on what the agent would otherwise miss

`SKILL.md` competes for attention with everything else in context.

Include:

- project-specific conventions
- domain-specific procedures
- preferred tools and commands
- non-obvious edge cases
- output templates when structure matters
- gotchas that contradict common assumptions

Avoid:

- generic background explanations
- textbook definitions
- exhaustive documentation that belongs in references
- long lists of equivalent options without a default

A good filter:

> Would the agent likely get this wrong without the instruction?

If no, cut it.

## 4. Keep the skill a coherent unit of work

Good skill scopes look like one reusable capability, not a whole department.

Good signs:

- the skill solves a recognizable class of requests
- the workflow has a clear start and finish
- the same defaults and gotchas apply across requests

Warning signs:

- the skill mixes unrelated workflows
- the skill duplicates another skill's scope
- the skill is so narrow that several skills must always load together

## 5. Use progressive disclosure

Keep `SKILL.md` focused on core instructions the agent should read every time.

Move detail into support files:

- `references/` for optional docs
- `assets/` for templates, examples, and schemas
- `scripts/` for reusable automation

Only point to a reference file when you can say when it should be read.

Better:

- Read `references/api-errors.md` if the API returns a non-200 response.

Worse:

- See `references/` for more details.

## 6. Calibrate control

Not every instruction needs the same level of rigidity.

Be flexible when:

- multiple approaches are acceptable
- the task tolerates variation
- the agent benefits from understanding the goal more than exact steps

Be prescriptive when:

- the sequence is fragile
- consistency matters
- one exact command or workflow must be followed
- the cost of deviation is high

## 7. Give defaults, not menus

When several approaches are possible:

- choose one default
- mention alternatives briefly
- say when the alternative applies

This reduces tool thrashing and indecision.

## 8. Favor reusable procedures over one-off answers

A good skill teaches the agent how to approach a class of tasks.

Prefer:

- read schema
- choose relevant tables
- join by the project convention
- apply user filters
- format output as a markdown table

Over:

- a single hard-coded query that only solves one example

## 9. Put gotchas where the agent will see them

Gotchas are often the most valuable part of a skill.

Use a `Gotchas` section for facts like:

- naming mismatches across systems
- misleading endpoints
- soft-delete rules
- environment-specific constraints
- commands that look safe but are not

If a mistake keeps recurring, add it to the gotchas.

## 10. Use templates when output shape matters

If the response must match a structure, provide a template.

Keep short templates inline in `SKILL.md`.
Move larger or optional templates into `assets/`.

## 11. Keep the main file modest in size

The specification recommends keeping `SKILL.md` under roughly:

- 500 lines
- 5,000 tokens

If you are above that, move detail into support files.

## 12. Final preflight checklist

Before shipping a skill, confirm:

- the scope is coherent
- the skill is grounded in real expertise
- the description is specific
- the body is concise and procedural
- defaults are clear
- gotchas are explicit
- support files are referenced intentionally
- file paths are relative to the skill root
- no important guidance is hidden in a file the agent would never think to read
