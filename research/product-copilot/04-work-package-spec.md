# Work Package Specification

A **work package** is the atomic unit of autonomous execution.

It should be small enough for an agent to complete safely, but rich enough to preserve context, constraints, and verification rules.

## 1. Purpose

Work packages bridge:

- product intent
- engineering implementation
- governance controls
- agent execution

They are the main mechanism for turning a graph of knowledge into a graph of action.

## 2. Properties of a good work package

A good work package is:

- **bounded** — clear scope and interfaces
- **traceable** — linked to evidence, decisions, requirements, and architecture
- **verifiable** — completion can be checked automatically or by policy-defined review
- **safe** — permissions and risk level are explicit
- **composable** — can sit in a dependency graph with other work packages

## 3. Suggested schema

```yaml
id: WP-0001
title: Add audit logging for workspace member role changes
type: code
objective: >
  Record all workspace role changes so security-sensitive admin actions are traceable.

context:
  business_goal: Improve enterprise trust and support compliance controls.
  linked_goals:
    - GOAL-014
  linked_outcomes:
    - OUT-014
  linked_opportunities:
    - OPP-009
  linked_decisions:
    - DEC-021
  linked_gap:
    - GAP-003
  target_plateau:
    - PLAT-002

inputs:
  requirements:
    - REQ-103
  acceptance_criteria:
    - AC-103.1
    - AC-103.2
  architecture_elements:
    - SVC-auth
    - API-workspace-members
  source_artifacts:
    - services/auth/
    - packages/events/

constraints:
  security:
    - Must not log secrets or tokens
  compliance:
    - Audit records must be immutable for 90 days
  technical:
    - Use existing event bus abstraction

expected_outputs:
  - application code
  - migration if needed
  - tests
  - deliverable record linked in graph
  - docs/update to runbook or ADR if relevant

interfaces:
  touched_components:
    - auth-service
    - event-schema
  external_contracts:
    - WorkspaceMemberRoleChanged event

execution_policy:
  autonomy_level: bounded-execution
  allowed_tools:
    - repo-write
    - test-runner
  forbidden_actions:
    - production deployment
    - schema deletion
  required_reviews:
    - security-review
    - code-review

verification:
  automated_checks:
    - unit tests pass
    - integration tests pass
    - lint passes
  semantic_checks:
    - all acceptance criteria linked to tests
    - no sensitive fields logged

dependencies:
  blocks: []
  depends_on:
    - WP-0000

risk:
  level: medium
  failure_modes:
    - noisy logs
    - incomplete audit coverage
    - schema mismatch

handoff:
  next_packages:
    - WP-0002
  escalation_rules:
    - escalate if event schema change breaks downstream consumers

status: ready
```

## 4. Required fields

Every work package should include at least:

- `id`
- `title`
- `type`
- `objective`
- `linked goals/outcomes`
- `linked requirements`
- `linked architecture elements`
- `linked gap` and optional `target plateau`
- `constraints`
- `expected outputs`
- `verification rules`
- `dependencies`
- `risk level`
- `execution policy`
- `status`

## 5. Work package types

Use a small controlled vocabulary.

| Type | Purpose |
|---|---|
| `research` | collect and synthesize evidence |
| `decision` | compare options and propose a choice |
| `spec` | produce requirements, API specs, architecture docs |
| `code` | implement or refactor code |
| `test` | create or improve verification assets |
| `ops` | change deployment, observability, runbooks, or reliability configuration |
| `review` | inspect artifacts for quality, policy, or security |
| `migration` | move data, contracts, or infrastructure safely |

## 6. Definition of ready

A work package is **ready** when:

- objective is clear
- inputs are available
- dependencies are resolved or explicit
- acceptance criteria are testable
- authority boundaries are defined
- risk is understood

## 7. Definition of done

A work package is **done** when:

- expected outputs are produced
- required checks pass
- trace links are updated
- required reviews are completed
- downstream packages can consume the result

## 8. How work packages should be generated

The planner should derive them from the graph in this order:

1. opportunity, goal, and outcome
2. decisions, principles, and constraints
3. requirements and acceptance criteria
4. architecture allocation
5. gap and target plateau identification
6. dependency analysis
7. risk classification
8. execution policy assignment

## 9. Rules for safe autonomous execution

An agent may execute automatically only if:

- the package has no unresolved ambiguity
- required permissions are available
- all destructive actions are disallowed or explicitly approved
- rollback or recovery path exists
- verification is automatable or policy-approved

Require human approval when:

- pricing or strategy changes are involved
- legal/compliance interpretation is uncertain
- customer-visible behavior changes materially
- production data may be damaged or exposed
- architecture boundaries are being redefined

## 10. Why work packages matter here

For a dark factory model, work packages are the control surface that lets you:

- decouple discovery from execution
- keep agents within safe bounds
- measure throughput and quality
- preserve traceability from business intent to code and operations
