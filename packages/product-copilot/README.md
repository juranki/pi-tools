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
- one read-only diagnostic command and one read-only diagnostic tool

Not included yet:

- LadybugDB ownership / connection lifecycle
- graph schema bootstrap
- Product Copilot query tools
- ingestion tools
- worker process management from the extension runtime

## Folder layout

```text
packages/product-copilot/
├── package.json
├── README.md
├── tsconfig.json
├── fixtures/
├── test/
└── src/
    ├── index.ts
    ├── lib/
    │   └── config.ts
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

1. Add a `WorkerClient` that starts and talks to `src/worker/ladybug-worker.mjs`.
2. Move LadybugDB ownership into that worker.
3. Add read-only graph tools first:
   - `product_copilot_get_node`
   - `product_copilot_get_subgraph`
   - `product_copilot_query_readonly`
4. Translate the Product Copilot ontology into Ladybug schema/bootstrap assets.
