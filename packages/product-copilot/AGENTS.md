# Product Copilot agent conventions

Apply these rules when changing code in `packages/product-copilot`.

## Delivery pattern

Use **TDD** by default.

Follow the loop:

1. **Red** — write or update a failing test first
2. **Green** — implement the smallest change that makes the test pass
3. **Refactor** — improve names, structure, and duplication while keeping tests green

Do not skip straight to implementation unless:

- the change is documentation-only, or
- the repo does not yet have a runnable test path for that area and you are explicitly scaffolding it

When tests are not yet available, add the next-best executable validation you can, and leave the codebase closer to real TDD rather than further away.

## Code organization

- Put production code under `src/`
- Put tests under `test/`
- Use the native Node test stack: `node:test` + `node:assert/strict`, executed through `tsx`
- Put stable sample inputs under `fixtures/`
- Keep files small and focused
- Prefer extracting pure helpers into `src/lib/`
- Keep pi tool definitions task-shaped and narrow
- Keep LadybugDB ownership isolated behind a small boundary so it can move into a worker process cleanly

## Naming and style

The linter enforces these conventions. Follow them directly instead of relying on autofixes to tell you later.

- **Files in `src/`**: `kebab-case`
- **Variables / functions / object properties / class members**: `camelCase`
- **Types / interfaces / classes / enums**: `PascalCase`
- **Module-level constants**: `camelCase` or `CONSTANT_CASE`
- Use `node:` imports for Node built-ins
- Use `import type` when importing types only

## TypeScript rules

Write code for the strict compiler configuration, not around it.

- Do not use `any`
- Prefer `unknown` plus narrowing
- Do not add `@ts-ignore` unless the user explicitly asks and you document why
- Avoid non-null assertions unless there is a strong invariant directly visible in the code
- Model optionality precisely
- Handle async code explicitly; do not leave floating promises

## Validation before finishing

Run the package validation commands after meaningful code changes:

```bash
cd packages/product-copilot
npm run validate
```

If a test-only change makes `src/` rules irrelevant, still run the most relevant subset and state what you ran.

For tight feedback during TDD, use:

```bash
cd packages/product-copilot
npm run test:watch
```

## Change discipline

- Prefer the smallest safe change
- Preserve a clean extraction path from this repo into its own package or repo later
- Do not introduce repo-root coupling unless it is intentional and documented
- Update `README.md` when package behavior, scripts, or runtime assumptions change
