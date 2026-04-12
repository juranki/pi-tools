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
- `06-neo4j-bootstrap.cypher` — Neo4j 5 bootstrap script with constraints and indexes generated from the ontology
- `06b-memgraph-bootstrap.cypher` — Memgraph bootstrap script with uniqueness, existence constraints, and common indexes
- `07-neo4j-query-patterns.cypher` — Neo4j query patterns for validating traceability and agent retrieval use cases
- `07b-memgraph-query-patterns.cypher` — Memgraph/openCypher query patterns using compatibility-friendly OPTIONAL MATCH + aggregation
- `08-sample-data-memgraph.cypher` — sample Memgraph dataset for exercising the ontology, bootstrap, and query patterns
- `09-agent-tooling.md` — recommended tool surface for safe agent access to the graph
- `10-human-visualizations.md` — visualization catalog for human-facing product, delivery, and operations views
- `11-ladybugdb-evaluation.md` — evaluation of LadybugDB as an embedded graph option for Product Copilot, including pi extension implications
- `compose.yaml` — local Memgraph + MAGE + Lab setup for Product Copilot

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

## Local Memgraph setup

A minimal Docker Compose setup is included in `compose.yaml` for running the official Memgraph image locally, plus Memgraph Lab.

Persisted host folders:

- `${HOME}/.local/state/product-copilot/memgraph/data`
- `${HOME}/.local/state/product-copilot/memgraph/logs`

Quick start:

```bash
cd research/product-copilot
cp .env.example .env

docker compose up -d
```

Connection endpoints:

- Bolt: `bolt://localhost:7687`
- Memgraph port: `localhost:7444`
- Memgraph Lab: <http://localhost:3000>

The compose file runs Memgraph as `1000:1000` by default. Memgraph requires the process user to match the owner of the mounted data directory, so if your local user has a different uid/gid, set `MEMGRAPH_CONTAINER_USER` in `.env` to match.

Stop Memgraph:

```bash
docker compose down
```

Use the Memgraph-specific files with the local Memgraph setup:

- `06b-memgraph-bootstrap.cypher`
- `07b-memgraph-query-patterns.cypher`
- `08-sample-data-memgraph.cypher`

The Neo4j-oriented files (`06-neo4j-bootstrap.cypher`, `07-neo4j-query-patterns.cypher`) are retained for comparison and portability, but should not be the default against Memgraph.

## Companion skills

- `../../skills/product-copilot-graph-analysis/` — skill for bounded Memgraph graph retrieval, tracing, and traceability analysis
- `../../skills/product-copilot-visualization-design/` — skill for designing audience-specific graph views and dashboards

## Suggested next research steps

1. Implement the read-only graph tools defined in `09-agent-tooling.md` and bind them to the Memgraph instance.
2. Validate the visualization catalog in `10-human-visualizations.md` against real product, architecture, and operations workflows.
3. Define ingestion sources for evidence:
   - analyst reports
   - competitor docs and pricing pages
   - customer interviews and tickets
   - product analytics
   - architecture and code repositories
   - incident and operations data
4. Refine the graph stack and query language strategy:
   - Ladybug / Memgraph / Neo4j / PostgreSQL + graph layer / RDF stack
5. Define autonomous work package boundaries:
   - what an agent may do without approval
   - what requires human review
6. Build an eval set:
   - can the system trace every requirement to evidence, decision, implementation, test, and metric?

## Important assumption

This initial material is a synthesis of widely used standards and methods, intended as a research starting point. It should later be validated with live source collection, especially for current tooling, governance expectations, and domain-specific regulation.
