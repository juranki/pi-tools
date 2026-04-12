---
name: product-copilot-graph-analysis
description: Use this skill when the user wants to query, trace, audit, or explain the Product Copilot graph in LadybugDB, including feature-to-evidence traces, requirement coverage, work package context, release impact, or incident-to-decision analysis. It helps choose bounded retrieval patterns, shape LadybugDB Cypher around the ontology, and summarize results with provenance. Do not use it for schema migrations or unrestricted graph writes.
compatibility: Requires access to a Product Copilot LadybugDB dataset or project-local `.lbug` database, plus the ontology and backend guidance in ../../research/product-copilot.
---

# Product Copilot Graph Analysis

Use this skill to retrieve and explain bounded subgraphs from the Product Copilot knowledge graph.

## When to use

Use this skill when:

- the user wants to understand why a feature, requirement, release, or incident exists
- the user wants a trace such as evidence -> claim -> opportunity -> outcome -> requirement -> work package -> release
- the user wants to find missing links, weak traceability, or autonomy blockers
- the user wants query help against the LadybugDB-backed ontology in `../../research/product-copilot/05-ontology-v0.yaml`

Do not use it for:

- ontology redesign from scratch
- unrestricted write operations to the graph
- front-end dashboard implementation details

## Workflow

1. Identify the primary user question and the seed object IDs if available.
2. Map the question to the smallest matching retrieval pattern.
3. Read the ontology or backend guidance only as needed:
   - `../../research/product-copilot/05-ontology-v0.yaml`
   - `../../research/product-copilot/09-agent-tooling.md`
   - `../../research/product-copilot/11-ladybugdb-evaluation.md`
   - `../ladybugdb/references/notes.md`
4. Prefer bounded retrieval:
   - exact IDs first
   - then one-hop or named trace patterns
   - only then broader exploratory queries
5. When writing Cypher, adapt it to LadybugDB realities:
   - explicit schema / one label per node or relationship
   - prepared statements for parameters
   - validate syntax against the deployed LadybugDB version
6. Return:
   - the answer
   - the key nodes and edges used
   - missing links or confidence gaps
   - suggested next query if the picture is incomplete

## Defaults

- Default graph dialect: **LadybugDB Cypher**
- Default starting point: an exact `id` such as `FEAT-001`, `REQ-001`, `WP-001`, `INC-001`, or `REL-001`
- Prefer question-shaped traces over general graph dumps
- Prefer named or versioned query templates over ad hoc console-style querying

## Gotchas

- LadybugDB is schema-first and stricter than service-style property-graph defaults; do not assume label or property flexibility.
- Keep retrieval bounded; do not render or retrieve the whole graph unless the user explicitly asks.
- Missing trace links are often the answer; do not hide them behind a smooth narrative.
- Keep business, architecture, and operations layers distinct in the explanation.
- If multiple paths exist, rank them by directness and evidence quality.
- If the graph is embedded in-process, assume one owning `Database` object per `.lbug` file for read-write access.

## Query intent map

Use these defaults:

- **Why are we building this?** -> feature or requirement rationale trace
- **What is missing from requirements?** -> requirement coverage audit or acceptance-gap audit
- **What can run autonomously?** -> autonomy-ready work package filter
- **What context should an agent get before execution?** -> work package execution context trace
- **What decision/assumption relates to this incident?** -> incident-to-decision / assumption trace
- **What gap did this release close?** -> release impact trace
- **Which goals are weakly supported?** -> goal evidence-strength audit
- **Which incidents are missing follow-up?** -> incident follow-up audit
- **Show end-to-end trace from feature to runtime metric** -> feature-to-runtime trace

## Output format

```markdown
# Graph Analysis

## Answer
<direct answer>

## Supporting trace
- <node> -> <edge> -> <node>
- <node> -> <edge> -> <node>

## Gaps / caveats
- <missing link or confidence issue>

## Suggested next step
- <next query or follow-up>
```

## References to load on demand

- Read `references/query-intents.md` when mapping a user question to a graph retrieval pattern.
- Read `../../research/product-copilot/05-ontology-v0.yaml` when label or edge semantics are unclear.
- Read `../../research/product-copilot/09-agent-tooling.md` when selecting tool shapes or bounded retrieval patterns.
- Read `../../research/product-copilot/11-ladybugdb-evaluation.md` for Product Copilot backend rationale and runtime caveats.
- Read `../ladybugdb/references/notes.md` when LadybugDB syntax, loading, or concurrency details matter.
