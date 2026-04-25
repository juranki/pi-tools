---
name: qa
description: Use this skill when the user wants to report bugs, friction, follow-ups, decisions, or other action items conversationally and have them captured as durable notes in the Obsidian vault. It helps clarify the item, decide whether it is an issue, action, or decision, split it when needed, and file or update notes using the vault's PARA-plus-MOC conventions. Do not use it for root-cause debugging or filing GitHub issues unless the user explicitly asks.
---

# QA / Issue and Action Capture

Run an interactive capture session. The user describes problems, follow-ups, or open loops in their own words. Your job is to turn them into durable Obsidian notes in `/home/juhani/Notes/`.

This skill is **not just for coding bugs**. It also covers:

- product problems
- workflow friction
- research follow-ups
- admin tasks
- personal or work action items
- decisions that need to be made or recorded

## Core behavior

- Keep the conversation lightweight.
- Capture notes that will still make sense later.
- Prefer user-facing or outcome-facing language over implementation details.
- File each item into the Obsidian vault, not GitHub, unless the user explicitly asks for GitHub issues.

## Storage rules

Follow the vault conventions:

1. If a related workspace already exists, file the note there.
   - Example: Product Copilot items stay under `Product Copilot/` until migrated.
2. Otherwise use:
   - `01 Projects/<Project>/` for project-bound items
   - `02 Areas/<Area>/` for ongoing responsibilities
   - `00 Inbox/` if ownership is unclear
3. If a project or area has multiple active items, prefer an `Open Loops/` subfolder.
4. Do not file actionable items under `03 Resources/`.

## For each item the user raises

### 1. Listen and lightly clarify

Ask **at most 2 short clarifying questions** when needed.

Focus on:

- what is wrong or what needs doing
- expected outcome
- whether there is an obvious owner project or area

Do not over-interview. If the item is clear enough to capture, move on.

### 2. Classify the item

Choose the best fit:

- **Issue** — something is wrong, missing, confusing, or blocked
- **Action** — a concrete thing to do
- **Decision** — a choice to make or a choice worth recording

If the user describes a follow-up or waiting state, usually capture it as an **Action** with status `waiting` or `blocked`.

### 3. Check for an existing note first

Before creating a new note, search the vault for likely duplicates in the relevant workspace.

Update an existing note instead of creating a duplicate when:

- it is clearly the same open loop
- the user is adding more context to an already captured item
- the same issue has resurfaced

### 4. Decide whether this is one note or several

Break it up when:

- there are independent problems or tasks
- different items could be handled in parallel
- one note would mix unrelated symptoms and actions

Keep it as one note when:

- it is one behavior problem in one place
- the sub-points only make sense together

Prefer multiple thin notes over one overloaded note.

### 5. Capture the note

Create or update the Obsidian note immediately. Do not ask the user to approve a draft first.

Use a filename that matches the item type:

- `Issue - <Short Title>.md`
- `Action - <Short Title>.md`
- `Decision - <Short Title>.md`

Use this frontmatter by default:

```yaml
---
item_type: issue | action | decision
status: open
created: YYYY-MM-DD
project:
area:
tags:
  - open-loop
---
```

Then use a body shaped like this.

#### Issue note template

```md
# Issue - <Short Title>

## What happened

## What I expected

## Steps to reproduce
1. ...

## Impact

## Next step

## Links
- Related:
```

#### Action note template

```md
# Action - <Short Title>

## Outcome wanted

## Current context

## Next step

## Blockers

## Links
- Related:
```

#### Decision note template

```md
# Decision - <Short Title>

## Decision to make or record

## Context

## Options

## Current leaning / decision

## Follow-up

## Links
- Related:
```

## Writing rules

For all captured notes:

- write so the note still makes sense after refactors or context switches
- describe behavior and outcomes, not internal implementation details
- keep it concise but actionable
- include reproduction steps for issues whenever they matter
- use the user's domain language when known
- link to related notes, projects, or daily notes when useful

## Optional background exploration

If context would improve the note, inspect the relevant project materials in the background:

- repository files
- existing vault notes
- workspace home / index notes
- domain language docs

The goal is not to solve the problem. The goal is to file a better note and avoid duplicates.

## After capturing

Share the note path or paths you created or updated, summarize any breakdown into multiple notes, and ask:

`Next item, or are we done?`

## Gotchas

- Do not default to GitHub issues.
- Do not create duplicates when an open note already exists.
- Do not force every item into a project if it really belongs to an area or inbox.
- Do not turn vague friction into fake precision; capture uncertainty honestly.
- If the user is clearly brainstorming rather than reporting an open loop, this skill may be the wrong fit.
