---
name: obsidian-vault
description: Use this skill when the user wants to search, create, move, reorganize, or maintain notes in the Obsidian vault, especially when deciding where notes belong, creating MOCs/index notes, or filing issues and action items. It uses a light PARA structure for placement and MOCs for navigation. Do not use it for generic filesystem cleanup outside the vault.
---

# Obsidian Vault

## Vault location

`/home/juhani/Notes/`

## Default organization for this vault

Use a **hybrid PARA + MOC** approach.

- **PARA** answers: where should this note live?
- **MOCs / home notes** answer: how should this topic be navigated and thought about?

This is the default because pure index-only organization is too loose for actionable items, while pure PARA is too rigid for idea-heavy note networks.

## Preferred top-level layout

Use this target structure for new organization work:

- `00 Inbox/` — uncategorized capture and triage
- `01 Projects/` — time-bounded efforts with a clear outcome
- `02 Areas/` — ongoing responsibilities
- `03 Resources/` — reference material
- `04 Archive/` — inactive material
- `Daily/` — daily notes

Keep folder depth shallow. Prefer at most:

- top-level PARA folder
- optional project / area / resource folder
- note or one lightweight subfolder such as `Open Loops/`

Do not create deep taxonomies unless the user explicitly asks.

## Current vault-specific defaults

The current vault already has useful structure. Do **gradual migration**, not a big-bang reorg.

- `Product Copilot/` is an active workspace. Keep using it until the user explicitly migrates it into `01 Projects/`.
- `03 Resources/` is the resource library.
- `Work/` usually behaves like an Area. Split time-bounded efforts inside it into Projects only when touched.
- Loose top-level notes should be triaged gradually as they are reviewed.

When an established workspace already exists, prefer filing new related notes there instead of creating a parallel location.

## Naming conventions

- Use **Title Case** for regular note names.
- Daily notes use `YYYY-MM-DD.md`.
- Use hub notes such as `Topic - Home.md` or `Topic - Index.md`.
- **Do not repeat the note title as a `#` heading inside the file body.** In this vault, the filename is the title.
- For actionable notes, use clear prefixes:
  - `Issue - <Short Title>.md`
  - `Action - <Short Title>.md`
  - `Decision - <Short Title>.md`

## Placement rules

When creating or moving a note, decide location in this order:

1. **Existing workspace already exists?** File it there.
   - Example: Product Copilot-related notes stay under `Product Copilot/` for now.
2. **Time-bounded effort with an outcome?** Put it in `01 Projects/<Project>/`.
3. **Ongoing responsibility?** Put it in `02 Areas/<Area>/`.
4. **Reference material?** Put it in `03 Resources/<Topic>/`.
5. **Inactive but worth keeping?** Put it in `04 Archive/`.
6. **Unclear?** Put it in `00 Inbox/`.

### Rules for actionable items

- Actionable items belong with the owning **project** or **area** whenever known.
- Do **not** file issues or tasks under `03 Resources/`.
- If the owning project or area is unclear, capture in `00 Inbox/` and leave breadcrumbs with links.
- Within a project or area, prefer an `Open Loops/` subfolder once there are multiple active items.

## MOCs / home notes

For any active project or area with more than a few notes, maintain a curated hub note.

A good home note usually contains:

- purpose
- current focus
- important note groups
- open loops section linking relevant `Issue - ...` and `Action - ...` notes
- a few high-value related notes, not an exhaustive dump

MOCs are curated maps, not automatic link spam.

## Reorganization workflow

When the user wants to clean up or reorganize the vault, default to this sequence:

1. Inventory the relevant folder or topic.
2. Propose a **small batch** of moves or a target structure.
3. Create or refresh the relevant home / index note.
4. Move only the notes in scope.
5. Update links or add backlinks where useful.
6. Leave untouched areas alone.

Prefer incremental cleanup over whole-vault redesigns.

## Search workflows

Use `bash` for discovery and `read` to inspect note contents.

### Search by filename

```bash
find "/home/juhani/Notes/" -type f -name "*.md" | grep -i "keyword"
```

### Search by content

```bash
rg -n --glob "*.md" "keyword" "/home/juhani/Notes/"
```

### Find backlinks to a note

```bash
rg -l "\\[\\[Note Title\\]\\]" "/home/juhani/Notes/"
```

### Find home / index notes

```bash
find "/home/juhani/Notes/" -type f \( -name "* - Home.md" -o -name "* - Index.md" \)
```

## Default actionable-note template

Use this when no workspace-specific template exists:

```md
---
item_type: issue | action | decision
status: open
created: YYYY-MM-DD
project:
area:
tags:
  - open-loop
---

## Summary

## Current context

## Desired outcome

## Next step

## Links
- Related:
```

## Gotchas

- Do not force an immediate full PARA migration.
- Do not invent deep folder trees to compensate for weak note titles.
- Prefer filing into an existing workspace over creating duplicate homes.
- Use MOCs for navigation, not as substitutes for every real note.
- When in doubt, capture to `00 Inbox/` and let later triage place it.
