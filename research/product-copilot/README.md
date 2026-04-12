# Product Copilot Research

Goal: assemble a research base for a "dark factory" for SaaS product development, where agentic systems can help move from market sensing to product operation with minimal manual coordination.

## Working concept

The target system has three major capabilities:

1. **Discovery copilot**
   - collect market, customer, competitor, and operational evidence
   - help shape a product idea into a validated opportunity
2. **Knowledge graph backbone**
   - store product knowledge, evidence, decisions, requirements, architecture, code, and operations data in a graph
   - preserve provenance so agents can reason over trusted context
3. **Autonomous delivery engine**
   - refine goals and requirements into executable work packages
   - allow specialized agents to build, verify, release, and operate the system

## Folder contents

- `README.md` — overview and suggested direction
- `01-taxonomy-foundations.md` — standards and methodologies to extract a coherent lifecycle taxonomy
- `02-agent-skills-by-phase.md` — skills needed by the assistant across lifecycle phases
- `03-graph-schema.md` — suggested graph model for product development knowledge
- `04-work-package-spec.md` — work package format for autonomous execution
- `05-ontology-v0.yaml` — machine-readable ontology for entities, relationships, properties, and lifecycle states
- `06-ladybugdb-schema.cypher` — LadybugDB-first schema scaffold derived from the ontology for the current Product Copilot MVP slice
- `07-ladybugdb-query-patterns.cypher` — LadybugDB-first bounded query patterns aligned to the scaffold schema
- `08-ladybugdb-sample-data.cypher` — compact LadybugDB sample dataset for exercising the scaffold schema and queries
- `09-agent-tooling.md` — recommended tool surface for safe agent access to the graph, updated for LadybugDB-first execution
- `10-human-visualizations.md` — visualization catalog for human-facing product, delivery, and operations views
- `11-ladybugdb-evaluation.md` — decision basis and implementation guidance for adopting LadybugDB as the current default backend
- `archive/README.md` — archived Neo4j and Memgraph comparison assets retained for portability/reference work

## Recommended framing

Use a layered approach:

- **formal standards as skeleton**
  - lifecycle, requirements, architecture, quality, security, service management
- **product and innovation methods as discovery overlay**
  - lean startup, JTBD, design thinking, opportunity/solution trees, strategy methods
- **software delivery methods as execution overlay**
  - agile, DDD, DevOps, SRE, FinOps, security engineering

This gives a stable taxonomy without forcing one methodology onto every phase.

## Canonical lifecycle to model

1. Opportunity sensing
2. Problem framing
3. Product strategy
4. Solution shaping
5. Requirements and constraints
6. Architecture and delivery planning
7. Build and verification
8. Release and rollout
9. Operate and observe
10. Learn and adapt

Cross-cutting across all phases:

- security
- privacy and compliance
- economics and pricing
- quality and reliability
- governance and decision logging
- provenance and evidence quality

## Local LadybugDB setup

LadybugDB is embedded, so no Docker Compose stack is required for the default local Product Copilot workflow.

Recommended local defaults:

- use a project-local `.lbug` database file for persistent development state
- use `:memory:` for tests and short-lived fixtures
- keep one owning process / `Database` object per database file
- load required LadybugDB extensions explicitly in each new process or session

Suggested implementation shape:

1. add `@ladybugdb/core` to the owning Node.js package or pi extension
2. open a project-local database such as `./.state/product-copilot.lbug`
3. apply or adapt `06-ladybugdb-schema.cypher`
4. load `08-ladybugdb-sample-data.cypher` when you need a compact local fixture dataset
5. expose bounded read tools first
6. add controlled writes only after traceability queries and policy checks are stable

For detailed integration notes, see:

- `11-ladybugdb-evaluation.md`
- `06-ladybugdb-schema.cypher`
- `07-ladybugdb-query-patterns.cypher`
- `../../skills/ladybugdb/`

Archived Neo4j and Memgraph comparison assets now live under `archive/`; they are retained for portability/reference work only.

## Companion skills

- `../../skills/ladybugdb/` — skill for LadybugDB setup, storage-mode choices, imports, and integration caveats
- `../../skills/product-copilot-graph-analysis/` — skill for bounded LadybugDB graph retrieval, tracing, and traceability analysis
- `../../skills/product-copilot-visualization-design/` — skill for designing audience-specific graph views and dashboards

## Suggested next research steps

1. Implement the read-only graph tools defined in `09-agent-tooling.md` and bind them to an embedded LadybugDB instance.
2. Validate the visualization catalog in `10-human-visualizations.md` against real product, architecture, and operations workflows.
3. Define ingestion sources for evidence:
   - analyst reports
   - competitor docs and pricing pages
   - customer interviews and tickets
   - product analytics
   - architecture and code repositories
   - incident and operations data
4. Derive the LadybugDB schema, load path, and reusable query templates from `05-ontology-v0.yaml`, while keeping the graph model portable enough for a future service-backed backend if needed.
5. Define autonomous work package boundaries:
   - what an agent may do without approval
   - what requires human review
6. Build an eval set:
   - can the system trace every requirement to evidence, decision, implementation, test, and metric?

## Important assumption

This initial material is a synthesis of widely used standards and methods, intended as a research starting point. It should later be validated with live source collection, especially for current tooling, governance expectations, and domain-specific regulation.
