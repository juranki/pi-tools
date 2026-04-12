---
name: product-copilot-graph-analysis
description: Use this skill when the user wants to query, trace, audit, or explain the Product Copilot graph in Memgraph, including feature-to-evidence traces, requirement coverage, work package context, release impact, or incident-to-decision analysis. It helps choose the right query pattern, keep retrieval bounded, and summarize graph results with provenance. Do not use it for schema migrations or unrestricted graph writes.
compatibility: Requires access to the Product Copilot Memgraph dataset and the query assets in ../../research/product-copilot.
---

# Product Copilot Graph Analysis

Use this skill to retrieve and explain bounded subgraphs from the Product Copilot knowledge graph.

## When to use

Use this skill when:

- the user wants to understand why a feature, requirement, release, or incident exists
- the user wants a trace such as evidence -> claim -> opportunity -> outcome -> requirement -> work package -> release
- the user wants to find missing links, weak traceability, or autonomy blockers
- the user wants query help against the Memgraph-backed ontology in `../../research/product-copilot/05-ontology-v0.yaml`

Do not use it for:

- ontology redesign from scratch
- unrestricted write operations to the graph
- front-end dashboard implementation details

## Workflow

1. Identify the primary user question and the seed object IDs if available.
2. Map the question to the smallest matching query pattern.
3. Read the ontology or query asset only as needed:
   - `../../research/product-copilot/05-ontology-v0.yaml`
   - `../../research/product-copilot/07b-memgraph-query-patterns.cypher`
4. Prefer bounded retrieval:
   - exact IDs first
   - then one-hop or named trace patterns
   - only then broader exploratory queries
5. Return:
   - the answer
   - the key nodes and edges used
   - missing links or confidence gaps
   - suggested next query if the picture is incomplete

## Defaults

- Default graph dialect: **Memgraph/openCypher**
- Default query asset: `../../research/product-copilot/07b-memgraph-query-patterns.cypher`
- Default starting point: an exact `id` such as `FEAT-001`, `REQ-001`, `WP-001`, `INC-001`, or `REL-001`
- Prefer question-shaped traces over general graph dumps

## Gotchas

- Avoid Neo4j-only subquery patterns when reusing queries against Memgraph.
- Do not render or retrieve the whole graph unless the user explicitly asks.
- Missing trace links are often the answer; do not hide them behind a smooth narrative.
- Keep business, architecture, and operations layers distinct in the explanation.
- If multiple paths exist, rank them by directness and evidence quality.

## Query intent map

Use these defaults:

- **Why are we building this?** -> Q1
- **What is missing from requirements?** -> Q2 or Q3
- **What can run autonomously?** -> Q4
- **What context should an agent get before execution?** -> Q5
- **What decision/assumption relates to this incident?** -> Q6
- **What gap did this release close?** -> Q7
- **Which goals are weakly supported?** -> Q8
- **Which incidents are missing follow-up?** -> Q9
- **Show end-to-end trace from feature to runtime metric** -> Q10

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
- Read `../../research/product-copilot/07b-memgraph-query-patterns.cypher` when adapting or selecting a Memgraph query.
