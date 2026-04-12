# Suggested Graph Schema

This is a practical graph model for a product copilot that needs to reason from market evidence to running system behavior.

## 1. Design goals

The graph should support:

- traceability from **signal -> decision -> requirement -> implementation -> operation**
- provenance for every important node and edge
- confidence and contradiction handling
- explicit modeling of **target states, gaps, and migration work**
- agent-friendly decomposition into work packages
- fast retrieval of all context needed for a local task

## 2. Core node types

### 2.1 Discovery and evidence

- `Source`
- `Document`
- `Signal`
- `Evidence`
- `Claim`
- `Assumption`
- `Experiment`
- `Result`
- `Decision`

Suggested properties:

- `id`
- `title`
- `summary`
- `status`
- `confidence`
- `owner`
- `created_at`
- `updated_at`
- `source_uri`
- `tags`

### 2.2 Motivation and strategy

- `Driver`
- `Assessment`
- `Goal`
- `Outcome`
- `Principle`
- `CourseOfAction`
- `ValueStream`
- `Capability`
- `Market`
- `Segment`
- `Competitor`
- `Persona`
- `Job`
- `Opportunity`
- `KPI`
- `Feature`
- `Policy`
- `ReleaseGoal`

### 2.3 Requirements and architecture

- `Requirement`
- `Constraint`
- `AcceptanceCriterion`
- `Risk`
- `BusinessService`
- `ApplicationService`
- `TechnologyService`
- `BoundedContext`
- `Service`
- `Component`
- `API`
- `Event`
- `DataEntity`
- `Workflow`
- `ADR`
- `Environment`

### 2.4 Delivery and migration

- `Epic`
- `Story`
- `WorkPackage`
- `Task`
- `Deliverable`
- `Gap`
- `Plateau`
- `Artifact`
- `TestCase`
- `TestSuite`
- `Agent`
- `Review`
- `Gate`

### 2.5 Operations

- `Release`
- `Deployment`
- `Metric`
- `SLI`
- `SLO`
- `Alert`
- `Incident`
- `Runbook`
- `CostItem`
- `Postmortem`

## 3. Core relationships

### 3.1 Evidence and motivation

- `(Source)-[:CONTAINS]->(Document)`
- `(Document)-[:YIELDS]->(Signal)`
- `(Signal)-[:SUPPORTS]->(Evidence)`
- `(Signal)-[:INFORMS]->(Assessment)`
- `(Evidence)-[:SUPPORTS]->(Claim)`
- `(Evidence)-[:CONTRADICTS]->(Claim)`
- `(Claim)-[:IMPLIES]->(Opportunity)`
- `(Assumption)-[:TESTED_BY]->(Experiment)`
- `(Experiment)-[:PRODUCES]->(Result)`
- `(Result)-[:UPDATES]->(Claim)`
- `(Assessment)-[:BASED_ON]->(Evidence)`
- `(Driver)-[:ASSESSED_BY]->(Assessment)`
- `(Decision)-[:BASED_ON]->(Evidence)`
- `(Decision)-[:RESOLVES]->(Assumption)`

### 3.2 Strategy to solution intent

- `(Driver)-[:INFLUENCES]->(Goal)`
- `(Assessment)-[:INFLUENCES]->(Goal)`
- `(Goal)-[:REALIZED_BY]->(Outcome)`
- `(Principle)-[:GUIDES]->(Decision)`
- `(CourseOfAction)-[:PURSUES]->(Goal)`
- `(ValueStream)-[:CREATES]->(Outcome)`
- `(ValueStream)-[:USES]->(Capability)`
- `(Segment)-[:HAS_JOB]->(Job)`
- `(Job)-[:SEEKS]->(Outcome)`
- `(Opportunity)-[:TARGETS]->(Segment)`
- `(Opportunity)-[:ADDRESSES]->(Job)`
- `(Opportunity)-[:PURSUES]->(Outcome)`
- `(Capability)-[:REALIZES]->(Outcome)`
- `(Feature)-[:IMPLEMENTS]->(Capability)`
- `(KPI)-[:MEASURES]->(Outcome)`
- `(Policy)-[:CONSTRAINS]->(Feature)`

### 3.3 Requirements and architecture

- `(Decision)-[:CREATES]->(Requirement)`
- `(Goal)-[:DRIVES]->(Requirement)`
- `(Requirement)-[:HAS_ACCEPTANCE]->(AcceptanceCriterion)`
- `(Constraint)-[:LIMITS]->(Requirement)`
- `(Requirement)-[:ALLOCATED_TO]->(BusinessService)`
- `(Requirement)-[:ALLOCATED_TO]->(ApplicationService)`
- `(Requirement)-[:ALLOCATED_TO]->(Component)`
- `(Capability)-[:SERVED_BY]->(BusinessService)`
- `(BusinessService)-[:REALIZED_BY]->(ApplicationService)`
- `(ApplicationService)-[:REALIZED_BY]->(Service)`
- `(Service)-[:SUPPORTED_BY]->(TechnologyService)`
- `(ADR)-[:DECIDES]->(Service)`
- `(ADR)-[:DECIDES]->(API)`
- `(Service)-[:EXPOSES]->(API)`
- `(Service)-[:EMITS]->(Event)`
- `(Service)-[:READS]->(DataEntity)`
- `(Service)-[:WRITES]->(DataEntity)`
- `(Workflow)-[:USES]->(API)`

### 3.4 Delivery and migration

- `(Feature)-[:DECOMPOSED_INTO]->(Epic)`
- `(Epic)-[:DECOMPOSED_INTO]->(Story)`
- `(Story)-[:DECOMPOSED_INTO]->(WorkPackage)`
- `(Gap)-[:ADDRESSED_BY]->(WorkPackage)`
- `(WorkPackage)-[:DEPENDS_ON]->(WorkPackage)`
- `(WorkPackage)-[:IMPLEMENTS]->(Requirement)`
- `(WorkPackage)-[:CHANGES]->(Artifact)`
- `(WorkPackage)-[:ASSIGNED_TO]->(Agent)`
- `(WorkPackage)-[:VERIFIED_BY]->(Review)`
- `(WorkPackage)-[:PRODUCES]->(Deliverable)`
- `(Deliverable)-[:UPDATES]->(Artifact)`
- `(Deliverable)-[:REALIZES]->(Plateau)`
- `(Plateau)-[:SUPERSEDES]->(Plateau)`
- `(TestCase)-[:VERIFIES]->(AcceptanceCriterion)`
- `(TestSuite)-[:CONTAINS]->(TestCase)`
- `(Artifact)-[:PRODUCES]->(Release)`

### 3.5 Operations and learning

- `(Release)-[:DEPLOYED_AS]->(Deployment)`
- `(Deployment)-[:RUNS_IN]->(Environment)`
- `(Metric)-[:MEASURES]->(Service)`
- `(SLI)-[:DERIVED_FROM]->(Metric)`
- `(SLO)-[:TARGETS]->(SLI)`
- `(Alert)-[:FIRES_ON]->(Metric)`
- `(Incident)-[:AFFECTS]->(Service)`
- `(Incident)-[:TRIGGERED_BY]->(Deployment)`
- `(Postmortem)-[:ANALYZES]->(Incident)`
- `(Postmortem)-[:CREATES]->(WorkPackage)`
- `(Postmortem)-[:UPDATES]->(Assessment)`
- `(CostItem)-[:ATTRIBUTED_TO]->(Service)`

## 4. LadybugDB implementation profile

The ontology in `05-ontology-v0.yaml` remains the conceptual source of truth.

For LadybugDB-backed execution, the implementation schema should be slightly more explicit than the conceptual graph model:

- keep **one node label per table**
- prefer **endpoint-specific relationship table names** when the conceptual ontology reuses a verb across heterogeneous source/target pairs
- derive the executable schema from the ontology, but do not force every conceptual edge name to map 1:1 to a single LadybugDB relationship table

Examples:

- conceptual `IMPLEMENTS` may become `IMPLEMENTS_CAPABILITY` and `IMPLEMENTS_REQUIREMENT`
- conceptual `REALIZES` may become `REALIZES_OUTCOME` and `REALIZES_PLATEAU`
- conceptual `PRODUCES` may become `PRODUCES_DELIVERABLE` and `PRODUCES_RELEASE`
- conceptual `ALLOCATED_TO` may become `ALLOCATED_TO_SERVICE`, `ALLOCATED_TO_COMPONENT`, and similar endpoint-specific tables

This keeps the conceptual model readable while making the executable LadybugDB schema unambiguous and easier to maintain.

## 5. Provenance model

Every important node should be attributable.

Minimum provenance fields:

- `source_uri`
- `source_type`
- `collected_at`
- `collector`
- `extraction_method`
- `confidence`
- `review_status`
- `version`

Useful provenance edges:

- `[:DERIVED_FROM]`
- `[:SUMMARIZES]`
- `[:CITED_BY]`
- `[:SUPERSEDES]`

## 6. Minimal work package fields

Each `WorkPackage` should at least include:

- `id`
- `title`
- `goal`
- `type` (`research`, `spec`, `code`, `test`, `ops`, `review`)
- `scope`
- `inputs`
- `outputs`
- `constraints`
- `acceptance_checks`
- `risk_level`
- `required_tools`
- `required_permissions`
- `estimated_effort`
- `status`

Useful ArchiMate-aligned fields:

- `addresses_gap`
- `target_plateau`
- `produces_deliverable`

## 7. Retrieval patterns the graph should support

The graph should make these questions easy:

1. **Why are we building this feature?**
   - feature -> capability -> outcome -> goal/opportunity -> supporting evidence
2. **Which requirements are not implemented yet?**
   - requirement minus linked work packages/artifacts/tests
3. **Which production incidents map back to product assumptions or architecture decisions?**
   - incident -> deployment/service -> ADR/requirement -> decision/assumption
4. **Can an agent safely take this task?**
   - work package -> permissions, dependencies, constraints, review gates
5. **What changed after an experiment or incident?**
   - result/postmortem -> updated claims, assessments, decisions, requirements, work packages
6. **What gap does this release close, and what target state does it move us toward?**
   - release -> artifact/deliverable -> work package -> gap -> plateau

## 7. Practical implementation notes

- Start with a **labeled property graph** unless semantic-web interoperability is a hard requirement.
- Keep IDs stable and globally unique.
- Store both raw source references and normalized summaries.
- Make relationships directional and semantically tight.
- Treat confidence and review state as first-class metadata.
- Use ArchiMate semantics selectively for **motivation, services, and migration**, not as a substitute for discovery or software-delivery detail.
- Avoid turning every sentence into a node; normalize at the level needed for reasoning and traceability.

## 8. Initial subset to implement first

If you want a narrow MVP, start with these node types only:

- `Evidence`
- `Claim`
- `Opportunity`
- `Goal`
- `Outcome`
- `Capability`
- `Requirement`
- `AcceptanceCriterion`
- `Decision`
- `Service`
- `WorkPackage`
- `Gap`
- `Artifact`
- `TestCase`
- `Release`
- `Metric`
- `Incident`

That subset already enables end-to-end traceability for many product tasks.
