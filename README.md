# pi-tools

Utilities, skills, and experiments for the [pi](https://github.com/mariozechner/pi-coding-agent) coding agent.

This repository currently contains three main things:

- reusable **Agent Skills** under [`skills/`](./skills)
- a **Product Copilot** pi extension scaffold under [`packages/product-copilot/`](./packages/product-copilot)
- supporting **research and graph assets** under [`research/product-copilot/`](./research/product-copilot)

## What is in this repo?

### Skills

The [`skills/`](./skills) directory contains Agent Skills-style folders with a `SKILL.md` plus optional references, assets, and scripts.

Included today:

| Skill | Purpose |
| --- | --- |
| [`ladybugdb`](./skills/ladybugdb/) | Guidance for evaluating, modeling, querying, and integrating LadybugDB in local-first and embedded workflows. |
| [`product-copilot-graph-analysis`](./skills/product-copilot-graph-analysis/) | Bounded Memgraph/openCypher retrieval and explanation for the Product Copilot knowledge graph. |
| [`product-copilot-visualization-design`](./skills/product-copilot-visualization-design/) | Design guidance for human-facing graph views, dashboards, and reporting layouts. |
| [`skill-creation`](./skills/skill-creation/) | Help for creating, reviewing, and scaffolding Agent Skills-standard skills. |

### Product Copilot package

[`packages/product-copilot/`](./packages/product-copilot) is a real Node package that acts as a scaffold for a local-first pi extension.

Current focus:

- pi extension entrypoint
- LadybugDB-oriented runtime layout
- worker-process scaffold for future isolation
- tests, linting, and TypeScript validation

Start here for package-specific details:

- [`packages/product-copilot/README.md`](./packages/product-copilot/README.md)
- [`packages/product-copilot/AGENTS.md`](./packages/product-copilot/AGENTS.md)

### Research

[`research/product-copilot/`](./research/product-copilot) contains the background material for the Product Copilot concept, including:

- lifecycle taxonomy notes
- graph schema and ontology drafts
- Neo4j and Memgraph bootstrap/query assets
- sample graph data
- agent tooling ideas
- visualization concepts
- LadybugDB evaluation notes

Start with [`research/product-copilot/README.md`](./research/product-copilot/README.md).

## Repository layout

```text
.
├── packages/
│   └── product-copilot/
├── research/
│   └── product-copilot/
└── skills/
    ├── ladybugdb/
    ├── product-copilot-graph-analysis/
    ├── product-copilot-visualization-design/
    └── skill-creation/
```

## Quick start

### Browse the skills

Open any skill directory and read its `SKILL.md`:

```bash
find skills -maxdepth 2 -name SKILL.md | sort
```

### Work on the Product Copilot package

```bash
cd packages/product-copilot
npm install
npm run validate
```

To load the scaffolded extension in pi from the repository root:

```bash
pi -e packages/product-copilot/src/index.ts
```

## Notes

- There is currently **no repo-wide root package** or top-level validation script.
- Most executable code lives in `packages/product-copilot/`.
- The rest of the repo is primarily reusable skill content and research material.
- Project-local runtime state is ignored under `.pi/`.

## Status

This repository is experimental and evolving. Expect scaffolds, research artifacts, and conventions to tighten as the Product Copilot implementation matures.
