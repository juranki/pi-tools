# Taxonomy Foundations

This document answers the question: **which existing standards and methodologies can provide a coherent taxonomy for refining a SaaS product from idea to system in operation?**

## 1. Recommended approach

Do not rely on a single framework.

Use:

- **standards for stable structure and terminology**
- **methods for discovery and decision-making**
- **enterprise architecture semantics for cross-layer traceability**
- **engineering practices for implementation and operation**

A practical stack is:

- **Lifecycle backbone**: ISO/IEC/IEEE 12207, ISO/IEC/IEEE 15288
- **Requirements**: ISO/IEC/IEEE 29148
- **Architecture**: ISO/IEC/IEEE 42010
- **EA/traceability layer**: ArchiMate
- **Quality model**: ISO/IEC 25010
- **Security/dev security**: NIST SSDF, ISO 27001, OWASP ASVS/SAMM
- **Service operation**: SRE, ITIL, DORA metrics, FinOps
- **Discovery/strategy overlays**: Lean Startup, JTBD, Design Thinking, Wardley Mapping, Opportunity Solution Tree, Agile/DDD

## 2. Standards backbone

These are the most useful formal anchors.

| Standard / body of practice | What it contributes | Why it matters for a product copilot |
|---|---|---|
| **ISO/IEC/IEEE 12207** Software life cycle processes | Process taxonomy for software lifecycle activities | Strong backbone for software work from concept through maintenance |
| **ISO/IEC/IEEE 15288** System life cycle processes | Broader system lifecycle view | Useful when the SaaS includes people, process, integrations, and operations as a system |
| **ISO/IEC/IEEE 29148** Requirements engineering | Requirement types, quality, structure, traceability | Essential for turning product ideas into machine-manageable requirements |
| **ISO/IEC/IEEE 42010** Architecture description | Stakeholders, concerns, viewpoints, architecture decisions | Good basis for architecture knowledge in a graph |
| **ArchiMate (The Open Group)** | Cross-layer enterprise modeling language spanning motivation, strategy, business, application, technology, and implementation/migration | Useful for linking goals, capabilities, services, architecture elements, work packages, and target states |
| **ISO/IEC 25010** Systems/software quality model | Quality characteristics such as reliability, security, usability, maintainability | Helps agents reason about non-functional requirements consistently |
| **NIST SSDF** Secure Software Development Framework | Secure development practices | Useful for autonomous build pipelines and work package controls |
| **ISO/IEC 27001** Information security management | Security governance and controls | Important for SaaS operating in production |
| **OWASP ASVS / SAMM** App security verification / maturity model | Concrete security requirements and practices | Strong source for security acceptance criteria |
| **ITIL** Service management | Incident, change, service operations concepts | Useful for post-release operational taxonomy |
| **DORA metrics** | Delivery performance measures | Useful for measuring autonomous delivery effectiveness |
| **FinOps framework** | Cloud cost management | Important for SaaS unit economics and operational optimization |

## 3. Methodology overlays

These are not always formal standards, but they are essential for the upstream part that standards usually underspecify.

| Methodology | Best use | Concepts to extract |
|---|---|---|
| **Lean Startup** | Early-stage product discovery | hypotheses, experiments, MVP, learning loop |
| **Design Thinking** | Problem exploration and user understanding | personas, pain points, ideation, prototype, test |
| **Jobs To Be Done (JTBD)** | Demand-side customer understanding | job, context, struggle, desired outcome, switching forces |
| **Wardley Mapping** | Strategic positioning | user needs, value chain, evolution stage, strategic moves |
| **Business Model Canvas / Lean Canvas** | Business viability | segments, value proposition, channels, costs, revenues |
| **Opportunity Solution Tree** | Linking outcomes to opportunities and solutions | outcome, opportunity, solution experiment |
| **Agile / Scrum / Kanban** | Iterative delivery and flow | backlog item, increment, iteration, WIP, service class |
| **User Story Mapping** | Scope and release planning | activities, tasks, slices, release boundary |
| **Domain-Driven Design (DDD)** | Domain and service boundaries | bounded context, aggregate, ubiquitous language, domain event |
| **Event Storming** | Collaborative domain discovery | events, commands, actors, policies, hotspots |
| **DevOps** | Build-to-run continuity | automation, CI/CD, feedback loops, shared ownership |
| **Site Reliability Engineering (SRE)** | Production reliability | SLI, SLO, error budget, toil, incident response |

## 4. EA/traceability overlay: where ArchiMate helps

ArchiMate should not replace the whole taxonomy. It is most useful as a **mid-layer semantic spine** between discovery and implementation.

### 4.1 What it adds

Highest-value concepts to import:

- **Driver**
- **Assessment**
- **Goal**
- **Outcome**
- **Principle**
- **Course of Action**
- **Value Stream**
- **Capability**
- **Business Service**
- **Application Service**
- **Technology Service**
- **Work Package**
- **Deliverable**
- **Plateau**
- **Gap**

### 4.2 Why it is useful here

ArchiMate is especially helpful for:

- connecting **why** a change is needed to **what** must be built
- normalizing **capability-based planning**
- distinguishing **business**, **application**, and **technology** services
- modeling **transition states** and migration steps
- making **work packages** part of a formal change model instead of only a task list

### 4.3 What it does not solve well

ArchiMate is weak for:

- market and customer evidence collection
- JTBD-style demand modeling
- contradictory evidence and confidence handling
- detailed software design, API contracts, and test structure
- autonomous execution controls such as tool permissions and escalation rules
- runtime reliability detail such as alerts, telemetry cardinality, and incident workflows

So the right pattern is:

- **discovery ontology** upstream
- **ArchiMate-like traceability layer** in the middle
- **engineering and operations models** downstream

## 5. A coherent lifecycle taxonomy

The following taxonomy works well for a graph-backed product copilot.

### 5.1 Opportunity layer

Purpose: identify where to play.

Core entities:

- market
- segment
- competitor
- trend
- signal
- customer type
- stakeholder
- problem space
- opportunity
- strategic bet

Useful source methods:

- JTBD
- Lean Startup
- Wardley Mapping
- Design Thinking

### 5.2 Evidence layer

Purpose: capture why the system believes something.

Core entities:

- source
- evidence item
- observation
- claim
- confidence
- contradiction
- assumption
- experiment
- result
- decision

Useful source methods:

- Lean Startup
- discovery interviewing
- analytics review
- competitor research

### 5.3 Motivation and strategy layer

Purpose: translate evidence into a normalized change rationale.

Core entities:

- driver
- assessment
- goal
- outcome
- principle
- course of action
- value stream
- capability
- business service

Useful source standards/methods:

- ArchiMate motivation and strategy concepts
- Opportunity Solution Tree
- Business Model Canvas
- Wardley Mapping

### 5.4 Product definition layer

Purpose: define what value will be delivered.

Core entities:

- persona or actor
- JTBD job
- use case
- journey
- desired outcome
- KPI / metric
- feature
- policy
- pricing element
- release target

Useful source methods:

- Opportunity Solution Tree
- Business Model Canvas
- User Story Mapping

### 5.5 Requirements layer

Purpose: make solution intent executable and testable.

Core entities:

- business requirement
- stakeholder requirement
- system requirement
- functional requirement
- quality attribute requirement
- constraint
- acceptance criterion
- risk
- dependency
- trace link

Useful source standards:

- ISO/IEC/IEEE 29148
- ISO/IEC 25010
- OWASP ASVS

### 5.6 Architecture layer

Purpose: define the structure of the solution.

Core entities:

- bounded context
- application service
- technology service
- service
- component
- interface
- API
- data object
- event
- workflow
- architecture decision record
- deployment unit
- environment

Useful source standards/methods:

- ISO/IEC/IEEE 42010
- ArchiMate application/technology layers
- DDD
- Event Storming
- C4 model

### 5.7 Delivery and migration layer

Purpose: turn requirements and architecture into executable change plans.

Core entities:

- epic
- story
- task
- work package
- deliverable
- agent assignment
- prerequisite
- artifact
- test suite
- gate
- review
- gap
- plateau

Useful source methods:

- ArchiMate implementation and migration concepts
- Agile
- Kanban
- DevOps
- autonomous agent orchestration practices

### 5.8 Operations layer

Purpose: run and improve the system in production.

Core entities:

- release
- deployment
- change
- service level indicator
- service level objective
- alert
- incident
- runbook
- cost center
- usage metric
- support issue
- postmortem

Useful source practices:

- SRE
- ITIL
- DORA
- FinOps

### 5.9 Governance layer

Purpose: ensure controlled autonomy.

Core entities:

- approval policy
- compliance requirement
- control
- data classification
- audit record
- provenance link
- model/tool authorization
- human decision point

Useful source standards:

- NIST SSDF
- ISO 27001
- SOC 2 style control sets
- internal engineering governance

## 6. Merged taxonomy: discovery + ArchiMate + delivery/ops

A practical merged model looks like this.

| Layer | Primary sources | Normalized concepts |
|---|---|---|
| **Discovery** | JTBD, Lean Startup, interviews, competitor research, analytics | signal, evidence, claim, assumption, opportunity |
| **Motivation/strategy** | ArchiMate motivation + strategy, OST, business model methods | driver, assessment, goal, outcome, principle, course of action, value stream, capability |
| **Product definition** | story mapping, product strategy methods | actor, job, journey, feature, KPI, policy, release target |
| **Requirements/architecture** | 29148, 42010, ArchiMate, DDD, C4 | requirement, constraint, business service, application service, technology service, bounded context, component, API, event |
| **Delivery/migration** | ArchiMate implementation & migration, Agile, DevOps | work package, deliverable, dependency, gap, plateau, review gate |
| **Operations/learning** | SRE, ITIL, DORA, FinOps | deployment, metric, SLI, SLO, incident, postmortem, cost item, feedback signal |

This layered merge is a good fit for a dark factory because it preserves the full chain:

**market evidence -> strategic rationale -> product intent -> system design -> autonomous work -> running service -> feedback**

## 7. Recommended canonical terms

If you need one normalized vocabulary for the graph, use these top-level terms:

- **Signal** — raw external or internal observation
- **Evidence** — normalized supporting material with provenance
- **Claim** — a statement inferred from evidence
- **Assumption** — an unproven but decision-relevant belief
- **Driver** — a reason for change grounded in evidence or context
- **Assessment** — interpretation of a driver or current state
- **Goal** — desired state to be achieved
- **Opportunity** — a valuable problem space worth exploring
- **Outcome** — measurable business or user result
- **Principle** — durable rule that guides solution choices
- **Value Stream** — end-to-end flow that creates value for a stakeholder
- **Capability** — what the product/system must enable
- **Requirement** — testable expression of needed behavior or constraint
- **Decision** — chosen direction with rationale
- **Service** — externally meaningful behavior, specialized as business/application/technology service where useful
- **Architecture Element** — structural part of the system
- **Gap** — difference between current and target state
- **Plateau** — stable current or target architecture state
- **Work Package** — atomic unit of autonomous execution
- **Deliverable** — formal output produced by a work package
- **Artifact** — produced asset such as code, spec, test, or document
- **Release** — deployable product state
- **Operational Signal** — runtime feedback, incident, usage, cost, reliability data

## 8. Why this works for a dark factory

This taxonomy supports:

- **traceability** from market signal to production metric
- **agent routing** because each phase has distinct object types and tasks
- **controlled autonomy** because work packages can inherit constraints and acceptance criteria
- **change planning** because gaps, plateaus, and deliverables can be modeled explicitly
- **continuous learning** because operational evidence can update assumptions and strategy

## 9. Gaps to research next

1. Which domain-specific regulations apply to target SaaS categories?
2. Which ontology shape is best: labeled property graph, RDF/OWL, or hybrid?
3. How should trust/confidence be represented across evidence and claims?
4. What approval model is needed for autonomous code and infrastructure changes?
5. Which ArchiMate subset is actually worth operationalizing in a product-development graph?
6. Which parts of 12207/15288 are useful operationally, and which are too heavyweight?
