---
name: {{skill-name}}
description: Use this skill when the user wants to {{primary intent}}, {{secondary intent}}, or {{tertiary intent}}. It helps with {{key capabilities}}. Use it especially when {{non-obvious trigger situations}}.
# compatibility: Requires {{runtime / tools}}   # optional
# license: {{license}}                           # optional
# metadata:                                      # optional
#   author: {{author}}
#   version: "0.1.0"
---

# {{Skill Title}}

Briefly state what the skill is for in one or two sentences.

## When to use

Use this skill when:

- {{trigger situation 1}}
- {{trigger situation 2}}
- {{trigger situation 3}}

Do not use it for:

- {{out-of-scope case 1}}
- {{out-of-scope case 2}}

## Workflow

1. {{first step}}
2. {{second step}}
3. {{third step}}

## Defaults

- Preferred tool / library: {{default tool}}
- Use {{alternative}} only when {{condition}}

## Gotchas

- {{non-obvious constraint}}
- {{naming mismatch / environment quirk}}
- {{failure mode or unsafe default}}

## Output format

If output structure matters, put a short template here. Move larger templates into `assets/`.

```markdown
# {{output title}}

## Summary
{{summary shape}}

## Details
- {{detail line}}
```

## References to load on demand

- Read `references/{{reference-file}}.md` when {{trigger to read it}}.
- Read `assets/{{template-or-schema-file}}` when {{trigger to load it}}.

## Scripts

If scripts are needed, list them explicitly and show the command:

```bash
python3 scripts/{{script-name}}.py --{{flag}} {{value}}
```

## Notes for the skill author

Remove any section that does not add value.
Keep the main file concise.
Move longer docs into `references/`.
Use relative paths from the skill root.
