# Description guidance

Derived from:
- https://agentskills.io/skill-creation/optimizing-descriptions
- https://agentskills.io/specification

## Why the description matters

At startup, agents usually see only the skill catalog: `name` + `description`.

That means the description carries the main triggering burden. If it is too vague, the skill will not activate when it should. If it is too broad, it will activate when it should not.

Also note: some simple requests may not trigger a skill even if the description matches, because the agent can already complete the task without loading the skill. Description quality matters most when the task needs specialized knowledge, structure, or workflow.

## Writing rules

### 1. Use imperative phrasing

Prefer:

- `Use this skill when ...`

Avoid:

- `This skill does ...`
- `Helps with ...`

The description should tell the agent when to act.

### 2. Describe user intent, not implementation details

Focus on what the user is trying to accomplish.

Good:

- `Use this skill when the user wants to create, review, or improve an Agent Skills-standard skill, including writing SKILL.md, descriptions, references, or scripts.`

Weaker:

- `Uses templates and markdown to generate skill files.`

### 3. Be explicit about non-obvious matches

List situations where the skill applies even if the user does not use the exact domain terms.

Example pattern:

- `Use this skill when the user wants X, Y, or Z, including cases where they describe the workflow without naming the standard explicitly.`

### 4. Stay concise

A few sentences is usually enough.

Target qualities:

- specific
- concrete
- easy to scan
- under the 1024-character spec limit

## A practical formula

Use this shape as a starting point:

```yaml
description: Use this skill when the user wants to [primary intent], [secondary intent], or [tertiary intent]. It helps with [important capabilities]. Use it especially when [non-obvious trigger situations]. Do not use it for [nearby but out-of-scope work].
```

You do not need every sentence, but this structure is a good drafting aid.

## Examples

### Strong

```yaml
description: Use this skill when the user wants to create, revise, review, or scaffold an Agent Skills-standard skill. It helps define scope, write a strong SKILL.md, improve the description for triggering, and decide when to add references, assets, or scripts.
```

### Weak

```yaml
description: Helps with skill creation.
```

## Trigger eval guidance

If triggering accuracy matters, test it.

### Build a query set

Aim for about 16-20 realistic prompts:

- 8-10 should trigger
- 8-10 should not trigger

Make the negatives near-misses, not obviously unrelated prompts.

### Vary the prompts

Include variation in:

- phrasing
- directness
- length
- complexity
- typos / abbreviations
- file paths and concrete details
- personal context

### Re-run prompts multiple times

Model behavior is nondeterministic. Run the same prompt several times and look at trigger rate, not a single pass.

### Use train / validation splits

To avoid overfitting, split the eval set:

- train set: use for revisions
- validation set: use only to check generalization

Do not keep tuning the description against the same full prompt list forever.

## Common failure modes

### Too vague

Symptoms:

- skill rarely activates
- description uses generic verbs like `helps`, `supports`, `handles`

Fix:

- add concrete user intents
- mention when to use the skill
- include domain keywords and adjacent phrasings

### Too broad

Symptoms:

- skill activates for near-miss tasks
- description claims too much adjacent territory

Fix:

- clarify boundaries
- mention out-of-scope cases
- focus on the actual reusable workflow

### Too implementation-focused

Symptoms:

- description mentions file types, internal tools, or storage layout
- it fails to match how users actually ask for help

Fix:

- rewrite around user goals and requests

## Final checklist

Before finalizing a description, confirm:

- it starts with or strongly implies `Use this skill when ...`
- it describes user intent
- it includes the key capabilities
- it names important trigger situations
- it avoids generic filler
- it stays within 1024 characters
- it is specific enough to beat nearby false positives
