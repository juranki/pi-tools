// Product Copilot sample data for Memgraph
// Purpose: provide a small but connected dataset that exercises the ontology,
// bootstrap constraints, and 07b-memgraph-query-patterns.cypher.
//
// Domain: hypothetical B2B SaaS workspace platform adding enterprise auditability.
//
// Suggested load order:
//   1. 06b-memgraph-bootstrap.cypher
//   2. 08-sample-data-memgraph.cypher
//   3. 07b-memgraph-query-patterns.cypher

// -----------------------------------------------------------------------------
// Nodes: discovery and evidence
// -----------------------------------------------------------------------------
MERGE (src1:Source {id: 'SRC-001', title: 'Enterprise Security Analyst Feed', status: 'active', source_type: 'analyst_report'})
  SET src1.summary = 'External analyst source for enterprise SaaS buyer expectations.';

MERGE (src2:Source {id: 'SRC-002', title: 'Customer Discovery Interviews', status: 'active', source_type: 'interview_repo'})
  SET src2.summary = 'Repository of customer interview notes and transcripts.';

MERGE (src3:Source {id: 'SRC-003', title: 'Support Ticket Warehouse', status: 'active', source_type: 'support_ticket'})
  SET src3.summary = 'Support and success ticket corpus.';

MERGE (doc1:Document {id: 'DOC-001', title: 'Enterprise SaaS Security Expectations 2026', status: 'active'})
  SET doc1.source_uri = 'https://example.com/research/enterprise-saas-security-2026',
      doc1.source_type = 'analyst_report',
      doc1.review_status = 'human_reviewed',
      doc1.summary = 'Analyst report summarizing enterprise expectations for auditability and admin controls.';

MERGE (doc2:Document {id: 'DOC-002', title: 'Interview Transcript - NovaBank Admin Team', status: 'active'})
  SET doc2.source_uri = 'file://interviews/novabank-admin-team.md',
      doc2.source_type = 'interview_transcript',
      doc2.review_status = 'human_reviewed',
      doc2.summary = 'Interview notes from a regulated buyer evaluating workspace admin controls.';

MERGE (doc3:Document {id: 'DOC-003', title: 'Support Theme - Audit Export Requests', status: 'active'})
  SET doc3.source_uri = 'file://support/audit-export-theme.csv',
      doc3.source_type = 'support_analysis',
      doc3.review_status = 'machine_extracted',
      doc3.summary = 'Clustered support analysis showing repeated requests for exportable audit history.';

MERGE (sig1:Signal {id: 'SIG-001', title: 'Enterprise buyers require auditable admin actions', status: 'accepted', signal_kind: 'market'})
  SET sig1.confidence = 'high',
      sig1.summary = 'Market signal that regulated buyers expect immutable admin audit trails.';

MERGE (sig2:Signal {id: 'SIG-002', title: 'Admins need proof of role changes', status: 'accepted', signal_kind: 'customer'})
  SET sig2.confidence = 'high',
      sig2.summary = 'Customer signal that admins must prove who changed workspace access.';

MERGE (sig3:Signal {id: 'SIG-003', title: 'Audit log export is a recurring support request', status: 'accepted', signal_kind: 'support'})
  SET sig3.confidence = 'medium',
      sig3.summary = 'Support signal showing repeated requests for downloadable audit history.';

MERGE (ev1:Evidence {id: 'EVD-001', title: 'Auditability is required for enterprise deals', status: 'accepted'})
  SET ev1.confidence = 'high',
      ev1.review_status = 'approved',
      ev1.summary = 'Normalized evidence that admin audit trails are a recurring enterprise buying requirement.';

MERGE (ev2:Evidence {id: 'EVD-002', title: 'Admins must export audit history for compliance reviews', status: 'accepted'})
  SET ev2.confidence = 'high',
      ev2.review_status = 'approved',
      ev2.summary = 'Interview-based evidence that exportable audit history is needed during compliance checks.';

MERGE (ev3:Evidence {id: 'EVD-003', title: 'Support tickets cite missing audit export as a blocker', status: 'accepted'})
  SET ev3.confidence = 'medium',
      ev3.review_status = 'approved',
      ev3.summary = 'Normalized support evidence linking missing audit export to customer friction.';

MERGE (clm1:Claim {id: 'CLM-001', title: 'Workspace admin auditability is table stakes for regulated buyers', status: 'active'})
  SET clm1.confidence = 'high',
      clm1.summary = 'The product needs auditable role-change records to compete in regulated segments.';

MERGE (clm2:Claim {id: 'CLM-002', title: 'Audit log export is necessary for compliance workflows', status: 'active'})
  SET clm2.confidence = 'medium',
      clm2.summary = 'The product should support exportable audit history for downstream review processes.';

MERGE (asmpt1:Assumption {id: 'ASMPT-001', title: 'Sub-minute asynchronous propagation is acceptable for audit logs', status: 'active'})
  SET asmpt1.confidence = 'medium',
      asmpt1.summary = 'Admins will accept small propagation delay if records are complete and immutable.';

MERGE (drv1:Driver {id: 'DRV-001', title: 'Enterprise compliance pressure', status: 'active'})
  SET drv1.business_impact = 'Improves enterprise win rate and reduces security questionnaire friction.',
      drv1.summary = 'External pressure from enterprise and regulated customers.';

MERGE (ass1:Assessment {id: 'ASS-001', title: 'Current platform lacks admin action traceability', status: 'active'})
  SET ass1.confidence = 'high',
      ass1.rationale = 'Today role changes are visible in current state but not durably traceable as historical events.',
      ass1.summary = 'Assessment of the existing product gap.';

MERGE (dec1:Decision {id: 'DEC-001', title: 'Adopt event-based audit logging for role changes', status: 'accepted', rationale: 'Event emission provides an immutable trace with lower coupling than synchronous logging in every consumer.'})
  SET dec1.owner = 'platform-architecture',
      dec1.priority = 'high';

MERGE (dec2:Decision {id: 'DEC-002', title: 'Implement asynchronous CSV export jobs for audit history', status: 'accepted', rationale: 'Background export jobs can handle larger history windows without degrading interactive admin workflows.'})
  SET dec2.owner = 'product-engineering',
      dec2.priority = 'medium';

MERGE (adr1:ADR {id: 'ADR-001', title: 'ADR-001 Event-sourced audit trail', status: 'accepted', rationale: 'Use domain events from the auth service as the canonical source for audit records.'})
  SET adr1.summary = 'Architecture decision for the audit trail pipeline.';

// -----------------------------------------------------------------------------
// Nodes: strategy and product definition
// -----------------------------------------------------------------------------
MERGE (seg1:Segment {id: 'SEG-001', title: 'Regulated B2B SaaS teams', status: 'active'})
  SET seg1.priority = 'high',
      seg1.summary = 'Security-conscious teams operating in regulated or procurement-heavy environments.';

MERGE (job1:Job {id: 'JOB-001', title: 'Prove who changed a workspace member role', status: 'active'})
  SET job1.summary = 'Workspace admins need a durable record of privileged role changes.';

MERGE (opp1:Opportunity {id: 'OPP-001', title: 'Unlock enterprise adoption with admin auditability', status: 'planned'})
  SET opp1.priority = 'high',
      opp1.confidence = 'high',
      opp1.business_impact = 'Expands suitability for regulated buyers.',
      opp1.summary = 'Opportunity centered on traceable administrative actions.';

MERGE (opp2:Opportunity {id: 'OPP-002', title: 'Reduce compliance review friction with audit exports', status: 'planned'})
  SET opp2.priority = 'medium',
      opp2.confidence = 'medium',
      opp2.business_impact = 'Shortens buyer review cycles and reduces support load.',
      opp2.summary = 'Opportunity focused on exportable audit history.';

MERGE (goal1:Goal {id: 'GOAL-001', title: 'Achieve enterprise-ready admin auditability', status: 'in_progress'})
  SET goal1.priority = 'high',
      goal1.owner_team = 'product-platform';

MERGE (goal2:Goal {id: 'GOAL-002', title: 'Enable self-serve compliance evidence export', status: 'planned'})
  SET goal2.priority = 'medium',
      goal2.owner_team = 'product-platform';

MERGE (out1:Outcome {id: 'OUT-001', title: 'Every role change produces a searchable audit event', status: 'in_progress'})
  SET out1.metric_definition = 'percentage of role changes with corresponding audit event available for query',
      out1.target_value = '100%',
      out1.current_value = '0%',
      out1.owner_team = 'product-platform';

MERGE (out2:Outcome {id: 'OUT-002', title: 'Admins can export 90 days of audit history within two minutes', status: 'planned'})
  SET out2.metric_definition = 'time to complete 90-day audit export job',
      out2.target_value = '<= 2m',
      out2.current_value = 'not available',
      out2.owner_team = 'product-platform';

MERGE (pri1:Principle {id: 'PRI-001', title: 'Security-sensitive actions must be traceable', status: 'active'})
  SET pri1.rationale = 'Administrative actions affecting access must be reconstructable for review and response.';

MERGE (coa1:CourseOfAction {id: 'COA-001', title: 'Introduce an audit event pipeline', status: 'planned'})
  SET coa1.rationale = 'Create a durable event-driven path from admin action to audit record.';

MERGE (vs1:ValueStream {id: 'VS-001', title: 'Admin governance and compliance response', status: 'active'})
  SET vs1.owner_team = 'product-platform',
      vs1.summary = 'Value stream covering detection, review, and export of sensitive admin actions.';

MERGE (cap1:Capability {id: 'CAP-001', title: 'Workspace administration auditability', status: 'in_progress'})
  SET cap1.priority = 'high',
      cap1.owner_team = 'product-platform';

MERGE (cap2:Capability {id: 'CAP-002', title: 'Audit history export', status: 'planned'})
  SET cap2.priority = 'medium',
      cap2.owner_team = 'product-platform';

MERGE (kpi1:KPI {id: 'KPI-001', title: 'Audit event coverage', status: 'active', metric_definition: 'percentage of privileged role changes with linked audit event'})
  SET kpi1.metric_kind = 'security',
      kpi1.target_value = '100%',
      kpi1.current_value = '0%';

MERGE (kpi2:KPI {id: 'KPI-002', title: 'Audit export completion time', status: 'active', metric_definition: 'p95 duration of 90-day audit export job'})
  SET kpi2.metric_kind = 'product',
      kpi2.target_value = '<= 2m',
      kpi2.current_value = 'N/A';

MERGE (feat1:Feature {id: 'FEAT-001', title: 'Workspace role audit trail', status: 'in_progress'})
  SET feat1.priority = 'high',
      feat1.user_impact = 'Admins can investigate who changed access and when.',
      feat1.summary = 'Adds a durable audit trail for workspace role changes.';

MERGE (feat2:Feature {id: 'FEAT-002', title: 'Audit log CSV export', status: 'planned'})
  SET feat2.priority = 'medium',
      feat2.user_impact = 'Admins can export audit history for compliance and investigation workflows.',
      feat2.summary = 'Adds asynchronous CSV export for audit history.';

MERGE (pol1:Policy {id: 'POL-001', title: 'Never log secrets or tokens in audit records', status: 'active'})
  SET pol1.rationale = 'Auditability must not create a secret leakage vector.',
      pol1.data_classification = 'internal-sensitive';

MERGE (rg1:ReleaseGoal {id: 'RG-001', title: 'Ship audit trail MVP to production', status: 'planned'})
  SET rg1.priority = 'high',
      rg1.target_value = '2026-Q3';

// -----------------------------------------------------------------------------
// Nodes: requirements and architecture
// -----------------------------------------------------------------------------
MERGE (req1:Requirement {id: 'REQ-001', title: 'Emit immutable audit event on workspace role change', status: 'implemented', requirement_kind: 'security'})
  SET req1.priority = 'high',
      req1.risk_level = 'high',
      req1.rationale = 'Role changes affect access and must be durably captured.';

MERGE (req2:Requirement {id: 'REQ-002', title: 'Retain audit records for at least 90 days', status: 'approved', requirement_kind: 'compliance'})
  SET req2.priority = 'high',
      req2.risk_level = 'medium',
      req2.rationale = 'Buyers require historical evidence over a meaningful compliance window.';

MERGE (req3:Requirement {id: 'REQ-003', title: 'Allow tenant admins to filter audit history by actor and date range', status: 'approved', requirement_kind: 'functional'})
  SET req3.priority = 'medium',
      req3.risk_level = 'low',
      req3.rationale = 'Audit logs must be navigable for investigation workflows.';

MERGE (req4:Requirement {id: 'REQ-004', title: 'Provide asynchronous CSV export of audit history', status: 'approved', requirement_kind: 'functional'})
  SET req4.priority = 'medium',
      req4.risk_level = 'medium',
      req4.rationale = 'Admins need portable audit evidence without degrading interactive performance.';

MERGE (req5:Requirement {id: 'REQ-005', title: 'Show export job progress and completion status', status: 'approved', requirement_kind: 'functional'})
  SET req5.priority = 'low',
      req5.risk_level = 'low',
      req5.rationale = 'Users need feedback when long-running export jobs are processing.';

MERGE (ac1:AcceptanceCriterion {id: 'AC-001', title: 'Role change emits audit event with actor, target, previous role, new role, and timestamp', status: 'verified'})
  SET ac1.expression = 'For every successful role change, one corresponding audit event exists with required fields.';

MERGE (ac2:AcceptanceCriterion {id: 'AC-002', title: 'Audit records remain queryable for ninety days', status: 'approved'})
  SET ac2.expression = 'Audit records are accessible for the full retention window.';

MERGE (ac4:AcceptanceCriterion {id: 'AC-004', title: 'Admins can request CSV export of 90-day audit history', status: 'approved'})
  SET ac4.expression = 'Export job can be initiated and produces downloadable CSV output.';

MERGE (ac5:AcceptanceCriterion {id: 'AC-005', title: 'Export page shows pending, running, and completed states', status: 'approved'})
  SET ac5.expression = 'Users see current progress state for asynchronous export jobs.';

MERGE (risk1:Risk {id: 'RISK-001', title: 'Audit event loss during worker restart', status: 'identified', risk_level: 'high'})
  SET risk1.blast_radius = 'Can create compliance gaps in privileged action history.',
      risk1.rationale = 'Restart handling may interrupt event processing.';

MERGE (con1:Constraint {id: 'CON-001', title: 'Use existing event bus abstraction', status: 'active'})
  SET con1.risk_level = 'low',
      con1.rationale = 'Minimize platform sprawl by reusing proven messaging infrastructure.';

MERGE (bsvc1:BusinessService {id: 'BSVC-001', title: 'Administrative audit evidence service', status: 'active', service_kind: 'business'})
  SET bsvc1.owner_team = 'product-platform';

MERGE (asvc1:ApplicationService {id: 'ASVC-001', title: 'Audit event application service', status: 'active', service_kind: 'application'})
  SET asvc1.owner_team = 'product-platform';

MERGE (tsvc1:TechnologyService {id: 'TSVC-001', title: 'Event bus platform service', status: 'active', service_kind: 'technology'})
  SET tsvc1.owner_team = 'platform-infra';

MERGE (svc1:Service {id: 'SVC-001', title: 'auth-service', status: 'active'})
  SET svc1.owner_team = 'product-platform',
      svc1.summary = 'Handles workspace membership and role changes.';

MERGE (cmp1:Component {id: 'CMP-001', title: 'audit-log-writer', status: 'active'})
  SET cmp1.owner_team = 'product-platform';

MERGE (api1:API {id: 'API-001', title: 'Audit Log Query API', status: 'active'})
  SET api1.version = 'v1';

MERGE (evt1:Event {id: 'EVT-001', title: 'WorkspaceMemberRoleChanged', status: 'active'})
  SET evt1.version = 'v1';

MERGE (data1:DataEntity {id: 'DATA-001', title: 'AuditRecord', status: 'active'})
  SET data1.data_classification = 'internal-sensitive',
      data1.retention_policy = '90d';

MERGE (wf1:Workflow {id: 'WF-001', title: 'Role change to audit pipeline', status: 'active'})
  SET wf1.owner_team = 'product-platform';

MERGE (env1:Environment {id: 'ENV-001', title: 'production', status: 'active', environment_kind: 'production'})
  SET env1.owner_team = 'platform-infra';

// -----------------------------------------------------------------------------
// Nodes: delivery, migration, operations
// -----------------------------------------------------------------------------
MERGE (ep1:Epic {id: 'EPIC-001', title: 'Enterprise auditability foundation', status: 'in_progress'})
  SET ep1.priority = 'high',
      ep1.owner_team = 'product-platform';

MERGE (ep2:Epic {id: 'EPIC-002', title: 'Audit export experience', status: 'planned'})
  SET ep2.priority = 'medium',
      ep2.owner_team = 'product-platform';

MERGE (story1:Story {id: 'STORY-001', title: 'Record privileged role changes', status: 'in_progress'})
  SET story1.priority = 'high',
      story1.owner_team = 'product-platform';

MERGE (story2:Story {id: 'STORY-002', title: 'Export audit history for compliance', status: 'planned'})
  SET story2.priority = 'medium',
      story2.owner_team = 'product-platform';

MERGE (gap1:Gap {id: 'GAP-001', title: 'Workspace role changes are not historically traceable', status: 'identified'})
  SET gap1.priority = 'high',
      gap1.rationale = 'The current product cannot reconstruct who changed access over time.';

MERGE (plat1:Plateau {id: 'PLAT-001', title: 'Audit trail MVP in production', status: 'completed'})
  SET plat1.version = '2026-Q3';

MERGE (art1:Artifact {id: 'ART-001', title: 'auth-service audit logging code', status: 'active', artifact_kind: 'code'})
  SET art1.version = '2026.09.0',
      art1.external_ref = 'git://repo/services/auth-service';

MERGE (del1:Deliverable {id: 'DEL-001', title: 'Audit trail MVP deliverable', status: 'completed'})
  SET del1.artifact_kind = 'code',
      del1.version = '2026.09.0';

MERGE (rel1:Release {id: 'REL-001', title: '2026.09 audit trail release', status: 'released'})
  SET rel1.version = '2026.09.0',
      rel1.owner_team = 'product-platform';

MERGE (dep1:Deployment {id: 'DEP-001', title: 'Deploy 2026.09 to production', status: 'completed'})
  SET dep1.owner_team = 'platform-infra';

MERGE (wp1:WorkPackage {id: 'WP-001', title: 'Emit audit events for role changes', status: 'done', work_package_type: 'code', objective: 'Implement immutable audit event emission in auth-service when workspace roles change.'})
  SET wp1.autonomy_level = 'bounded_execution',
      wp1.risk_level = 'medium',
      wp1.allowed_tools = ['repo-write', 'test-runner'],
      wp1.acceptance_checks = ['unit tests pass', 'integration tests pass', 'event schema validates'],
      wp1.owner = 'builder-agent',
      wp1.required_permissions = ['repo-write'];

MERGE (wp3:WorkPackage {id: 'WP-003', title: 'Add asynchronous CSV audit export endpoint', status: 'ready', work_package_type: 'code', objective: 'Create the API and job orchestration for asynchronous export of audit history.'})
  SET wp3.autonomy_level = 'bounded_execution',
      wp3.risk_level = 'medium',
      wp3.allowed_tools = ['repo-write', 'test-runner'],
      wp3.acceptance_checks = ['contract tests pass', 'integration tests pass'],
      wp3.owner = 'builder-agent',
      wp3.required_permissions = ['repo-write'];

MERGE (wp4:WorkPackage {id: 'WP-004', title: 'Add export progress UI states', status: 'ready', work_package_type: 'code', objective: 'Expose and render export job progress states for administrators.'})
  SET wp4.autonomy_level = 'bounded_execution',
      wp4.risk_level = 'low',
      wp4.allowed_tools = ['repo-write', 'test-runner'],
      wp4.acceptance_checks = ['ui tests pass', 'state transitions render correctly'],
      wp4.owner = 'builder-agent',
      wp4.required_permissions = ['repo-write'];

MERGE (wp5:WorkPackage {id: 'WP-005', title: 'Harden audit worker restart handling', status: 'backlog', work_package_type: 'ops', objective: 'Prevent audit event loss during worker restarts and replay missed messages.'})
  SET wp5.autonomy_level = 'drafting',
      wp5.risk_level = 'high',
      wp5.allowed_tools = ['repo-read', 'log-reader'],
      wp5.acceptance_checks = ['replay test passes', 'no event loss in restart simulation'],
      wp5.owner = 'operator-agent';

MERGE (agent1:Agent {id: 'AGENT-001', title: 'builder-agent', status: 'active'})
  SET agent1.allowed_tools = ['repo-write', 'test-runner'],
      agent1.required_permissions = ['repo-write'];

MERGE (review1:Review {id: 'REV-001', title: 'Security review for audit event payload', status: 'passed'})
  SET review1.owner = 'security-reviewer';

MERGE (ts1:TestSuite {id: 'TS-001', title: 'Audit trail integration suite', status: 'active'})
  SET ts1.external_ref = 'tests/integration/audit_trail';

MERGE (tc1:TestCase {id: 'TC-001', title: 'Role change creates audit event', status: 'verified'})
  SET tc1.external_ref = 'tests/integration/audit_trail/role_change_event.spec';

MERGE (metric1:Metric {id: 'MET-001', title: 'Audit event coverage metric', status: 'active', metric_kind: 'security', metric_definition: 'ratio of successful role changes with a corresponding audit event'})
  SET metric1.formula = 'audit_events / role_changes',
      metric1.current_value = '99.2%';

MERGE (sli1:SLI {id: 'SLI-001', title: 'Role change audit coverage', status: 'active'})
  SET sli1.expression = 'successful role changes with audit event / total successful role changes',
      sli1.current_value = '99.2%';

MERGE (slo1:SLO {id: 'SLO-001', title: 'Audit coverage SLO', status: 'active', target_value: '>= 99.9%'})
  SET slo1.threshold = '99.9%',
      slo1.rationale = 'Privileged admin actions must be almost fully observable.';

MERGE (alert1:Alert {id: 'ALT-001', title: 'Audit coverage below SLO', status: 'completed', threshold: '< 99.9%'})
  SET alert1.priority = 'high';

MERGE (inc1:Incident {id: 'INC-001', title: 'Audit events dropped during worker restart', status: 'reviewed', risk_level: 'high'})
  SET inc1.owner_team = 'product-platform',
      inc1.blast_radius = 'Some privileged role changes lacked durable audit records.';

MERGE (inc2:Incident {id: 'INC-002', title: 'Export backlog spike without documented review', status: 'reviewed', risk_level: 'medium'})
  SET inc2.owner_team = 'product-platform',
      inc2.blast_radius = 'Delayed export completion for compliance workflows.';

MERGE (pm1:Postmortem {id: 'PM-001', title: 'Postmortem for audit event loss on restart', status: 'active'})
  SET pm1.owner_team = 'product-platform',
      pm1.rationale = 'Restart sequencing allowed consumers to miss in-flight audit messages.';

// -----------------------------------------------------------------------------
// Relationships: discovery to evidence
// -----------------------------------------------------------------------------
MATCH (src1:Source {id: 'SRC-001'}), (doc1:Document {id: 'DOC-001'}) MERGE (src1)-[:CONTAINS]->(doc1);
MATCH (src2:Source {id: 'SRC-002'}), (doc2:Document {id: 'DOC-002'}) MERGE (src2)-[:CONTAINS]->(doc2);
MATCH (src3:Source {id: 'SRC-003'}), (doc3:Document {id: 'DOC-003'}) MERGE (src3)-[:CONTAINS]->(doc3);

MATCH (doc1:Document {id: 'DOC-001'}), (sig1:Signal {id: 'SIG-001'}) MERGE (doc1)-[:YIELDS]->(sig1);
MATCH (doc2:Document {id: 'DOC-002'}), (sig2:Signal {id: 'SIG-002'}) MERGE (doc2)-[:YIELDS]->(sig2);
MATCH (doc3:Document {id: 'DOC-003'}), (sig3:Signal {id: 'SIG-003'}) MERGE (doc3)-[:YIELDS]->(sig3);

MATCH (sig1:Signal {id: 'SIG-001'}), (ev1:Evidence {id: 'EVD-001'}) MERGE (sig1)-[:SUPPORTS]->(ev1);
MATCH (sig2:Signal {id: 'SIG-002'}), (ev1:Evidence {id: 'EVD-001'}) MERGE (sig2)-[:SUPPORTS]->(ev1);
MATCH (sig2:Signal {id: 'SIG-002'}), (ev2:Evidence {id: 'EVD-002'}) MERGE (sig2)-[:SUPPORTS]->(ev2);
MATCH (sig3:Signal {id: 'SIG-003'}), (ev3:Evidence {id: 'EVD-003'}) MERGE (sig3)-[:SUPPORTS]->(ev3);
MATCH (sig1:Signal {id: 'SIG-001'}), (ass1:Assessment {id: 'ASS-001'}) MERGE (sig1)-[:INFORMS]->(ass1);

MATCH (ev1:Evidence {id: 'EVD-001'}), (clm1:Claim {id: 'CLM-001'}) MERGE (ev1)-[:SUPPORTS]->(clm1);
MATCH (ev2:Evidence {id: 'EVD-002'}), (clm2:Claim {id: 'CLM-002'}) MERGE (ev2)-[:SUPPORTS]->(clm2);
MATCH (ev3:Evidence {id: 'EVD-003'}), (clm2:Claim {id: 'CLM-002'}) MERGE (ev3)-[:SUPPORTS]->(clm2);
MATCH (ass1:Assessment {id: 'ASS-001'}), (ev1:Evidence {id: 'EVD-001'}) MERGE (ass1)-[:BASED_ON]->(ev1);
MATCH (drv1:Driver {id: 'DRV-001'}), (ass1:Assessment {id: 'ASS-001'}) MERGE (drv1)-[:ASSESSED_BY]->(ass1);
MATCH (dec1:Decision {id: 'DEC-001'}), (ev1:Evidence {id: 'EVD-001'}) MERGE (dec1)-[:BASED_ON]->(ev1);
MATCH (dec2:Decision {id: 'DEC-002'}), (ev2:Evidence {id: 'EVD-002'}) MERGE (dec2)-[:BASED_ON]->(ev2);
MATCH (dec2:Decision {id: 'DEC-002'}), (ev3:Evidence {id: 'EVD-003'}) MERGE (dec2)-[:BASED_ON]->(ev3);
MATCH (dec1:Decision {id: 'DEC-001'}), (asmpt1:Assumption {id: 'ASMPT-001'}) MERGE (dec1)-[:RESOLVES]->(asmpt1);

// -----------------------------------------------------------------------------
// Relationships: strategy and product definition
// -----------------------------------------------------------------------------
MATCH (drv1:Driver {id: 'DRV-001'}), (goal1:Goal {id: 'GOAL-001'}) MERGE (drv1)-[:INFLUENCES]->(goal1);
MATCH (ass1:Assessment {id: 'ASS-001'}), (goal1:Goal {id: 'GOAL-001'}) MERGE (ass1)-[:INFLUENCES]->(goal1);
MATCH (ass1:Assessment {id: 'ASS-001'}), (goal2:Goal {id: 'GOAL-002'}) MERGE (ass1)-[:INFLUENCES]->(goal2);
MATCH (goal1:Goal {id: 'GOAL-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (goal1)-[:REALIZED_BY]->(out1);
MATCH (goal2:Goal {id: 'GOAL-002'}), (out2:Outcome {id: 'OUT-002'}) MERGE (goal2)-[:REALIZED_BY]->(out2);
MATCH (pri1:Principle {id: 'PRI-001'}), (dec1:Decision {id: 'DEC-001'}) MERGE (pri1)-[:GUIDES]->(dec1);
MATCH (pri1:Principle {id: 'PRI-001'}), (wp1:WorkPackage {id: 'WP-001'}) MERGE (pri1)-[:GUIDES]->(wp1);
MATCH (coa1:CourseOfAction {id: 'COA-001'}), (goal1:Goal {id: 'GOAL-001'}) MERGE (coa1)-[:PURSUES]->(goal1);
MATCH (vs1:ValueStream {id: 'VS-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (vs1)-[:CREATES]->(out1);
MATCH (vs1:ValueStream {id: 'VS-001'}), (cap1:Capability {id: 'CAP-001'}) MERGE (vs1)-[:USES]->(cap1);
MATCH (seg1:Segment {id: 'SEG-001'}), (job1:Job {id: 'JOB-001'}) MERGE (seg1)-[:HAS_JOB]->(job1);
MATCH (job1:Job {id: 'JOB-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (job1)-[:SEEKS]->(out1);
MATCH (opp1:Opportunity {id: 'OPP-001'}), (seg1:Segment {id: 'SEG-001'}) MERGE (opp1)-[:TARGETS]->(seg1);
MATCH (opp1:Opportunity {id: 'OPP-001'}), (job1:Job {id: 'JOB-001'}) MERGE (opp1)-[:ADDRESSES]->(job1);
MATCH (opp1:Opportunity {id: 'OPP-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (opp1)-[:PURSUES]->(out1);
MATCH (opp2:Opportunity {id: 'OPP-002'}), (out2:Outcome {id: 'OUT-002'}) MERGE (opp2)-[:PURSUES]->(out2);
MATCH (clm1:Claim {id: 'CLM-001'}), (opp1:Opportunity {id: 'OPP-001'}) MERGE (clm1)-[:IMPLIES]->(opp1);
MATCH (clm2:Claim {id: 'CLM-002'}), (opp2:Opportunity {id: 'OPP-002'}) MERGE (clm2)-[:IMPLIES]->(opp2);
MATCH (cap1:Capability {id: 'CAP-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (cap1)-[:REALIZES]->(out1);
MATCH (cap2:Capability {id: 'CAP-002'}), (out2:Outcome {id: 'OUT-002'}) MERGE (cap2)-[:REALIZES]->(out2);
MATCH (feat1:Feature {id: 'FEAT-001'}), (cap1:Capability {id: 'CAP-001'}) MERGE (feat1)-[:IMPLEMENTS]->(cap1);
MATCH (feat2:Feature {id: 'FEAT-002'}), (cap2:Capability {id: 'CAP-002'}) MERGE (feat2)-[:IMPLEMENTS]->(cap2);
MATCH (kpi1:KPI {id: 'KPI-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (kpi1)-[:MEASURES]->(out1);
MATCH (kpi2:KPI {id: 'KPI-002'}), (out2:Outcome {id: 'OUT-002'}) MERGE (kpi2)-[:MEASURES]->(out2);
MATCH (pol1:Policy {id: 'POL-001'}), (feat1:Feature {id: 'FEAT-001'}) MERGE (pol1)-[:CONSTRAINS]->(feat1);
MATCH (rg1:ReleaseGoal {id: 'RG-001'}), (out1:Outcome {id: 'OUT-001'}) MERGE (rg1)-[:TARGETS]->(out1);

// -----------------------------------------------------------------------------
// Relationships: requirements and architecture
// -----------------------------------------------------------------------------
MATCH (goal1:Goal {id: 'GOAL-001'}), (req1:Requirement {id: 'REQ-001'}) MERGE (goal1)-[:DRIVES]->(req1);
MATCH (goal1:Goal {id: 'GOAL-001'}), (req2:Requirement {id: 'REQ-002'}) MERGE (goal1)-[:DRIVES]->(req2);
MATCH (goal1:Goal {id: 'GOAL-001'}), (req3:Requirement {id: 'REQ-003'}) MERGE (goal1)-[:DRIVES]->(req3);
MATCH (goal2:Goal {id: 'GOAL-002'}), (req4:Requirement {id: 'REQ-004'}) MERGE (goal2)-[:DRIVES]->(req4);
MATCH (goal2:Goal {id: 'GOAL-002'}), (req5:Requirement {id: 'REQ-005'}) MERGE (goal2)-[:DRIVES]->(req5);

MATCH (dec1:Decision {id: 'DEC-001'}), (req1:Requirement {id: 'REQ-001'}) MERGE (dec1)-[:CREATES]->(req1);
MATCH (dec1:Decision {id: 'DEC-001'}), (req2:Requirement {id: 'REQ-002'}) MERGE (dec1)-[:CREATES]->(req2);
MATCH (dec1:Decision {id: 'DEC-001'}), (req3:Requirement {id: 'REQ-003'}) MERGE (dec1)-[:CREATES]->(req3);
MATCH (dec2:Decision {id: 'DEC-002'}), (req4:Requirement {id: 'REQ-004'}) MERGE (dec2)-[:CREATES]->(req4);
MATCH (dec2:Decision {id: 'DEC-002'}), (req5:Requirement {id: 'REQ-005'}) MERGE (dec2)-[:CREATES]->(req5);

MATCH (req1:Requirement {id: 'REQ-001'}), (ac1:AcceptanceCriterion {id: 'AC-001'}) MERGE (req1)-[:HAS_ACCEPTANCE]->(ac1);
MATCH (req2:Requirement {id: 'REQ-002'}), (ac2:AcceptanceCriterion {id: 'AC-002'}) MERGE (req2)-[:HAS_ACCEPTANCE]->(ac2);
MATCH (req4:Requirement {id: 'REQ-004'}), (ac4:AcceptanceCriterion {id: 'AC-004'}) MERGE (req4)-[:HAS_ACCEPTANCE]->(ac4);
MATCH (req5:Requirement {id: 'REQ-005'}), (ac5:AcceptanceCriterion {id: 'AC-005'}) MERGE (req5)-[:HAS_ACCEPTANCE]->(ac5);

MATCH (con1:Constraint {id: 'CON-001'}), (req1:Requirement {id: 'REQ-001'}) MERGE (con1)-[:LIMITS]->(req1);
MATCH (risk1:Risk {id: 'RISK-001'}), (dec1:Decision {id: 'DEC-001'}) MERGE (dec1)-[:RESOLVES]->(risk1);

MATCH (cap1:Capability {id: 'CAP-001'}), (bsvc1:BusinessService {id: 'BSVC-001'}) MERGE (cap1)-[:SERVED_BY]->(bsvc1);
MATCH (bsvc1:BusinessService {id: 'BSVC-001'}), (asvc1:ApplicationService {id: 'ASVC-001'}) MERGE (bsvc1)-[:REALIZED_BY]->(asvc1);
MATCH (asvc1:ApplicationService {id: 'ASVC-001'}), (svc1:Service {id: 'SVC-001'}) MERGE (asvc1)-[:REALIZED_BY]->(svc1);
MATCH (svc1:Service {id: 'SVC-001'}), (tsvc1:TechnologyService {id: 'TSVC-001'}) MERGE (svc1)-[:SUPPORTED_BY]->(tsvc1);

MATCH (req1:Requirement {id: 'REQ-001'}), (bsvc1:BusinessService {id: 'BSVC-001'}) MERGE (req1)-[:ALLOCATED_TO]->(bsvc1);
MATCH (req1:Requirement {id: 'REQ-001'}), (asvc1:ApplicationService {id: 'ASVC-001'}) MERGE (req1)-[:ALLOCATED_TO]->(asvc1);
MATCH (req1:Requirement {id: 'REQ-001'}), (svc1:Service {id: 'SVC-001'}) MERGE (req1)-[:ALLOCATED_TO]->(svc1);
MATCH (req1:Requirement {id: 'REQ-001'}), (cmp1:Component {id: 'CMP-001'}) MERGE (req1)-[:ALLOCATED_TO]->(cmp1);
MATCH (req4:Requirement {id: 'REQ-004'}), (svc1:Service {id: 'SVC-001'}) MERGE (req4)-[:ALLOCATED_TO]->(svc1);
MATCH (req5:Requirement {id: 'REQ-005'}), (svc1:Service {id: 'SVC-001'}) MERGE (req5)-[:ALLOCATED_TO]->(svc1);

MATCH (adr1:ADR {id: 'ADR-001'}), (svc1:Service {id: 'SVC-001'}) MERGE (adr1)-[:DECIDES]->(svc1);
MATCH (adr1:ADR {id: 'ADR-001'}), (api1:API {id: 'API-001'}) MERGE (adr1)-[:DECIDES]->(api1);
MATCH (svc1:Service {id: 'SVC-001'}), (api1:API {id: 'API-001'}) MERGE (svc1)-[:EXPOSES]->(api1);
MATCH (svc1:Service {id: 'SVC-001'}), (evt1:Event {id: 'EVT-001'}) MERGE (svc1)-[:EMITS]->(evt1);
MATCH (svc1:Service {id: 'SVC-001'}), (data1:DataEntity {id: 'DATA-001'}) MERGE (svc1)-[:WRITES]->(data1);
MATCH (wf1:Workflow {id: 'WF-001'}), (api1:API {id: 'API-001'}) MERGE (wf1)-[:USES]->(api1);

MATCH (feat1:Feature {id: 'FEAT-001'}), (req1:Requirement {id: 'REQ-001'}) MERGE (feat1)-[:ADDRESSES]->(req1);
MATCH (feat1:Feature {id: 'FEAT-001'}), (req2:Requirement {id: 'REQ-002'}) MERGE (feat1)-[:ADDRESSES]->(req2);
MATCH (feat1:Feature {id: 'FEAT-001'}), (req3:Requirement {id: 'REQ-003'}) MERGE (feat1)-[:ADDRESSES]->(req3);
MATCH (feat2:Feature {id: 'FEAT-002'}), (req4:Requirement {id: 'REQ-004'}) MERGE (feat2)-[:ADDRESSES]->(req4);
MATCH (feat2:Feature {id: 'FEAT-002'}), (req5:Requirement {id: 'REQ-005'}) MERGE (feat2)-[:ADDRESSES]->(req5);

// -----------------------------------------------------------------------------
// Relationships: delivery, releases, incidents, and learning
// -----------------------------------------------------------------------------
MATCH (feat1:Feature {id: 'FEAT-001'}), (ep1:Epic {id: 'EPIC-001'}) MERGE (feat1)-[:DECOMPOSED_INTO]->(ep1);
MATCH (feat2:Feature {id: 'FEAT-002'}), (ep2:Epic {id: 'EPIC-002'}) MERGE (feat2)-[:DECOMPOSED_INTO]->(ep2);
MATCH (ep1:Epic {id: 'EPIC-001'}), (story1:Story {id: 'STORY-001'}) MERGE (ep1)-[:DECOMPOSED_INTO]->(story1);
MATCH (ep2:Epic {id: 'EPIC-002'}), (story2:Story {id: 'STORY-002'}) MERGE (ep2)-[:DECOMPOSED_INTO]->(story2);
MATCH (story1:Story {id: 'STORY-001'}), (wp1:WorkPackage {id: 'WP-001'}) MERGE (story1)-[:DECOMPOSED_INTO]->(wp1);
MATCH (story2:Story {id: 'STORY-002'}), (wp3:WorkPackage {id: 'WP-003'}) MERGE (story2)-[:DECOMPOSED_INTO]->(wp3);
MATCH (story2:Story {id: 'STORY-002'}), (wp4:WorkPackage {id: 'WP-004'}) MERGE (story2)-[:DECOMPOSED_INTO]->(wp4);

MATCH (gap1:Gap {id: 'GAP-001'}), (wp1:WorkPackage {id: 'WP-001'}) MERGE (gap1)-[:ADDRESSED_BY]->(wp1);
MATCH (wp1:WorkPackage {id: 'WP-001'}), (req1:Requirement {id: 'REQ-001'}) MERGE (wp1)-[:IMPLEMENTS]->(req1);
MATCH (wp3:WorkPackage {id: 'WP-003'}), (req4:Requirement {id: 'REQ-004'}) MERGE (wp3)-[:IMPLEMENTS]->(req4);
MATCH (wp4:WorkPackage {id: 'WP-004'}), (req5:Requirement {id: 'REQ-005'}) MERGE (wp4)-[:IMPLEMENTS]->(req5);
MATCH (wp4:WorkPackage {id: 'WP-004'}), (wp3:WorkPackage {id: 'WP-003'}) MERGE (wp4)-[:DEPENDS_ON]->(wp3);

MATCH (wp1:WorkPackage {id: 'WP-001'}), (art1:Artifact {id: 'ART-001'}) MERGE (wp1)-[:CHANGES]->(art1);
MATCH (wp1:WorkPackage {id: 'WP-001'}), (del1:Deliverable {id: 'DEL-001'}) MERGE (wp1)-[:PRODUCES]->(del1);
MATCH (del1:Deliverable {id: 'DEL-001'}), (plat1:Plateau {id: 'PLAT-001'}) MERGE (del1)-[:REALIZES]->(plat1);
MATCH (art1:Artifact {id: 'ART-001'}), (rel1:Release {id: 'REL-001'}) MERGE (art1)-[:PRODUCES]->(rel1);
MATCH (rel1:Release {id: 'REL-001'}), (dep1:Deployment {id: 'DEP-001'}) MERGE (rel1)-[:DEPLOYED_AS]->(dep1);
MATCH (dep1:Deployment {id: 'DEP-001'}), (env1:Environment {id: 'ENV-001'}) MERGE (dep1)-[:RUNS_IN]->(env1);

MATCH (wp1:WorkPackage {id: 'WP-001'}), (agent1:Agent {id: 'AGENT-001'}) MERGE (wp1)-[:ASSIGNED_TO]->(agent1);
MATCH (wp3:WorkPackage {id: 'WP-003'}), (agent1:Agent {id: 'AGENT-001'}) MERGE (wp3)-[:ASSIGNED_TO]->(agent1);
MATCH (wp4:WorkPackage {id: 'WP-004'}), (agent1:Agent {id: 'AGENT-001'}) MERGE (wp4)-[:ASSIGNED_TO]->(agent1);
MATCH (wp1:WorkPackage {id: 'WP-001'}), (review1:Review {id: 'REV-001'}) MERGE (wp1)-[:VERIFIED_BY]->(review1);
MATCH (ts1:TestSuite {id: 'TS-001'}), (tc1:TestCase {id: 'TC-001'}) MERGE (ts1)-[:CONTAINS]->(tc1);
MATCH (tc1:TestCase {id: 'TC-001'}), (ac1:AcceptanceCriterion {id: 'AC-001'}) MERGE (tc1)-[:VERIFIES]->(ac1);
MATCH (req1:Requirement {id: 'REQ-001'}), (tc1:TestCase {id: 'TC-001'}) MERGE (req1)-[:VERIFIED_BY]->(tc1);

MATCH (metric1:Metric {id: 'MET-001'}), (svc1:Service {id: 'SVC-001'}) MERGE (metric1)-[:MEASURES]->(svc1);
MATCH (sli1:SLI {id: 'SLI-001'}), (metric1:Metric {id: 'MET-001'}) MERGE (sli1)-[:DERIVED_FROM]->(metric1);
MATCH (slo1:SLO {id: 'SLO-001'}), (sli1:SLI {id: 'SLI-001'}) MERGE (slo1)-[:SETS_TARGET_FOR]->(sli1);
MATCH (alert1:Alert {id: 'ALT-001'}), (sli1:SLI {id: 'SLI-001'}) MERGE (alert1)-[:FIRES_ON]->(sli1);

MATCH (inc1:Incident {id: 'INC-001'}), (svc1:Service {id: 'SVC-001'}) MERGE (inc1)-[:AFFECTS]->(svc1);
MATCH (inc1:Incident {id: 'INC-001'}), (dep1:Deployment {id: 'DEP-001'}) MERGE (inc1)-[:TRIGGERED_BY]->(dep1);
MATCH (inc2:Incident {id: 'INC-002'}), (svc1:Service {id: 'SVC-001'}) MERGE (inc2)-[:AFFECTS]->(svc1);
MATCH (inc2:Incident {id: 'INC-002'}), (alert1:Alert {id: 'ALT-001'}) MERGE (inc2)-[:TRIGGERED_BY]->(alert1);
MATCH (pm1:Postmortem {id: 'PM-001'}), (inc1:Incident {id: 'INC-001'}) MERGE (pm1)-[:ANALYZES]->(inc1);
MATCH (pm1:Postmortem {id: 'PM-001'}), (wp5:WorkPackage {id: 'WP-005'}) MERGE (pm1)-[:CREATES]->(wp5);
MATCH (pm1:Postmortem {id: 'PM-001'}), (ass1:Assessment {id: 'ASS-001'}) MERGE (pm1)-[:UPDATES]->(ass1);

// -----------------------------------------------------------------------------
// Quick manual checks after loading
// -----------------------------------------------------------------------------
// MATCH (n) RETURN labels(n) AS labels, count(*) AS c ORDER BY c DESC;
// MATCH (wp:WorkPackage) RETURN wp.id, wp.status, wp.work_package_type, wp.allowed_tools, wp.acceptance_checks;
// MATCH (f:Feature {id: 'FEAT-001'})-[:IMPLEMENTS]->(cap)-[:REALIZES]->(out) RETURN f, cap, out;
