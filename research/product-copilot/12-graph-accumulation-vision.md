# Graph Accumulation Vision

This document defines the next-phase product vision for Product Copilot: not only reading from a graph, but **continuously accumulating** a trustworthy product knowledge graph over time.

## 1. Core thesis

Product Copilot should not be only a query layer over a manually curated graph.

It should become a **compounding memory and execution spine** that:

1. collects signals from product, engineering, and operations systems
2. normalizes those signals into ontology-shaped records
3. links them into traceable chains
4. promotes reviewed knowledge into decisions, requirements, architecture, and work
5. observes what happens during delivery and runtime
6. feeds learning back into strategy and planning

In short:

> Product Copilot is a local-first, graph-backed product memory that accumulates evidence, interpretations, and commitments across the product lifecycle.

## 2. Why this matters

A read-first approach is a reasonable safety posture, but it is not sufficient as the product vision.

If the graph is only queried, then Product Copilot risks becoming:

- a reporting layer
- a search/index layer
- a manually maintained traceability artifact

The higher-value product is a system that **builds and maintains the graph as part of normal work**.

That means the graph must accumulate:

- new observations
- new interpretations
- new decisions and plans
- execution outcomes
- operational feedback
- supersession and correction history

## 3. What the graph should own

Product Copilot should not replace every source system.

### External systems remain systems of record

Examples:

- document repositories
- issue trackers
- code repositories
- CI systems
- observability platforms
- incident tools
- support systems
- analytics systems

### The graph becomes the system of synthesis

It should own normalized, cross-cutting knowledge such as:

- evidence
- claims
- assumptions
- assessments
- decisions
- requirements
- architecture trace links
- gaps and target states
- work packages
- review and audit records
- cross-system identity mapping
- supersession history

This gives Product Copilot a clear role: **make fragmented product knowledge queryable, traceable, and operationalizable**.

## 4. The three classes of accumulated knowledge

The graph should accumulate three distinct classes of knowledge.

### 4.1 Observations

These describe what was seen or what happened.

Examples:

- `Document`
- `Signal`
- `Metric`
- `Alert`
- `Incident`
- `Result`
- `Deployment`

Question answered:
- what happened?

### 4.2 Interpretations

These describe what we think the observations mean.

Examples:

- `Evidence`
- `Claim`
- `Assumption`
- `Assessment`
- `Postmortem`

Question answered:
- what does it mean?

### 4.3 Commitments

These describe what we decided to do or govern.

Examples:

- `Decision`
- `Goal`
- `Outcome`
- `Requirement`
- `AcceptanceCriterion`
- `WorkPackage`
- `ReleaseGoal`
- `Control`

Question answered:
- what are we going to do about it?

A healthy Product Copilot accumulates all three.

## 5. Accumulation loops

The graph should grow through a small number of intentional loops.

## 5.1 Discovery accumulation loop

Purpose:
- turn messy external and internal inputs into structured opportunity knowledge

Typical flow:

- `Source`
- `Document`
- `Signal`
- `Evidence`
- `Claim`
- `Assessment`
- `Opportunity`

Example sources:

- customer interviews
- support tickets
- analyst notes
- competitor pages
- usage anomalies

Primary value:
- creates grounded product understanding rather than disconnected research notes

## 5.2 Delivery accumulation loop

Purpose:
- turn product intent into executable and traceable work

Typical flow:

- `Goal`
- `Outcome`
- `Capability`
- `Requirement`
- `AcceptanceCriterion`
- `Gap`
- `WorkPackage`
- `Deliverable`
- `Artifact`
- `TestCase`

Primary value:
- lets humans and agents move from intent to execution with traceability intact

## 5.3 Runtime accumulation loop

Purpose:
- capture what actually happened after change was released

Typical flow:

- `Release`
- `Deployment`
- `Metric`
- `SLI`
- `SLO`
- `Alert`
- `Incident`
- `Postmortem`
- follow-up `WorkPackage`

Primary value:
- turns production reality into product and engineering learning

## 5.4 Learning and supersession loop

Purpose:
- update the graph when new evidence changes prior understanding

Typical flow:

- `Result` or `Incident` or `Postmortem`
- `UPDATES` `Claim` / `Assessment` / `Requirement` / `Decision`
- `SUPERSEDES` prior records where appropriate
- `CREATES` follow-up work or revised requirements

Primary value:
- makes Product Copilot a living memory instead of a stale documentation graph

## 6. Write model: append-first, promotion-based

Graph accumulation should not start from a generic unrestricted mutation interface.

Instead, writes should be:

- typed
- provenance-carrying
- auditable
- policy-gated where needed
- often append-oriented

Preferred mental model:

- add observation
- add normalized evidence
- propose interpretation
- promote reviewed knowledge
- record decision
- create work
- ingest runtime event
- supersede outdated understanding

This is safer and more trustworthy than arbitrary graph editing.

## 7. Proposed write lanes

Different writes have different risk and trust profiles.

### 7.1 Ingestion lane

Purpose:
- capture raw and normalized source material

Typical entities:

- `Source`
- `Document`
- `Signal`
- `Evidence`

Properties:

- high volume
- append-oriented
- provenance mandatory
- can be heavily automated

### 7.2 Synthesis lane

Purpose:
- convert observations into structured understanding

Typical entities:

- `Claim`
- `Assumption`
- `Assessment`
- support and contradiction links

Properties:

- confidence required
- review status required
- often starts as machine-generated and later reviewed

### 7.3 Planning and governance lane

Purpose:
- encode agreed product and delivery intent

Typical entities:

- `Decision`
- `Goal`
- `Outcome`
- `Requirement`
- `AcceptanceCriterion`
- `Gap`
- `WorkPackage`

Properties:

- narrower permissions
- schema validation required
- often approval-gated
- always auditable

### 7.4 Delivery and runtime lane

Purpose:
- accumulate factual execution and operational events

Typical entities:

- `Artifact`
- `Release`
- `Deployment`
- `Metric`
- `Alert`
- `Incident`
- `Postmortem`

Properties:

- often integrated from external systems
- timestamps and external refs are important
- should preserve links back to source systems

### 7.5 Curation and supersession lane

Purpose:
- keep the graph coherent as it grows

Typical actions:

- deduplicate records
- merge aliases and identities
- mark superseded records
- resolve conflict state
- advance review status

Properties:

- lower volume
- high leverage
- likely human-in-the-loop initially

## 8. Trust model and lifecycle states

Not all graph records should be treated as equally true.

Product Copilot should make trust and review state explicit.

A practical progression is:

1. raw or collected
2. normalized
3. machine-extracted
4. human-reviewed
5. approved
6. superseded or rejected

Trust should be visible in:

- query results
- visualizations
- write permissions
- promotion workflows
- downstream agent context assembly

Relevant ontology fields already support this direction:

- `status`
- `review_status`
- `confidence`
- `collector`
- `extraction_method`
- `version`
- `SUPERSEDES`
- `UPDATES`

## 9. Identity and deduplication

Accumulation only compounds if the graph can distinguish between:

- a new record
- another mention of the same thing
- a revised version
- a conflicting interpretation

Identity strategy is needed for at least:

- documents
- features
- requirements
- services
- incidents
- decisions
- work packages

Minimum mechanisms:

- stable internal IDs
- external references where available
- source-aware dedupe heuristics
- explicit supersession links
- preserved audit trail for merges and status changes

Without this, ingestion becomes noise rather than memory.

## 10. Product implications

This vision changes how Product Copilot should be scoped.

## 10.1 Read tools remain important

Read tools are still needed for:

- safe retrieval
- human-facing views
- bounded reasoning context
- audits and traceability checks

But they are the **consumption layer**, not the full product.

## 10.2 Accumulation paths must be designed from the start

The system should plan for controlled write paths even if early user-facing tools stay read-heavy.

That means designing:

- ingestion contracts
- typed write operations
- validation rules
- promotion workflows
- audit records
- supersession behavior

## 10.3 Task-shaped writes are better than open mutation

Prefer operations like:

- ingest document
- extract signals
- upsert evidence bundle
- record decision
- create requirement bundle
- create work package
- ingest release event
- ingest incident
- record postmortem follow-up

Avoid exposing an unrestricted general-purpose write console to agents.

## 11. MVP direction

The next phase should validate at least one or two complete accumulation loops.

Recommended order:

### MVP loop A — evidence to requirement

Flow:

- ingest notes, transcript, or support cluster
- extract signals and evidence
- synthesize claims and opportunity context
- create requirement draft
- create acceptance criteria draft
- review and approve

Why first:
- validates discovery-to-delivery traceability
- aligns strongly with the current ontology and visualization work

### MVP loop B — requirement to work package

Flow:

- take approved requirement
- allocate to architecture elements
- identify gap
- create bounded work package
- define acceptance checks and autonomy level

Why second:
- creates the bridge from planning into agent execution

### MVP loop C — incident to corrective work

Flow:

- ingest incident
- link to service and deployment
- attach postmortem
- update assessment or requirement
- create follow-up work package

Why third:
- closes the runtime learning loop

## 12. Near-term build priorities

To support this vision, the next implementation steps should be:

1. define the first source lanes to ingest
2. create staging-to-canonical normalization flow
3. implement task-shaped write APIs
4. add provenance enforcement to all writes
5. add review and promotion workflow
6. add identity and dedupe rules
7. keep read views aligned to the accumulated state

## 13. Success criteria

The accumulation vision is working when:

- new source material enters the graph with provenance intact
- machine-synthesized knowledge can be reviewed and promoted
- requirements and work packages can be created from accumulated context
- releases and incidents feed back into strategy and planning
- superseded understanding remains visible rather than silently overwritten
- humans and agents can both answer "why does this exist?" and "what changed?"

## 14. Summary

The Product Copilot graph should be treated as a **living product memory**, not just a query target.

The strongest version of the product is one where:

- knowledge is accumulated continuously
- trust levels are explicit
- decisions and work remain traceable to evidence
- runtime learning feeds back into planning
- read experiences sit on top of this compounding memory

That is the path from a graph-backed assistant to a real product copilot service.
