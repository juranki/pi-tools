// Archived comparison asset. Original role: Product Copilot Neo4j bootstrap.
// Current default backend is LadybugDB.
// Product Copilot Neo4j bootstrap
// Generated from research/product-copilot/05-ontology-v0.yaml
// Target: Neo4j 5.x
// Notes:
// - Creates label-scoped id uniqueness and required-property existence constraints
// - Creates a curated set of property indexes for common retrieval paths
// - Adjust index volume after observing real query plans

// ---- Uniqueness and required-property constraints ----
CREATE CONSTRAINT adr_id_unique IF NOT EXISTS
FOR (n:ADR) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT adr_title_required IF NOT EXISTS
FOR (n:ADR) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT adr_status_required IF NOT EXISTS
FOR (n:ADR) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT adr_rationale_required IF NOT EXISTS
FOR (n:ADR) REQUIRE n.rationale IS NOT NULL;

CREATE CONSTRAINT api_id_unique IF NOT EXISTS
FOR (n:API) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT api_title_required IF NOT EXISTS
FOR (n:API) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT api_status_required IF NOT EXISTS
FOR (n:API) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT acceptancecriterion_id_unique IF NOT EXISTS
FOR (n:AcceptanceCriterion) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT acceptancecriterion_title_required IF NOT EXISTS
FOR (n:AcceptanceCriterion) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT acceptancecriterion_status_required IF NOT EXISTS
FOR (n:AcceptanceCriterion) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT agent_id_unique IF NOT EXISTS
FOR (n:Agent) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT agent_title_required IF NOT EXISTS
FOR (n:Agent) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT agent_status_required IF NOT EXISTS
FOR (n:Agent) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT alert_id_unique IF NOT EXISTS
FOR (n:Alert) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT alert_title_required IF NOT EXISTS
FOR (n:Alert) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT alert_status_required IF NOT EXISTS
FOR (n:Alert) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT alert_threshold_required IF NOT EXISTS
FOR (n:Alert) REQUIRE n.threshold IS NOT NULL;

CREATE CONSTRAINT applicationservice_id_unique IF NOT EXISTS
FOR (n:ApplicationService) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT applicationservice_title_required IF NOT EXISTS
FOR (n:ApplicationService) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT applicationservice_status_required IF NOT EXISTS
FOR (n:ApplicationService) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT applicationservice_service_kind_required IF NOT EXISTS
FOR (n:ApplicationService) REQUIRE n.service_kind IS NOT NULL;

CREATE CONSTRAINT approvalpolicy_id_unique IF NOT EXISTS
FOR (n:ApprovalPolicy) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT approvalpolicy_title_required IF NOT EXISTS
FOR (n:ApprovalPolicy) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT approvalpolicy_status_required IF NOT EXISTS
FOR (n:ApprovalPolicy) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT artifact_id_unique IF NOT EXISTS
FOR (n:Artifact) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT artifact_title_required IF NOT EXISTS
FOR (n:Artifact) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT artifact_status_required IF NOT EXISTS
FOR (n:Artifact) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT artifact_artifact_kind_required IF NOT EXISTS
FOR (n:Artifact) REQUIRE n.artifact_kind IS NOT NULL;

CREATE CONSTRAINT assessment_id_unique IF NOT EXISTS
FOR (n:Assessment) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT assessment_title_required IF NOT EXISTS
FOR (n:Assessment) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT assessment_status_required IF NOT EXISTS
FOR (n:Assessment) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT assumption_id_unique IF NOT EXISTS
FOR (n:Assumption) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT assumption_title_required IF NOT EXISTS
FOR (n:Assumption) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT assumption_status_required IF NOT EXISTS
FOR (n:Assumption) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT auditrecord_id_unique IF NOT EXISTS
FOR (n:AuditRecord) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT auditrecord_title_required IF NOT EXISTS
FOR (n:AuditRecord) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT auditrecord_status_required IF NOT EXISTS
FOR (n:AuditRecord) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT boundedcontext_id_unique IF NOT EXISTS
FOR (n:BoundedContext) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT boundedcontext_title_required IF NOT EXISTS
FOR (n:BoundedContext) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT boundedcontext_status_required IF NOT EXISTS
FOR (n:BoundedContext) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT businessservice_id_unique IF NOT EXISTS
FOR (n:BusinessService) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT businessservice_title_required IF NOT EXISTS
FOR (n:BusinessService) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT businessservice_status_required IF NOT EXISTS
FOR (n:BusinessService) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT businessservice_service_kind_required IF NOT EXISTS
FOR (n:BusinessService) REQUIRE n.service_kind IS NOT NULL;

CREATE CONSTRAINT capability_id_unique IF NOT EXISTS
FOR (n:Capability) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT capability_title_required IF NOT EXISTS
FOR (n:Capability) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT capability_status_required IF NOT EXISTS
FOR (n:Capability) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT claim_id_unique IF NOT EXISTS
FOR (n:Claim) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT claim_title_required IF NOT EXISTS
FOR (n:Claim) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT claim_status_required IF NOT EXISTS
FOR (n:Claim) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT competitor_id_unique IF NOT EXISTS
FOR (n:Competitor) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT competitor_title_required IF NOT EXISTS
FOR (n:Competitor) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT competitor_status_required IF NOT EXISTS
FOR (n:Competitor) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT compliancerequirement_id_unique IF NOT EXISTS
FOR (n:ComplianceRequirement) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT compliancerequirement_title_required IF NOT EXISTS
FOR (n:ComplianceRequirement) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT compliancerequirement_status_required IF NOT EXISTS
FOR (n:ComplianceRequirement) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT component_id_unique IF NOT EXISTS
FOR (n:Component) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT component_title_required IF NOT EXISTS
FOR (n:Component) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT component_status_required IF NOT EXISTS
FOR (n:Component) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT constraint_id_unique IF NOT EXISTS
FOR (n:Constraint) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT constraint_title_required IF NOT EXISTS
FOR (n:Constraint) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT constraint_status_required IF NOT EXISTS
FOR (n:Constraint) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT control_id_unique IF NOT EXISTS
FOR (n:Control) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT control_title_required IF NOT EXISTS
FOR (n:Control) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT control_status_required IF NOT EXISTS
FOR (n:Control) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT costitem_id_unique IF NOT EXISTS
FOR (n:CostItem) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT costitem_title_required IF NOT EXISTS
FOR (n:CostItem) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT costitem_status_required IF NOT EXISTS
FOR (n:CostItem) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT courseofaction_id_unique IF NOT EXISTS
FOR (n:CourseOfAction) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT courseofaction_title_required IF NOT EXISTS
FOR (n:CourseOfAction) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT courseofaction_status_required IF NOT EXISTS
FOR (n:CourseOfAction) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT dataentity_id_unique IF NOT EXISTS
FOR (n:DataEntity) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT dataentity_title_required IF NOT EXISTS
FOR (n:DataEntity) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT dataentity_status_required IF NOT EXISTS
FOR (n:DataEntity) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT decision_id_unique IF NOT EXISTS
FOR (n:Decision) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT decision_title_required IF NOT EXISTS
FOR (n:Decision) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT decision_status_required IF NOT EXISTS
FOR (n:Decision) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT decision_rationale_required IF NOT EXISTS
FOR (n:Decision) REQUIRE n.rationale IS NOT NULL;

CREATE CONSTRAINT deliverable_id_unique IF NOT EXISTS
FOR (n:Deliverable) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT deliverable_title_required IF NOT EXISTS
FOR (n:Deliverable) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT deliverable_status_required IF NOT EXISTS
FOR (n:Deliverable) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT deployment_id_unique IF NOT EXISTS
FOR (n:Deployment) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT deployment_title_required IF NOT EXISTS
FOR (n:Deployment) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT deployment_status_required IF NOT EXISTS
FOR (n:Deployment) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT document_id_unique IF NOT EXISTS
FOR (n:Document) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT document_title_required IF NOT EXISTS
FOR (n:Document) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT document_status_required IF NOT EXISTS
FOR (n:Document) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT driver_id_unique IF NOT EXISTS
FOR (n:Driver) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT driver_title_required IF NOT EXISTS
FOR (n:Driver) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT driver_status_required IF NOT EXISTS
FOR (n:Driver) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT environment_id_unique IF NOT EXISTS
FOR (n:Environment) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT environment_title_required IF NOT EXISTS
FOR (n:Environment) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT environment_status_required IF NOT EXISTS
FOR (n:Environment) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT environment_environment_kind_required IF NOT EXISTS
FOR (n:Environment) REQUIRE n.environment_kind IS NOT NULL;

CREATE CONSTRAINT epic_id_unique IF NOT EXISTS
FOR (n:Epic) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT epic_title_required IF NOT EXISTS
FOR (n:Epic) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT epic_status_required IF NOT EXISTS
FOR (n:Epic) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT event_id_unique IF NOT EXISTS
FOR (n:Event) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT event_title_required IF NOT EXISTS
FOR (n:Event) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT event_status_required IF NOT EXISTS
FOR (n:Event) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT evidence_id_unique IF NOT EXISTS
FOR (n:Evidence) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT evidence_title_required IF NOT EXISTS
FOR (n:Evidence) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT evidence_status_required IF NOT EXISTS
FOR (n:Evidence) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT experiment_id_unique IF NOT EXISTS
FOR (n:Experiment) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT experiment_title_required IF NOT EXISTS
FOR (n:Experiment) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT experiment_status_required IF NOT EXISTS
FOR (n:Experiment) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT experiment_objective_required IF NOT EXISTS
FOR (n:Experiment) REQUIRE n.objective IS NOT NULL;

CREATE CONSTRAINT feature_id_unique IF NOT EXISTS
FOR (n:Feature) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT feature_title_required IF NOT EXISTS
FOR (n:Feature) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT feature_status_required IF NOT EXISTS
FOR (n:Feature) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT gap_id_unique IF NOT EXISTS
FOR (n:Gap) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT gap_title_required IF NOT EXISTS
FOR (n:Gap) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT gap_status_required IF NOT EXISTS
FOR (n:Gap) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT gate_id_unique IF NOT EXISTS
FOR (n:Gate) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT gate_title_required IF NOT EXISTS
FOR (n:Gate) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT gate_status_required IF NOT EXISTS
FOR (n:Gate) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT goal_id_unique IF NOT EXISTS
FOR (n:Goal) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT goal_title_required IF NOT EXISTS
FOR (n:Goal) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT goal_status_required IF NOT EXISTS
FOR (n:Goal) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT incident_id_unique IF NOT EXISTS
FOR (n:Incident) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT incident_title_required IF NOT EXISTS
FOR (n:Incident) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT incident_status_required IF NOT EXISTS
FOR (n:Incident) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT incident_risk_level_required IF NOT EXISTS
FOR (n:Incident) REQUIRE n.risk_level IS NOT NULL;

CREATE CONSTRAINT job_id_unique IF NOT EXISTS
FOR (n:Job) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT job_title_required IF NOT EXISTS
FOR (n:Job) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT job_status_required IF NOT EXISTS
FOR (n:Job) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT kpi_id_unique IF NOT EXISTS
FOR (n:KPI) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT kpi_title_required IF NOT EXISTS
FOR (n:KPI) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT kpi_status_required IF NOT EXISTS
FOR (n:KPI) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT kpi_metric_definition_required IF NOT EXISTS
FOR (n:KPI) REQUIRE n.metric_definition IS NOT NULL;

CREATE CONSTRAINT market_id_unique IF NOT EXISTS
FOR (n:Market) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT market_title_required IF NOT EXISTS
FOR (n:Market) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT market_status_required IF NOT EXISTS
FOR (n:Market) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT metric_id_unique IF NOT EXISTS
FOR (n:Metric) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT metric_title_required IF NOT EXISTS
FOR (n:Metric) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT metric_status_required IF NOT EXISTS
FOR (n:Metric) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT metric_metric_kind_required IF NOT EXISTS
FOR (n:Metric) REQUIRE n.metric_kind IS NOT NULL;

CREATE CONSTRAINT metric_metric_definition_required IF NOT EXISTS
FOR (n:Metric) REQUIRE n.metric_definition IS NOT NULL;

CREATE CONSTRAINT opportunity_id_unique IF NOT EXISTS
FOR (n:Opportunity) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT opportunity_title_required IF NOT EXISTS
FOR (n:Opportunity) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT opportunity_status_required IF NOT EXISTS
FOR (n:Opportunity) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT outcome_id_unique IF NOT EXISTS
FOR (n:Outcome) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT outcome_title_required IF NOT EXISTS
FOR (n:Outcome) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT outcome_status_required IF NOT EXISTS
FOR (n:Outcome) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT persona_id_unique IF NOT EXISTS
FOR (n:Persona) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT persona_title_required IF NOT EXISTS
FOR (n:Persona) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT persona_status_required IF NOT EXISTS
FOR (n:Persona) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT plateau_id_unique IF NOT EXISTS
FOR (n:Plateau) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT plateau_title_required IF NOT EXISTS
FOR (n:Plateau) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT plateau_status_required IF NOT EXISTS
FOR (n:Plateau) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT policy_id_unique IF NOT EXISTS
FOR (n:Policy) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT policy_title_required IF NOT EXISTS
FOR (n:Policy) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT policy_status_required IF NOT EXISTS
FOR (n:Policy) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT postmortem_id_unique IF NOT EXISTS
FOR (n:Postmortem) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT postmortem_title_required IF NOT EXISTS
FOR (n:Postmortem) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT postmortem_status_required IF NOT EXISTS
FOR (n:Postmortem) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT principle_id_unique IF NOT EXISTS
FOR (n:Principle) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT principle_title_required IF NOT EXISTS
FOR (n:Principle) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT principle_status_required IF NOT EXISTS
FOR (n:Principle) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT release_id_unique IF NOT EXISTS
FOR (n:Release) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT release_title_required IF NOT EXISTS
FOR (n:Release) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT release_status_required IF NOT EXISTS
FOR (n:Release) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT releasegoal_id_unique IF NOT EXISTS
FOR (n:ReleaseGoal) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT releasegoal_title_required IF NOT EXISTS
FOR (n:ReleaseGoal) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT releasegoal_status_required IF NOT EXISTS
FOR (n:ReleaseGoal) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT requirement_id_unique IF NOT EXISTS
FOR (n:Requirement) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT requirement_title_required IF NOT EXISTS
FOR (n:Requirement) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT requirement_status_required IF NOT EXISTS
FOR (n:Requirement) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT requirement_requirement_kind_required IF NOT EXISTS
FOR (n:Requirement) REQUIRE n.requirement_kind IS NOT NULL;

CREATE CONSTRAINT result_id_unique IF NOT EXISTS
FOR (n:Result) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT result_title_required IF NOT EXISTS
FOR (n:Result) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT result_status_required IF NOT EXISTS
FOR (n:Result) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT review_id_unique IF NOT EXISTS
FOR (n:Review) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT review_title_required IF NOT EXISTS
FOR (n:Review) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT review_status_required IF NOT EXISTS
FOR (n:Review) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT risk_id_unique IF NOT EXISTS
FOR (n:Risk) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT risk_title_required IF NOT EXISTS
FOR (n:Risk) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT risk_status_required IF NOT EXISTS
FOR (n:Risk) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT risk_risk_level_required IF NOT EXISTS
FOR (n:Risk) REQUIRE n.risk_level IS NOT NULL;

CREATE CONSTRAINT runbook_id_unique IF NOT EXISTS
FOR (n:Runbook) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT runbook_title_required IF NOT EXISTS
FOR (n:Runbook) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT runbook_status_required IF NOT EXISTS
FOR (n:Runbook) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT sli_id_unique IF NOT EXISTS
FOR (n:SLI) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT sli_title_required IF NOT EXISTS
FOR (n:SLI) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT sli_status_required IF NOT EXISTS
FOR (n:SLI) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT slo_id_unique IF NOT EXISTS
FOR (n:SLO) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT slo_title_required IF NOT EXISTS
FOR (n:SLO) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT slo_status_required IF NOT EXISTS
FOR (n:SLO) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT slo_target_value_required IF NOT EXISTS
FOR (n:SLO) REQUIRE n.target_value IS NOT NULL;

CREATE CONSTRAINT segment_id_unique IF NOT EXISTS
FOR (n:Segment) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT segment_title_required IF NOT EXISTS
FOR (n:Segment) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT segment_status_required IF NOT EXISTS
FOR (n:Segment) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT service_id_unique IF NOT EXISTS
FOR (n:Service) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT service_title_required IF NOT EXISTS
FOR (n:Service) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT service_status_required IF NOT EXISTS
FOR (n:Service) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT signal_id_unique IF NOT EXISTS
FOR (n:Signal) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT signal_title_required IF NOT EXISTS
FOR (n:Signal) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT signal_status_required IF NOT EXISTS
FOR (n:Signal) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT signal_signal_kind_required IF NOT EXISTS
FOR (n:Signal) REQUIRE n.signal_kind IS NOT NULL;

CREATE CONSTRAINT source_id_unique IF NOT EXISTS
FOR (n:Source) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT source_title_required IF NOT EXISTS
FOR (n:Source) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT source_status_required IF NOT EXISTS
FOR (n:Source) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT source_source_type_required IF NOT EXISTS
FOR (n:Source) REQUIRE n.source_type IS NOT NULL;

CREATE CONSTRAINT story_id_unique IF NOT EXISTS
FOR (n:Story) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT story_title_required IF NOT EXISTS
FOR (n:Story) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT story_status_required IF NOT EXISTS
FOR (n:Story) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT task_id_unique IF NOT EXISTS
FOR (n:Task) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT task_title_required IF NOT EXISTS
FOR (n:Task) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT task_status_required IF NOT EXISTS
FOR (n:Task) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT technologyservice_id_unique IF NOT EXISTS
FOR (n:TechnologyService) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT technologyservice_title_required IF NOT EXISTS
FOR (n:TechnologyService) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT technologyservice_status_required IF NOT EXISTS
FOR (n:TechnologyService) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT technologyservice_service_kind_required IF NOT EXISTS
FOR (n:TechnologyService) REQUIRE n.service_kind IS NOT NULL;

CREATE CONSTRAINT testcase_id_unique IF NOT EXISTS
FOR (n:TestCase) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT testcase_title_required IF NOT EXISTS
FOR (n:TestCase) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT testcase_status_required IF NOT EXISTS
FOR (n:TestCase) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT testsuite_id_unique IF NOT EXISTS
FOR (n:TestSuite) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT testsuite_title_required IF NOT EXISTS
FOR (n:TestSuite) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT testsuite_status_required IF NOT EXISTS
FOR (n:TestSuite) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT valuestream_id_unique IF NOT EXISTS
FOR (n:ValueStream) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT valuestream_title_required IF NOT EXISTS
FOR (n:ValueStream) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT valuestream_status_required IF NOT EXISTS
FOR (n:ValueStream) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT workpackage_id_unique IF NOT EXISTS
FOR (n:WorkPackage) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT workpackage_title_required IF NOT EXISTS
FOR (n:WorkPackage) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT workpackage_status_required IF NOT EXISTS
FOR (n:WorkPackage) REQUIRE n.status IS NOT NULL;

CREATE CONSTRAINT workpackage_work_package_type_required IF NOT EXISTS
FOR (n:WorkPackage) REQUIRE n.work_package_type IS NOT NULL;

CREATE CONSTRAINT workpackage_objective_required IF NOT EXISTS
FOR (n:WorkPackage) REQUIRE n.objective IS NOT NULL;

CREATE CONSTRAINT workflow_id_unique IF NOT EXISTS
FOR (n:Workflow) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT workflow_title_required IF NOT EXISTS
FOR (n:Workflow) REQUIRE n.title IS NOT NULL;

CREATE CONSTRAINT workflow_status_required IF NOT EXISTS
FOR (n:Workflow) REQUIRE n.status IS NOT NULL;

// ---- Lookup and search indexes ----
CREATE FULLTEXT INDEX product_copilot_title_summary_search IF NOT EXISTS
FOR (n:ADR|API|AcceptanceCriterion|Agent|Alert|ApplicationService|ApprovalPolicy|Artifact|Assessment|Assumption|AuditRecord|BoundedContext|BusinessService|Capability|Claim|Competitor|ComplianceRequirement|Component|Constraint|Control|CostItem|CourseOfAction|DataEntity|Decision|Deliverable|Deployment|Document|Driver|Environment|Epic|Event|Evidence|Experiment|Feature|Gap|Gate|Goal|Incident|Job|KPI|Market|Metric|Opportunity|Outcome|Persona|Plateau|Policy|Postmortem|Principle|Release|ReleaseGoal|Requirement|Result|Review|Risk|Runbook|SLI|SLO|Segment|Service|Signal|Source|Story|Task|TechnologyService|TestCase|TestSuite|ValueStream|WorkPackage|Workflow) ON EACH [n.title, n.summary, n.rationale];

CREATE INDEX signal_signal_kind_idx IF NOT EXISTS
FOR (n:Signal) ON (n.signal_kind);

CREATE INDEX signal_status_idx IF NOT EXISTS
FOR (n:Signal) ON (n.status);

CREATE INDEX signal_confidence_idx IF NOT EXISTS
FOR (n:Signal) ON (n.confidence);

CREATE INDEX evidence_status_idx IF NOT EXISTS
FOR (n:Evidence) ON (n.status);

CREATE INDEX evidence_confidence_idx IF NOT EXISTS
FOR (n:Evidence) ON (n.confidence);

CREATE INDEX evidence_review_status_idx IF NOT EXISTS
FOR (n:Evidence) ON (n.review_status);

CREATE INDEX claim_status_idx IF NOT EXISTS
FOR (n:Claim) ON (n.status);

CREATE INDEX claim_confidence_idx IF NOT EXISTS
FOR (n:Claim) ON (n.confidence);

CREATE INDEX decision_status_idx IF NOT EXISTS
FOR (n:Decision) ON (n.status);

CREATE INDEX decision_owner_idx IF NOT EXISTS
FOR (n:Decision) ON (n.owner);

CREATE INDEX decision_priority_idx IF NOT EXISTS
FOR (n:Decision) ON (n.priority);

CREATE INDEX goal_status_idx IF NOT EXISTS
FOR (n:Goal) ON (n.status);

CREATE INDEX goal_priority_idx IF NOT EXISTS
FOR (n:Goal) ON (n.priority);

CREATE INDEX goal_owner_team_idx IF NOT EXISTS
FOR (n:Goal) ON (n.owner_team);

CREATE INDEX outcome_status_idx IF NOT EXISTS
FOR (n:Outcome) ON (n.status);

CREATE INDEX outcome_owner_team_idx IF NOT EXISTS
FOR (n:Outcome) ON (n.owner_team);

CREATE INDEX opportunity_status_idx IF NOT EXISTS
FOR (n:Opportunity) ON (n.status);

CREATE INDEX opportunity_priority_idx IF NOT EXISTS
FOR (n:Opportunity) ON (n.priority);

CREATE INDEX opportunity_confidence_idx IF NOT EXISTS
FOR (n:Opportunity) ON (n.confidence);

CREATE INDEX feature_status_idx IF NOT EXISTS
FOR (n:Feature) ON (n.status);

CREATE INDEX feature_priority_idx IF NOT EXISTS
FOR (n:Feature) ON (n.priority);

CREATE INDEX requirement_status_idx IF NOT EXISTS
FOR (n:Requirement) ON (n.status);

CREATE INDEX requirement_requirement_kind_idx IF NOT EXISTS
FOR (n:Requirement) ON (n.requirement_kind);

CREATE INDEX requirement_priority_idx IF NOT EXISTS
FOR (n:Requirement) ON (n.priority);

CREATE INDEX requirement_risk_level_idx IF NOT EXISTS
FOR (n:Requirement) ON (n.risk_level);

CREATE INDEX constraint_status_idx IF NOT EXISTS
FOR (n:Constraint) ON (n.status);

CREATE INDEX constraint_risk_level_idx IF NOT EXISTS
FOR (n:Constraint) ON (n.risk_level);

CREATE INDEX risk_status_idx IF NOT EXISTS
FOR (n:Risk) ON (n.status);

CREATE INDEX risk_risk_level_idx IF NOT EXISTS
FOR (n:Risk) ON (n.risk_level);

CREATE INDEX workpackage_status_idx IF NOT EXISTS
FOR (n:WorkPackage) ON (n.status);

CREATE INDEX workpackage_work_package_type_idx IF NOT EXISTS
FOR (n:WorkPackage) ON (n.work_package_type);

CREATE INDEX workpackage_autonomy_level_idx IF NOT EXISTS
FOR (n:WorkPackage) ON (n.autonomy_level);

CREATE INDEX workpackage_risk_level_idx IF NOT EXISTS
FOR (n:WorkPackage) ON (n.risk_level);

CREATE INDEX workpackage_owner_idx IF NOT EXISTS
FOR (n:WorkPackage) ON (n.owner);

CREATE INDEX deliverable_status_idx IF NOT EXISTS
FOR (n:Deliverable) ON (n.status);

CREATE INDEX deliverable_artifact_kind_idx IF NOT EXISTS
FOR (n:Deliverable) ON (n.artifact_kind);

CREATE INDEX deliverable_version_idx IF NOT EXISTS
FOR (n:Deliverable) ON (n.version);

CREATE INDEX artifact_status_idx IF NOT EXISTS
FOR (n:Artifact) ON (n.status);

CREATE INDEX artifact_artifact_kind_idx IF NOT EXISTS
FOR (n:Artifact) ON (n.artifact_kind);

CREATE INDEX artifact_version_idx IF NOT EXISTS
FOR (n:Artifact) ON (n.version);

CREATE INDEX release_status_idx IF NOT EXISTS
FOR (n:Release) ON (n.status);

CREATE INDEX release_version_idx IF NOT EXISTS
FOR (n:Release) ON (n.version);

CREATE INDEX release_owner_team_idx IF NOT EXISTS
FOR (n:Release) ON (n.owner_team);

CREATE INDEX deployment_status_idx IF NOT EXISTS
FOR (n:Deployment) ON (n.status);

CREATE INDEX deployment_owner_team_idx IF NOT EXISTS
FOR (n:Deployment) ON (n.owner_team);

CREATE INDEX metric_status_idx IF NOT EXISTS
FOR (n:Metric) ON (n.status);

CREATE INDEX metric_metric_kind_idx IF NOT EXISTS
FOR (n:Metric) ON (n.metric_kind);

CREATE INDEX incident_status_idx IF NOT EXISTS
FOR (n:Incident) ON (n.status);

CREATE INDEX incident_risk_level_idx IF NOT EXISTS
FOR (n:Incident) ON (n.risk_level);

CREATE INDEX incident_owner_team_idx IF NOT EXISTS
FOR (n:Incident) ON (n.owner_team);

CREATE INDEX environment_status_idx IF NOT EXISTS
FOR (n:Environment) ON (n.status);

CREATE INDEX environment_environment_kind_idx IF NOT EXISTS
FOR (n:Environment) ON (n.environment_kind);

CREATE INDEX review_status_idx IF NOT EXISTS
FOR (n:Review) ON (n.status);

CREATE INDEX review_owner_idx IF NOT EXISTS
FOR (n:Review) ON (n.owner);

CREATE INDEX agent_status_idx IF NOT EXISTS
FOR (n:Agent) ON (n.status);

CREATE INDEX service_status_idx IF NOT EXISTS
FOR (n:Service) ON (n.status);

CREATE INDEX service_owner_team_idx IF NOT EXISTS
FOR (n:Service) ON (n.owner_team);

CREATE INDEX applicationservice_status_idx IF NOT EXISTS
FOR (n:ApplicationService) ON (n.status);

CREATE INDEX applicationservice_owner_team_idx IF NOT EXISTS
FOR (n:ApplicationService) ON (n.owner_team);

CREATE INDEX applicationservice_service_kind_idx IF NOT EXISTS
FOR (n:ApplicationService) ON (n.service_kind);

CREATE INDEX businessservice_status_idx IF NOT EXISTS
FOR (n:BusinessService) ON (n.status);

CREATE INDEX businessservice_owner_team_idx IF NOT EXISTS
FOR (n:BusinessService) ON (n.owner_team);

CREATE INDEX businessservice_service_kind_idx IF NOT EXISTS
FOR (n:BusinessService) ON (n.service_kind);

CREATE INDEX technologyservice_status_idx IF NOT EXISTS
FOR (n:TechnologyService) ON (n.status);

CREATE INDEX technologyservice_owner_team_idx IF NOT EXISTS
FOR (n:TechnologyService) ON (n.owner_team);

CREATE INDEX technologyservice_service_kind_idx IF NOT EXISTS
FOR (n:TechnologyService) ON (n.service_kind);

CREATE INDEX api_status_idx IF NOT EXISTS
FOR (n:API) ON (n.status);

CREATE INDEX api_version_idx IF NOT EXISTS
FOR (n:API) ON (n.version);

CREATE INDEX event_status_idx IF NOT EXISTS
FOR (n:Event) ON (n.status);

CREATE INDEX event_version_idx IF NOT EXISTS
FOR (n:Event) ON (n.version);

CREATE INDEX document_status_idx IF NOT EXISTS
FOR (n:Document) ON (n.status);

CREATE INDEX document_source_type_idx IF NOT EXISTS
FOR (n:Document) ON (n.source_type);

CREATE INDEX document_review_status_idx IF NOT EXISTS
FOR (n:Document) ON (n.review_status);

CREATE INDEX source_status_idx IF NOT EXISTS
FOR (n:Source) ON (n.status);

CREATE INDEX source_source_type_idx IF NOT EXISTS
FOR (n:Source) ON (n.source_type);

CREATE INDEX auditrecord_status_idx IF NOT EXISTS
FOR (n:AuditRecord) ON (n.status);

CREATE INDEX auditrecord_collected_at_idx IF NOT EXISTS
FOR (n:AuditRecord) ON (n.collected_at);

CREATE INDEX auditrecord_collector_idx IF NOT EXISTS
FOR (n:AuditRecord) ON (n.collector);

// ---- Optional relationship property indexes ----
// Enable if you later store provenance/confidence on relationships at scale.
// Example: CREATE INDEX supports_confidence_idx IF NOT EXISTS FOR ()-[r:SUPPORTS]-() ON (r.confidence);

// ---- Suggested conventions ----
// 1. Apply exactly one primary ontology label per node (for example :Requirement or :WorkPackage).
// 2. Optional grouping labels such as :StrategyElement or :ArchitectureElement may be added later for convenience.
// 3. Keep id values stable across imports and include source provenance on nodes for auditability.
// 4. Prefer MERGE by {id} during ingestion; SET mutable fields separately.

// ---- Suggested ingest pattern ----
// MERGE (n:Requirement {id: $id})
// SET n += $props, n.updated_at = datetime()
// WITH n
// MATCH (g:Goal {id: $goal_id})
// MERGE (g)-[:DRIVES]->(n);

// ---- Post-bootstrap sanity checks ----
// SHOW CONSTRAINTS;
// SHOW INDEXES;
// MATCH (n) RETURN labels(n) AS labels, count(*) AS c ORDER BY c DESC;