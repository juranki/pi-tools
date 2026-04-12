// Product Copilot LadybugDB sample data
// Purpose: provide a compact, connected fixture dataset for the MVP schema.
// Assumes the schema from 06-ladybugdb-schema.cypher has already been applied.
// Suggested load order:
//   1. 06-ladybugdb-schema.cypher
//   2. 08-ladybugdb-sample-data.cypher
//   3. 07-ladybugdb-query-patterns.cypher
//
// Domain: hypothetical B2B SaaS workspace platform adding enterprise auditability.
// Notes:
// - this dataset is intentionally smaller than the archived Memgraph sample
// - it is designed to exercise bounded retrieval patterns, not to cover the
//   entire ontology

// -----------------------------------------------------------------------------
// Nodes: evidence, strategy, and product intent
// -----------------------------------------------------------------------------
CREATE (:Evidence {
  id: 'EVD-001',
  title: 'Enterprise buyers require auditable admin actions',
  status: 'accepted',
  summary: 'Normalized evidence that privileged admin actions need durable traceability.',
  confidence: 'high',
  review_status: 'approved'
});

CREATE (:Evidence {
  id: 'EVD-002',
  title: 'Admins must export role-change history for compliance reviews',
  status: 'accepted',
  summary: 'Interview-based evidence that downloadable audit history matters in compliance workflows.',
  confidence: 'high',
  review_status: 'approved'
});

CREATE (:Evidence {
  id: 'EVD-003',
  title: 'Audit export remains a recurring support request',
  status: 'accepted',
  summary: 'Support evidence that exportability still causes friction.',
  confidence: 'medium',
  review_status: 'approved'
});

CREATE (:Claim {
  id: 'CLM-001',
  title: 'Workspace admin auditability is table stakes for regulated buyers',
  status: 'active',
  summary: 'The product needs durable role-change records to compete in regulated segments.',
  confidence: 'high'
});

CREATE (:Claim {
  id: 'CLM-002',
  title: 'Exportable audit history is part of compliance readiness',
  status: 'active',
  summary: 'Users need downloadable audit history for review and evidence workflows.',
  confidence: 'medium'
});

CREATE (:Opportunity {
  id: 'OPP-001',
  title: 'Unlock enterprise adoption with admin auditability',
  status: 'planned',
  summary: 'Opportunity centered on traceable administrative actions.',
  priority: 'high',
  confidence: 'high'
});

CREATE (:Opportunity {
  id: 'OPP-002',
  title: 'Reduce compliance review friction with audit exports',
  status: 'planned',
  summary: 'Opportunity focused on exportable audit history.',
  priority: 'medium',
  confidence: 'medium'
});

CREATE (:Outcome {
  id: 'OUT-001',
  title: 'Every role change produces a searchable audit event',
  status: 'in_progress',
  metric_definition: 'percentage of role changes with a corresponding audit event available for query',
  target_value: '100%',
  current_value: '99.2%'
});

CREATE (:Outcome {
  id: 'OUT-002',
  title: 'Admins can export 90 days of audit history within two minutes',
  status: 'planned',
  metric_definition: 'time to complete 90-day audit export job',
  target_value: '<= 2m',
  current_value: 'not available'
});

CREATE (:Capability {
  id: 'CAP-001',
  title: 'Workspace administration auditability',
  status: 'in_progress',
  priority: 'high',
  owner_team: 'product-platform'
});

CREATE (:Capability {
  id: 'CAP-002',
  title: 'Audit history export',
  status: 'planned',
  priority: 'medium',
  owner_team: 'product-platform'
});

CREATE (:Feature {
  id: 'FEAT-001',
  title: 'Workspace role audit trail',
  status: 'in_progress',
  priority: 'high',
  user_impact: 'Admins can investigate who changed access and when.',
  summary: 'Adds a durable audit trail for workspace role changes.'
});

CREATE (:Feature {
  id: 'FEAT-002',
  title: 'Audit log CSV export',
  status: 'planned',
  priority: 'medium',
  user_impact: 'Admins can export audit history for compliance workflows.',
  summary: 'Adds asynchronous CSV export for audit history.'
});

CREATE (:Goal {
  id: 'GOAL-001',
  title: 'Achieve enterprise-ready admin auditability',
  status: 'in_progress',
  priority: 'high',
  owner_team: 'product-platform'
});

CREATE (:Goal {
  id: 'GOAL-002',
  title: 'Enable self-serve compliance evidence export',
  status: 'planned',
  priority: 'medium',
  owner_team: 'product-platform'
});

// -----------------------------------------------------------------------------
// Nodes: requirements, architecture, and execution
// -----------------------------------------------------------------------------
CREATE (:Requirement {
  id: 'REQ-001',
  title: 'Emit immutable audit event on workspace role change',
  status: 'implemented',
  requirement_kind: 'security',
  priority: 'high',
  risk_level: 'high',
  rationale: 'Role changes affect access and must be durably captured.'
});

CREATE (:Requirement {
  id: 'REQ-002',
  title: 'Retain audit records for at least 90 days',
  status: 'approved',
  requirement_kind: 'compliance',
  priority: 'high',
  risk_level: 'medium',
  rationale: 'Buyers require historical evidence over a meaningful compliance window.'
});

CREATE (:Requirement {
  id: 'REQ-003',
  title: 'Allow tenant admins to filter audit history by actor and date range',
  status: 'approved',
  requirement_kind: 'functional',
  priority: 'medium',
  risk_level: 'low',
  rationale: 'Audit logs must be navigable for investigation workflows.'
});

CREATE (:Requirement {
  id: 'REQ-004',
  title: 'Provide asynchronous CSV export of audit history',
  status: 'approved',
  requirement_kind: 'functional',
  priority: 'medium',
  risk_level: 'medium',
  rationale: 'Admins need portable audit evidence without degrading interactive performance.'
});

CREATE (:Requirement {
  id: 'REQ-005',
  title: 'Show export job progress and completion status',
  status: 'approved',
  requirement_kind: 'functional',
  priority: 'low',
  risk_level: 'low',
  rationale: 'Users need feedback when long-running export jobs are processing.'
});

CREATE (:AcceptanceCriterion {
  id: 'AC-001',
  title: 'Role change emits audit event with actor, target, previous role, new role, and timestamp',
  status: 'verified',
  expression: 'For every successful role change, one corresponding audit event exists with required fields.'
});

CREATE (:AcceptanceCriterion {
  id: 'AC-002',
  title: 'Audit records remain queryable for ninety days',
  status: 'approved',
  expression: 'Audit records are accessible for the full retention window.'
});

CREATE (:AcceptanceCriterion {
  id: 'AC-004',
  title: 'Admins can request CSV export of 90-day audit history',
  status: 'approved',
  expression: 'Export job can be initiated and produces downloadable CSV output.'
});

CREATE (:AcceptanceCriterion {
  id: 'AC-005',
  title: 'Export page shows pending, running, and completed states',
  status: 'approved',
  expression: 'Users see current progress state for asynchronous export jobs.'
});

CREATE (:Decision {
  id: 'DEC-001',
  title: 'Adopt event-based audit logging for role changes',
  status: 'accepted',
  rationale: 'Event emission provides an immutable trace with lower coupling than synchronous logging in every consumer.',
  owner: 'platform-architecture',
  priority: 'high'
});

CREATE (:Decision {
  id: 'DEC-002',
  title: 'Implement asynchronous CSV export jobs for audit history',
  status: 'accepted',
  rationale: 'Background export jobs can handle larger history windows without degrading interactive admin workflows.',
  owner: 'product-engineering',
  priority: 'medium'
});

CREATE (:Assumption {
  id: 'ASMPT-001',
  title: 'Sub-minute asynchronous propagation is acceptable for audit logs',
  status: 'active',
  summary: 'Admins will accept small propagation delay if records are complete and immutable.',
  confidence: 'medium'
});

CREATE (:Service {
  id: 'SVC-001',
  title: 'auth-service',
  status: 'active',
  owner_team: 'product-platform',
  summary: 'Handles workspace membership and role changes.'
});

CREATE (:ADR {
  id: 'ADR-001',
  title: 'ADR-001 Event-sourced audit trail',
  status: 'accepted',
  rationale: 'Use domain events from the auth service as the canonical source for audit records.',
  summary: 'Architecture decision for the audit trail pipeline.'
});

CREATE (:WorkPackage {
  id: 'WP-001',
  title: 'Emit audit events for role changes',
  status: 'done',
  work_package_type: 'code',
  objective: 'Implement immutable audit event emission in auth-service when workspace roles change.',
  autonomy_level: 'bounded_execution',
  risk_level: 'medium',
  owner: 'builder-agent',
  allowed_tools: ['repo-write', 'test-runner'],
  acceptance_checks: ['unit tests pass', 'integration tests pass', 'event schema validates'],
  required_permissions: ['repo-write']
});

CREATE (:WorkPackage {
  id: 'WP-003',
  title: 'Add asynchronous CSV audit export endpoint',
  status: 'ready',
  work_package_type: 'code',
  objective: 'Create the API and job orchestration for asynchronous export of audit history.',
  autonomy_level: 'bounded_execution',
  risk_level: 'medium',
  owner: 'builder-agent',
  allowed_tools: ['repo-write', 'test-runner'],
  acceptance_checks: ['contract tests pass', 'integration tests pass'],
  required_permissions: ['repo-write']
});

CREATE (:WorkPackage {
  id: 'WP-004',
  title: 'Add export progress UI states',
  status: 'ready',
  work_package_type: 'code',
  objective: 'Expose and render export job progress states for administrators.',
  autonomy_level: 'bounded_execution',
  risk_level: 'low',
  owner: 'builder-agent',
  allowed_tools: ['repo-write', 'test-runner'],
  acceptance_checks: ['ui tests pass', 'state transitions render correctly'],
  required_permissions: ['repo-write']
});

CREATE (:WorkPackage {
  id: 'WP-005',
  title: 'Harden audit worker restart handling',
  status: 'backlog',
  work_package_type: 'ops',
  objective: 'Prevent audit event loss during worker restarts and replay missed messages.',
  autonomy_level: 'drafting',
  risk_level: 'high',
  owner: 'operator-agent',
  allowed_tools: ['repo-read', 'log-reader'],
  acceptance_checks: ['replay test passes', 'no event loss in restart simulation'],
  required_permissions: ['repo-read']
});

CREATE (:Artifact {
  id: 'ART-001',
  title: 'auth-service audit logging code',
  status: 'active',
  artifact_kind: 'code',
  version: '2026.09.0',
  external_ref: 'git://repo/services/auth-service'
});

CREATE (:Gap {
  id: 'GAP-001',
  title: 'Workspace role changes are not historically traceable',
  status: 'identified',
  priority: 'high',
  rationale: 'The current product cannot reconstruct who changed access over time.'
});

CREATE (:Deliverable {
  id: 'DEL-001',
  title: 'Audit trail MVP deliverable',
  status: 'completed',
  artifact_kind: 'code',
  version: '2026.09.0'
});

CREATE (:Plateau {
  id: 'PLAT-001',
  title: 'Audit trail MVP in production',
  status: 'completed',
  version: '2026-Q3'
});

CREATE (:Release {
  id: 'REL-001',
  title: '2026.09 audit trail release',
  status: 'released',
  version: '2026.09.0',
  owner_team: 'product-platform'
});

CREATE (:Metric {
  id: 'MET-001',
  title: 'Audit event coverage metric',
  status: 'active',
  metric_kind: 'security',
  metric_definition: 'ratio of successful role changes with a corresponding audit event',
  formula: 'audit_events / role_changes',
  current_value: '99.2%'
});

CREATE (:Incident {
  id: 'INC-001',
  title: 'Audit events dropped during worker restart',
  status: 'reviewed',
  risk_level: 'high',
  owner_team: 'product-platform',
  blast_radius: 'Some privileged role changes lacked durable audit records.'
});

CREATE (:Incident {
  id: 'INC-002',
  title: 'Export backlog spike without documented review',
  status: 'reviewed',
  risk_level: 'medium',
  owner_team: 'product-platform',
  blast_radius: 'Delayed export completion for compliance workflows.'
});

CREATE (:Postmortem {
  id: 'PM-001',
  title: 'Postmortem for audit event loss on restart',
  status: 'active',
  owner_team: 'product-platform',
  rationale: 'Restart sequencing allowed consumers to miss in-flight audit messages.'
});

// -----------------------------------------------------------------------------
// Relationships: rationale and strategy trace
// -----------------------------------------------------------------------------
MATCH (ev1:Evidence {id: 'EVD-001'}), (clm1:Claim {id: 'CLM-001'}) CREATE (ev1)-[:SUPPORTS_CLAIM]->(clm1);
MATCH (ev2:Evidence {id: 'EVD-002'}), (clm1:Claim {id: 'CLM-001'}) CREATE (ev2)-[:SUPPORTS_CLAIM]->(clm1);
MATCH (ev3:Evidence {id: 'EVD-003'}), (clm2:Claim {id: 'CLM-002'}) CREATE (ev3)-[:SUPPORTS_CLAIM]->(clm2);

MATCH (clm1:Claim {id: 'CLM-001'}), (opp1:Opportunity {id: 'OPP-001'}) CREATE (clm1)-[:IMPLIES_OPPORTUNITY]->(opp1);
MATCH (clm2:Claim {id: 'CLM-002'}), (opp2:Opportunity {id: 'OPP-002'}) CREATE (clm2)-[:IMPLIES_OPPORTUNITY]->(opp2);

MATCH (opp1:Opportunity {id: 'OPP-001'}), (out1:Outcome {id: 'OUT-001'}) CREATE (opp1)-[:PURSUES_OUTCOME]->(out1);
MATCH (opp2:Opportunity {id: 'OPP-002'}), (out2:Outcome {id: 'OUT-002'}) CREATE (opp2)-[:PURSUES_OUTCOME]->(out2);

MATCH (cap1:Capability {id: 'CAP-001'}), (out1:Outcome {id: 'OUT-001'}) CREATE (cap1)-[:REALIZES_OUTCOME]->(out1);
MATCH (cap2:Capability {id: 'CAP-002'}), (out2:Outcome {id: 'OUT-002'}) CREATE (cap2)-[:REALIZES_OUTCOME]->(out2);

MATCH (feat1:Feature {id: 'FEAT-001'}), (cap1:Capability {id: 'CAP-001'}) CREATE (feat1)-[:IMPLEMENTS_CAPABILITY]->(cap1);
MATCH (feat2:Feature {id: 'FEAT-002'}), (cap2:Capability {id: 'CAP-002'}) CREATE (feat2)-[:IMPLEMENTS_CAPABILITY]->(cap2);

// -----------------------------------------------------------------------------
// Relationships: requirements and architecture
// -----------------------------------------------------------------------------
MATCH (goal1:Goal {id: 'GOAL-001'}), (req1:Requirement {id: 'REQ-001'}) CREATE (goal1)-[:DRIVES_REQUIREMENT]->(req1);
MATCH (goal1:Goal {id: 'GOAL-001'}), (req2:Requirement {id: 'REQ-002'}) CREATE (goal1)-[:DRIVES_REQUIREMENT]->(req2);
MATCH (goal1:Goal {id: 'GOAL-001'}), (req3:Requirement {id: 'REQ-003'}) CREATE (goal1)-[:DRIVES_REQUIREMENT]->(req3);
MATCH (goal2:Goal {id: 'GOAL-002'}), (req4:Requirement {id: 'REQ-004'}) CREATE (goal2)-[:DRIVES_REQUIREMENT]->(req4);
MATCH (goal2:Goal {id: 'GOAL-002'}), (req5:Requirement {id: 'REQ-005'}) CREATE (goal2)-[:DRIVES_REQUIREMENT]->(req5);

MATCH (dec1:Decision {id: 'DEC-001'}), (req1:Requirement {id: 'REQ-001'}) CREATE (dec1)-[:CREATES_REQUIREMENT]->(req1);
MATCH (dec1:Decision {id: 'DEC-001'}), (req2:Requirement {id: 'REQ-002'}) CREATE (dec1)-[:CREATES_REQUIREMENT]->(req2);
MATCH (dec1:Decision {id: 'DEC-001'}), (req3:Requirement {id: 'REQ-003'}) CREATE (dec1)-[:CREATES_REQUIREMENT]->(req3);
MATCH (dec2:Decision {id: 'DEC-002'}), (req4:Requirement {id: 'REQ-004'}) CREATE (dec2)-[:CREATES_REQUIREMENT]->(req4);
MATCH (dec2:Decision {id: 'DEC-002'}), (req5:Requirement {id: 'REQ-005'}) CREATE (dec2)-[:CREATES_REQUIREMENT]->(req5);

MATCH (dec1:Decision {id: 'DEC-001'}), (ev1:Evidence {id: 'EVD-001'}) CREATE (dec1)-[:BASED_ON_EVIDENCE]->(ev1);
MATCH (dec1:Decision {id: 'DEC-001'}), (ev2:Evidence {id: 'EVD-002'}) CREATE (dec1)-[:BASED_ON_EVIDENCE]->(ev2);
MATCH (dec2:Decision {id: 'DEC-002'}), (ev3:Evidence {id: 'EVD-003'}) CREATE (dec2)-[:BASED_ON_EVIDENCE]->(ev3);
MATCH (dec1:Decision {id: 'DEC-001'}), (asmpt1:Assumption {id: 'ASMPT-001'}) CREATE (dec1)-[:RESOLVES_ASSUMPTION]->(asmpt1);

MATCH (req1:Requirement {id: 'REQ-001'}), (ac1:AcceptanceCriterion {id: 'AC-001'}) CREATE (req1)-[:HAS_ACCEPTANCE]->(ac1);
MATCH (req2:Requirement {id: 'REQ-002'}), (ac2:AcceptanceCriterion {id: 'AC-002'}) CREATE (req2)-[:HAS_ACCEPTANCE]->(ac2);
MATCH (req4:Requirement {id: 'REQ-004'}), (ac4:AcceptanceCriterion {id: 'AC-004'}) CREATE (req4)-[:HAS_ACCEPTANCE]->(ac4);
MATCH (req5:Requirement {id: 'REQ-005'}), (ac5:AcceptanceCriterion {id: 'AC-005'}) CREATE (req5)-[:HAS_ACCEPTANCE]->(ac5);

MATCH (req1:Requirement {id: 'REQ-001'}), (svc1:Service {id: 'SVC-001'}) CREATE (req1)-[:ALLOCATED_TO_SERVICE]->(svc1);
MATCH (req4:Requirement {id: 'REQ-004'}), (svc1:Service {id: 'SVC-001'}) CREATE (req4)-[:ALLOCATED_TO_SERVICE]->(svc1);
MATCH (req5:Requirement {id: 'REQ-005'}), (svc1:Service {id: 'SVC-001'}) CREATE (req5)-[:ALLOCATED_TO_SERVICE]->(svc1);
MATCH (adr1:ADR {id: 'ADR-001'}), (svc1:Service {id: 'SVC-001'}) CREATE (adr1)-[:DECIDES_SERVICE]->(svc1);

MATCH (feat1:Feature {id: 'FEAT-001'}), (req1:Requirement {id: 'REQ-001'}) CREATE (feat1)-[:ADDRESSES_REQUIREMENT]->(req1);
MATCH (feat1:Feature {id: 'FEAT-001'}), (req2:Requirement {id: 'REQ-002'}) CREATE (feat1)-[:ADDRESSES_REQUIREMENT]->(req2);
MATCH (feat1:Feature {id: 'FEAT-001'}), (req3:Requirement {id: 'REQ-003'}) CREATE (feat1)-[:ADDRESSES_REQUIREMENT]->(req3);
MATCH (feat2:Feature {id: 'FEAT-002'}), (req4:Requirement {id: 'REQ-004'}) CREATE (feat2)-[:ADDRESSES_REQUIREMENT]->(req4);
MATCH (feat2:Feature {id: 'FEAT-002'}), (req5:Requirement {id: 'REQ-005'}) CREATE (feat2)-[:ADDRESSES_REQUIREMENT]->(req5);

// -----------------------------------------------------------------------------
// Relationships: delivery, release, and operations
// -----------------------------------------------------------------------------
MATCH (wp1:WorkPackage {id: 'WP-001'}), (req1:Requirement {id: 'REQ-001'}) CREATE (wp1)-[:IMPLEMENTS_REQUIREMENT]->(req1);
MATCH (wp3:WorkPackage {id: 'WP-003'}), (req4:Requirement {id: 'REQ-004'}) CREATE (wp3)-[:IMPLEMENTS_REQUIREMENT]->(req4);
MATCH (wp4:WorkPackage {id: 'WP-004'}), (req5:Requirement {id: 'REQ-005'}) CREATE (wp4)-[:IMPLEMENTS_REQUIREMENT]->(req5);
MATCH (wp4:WorkPackage {id: 'WP-004'}), (wp3:WorkPackage {id: 'WP-003'}) CREATE (wp4)-[:DEPENDS_ON]->(wp3);

MATCH (gap1:Gap {id: 'GAP-001'}), (wp1:WorkPackage {id: 'WP-001'}) CREATE (gap1)-[:ADDRESSED_BY_WORK_PACKAGE]->(wp1);
MATCH (wp1:WorkPackage {id: 'WP-001'}), (art1:Artifact {id: 'ART-001'}) CREATE (wp1)-[:CHANGES_ARTIFACT]->(art1);
MATCH (wp1:WorkPackage {id: 'WP-001'}), (del1:Deliverable {id: 'DEL-001'}) CREATE (wp1)-[:PRODUCES_DELIVERABLE]->(del1);
MATCH (del1:Deliverable {id: 'DEL-001'}), (plat1:Plateau {id: 'PLAT-001'}) CREATE (del1)-[:REALIZES_PLATEAU]->(plat1);
MATCH (art1:Artifact {id: 'ART-001'}), (rel1:Release {id: 'REL-001'}) CREATE (art1)-[:PRODUCES_RELEASE]->(rel1);

MATCH (metric1:Metric {id: 'MET-001'}), (svc1:Service {id: 'SVC-001'}) CREATE (metric1)-[:MEASURES_SERVICE]->(svc1);
MATCH (inc1:Incident {id: 'INC-001'}), (svc1:Service {id: 'SVC-001'}) CREATE (inc1)-[:AFFECTS_SERVICE]->(svc1);
MATCH (inc2:Incident {id: 'INC-002'}), (svc1:Service {id: 'SVC-001'}) CREATE (inc2)-[:AFFECTS_SERVICE]->(svc1);
MATCH (pm1:Postmortem {id: 'PM-001'}), (inc1:Incident {id: 'INC-001'}) CREATE (pm1)-[:ANALYZES_INCIDENT]->(inc1);
MATCH (pm1:Postmortem {id: 'PM-001'}), (wp5:WorkPackage {id: 'WP-005'}) CREATE (pm1)-[:CREATES_WORK_PACKAGE]->(wp5);

// -----------------------------------------------------------------------------
// Handy smoke checks
// -----------------------------------------------------------------------------
// MATCH (n) RETURN label(n) AS label, count(*) AS c ORDER BY c DESC;
// MATCH (wp:WorkPackage) RETURN wp.id, wp.status, wp.autonomy_level, wp.allowed_tools;
// MATCH (f:Feature {id: 'FEAT-001'})-[:IMPLEMENTS_CAPABILITY]->(cap)-[:REALIZES_OUTCOME]->(out) RETURN f, cap, out;
