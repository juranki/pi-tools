# Agent Tooling for Graph Access

This document defines the **minimum tool surface** an agent should have for working against the Product Copilot graph in Memgraph.

## 1. Design principle

Separate tools by risk level.

- **read tools** should be broadly available
- **analysis tools** may compose multiple reads and summaries
- **write tools** should be separate, policy-gated, and auditable

Default posture:

- start with **read-only graph access**
- add controlled mutation only after retrieval patterns and ontology stability are proven

## 2. Recommended tool set

### 2.1 Core read tools

#### `graph_get_node`

Purpose:
- fetch one node by stable `id`

Inputs:
- `id`
- optional `expand` depth

Output:
- node properties
- immediate neighbors if expanded

Best use:
- precise retrieval when the user names a requirement, feature, work package, incident, or decision

#### `graph_run_query`

Purpose:
- run parameterized read-only Cypher

Inputs:
- `query`
- `params`
- `limit`

Output:
- rows
- optional lightweight graph projection

Guardrails:
- reject write clauses: `CREATE`, `MERGE`, `SET`, `DELETE`, `REMOVE`, `DROP`
- apply timeout and row limits

#### `graph_get_subgraph`

Purpose:
- retrieve a bounded neighborhood around one or more ids

Inputs:
- `seed_ids`
- `edge_types`
- `max_depth`
- `node_labels`

Output:
- nodes
- edges

Best use:
- visualization and local reasoning context

#### `graph_trace_path`

Purpose:
- retrieve known traceability paths using approved templates

Supported trace kinds:
- `feature_to_evidence`
- `requirement_to_tests`
- `incident_to_decision`
- `release_to_gap`
- `work_package_context`

Output:
- ordered path segments
- missing-link report

### 2.2 Analysis tools

#### `graph_traceability_audit`

Purpose:
- check for missing required links

Examples:
- requirement without acceptance criterion
- approved requirement without work package
- reviewed incident without postmortem or follow-up
- feature without supporting evidence chain

Output:
- violations
- severity
- candidate next actions

#### `graph_rag_context`

Purpose:
- assemble compact, provenance-preserving context for another agent

Inputs:
- `task_type`
- `seed_ids`
- `token_budget`

Output:
- compact summary
- cited nodes/edges
- unresolved gaps

#### `graph_compare_options`

Purpose:
- compare candidate features, goals, work packages, or solutions using graph evidence

Output:
- comparison table
- evidence counts
- confidence notes
- missing information

### 2.3 Controlled write tools

Do **not** expose these by default.

#### `graph_upsert_nodes_edges`

Use only for:
- ingestion pipelines
- approved normalization flows
- post-reviewed analysis outputs

Requirements:
- schema validation
- provenance required
- audit record required
- dry-run mode

#### `graph_record_decision`

Use only for:
- adding reviewed decisions/ADRs
- linking rationale and evidence

Requirements:
- human approver or policy-authorized agent
- immutable audit trail

## 3. Best tool API shape

Prefer **task-shaped tools**, not a single unrestricted SQL/Cypher console.

Recommended progression:

1. `graph_get_node`
2. `graph_get_subgraph`
3. `graph_trace_path`
4. `graph_traceability_audit`
5. `graph_run_query` for advanced cases
6. write tools later

Why:
- better safety
- easier prompting
- easier caching
- easier auditing
- less query fragility

## 4. Suggested response formats

### 4.1 Row result

```json
{
  "columns": ["id", "title", "status"],
  "rows": [
    ["REQ-001", "Emit immutable audit event on workspace role change", "implemented"]
  ],
  "row_count": 1
}
```

### 4.2 Graph projection

```json
{
  "nodes": [
    {"id": "FEAT-001", "label": "Feature", "title": "Workspace role audit trail"},
    {"id": "CAP-001", "label": "Capability", "title": "Workspace administration auditability"}
  ],
  "edges": [
    {"type": "IMPLEMENTS", "from": "FEAT-001", "to": "CAP-001"}
  ]
}
```

### 4.3 Trace report

```json
{
  "trace_kind": "feature_to_evidence",
  "seed_id": "FEAT-001",
  "paths": [
    ["Feature:FEAT-001", "Capability:CAP-001", "Outcome:OUT-001", "Opportunity:OPP-001", "Claim:CLM-001", "Evidence:EVD-001"]
  ],
  "missing_links": []
}
```

## 5. Practical Memgraph implementation notes

Use Memgraph-compatible query style:

- prefer `OPTIONAL MATCH + aggregation`
- avoid Neo4j-specific existential subqueries in shared query assets
- keep parameterized queries in versioned `.cypher` files where possible

Current project assets:

- `07b-memgraph-query-patterns.cypher`
- `08-sample-data-memgraph.cypher`
- `05-ontology-v0.yaml`

## 6. Access policy recommendation

### Default read policy

Allow agents to read:
- discovery/evidence
- goals/outcomes/capabilities
- requirements and architecture
- work packages and releases
- incidents and postmortems

### Restricted read policy

Mask or gate:
- secrets
- credentials
- sensitive ticket content
- production PII
- regulated data entities

### Write policy

Require approval for:
- ontology-changing writes
- decision/ADR creation
- production incident closure
- release-state mutation
- destructive deletes

## 7. Minimum viable implementation

Start with these four tools only:

1. `graph_get_node`
2. `graph_get_subgraph`
3. `graph_trace_path`
4. `graph_traceability_audit`

That is enough to support most assistant use cases without exposing a fully open graph mutation surface.

## 8. Immediate next build steps

1. implement a read-only Memgraph adapter
2. wrap approved query templates as named operations
3. return both table results and graph projections
4. add audit logging for every tool invocation
5. add caching for repeated trace requests
6. add policy filters for sensitive nodes and properties
