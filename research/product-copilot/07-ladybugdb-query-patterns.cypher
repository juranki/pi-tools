// Product Copilot LadybugDB query patterns
// Purpose: validate the LadybugDB-first schema against real retrieval needs.
// Assumes the schema from 06-ladybugdb-schema.cypher has already been applied.
// Notes:
// - queries stay bounded and task-shaped
// - user-supplied values should be passed as prepared-statement parameters
// - relationship names are endpoint-specific to match the executable
//   LadybugDB schema

// -----------------------------------------------------------------------------
// Q1. Why are we building this feature?
// Param: $feature_id
// -----------------------------------------------------------------------------
MATCH (f:Feature {id: $feature_id})
OPTIONAL MATCH (f)-[:IMPLEMENTS_CAPABILITY]->(cap:Capability)
OPTIONAL MATCH (cap)-[:REALIZES_OUTCOME]->(out:Outcome)
OPTIONAL MATCH (opp:Opportunity)-[:PURSUES_OUTCOME]->(out)
OPTIONAL MATCH (claim:Claim)-[:IMPLIES_OPPORTUNITY]->(opp)
OPTIONAL MATCH (ev:Evidence)-[:SUPPORTS_CLAIM]->(claim)
RETURN f,
       collect(DISTINCT cap) AS capabilities,
       collect(DISTINCT out) AS outcomes,
       collect(DISTINCT opp) AS opportunities,
       collect(DISTINCT claim) AS claims,
       collect(DISTINCT ev) AS supporting_evidence;

// -----------------------------------------------------------------------------
// Q2. Which requirements are approved but not yet implemented by any work package?
// -----------------------------------------------------------------------------
MATCH (r:Requirement)
WHERE r.status IN ['approved', 'implemented']
OPTIONAL MATCH (wp:WorkPackage)-[:IMPLEMENTS_REQUIREMENT]->(r)
WITH r, count(DISTINCT wp) AS work_package_count
WHERE work_package_count = 0
RETURN r.id, r.title, r.requirement_kind, r.priority, r.risk_level
ORDER BY r.priority DESC, r.id;

// -----------------------------------------------------------------------------
// Q3. Which requirements are missing acceptance criteria?
// -----------------------------------------------------------------------------
MATCH (r:Requirement)
OPTIONAL MATCH (r)-[:HAS_ACCEPTANCE]->(ac:AcceptanceCriterion)
WITH r, count(DISTINCT ac) AS acceptance_count
WHERE acceptance_count = 0
RETURN r.id, r.title, r.status, r.requirement_kind
ORDER BY r.id;

// -----------------------------------------------------------------------------
// Q4. Which work packages are ready for bounded autonomous execution?
// -----------------------------------------------------------------------------
MATCH (wp:WorkPackage)
WHERE wp.status = 'ready'
  AND wp.autonomy_level IN ['drafting', 'bounded_execution', 'managed_autonomy']
  AND wp.allowed_tools IS NOT NULL
  AND wp.acceptance_checks IS NOT NULL
OPTIONAL MATCH (wp)-[:DEPENDS_ON]->(dep:WorkPackage)
WITH wp,
     sum(CASE WHEN dep IS NOT NULL AND dep.status <> 'done' THEN 1 ELSE 0 END) AS open_dependency_count
WHERE open_dependency_count = 0
RETURN wp.id, wp.title, wp.work_package_type, wp.autonomy_level, wp.risk_level, wp.owner
ORDER BY wp.risk_level, wp.id;

// -----------------------------------------------------------------------------
// Q5. For a work package, what evidence, goals, requirements, and architecture
// context should an agent retrieve before execution?
// Param: $work_package_id
// -----------------------------------------------------------------------------
MATCH (wp:WorkPackage {id: $work_package_id})
OPTIONAL MATCH (wp)-[:IMPLEMENTS_REQUIREMENT]->(r:Requirement)
OPTIONAL MATCH (g:Goal)-[:DRIVES_REQUIREMENT]->(r)
OPTIONAL MATCH (d:Decision)-[:CREATES_REQUIREMENT]->(r)
OPTIONAL MATCH (d)-[:BASED_ON_EVIDENCE]->(ev:Evidence)
OPTIONAL MATCH (r)-[:ALLOCATED_TO_SERVICE]->(svc:Service)
RETURN wp,
       collect(DISTINCT r) AS requirements,
       collect(DISTINCT g) AS goals,
       collect(DISTINCT d) AS decisions,
       collect(DISTINCT ev) AS evidence,
       collect(DISTINCT svc) AS service_context;

// -----------------------------------------------------------------------------
// Q6. Which incidents trace back to architecture decisions or assumptions?
// -----------------------------------------------------------------------------
MATCH (i:Incident)-[:AFFECTS_SERVICE]->(s:Service)
OPTIONAL MATCH (adr:ADR)-[:DECIDES_SERVICE]->(s)
OPTIONAL MATCH (r:Requirement)-[:ALLOCATED_TO_SERVICE]->(s)
OPTIONAL MATCH (d:Decision)-[:CREATES_REQUIREMENT]->(r)
OPTIONAL MATCH (d)-[:RESOLVES_ASSUMPTION]->(a:Assumption)
RETURN i.id, i.title,
       collect(DISTINCT s.id) AS affected_services,
       collect(DISTINCT adr.id) AS adrs,
       collect(DISTINCT r.id) AS requirements,
       collect(DISTINCT d.id) AS decisions,
       collect(DISTINCT a.id) AS assumptions
ORDER BY i.id;

// -----------------------------------------------------------------------------
// Q7. What gap does a release close, and what plateau does it realize?
// Param: $release_id
// -----------------------------------------------------------------------------
MATCH (rel:Release {id: $release_id})
OPTIONAL MATCH (artifact:Artifact)-[:PRODUCES_RELEASE]->(rel)
OPTIONAL MATCH (wp:WorkPackage)-[:CHANGES_ARTIFACT]->(artifact)
OPTIONAL MATCH (gap:Gap)-[:ADDRESSED_BY_WORK_PACKAGE]->(wp)
OPTIONAL MATCH (wp)-[:PRODUCES_DELIVERABLE]->(del:Deliverable)
OPTIONAL MATCH (del)-[:REALIZES_PLATEAU]->(plat:Plateau)
RETURN rel,
       collect(DISTINCT artifact) AS artifacts,
       collect(DISTINCT wp) AS work_packages,
       collect(DISTINCT gap) AS closed_gaps,
       collect(DISTINCT del) AS deliverables,
       collect(DISTINCT plat) AS target_plateaus;

// -----------------------------------------------------------------------------
// Q8. Which goals have weak evidence support?
// Heuristic: goals linked to requirements whose creating decisions cite fewer than
// two evidence nodes.
// -----------------------------------------------------------------------------
MATCH (g:Goal)-[:DRIVES_REQUIREMENT]->(r:Requirement)
OPTIONAL MATCH (d:Decision)-[:CREATES_REQUIREMENT]->(r)
OPTIONAL MATCH (d)-[:BASED_ON_EVIDENCE]->(ev:Evidence)
WITH g, count(DISTINCT ev) AS evidence_count, collect(DISTINCT d.id) AS decisions
WHERE evidence_count < 2
RETURN g.id, g.title, evidence_count, decisions
ORDER BY evidence_count ASC, g.id;

// -----------------------------------------------------------------------------
// Q9. Which reviewed incidents are missing a postmortem or follow-up work?
// -----------------------------------------------------------------------------
MATCH (i:Incident {status: 'reviewed'})
OPTIONAL MATCH (pm:Postmortem)-[:ANALYZES_INCIDENT]->(i)
OPTIONAL MATCH (pm)-[:CREATES_WORK_PACKAGE]->(wp:WorkPackage)
WITH i, count(DISTINCT pm) AS postmortem_count, count(DISTINCT wp) AS followup_count
WHERE postmortem_count = 0 OR followup_count = 0
RETURN i.id, i.title, i.risk_level, i.owner_team, postmortem_count, followup_count
ORDER BY i.risk_level DESC, i.id;

// -----------------------------------------------------------------------------
// Q10. What is the end-to-end trace from feature to runtime metric?
// Param: $feature_id
// -----------------------------------------------------------------------------
MATCH (f:Feature {id: $feature_id})
OPTIONAL MATCH (f)-[:IMPLEMENTS_CAPABILITY]->(cap:Capability)
OPTIONAL MATCH (cap)-[:REALIZES_OUTCOME]->(out:Outcome)
OPTIONAL MATCH (opp:Opportunity)-[:PURSUES_OUTCOME]->(out)
OPTIONAL MATCH (claim:Claim)-[:IMPLIES_OPPORTUNITY]->(opp)
OPTIONAL MATCH (ev:Evidence)-[:SUPPORTS_CLAIM]->(claim)
OPTIONAL MATCH (f)-[:ADDRESSES_REQUIREMENT]->(r:Requirement)
OPTIONAL MATCH (wp:WorkPackage)-[:IMPLEMENTS_REQUIREMENT]->(r)
OPTIONAL MATCH (r)-[:ALLOCATED_TO_SERVICE]->(svc:Service)
OPTIONAL MATCH (m:Metric)-[:MEASURES_SERVICE]->(svc)
RETURN f,
       collect(DISTINCT cap) AS capabilities,
       collect(DISTINCT out) AS outcomes,
       collect(DISTINCT opp) AS opportunities,
       collect(DISTINCT ev) AS evidence,
       collect(DISTINCT r) AS requirements,
       collect(DISTINCT wp) AS work_packages,
       collect(DISTINCT svc) AS services,
       collect(DISTINCT m) AS runtime_metrics;
