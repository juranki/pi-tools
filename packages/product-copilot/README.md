# Product Copilot

Scaffold for a local-first pi extension package for Product Copilot.

This package is set up as a **real Node package** inside the repository so it can grow into:

- a pi extension with its own dependencies
- a LadybugDB-backed local graph runtime
- a child-process worker if we want native-module isolation later

## Current status

This is a scaffold, not the full implementation.

Included now:

- package-style pi extension entrypoint in `src/index.ts`
- config helper for resolving the default LadybugDB path
- a tiny JSON-lines worker scaffold in `src/worker/ladybug-worker.mjs`
- a minimal `WorkerClient` in `src/lib/worker-client.ts`
- one read-only diagnostic command and one read-only diagnostic tool
- native Node test runner setup via `node:test` + `tsx`
- strict validation and agent conventions for package-local work

Not included yet:

- LadybugDB ownership / connection lifecycle
- graph schema bootstrap
- Product Copilot query tools
- ingestion tools
- worker process management wired into the pi extension runtime

## Folder layout

```text
packages/product-copilot/
├── AGENTS.md
├── biome.json
├── knip.json
├── package.json
├── README.md
├── tsconfig.base.json
├── tsconfig.json
├── tsconfig.test.json
├── fixtures/
├── test/
└── src/
    ├── index.ts
    ├── lib/
    │   ├── config.ts
    │   ├── ladybug.ts
    │   └── worker-client.ts
    ├── tools/
    │   └── README.md
    └── worker/
        └── ladybug-worker.mjs
```

## Install

```bash
cd packages/product-copilot
npm install
```

## Load in pi

For quick testing, load the extension entry file directly:

```bash
pi -e packages/product-copilot/src/index.ts
```

If you later want to load it as a local pi package, add the package path to project settings.

## Validation

Run the full package validation before finishing meaningful code changes:

```bash
cd packages/product-copilot
npm run validate
```

Main scripts:

- `npm run format` — apply Biome formatting and safe fixes
- `npm run lint` — strict Biome checks with warnings treated as failures
- `npm run typecheck:src` — strict TypeScript validation for `src/`
- `npm run typecheck:test` — slightly more lenient TypeScript validation for `test/`
- `npm run test` — run tests with the native Node test runner through `tsx`
- `npm run test:watch` — tight TDD loop for red / green / refactor
- `npm run knip` — detect dead code, unused exports, and unused dependencies
- `npm run validate` — run the full validation pipeline

## Conventions

Agent-facing coding conventions live in `AGENTS.md`.

Highlights:

- use **TDD** by default
- follow **red / green / refactor**
- write tests with `node:test` and `node:assert/strict`
- keep `src/` strict
- allow `test/` to be somewhat more flexible
- use `kebab-case` filenames in `src/`
- use `camelCase` for runtime names and `PascalCase` for type-like names
- use `node:` imports for Node built-ins
- use `import type` for type-only imports

## Default runtime config

Default database path:

```text
.pi/state/product-copilot/product-copilot.lbug
```

Optional environment variables:

- `PRODUCT_COPILOT_DB_PATH` — override the database path
- `PRODUCT_COPILOT_MODE` — `direct` or `worker` (default: `direct`)

## Why the worker scaffold exists already

LadybugDB is a native dependency. A child-process worker is a good long-term option if we want:

- crash isolation
- one clear owner of the `.lbug` file
- simpler behavior across pi reloads

The current package does **not** spawn the worker yet. It only includes the layout so the next implementation step is straightforward.

## Suggested next steps

1. Move LadybugDB ownership into the worker behind `WorkerClient`.
2. Wire worker-mode selection into the pi extension runtime.
3. Add read-only graph tools first:
   - `product_copilot_get_node`
   - `product_copilot_get_subgraph`
   - `product_copilot_query_readonly`
4. Translate the Product Copilot ontology into Ladybug schema/bootstrap assets.
