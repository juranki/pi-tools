# Human-Optimized Visualizations

This document defines visualization patterns for humans using the Product Copilot graph.

## 1. Core rule

Do not show the whole graph.

Use **question-shaped views** with:

- a specific audience
- a bounded slice of the graph
- explicit default filters
- a small set of actions

## 2. Primary audiences

- founder / product lead
- product manager
- architect / tech lead
- delivery lead
- engineering team
- support / operations lead
- executive / investor

## 3. Recommended visualization families

### 3.1 Strategy trace view

Question:
- why does this product bet exist?

Audience:
- founder, PM, strategy lead

Show:
- driver
- assessment
- goal
- outcome
- capability
- feature
- supporting evidence

Best visual form:
- left-to-right trace map
- side panel for evidence and confidence

Primary interactions:
- click any node to see provenance
- filter by segment, confidence, owner, status

### 3.2 Evidence board

Question:
- what do we know, how well do we know it, and what conflicts exist?

Audience:
- research analyst, PM, founder

Show:
- evidence
- claims
- contradictions
- assumptions
- experiments/results

Best visual form:
- sortable table + contradiction network
- confidence heatmap

Primary interactions:
- filter by source type, confidence, review status
- expand claim to see supporting and contradicting evidence

### 3.3 Requirement trace matrix

Question:
- are requirements fully connected to acceptance, implementation, and tests?

Audience:
- PM, architect, QA, delivery lead

Show:
- requirement
- acceptance criteria
- allocated architecture element
- work package
- test case
- release

Best visual form:
- matrix / grid
- missing-link highlighting

Primary interactions:
- filter by status, requirement kind, risk level
- highlight rows with missing acceptance/tests/work packages

### 3.4 Work package control tower

Question:
- what can run autonomously, what is blocked, and why?

Audience:
- delivery lead, orchestrator agent overseer

Show:
- work package DAG
- autonomy level
- dependency status
- risk level
- review gates
- assigned agent

Best visual form:
- DAG timeline or dependency board
- grouped swimlanes by status or agent

Primary interactions:
- show only ready packages
- show blockers and critical path
- show policy exceptions requiring human review

### 3.5 Architecture realization map

Question:
- how do capabilities and requirements map into services and components?

Audience:
- architect, tech lead

Show:
- capability
- business/application/technology services
- service/component/API/event/data entity
- ADR links

Best visual form:
- layered architecture map
- service dependency mini-graph

Primary interactions:
- trace from requirement to service/API/event
- filter by bounded context or owner team

### 3.6 Release impact view

Question:
- what did this release change and what gap did it close?

Audience:
- PM, release manager, architect

Show:
- release
- artifacts
- deliverables
- work packages
- addressed gaps
- target plateau
- incidents after release

Best visual form:
- release dossier page
- timeline + trace panel

### 3.7 Reliability and learning loop

Question:
- what operational signals are feeding back into strategy and delivery?

Audience:
- SRE, PM, tech lead

Show:
- metric / SLI / SLO
- alerts
- incidents
- postmortems
- created work packages
- updated assessments/decisions

Best visual form:
- incident timeline + causal trace
- reliability scorecard

## 4. Recommended visual product surfaces

### Surface A — Product Command Center

Use for daily PM / founder / lead review.

Panels:
- top goals and outcomes
- opportunity confidence changes
- blocked work packages
- latest incidents affecting roadmap
- traceability violations

### Surface B — Requirement & Delivery Console

Use for delivery planning and readiness.

Panels:
- requirements missing links
- autonomy-ready work packages
- review gate failures
- release readiness snapshot

### Surface C — Operations Learning Console

Use for SRE + product feedback loops.

Panels:
- SLO state
- open incidents
- postmortem-created work packages
- assumptions invalidated by production

## 5. Visualization anti-patterns

Avoid:

- giant unlabeled node-link diagrams
- dashboards mixing strategy, delivery, and incidents with no audience separation
- charts with no provenance link-back
- status-only boards without dependency or evidence context
- full graph rendering by default

## 6. Design defaults

Always include:

- stable IDs
- status color semantics
- confidence indication where relevant
- provenance drill-down
- missing-link warnings
- time filter
- owner/segment/service filters

## 7. Suggested first three views to implement

1. **Strategy trace view**
   - strongest demonstration of graph value
2. **Requirement trace matrix**
   - strongest governance and delivery value
3. **Work package control tower**
   - strongest autonomous execution value

## 8. Data products for the UI layer

Precompute or cache these shapes:

- `feature_trace_view(feature_id)`
- `requirement_trace_matrix(filters)`
- `autonomy_ready_work_packages(filters)`
- `release_impact_view(release_id)`
- `incident_learning_loop(service_id | incident_id)`

This keeps the human UI fast and avoids repeated ad hoc graph traversals.
