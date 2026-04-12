# Archived graph backend comparison assets

These files are retained for reference and portability work only.

Current default backend for Product Copilot is **LadybugDB**.

## Archived directories

- `neo4j/`
  - `06-bootstrap.cypher`
  - `07-query-patterns.cypher`
- `memgraph/`
  - `06-bootstrap.cypher`
  - `07-query-patterns.cypher`
  - `08-sample-data.cypher`

## Why these are archived

They reflect earlier comparison work for service-oriented graph backends.
They are still useful when:

- reviewing prior design assumptions
- checking query portability
- planning a future migration to a shared graph service

They are **not** the default implementation path for current Product Copilot work.

## Use instead

For active work, start with:

- `../06-ladybugdb-schema.cypher`
- `../07-ladybugdb-query-patterns.cypher`
- `../08-ladybugdb-sample-data.cypher`
- `../09-agent-tooling.md`
- `../11-ladybugdb-evaluation.md`
