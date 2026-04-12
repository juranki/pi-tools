// Archived comparison asset. Original role: Product Copilot Neo4j query patterns.
// Current default backend is LadybugDB.
// Product Copilot Neo4j query patterns
// Purpose: validate the ontology against real retrieval needs.
// Assumes the schema from 06-neo4j-bootstrap.cypher has already been applied.

// -----------------------------------------------------------------------------
// Q1. Why are we building this feature?
// Param: $feature_id
// -----------------------------------------------------------------------------
MATCH (f:Feature {id: $feature_id})
OPTIONAL MATCH (f)-[:IMPLEMENTS]->(cap:Capability)
OPTIONAL MATCH (cap)-[:REALIZES]->(out:Outcome)
OPTIONAL MATCH (opp:Opportunity)-[:PURSUES]->(out)
OPTIONAL MATCH (claim:Claim)-[:IMPLIES]->(opp)
OPTIONAL MATCH (ev:Evidence)-[:SUPPORTS]->(claim)
RETURN f, cap, out, opp, claim, collect(DISTINCT ev) AS supporting_evidence;

// -----------------------------------------------------------------------------
// Q2. Which requirements are approved but not yet implemented by any work package?
// -----------------------------------------------------------------------------
MATCH (r:Requirement)
WHERE r.status IN ['approved', 'implemented']
  AND NOT EXISTS {
    MATCH (:WorkPackage)-[:IMPLEMENTS]->(r)
  }
RETURN r.id, r.title, r.requirement_kind, r.priority, r.risk_level
ORDER BY r.priority DESC, r.id;

// -----------------------------------------------------------------------------
// Q3. Which requirements are missing acceptance criteria?
// -----------------------------------------------------------------------------
MATCH (r:Requirement)
WHERE NOT EXISTS {
  MATCH (r)-[:HAS_ACCEPTANCE]->(:AcceptanceCriterion)
}
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
  AND NOT EXISTS {
    MATCH (wp)-[:DEPENDS_ON]->(blocked:WorkPackage)
    WHERE blocked.status <> 'done'
  }
RETURN wp.id, wp.title, wp.work_package_type, wp.autonomy_level, wp.risk_level, wp.owner
ORDER BY wp.risk_level, wp.id;

// -----------------------------------------------------------------------------
// Q5. For a work package, what evidence, goals, requirements, and architecture
// context should an agent retrieve before execution?
// Param: $work_package_id
// -----------------------------------------------------------------------------
MATCH (wp:WorkPackage {id: $work_package_id})
OPTIONAL MATCH (wp)-[:IMPLEMENTS]->(r:Requirement)
OPTIONAL MATCH (r)<-[:DRIVES]-(g:Goal)
OPTIONAL MATCH (d:Decision)-[:CREATES]->(r)
OPTIONAL MATCH (d)-[:BASED_ON]->(ev:Evidence)
OPTIONAL MATCH (r)-[:ALLOCATED_TO]->(arch)
RETURN wp,
       collect(DISTINCT r) AS requirements,
       collect(DISTINCT g) AS goals,
       collect(DISTINCT d) AS decisions,
       collect(DISTINCT ev) AS evidence,
       collect(DISTINCT arch) AS architecture_context;

// -----------------------------------------------------------------------------
// Q6. Which incidents trace back to architecture decisions or assumptions?
// -----------------------------------------------------------------------------
MATCH (i:Incident)-[:AFFECTS]->(s:Service)
OPTIONAL MATCH (adr:ADR)-[:DECIDES]->(s)
OPTIONAL MATCH (r:Requirement)-[:ALLOCATED_TO]->(s)
OPTIONAL MATCH (d:Decision)-[:CREATES]->(r)
OPTIONAL MATCH (d)-[:RESOLVES]->(a:Assumption)
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
OPTIONAL MATCH (artifact:Artifact)-[:PRODUCES]->(rel)
OPTIONAL MATCH (wp:WorkPackage)-[:CHANGES]->(artifact)
OPTIONAL MATCH (gap:Gap)-[:ADDRESSED_BY]->(wp)
OPTIONAL MATCH (wp)-[:PRODUCES]->(del:Deliverable)
OPTIONAL MATCH (del)-[:REALIZES]->(plat:Plateau)
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
MATCH (g:Goal)-[:DRIVES]->(r:Requirement)
OPTIONAL MATCH (d:Decision)-[:CREATES]->(r)
OPTIONAL MATCH (d)-[:BASED_ON]->(ev:Evidence)
WITH g, count(DISTINCT ev) AS evidence_count, collect(DISTINCT d.id) AS decisions
WHERE evidence_count < 2
RETURN g.id, g.title, evidence_count, decisions
ORDER BY evidence_count ASC, g.id;

// -----------------------------------------------------------------------------
// Q9. Which reviewed incidents are missing a postmortem or follow-up work?
// -----------------------------------------------------------------------------
MATCH (i:Incident {status: 'reviewed'})
OPTIONAL MATCH (pm:Postmortem)-[:ANALYZES]->(i)
OPTIONAL MATCH (pm)-[:CREATES]->(wp:WorkPackage)
WITH i, count(DISTINCT pm) AS postmortem_count, count(DISTINCT wp) AS followup_count
WHERE postmortem_count = 0 OR followup_count = 0
RETURN i.id, i.title, i.risk_level, i.owner_team, postmortem_count, followup_count
ORDER BY i.risk_level DESC, i.id;

// -----------------------------------------------------------------------------
// Q10. What is the end-to-end trace from signal to runtime metric for a feature?
// Param: $feature_id
// -----------------------------------------------------------------------------
MATCH (f:Feature {id: $feature_id})-[:IMPLEMENTS]->(cap:Capability)-[:REALIZES]->(out:Outcome)
OPTIONAL MATCH (opp:Opportunity)-[:PURSUES]->(out)
OPTIONAL MATCH (claim:Claim)-[:IMPLIES]->(opp)
OPTIONAL MATCH (ev:Evidence)-[:SUPPORTS]->(claim)
OPTIONAL MATCH (wp:WorkPackage)-[:IMPLEMENTS]->(r:Requirement)
OPTIONAL MATCH (f)-[:ADDRESSES]->(r)
OPTIONAL MATCH (r)-[:ALLOCATED_TO]->(svc)
OPTIONAL MATCH (m:Metric)-[:MEASURES]->(svc)
RETURN f,
       collect(DISTINCT ev) AS evidence,
       collect(DISTINCT opp) AS opportunities,
       collect(DISTINCT out) AS outcomes,
       collect(DISTINCT r) AS requirements,
       collect(DISTINCT svc) AS services,
       collect(DISTINCT m) AS runtime_metrics,
       collect(DISTINCT wp) AS work_packages;
