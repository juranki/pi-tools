# Query intents

Use this file when selecting the smallest useful retrieval pattern.

## Intent -> seed object -> preferred retrieval

### Explain a feature

Seed:
- `Feature`

Retrieve:
- feature -> capability -> outcome -> opportunity -> claim -> evidence
- feature -> requirement -> work package -> release/metric if relevant

### Audit requirement coverage

Seed:
- `Requirement`
- optionally a status filter

Retrieve:
- acceptance criteria
- allocated architecture elements
- work packages
- tests
- release links

### Prepare an agent execution context

Seed:
- `WorkPackage`

Retrieve:
- linked requirements
- linked goals
- creating decisions
- supporting evidence
- architecture allocation
- dependencies and blocked prerequisites

### Analyze incident causality

Seed:
- `Incident`

Retrieve:
- affected service
- triggering deployment or alert
- ADRs and decisions linked via services/requirements
- assumptions or risks related to the decision chain
- postmortem and created work packages

### Explain a release

Seed:
- `Release`

Retrieve:
- artifacts
- work packages
- gaps addressed
- deliverables
- plateau realized
- incidents triggered afterward

## Answer discipline

Always answer in this order:

1. direct answer
2. evidence-bearing trace
3. missing links
4. recommended next retrieval
