---
name: product-copilot-visualization-design
description: Use this skill when the user wants human-facing views, dashboards, graph slices, or reporting layouts for the Product Copilot graph, including strategy traces, requirement coverage views, work package control towers, release impact pages, or incident learning loops. It helps choose the audience, question, visual form, query shape, and interaction model. Do not use it for unrestricted BI sprawl or raw whole-graph rendering.
compatibility: Requires the Product Copilot ontology and visualization guidance in ../../research/product-copilot. Current default backend is LadybugDB.
---

# Product Copilot Visualization Design

Use this skill to design human-friendly views over the Product Copilot graph.

## When to use

Use this skill when:

- the user wants dashboards or graph views for product, architecture, delivery, or operations audiences
- the user wants to turn graph queries into human-readable visual products
- the user wants a visualization spec before implementing UI components
- the user wants to avoid hairball graphs and focus on use-case-shaped views

Do not use it for:

- generic analytics dashboards with no graph semantics
- low-level front-end coding unless the visualization spec is already agreed
- unrestricted full-graph rendering

## Workflow

1. Identify the audience.
2. State the primary question the view must answer.
3. Choose the smallest graph slice needed.
4. Pick a visual form that matches the task:
   - trace map
   - matrix
   - DAG board
   - timeline
   - layered architecture map
   - dossier page
5. Define the interaction model:
   - default filters
   - drill-down target
   - provenance access
   - missing-link highlighting
6. Specify the backing data product or query.
7. Return a compact visualization spec the UI layer can implement.

## Defaults

- Prefer one audience per view.
- Prefer one primary question per view.
- Default to bounded subgraphs, not the whole dataset.
- Always include provenance drill-down and stable IDs.
- Use `../../research/product-copilot/10-human-visualizations.md` as the default catalog.

## Gotchas

- A pretty graph without a decision question is usually noise.
- Mixing strategy, delivery, and incident operations in one screen usually reduces clarity.
- Tables are often better than node-link diagrams for coverage and audit tasks.
- DAGs are better than kanban boards when dependency order matters.
- Confidence and missing links should be visible, not hidden in tooltips only.

## Output format

```markdown
# Visualization Spec

## Audience
<audience>

## Primary question
<question>

## View type
<trace map / matrix / DAG / timeline / layered map / dossier>

## Graph slice
- nodes: <labels>
- edges: <types>
- seed objects: <ids or filters>

## Default filters
- <filter>

## Panels / interactions
- <panel or action>

## Backing query / data product
- <query name or retrieval function>
```

## References to load on demand

- Read `../../research/product-copilot/10-human-visualizations.md` when selecting the view family.
- Read `assets/visualization-spec-template.md` when producing a reusable implementation-ready spec.
- Read `../../research/product-copilot/09-agent-tooling.md` when a view needs a concrete backing retrieval shape for the LadybugDB-backed graph.
