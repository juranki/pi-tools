# Agent Skills by Phase

This document answers: **what skills does the agentic assistant need to support product development in different phases?**

## 1. Design principle

A single general-purpose agent is not enough.

The product copilot should be modeled as a **skill mesh**:

- phase-specific specialist skills
- cross-cutting governance and knowledge skills
- orchestration skills for planning and delegation
- verification skills to prevent low-trust actions

## 2. Skills by lifecycle phase

| Phase | Skill | What it does | Typical inputs | Typical outputs |
|---|---|---|---|---|
| Opportunity sensing | **Market intelligence** | collects market signals, trends, competitors, adjacent tools | web/docs, analyst notes, pricing pages, changelogs | market map, trend summary, competitor profiles |
| Opportunity sensing | **Segment analysis** | defines ICPs, customer segments, and niches | sales notes, research, product usage | segment definitions, priority segments |
| Opportunity sensing | **Voice-of-customer synthesis** | clusters pain points and demand signals | interviews, tickets, forum posts, reviews | pain themes, demand clusters, evidence links |
| Problem framing | **JTBD modeling** | converts user narratives into jobs, desired outcomes, and constraints | interviews, workflows, support cases | JTBD statements, forces diagram, job map |
| Problem framing | **Problem framing** | turns raw insights into clear problem statements | evidence graph, customer signals | problem statements, assumptions, risk list |
| Problem framing | **Opportunity ranking** | scores opportunities by value, urgency, evidence strength, and fit | opportunities, strategy, constraints | ranked opportunity list |
| Product strategy | **Outcome and KPI design** | defines success measures and leading indicators | goals, market context, business model | KPI tree, success metrics, guardrails |
| Product strategy | **Business model analysis** | tests viability of pricing, channels, and costs | cost assumptions, market, segment data | pricing hypotheses, economic model |
| Product strategy | **Roadmapping and prioritization** | sequences bets and release slices | opportunities, dependencies, capacity | roadmap options, priorities, trade-offs |
| Solution shaping | **Concept generation** | proposes solution alternatives | problem statements, jobs, constraints | solution concepts, experiments |
| Solution shaping | **Experiment design** | defines MVPs and tests for risky assumptions | hypotheses, success metrics | experiment plan, expected evidence |
| Requirements | **Requirements engineering** | turns product intent into structured requirements | outcomes, solution concepts, policies | requirement set with traceability |
| Requirements | **Acceptance criteria generation** | makes work testable and automatable | requirements, quality attributes | acceptance criteria, test scenarios |
| Requirements | **Constraint extraction** | identifies legal, security, platform, and business constraints | policies, architecture, contracts | constraint catalog |
| Requirements | **Quality attribute analysis** | derives performance, reliability, security, usability needs | product context, risk model | NFR set, quality scenarios |
| Architecture | **Domain modeling** | identifies bounded contexts, core entities, workflows | requirements, language, event flows | domain model, context map |
| Architecture | **Solution architecture** | proposes components, interfaces, and deployment structure | requirements, domain model, constraints | architecture options, target design |
| Architecture | **Data and API design** | defines schemas, contracts, integration points | domain model, use cases | API specs, event schemas, data models |
| Architecture | **Decision analysis** | compares architecture options and records rationale | options, constraints, risks | ADRs, recommendation |
| Delivery planning | **Work package decomposition** | breaks objectives into autonomous packages | requirements, architecture, dependencies | work package graph |
| Delivery planning | **Dependency and sequencing analysis** | finds blockers and parallelizable work | work packages, codebase, interfaces | DAG, critical path |
| Delivery planning | **Agent routing** | assigns work to the right specialist agents | package metadata, policies | execution plan, assignment map |
| Delivery planning | **Estimation and risk planning** | predicts effort, uncertainty, and review needs | work packages, history, risk | effort ranges, review gates |
| Build | **Code implementation** | writes or changes code | work package, repo context, tests | commits/patches |
| Build | **Test generation** | creates unit, integration, contract, and end-to-end tests | requirements, code, interfaces | test suites |
| Build | **Documentation generation** | keeps specs, runbooks, and ADRs current | code, decisions, deployment model | docs, change notes |
| Verification | **Code review** | checks correctness, maintainability, style, and boundary conditions | diff, requirements, tests | review findings |
| Verification | **Security review** | checks common vulnerabilities and control requirements | code, architecture, secrets usage | security findings, required fixes |
| Verification | **Traceability audit** | verifies every implementation maps back to requirement and evidence | graph data, diffs, test results | trace report |
| Release | **Release planning** | prepares deployable slices, rollout strategy, and rollback plans | changes, environments, dependencies | release package |
| Release | **CI/CD orchestration** | manages build, gates, packaging, and deployment automation | code, infra config, policies | pipeline runs, deployment status |
| Operate | **Observability design** | defines metrics, logs, traces, dashboards, and alerts | architecture, KPIs, SLOs | observability config |
| Operate | **Incident triage** | analyzes failures and routes remediation | alerts, logs, incidents, recent changes | diagnosis, remediation tasks |
| Operate | **SRE analysis** | manages SLOs, error budgets, toil, and reliability investment | telemetry, incidents, service levels | reliability recommendations |
| Operate | **FinOps analysis** | evaluates cost drivers and optimization actions | billing, infra topology, traffic | cost insights, optimization plan |
| Learn/adapt | **Experiment analysis** | interprets results and updates confidence | experiment data, KPIs | learned outcomes, updated claims |
| Learn/adapt | **Feedback synthesis** | rolls up support, usage, and churn signals | tickets, analytics, surveys | backlog candidates, priority shifts |
| Learn/adapt | **Strategic re-planning** | updates bets based on new evidence | portfolio, metrics, incidents | revised roadmap |

## 3. Cross-cutting skills

These are always needed, independent of phase.

| Skill | Purpose |
|---|---|
| **Knowledge graph curation** | maintain entities, relationships, IDs, provenance, and deduplication |
| **Source ingestion and normalization** | transform messy external/internal inputs into structured graph objects |
| **Provenance tracking** | preserve where every claim, requirement, and decision came from |
| **Contradiction detection** | identify conflicts across sources, decisions, and implementation |
| **Decision logging** | keep ADRs, trade-offs, approvals, and rationale queryable |
| **Policy enforcement** | apply security, compliance, and autonomy constraints |
| **Tool-use planning** | choose tools, repos, environments, and models appropriately |
| **Human-in-the-loop routing** | escalate decisions that exceed agent authority |
| **Confidence estimation** | score uncertainty and determine when more evidence is needed |
| **Memory management** | summarize context while preserving traceability |

## 4. Meta-skills required for autonomous operation

These make the assistant trustworthy, not just capable.

### 4.1 Decomposition

Ability to turn vague goals into:

- hypotheses
- decisions to make
- information to collect
- constraints to respect
- work packages to execute

### 4.2 Verification

Ability to check:

- factual grounding
- internal consistency
- test coverage
- policy compliance
- completion against acceptance criteria

### 4.3 Coordination

Ability to:

- manage dependencies between agents
- merge partial outputs
- detect blocking ambiguity
- reschedule around failures

### 4.4 Self-limitation

Ability to know when not to act autonomously:

- unclear business intent
- legal or compliance uncertainty
- destructive infrastructure changes
- material UX or pricing decisions
- high-cost or irreversible operations

## 5. Recommended skill families for an initial implementation

A practical first version could start with 8 skill families.

1. **Research analyst**
   - market, competitor, trend, customer evidence
2. **Product analyst**
   - JTBD, problem framing, KPI design, prioritization
3. **Requirements engineer**
   - requirements, constraints, acceptance criteria, traceability
4. **Architect**
   - domain model, service boundaries, APIs, ADRs
5. **Planner/orchestrator**
   - work package generation, dependency graph, agent assignment
6. **Builder**
   - code, tests, docs, refactors
7. **Verifier**
   - review, security, policy, traceability, quality gates
8. **Operator**
   - release, telemetry, incident response, reliability, cost analysis

## 6. Capability maturity ladder

Use this ladder when deciding how much autonomy to allow.

### Level 0 — Assistive

- summarizes and suggests
- no state-changing actions

### Level 1 — Drafting

- produces research notes, specs, code patches, and plans
- human approves before execution

### Level 2 — Bounded execution

- executes low-risk work packages automatically
- strict policy checks and rollback paths

### Level 3 — Managed autonomy

- coordinates multiple agents across build/test/release
- human reviews only policy-defined exceptions

### Level 4 — Closed-loop optimization

- uses production feedback to trigger discovery, prioritization, and implementation cycles
- still constrained by governance and approval rules

## 7. Evaluation questions

Use these to assess whether a skill is actually useful.

- Can it cite its evidence?
- Can it explain confidence and uncertainty?
- Can it preserve traceability to upstream decisions?
- Can it produce outputs in machine-readable form?
- Can it detect when it lacks authority or context?
- Can another agent safely consume its output?
