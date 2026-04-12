---
name: ladybugdb
description: Use this skill when the user wants to evaluate, set up, query, import into, or integrate LadybugDB, especially for embedded graph workflows, local-first development, tests, Node.js applications, or pi extensions. It helps choose storage mode, model Ladybug schemas, use Cypher and COPY/LOAD patterns, and account for concurrency, file-layout, and extension-loading constraints. Do not use it for managed graph service administration or unrestricted Neo4j/Memgraph operations.
compatibility: Requires access to LadybugDB docs or a local LadybugDB install. Node.js integration guidance assumes @ladybugdb/core.
---

# LadybugDB

Use this skill to work effectively with LadybugDB as an embedded graph database.

LadybugDB is a strong fit when simplicity matters more than running a separate graph service: local development, automated tests, project-local graph tools, and embedded application workflows.

## When to use

Use this skill when:

- the user wants to compare LadybugDB with service-based graph databases such as Neo4j or Memgraph
- the user wants to embed a graph database in a Node.js, Python, or pi-based workflow
- the user wants help designing Ladybug node/relationship tables, imports, or query patterns
- the user wants to understand operational constraints such as file layout, locking, extension loading, or in-memory vs on-disk mode

Do not use it for:

- cluster planning, hosted graph service administration, or remote database operations
- unrestricted Neo4j syntax help when Ladybug compatibility is not the goal

## Workflow

1. Clarify the workload:
   - local prototype
   - automated tests
   - embedded app database
   - shared multi-user graph service
2. Decide whether Ladybug is the right fit:
   - prefer it for local-first, embedded, single-owner workflows
   - be cautious for shared multi-process write-heavy workflows
3. Choose the storage mode:
   - `:memory:` or empty path for ephemeral tests
   - on-disk `.lbug` file for persistent local state
4. Model the schema explicitly:
   - create node tables and relationship tables up front
   - define node primary keys
   - keep in mind that Ladybug uses one label per node or relationship
5. Pick the data path:
   - `COPY FROM` for ingestion
   - `LOAD FROM` for scanning and inspection
   - external table storage / attach features only when query-in-place is better than import
6. If the integration is in Node.js or pi:
   - use `@ladybugdb/core`
   - prefer prepared statements for parameters
   - keep one shared `Database` object per database file in the owning process
   - load Ladybug extensions explicitly in each new process or session
7. Return:
   - fit assessment
   - recommended architecture
   - concrete commands or code
   - key caveats

## Defaults

- Default persistence mode: single on-disk `.lbug` file for local development
- Default test mode: in-memory database
- Default Node.js package: `@ladybugdb/core`
- Default import format for bulk loads: Parquet when available, CSV otherwise
- Default query safety posture: prepared statements for user-supplied values

## Gotchas

- Ladybug concurrency is centered on a single owning `Database` object for read-write access. Do not assume you can safely open the same database file read-write from multiple processes.
- Official Ladybug extensions require `INSTALL <name>` once and `LOAD <name>` in every new process or session before use.
- Ladybug is stricter than Neo4j-style property graphs: explicit schema, one label per node/relationship, and fewer compatibility features.
- For Node.js and pi integrations, treat Ladybug as a native dependency. If lifecycle behavior is unstable in your environment, isolate it in a child process instead of owning it directly inside the extension runtime.
- The docs currently show some evolving multi-graph semantics. Validate `CREATE GRAPH` / `USE` behavior against the exact Ladybug version you deploy.

## Output format

```markdown
# LadybugDB Plan

## Fit
- <why Ladybug is or is not a good fit>

## Storage mode
- <in-memory or on-disk>
- <database path convention>

## Schema / data model
- <node tables>
- <relationship tables>
- <primary key strategy>

## Data path
- <COPY FROM / LOAD FROM / query in place>

## Integration pattern
- <embedded library / child process / other>

## Caveats
- <locking, schema, extension, or runtime caveats>
```

## References to load on demand

- Read `references/notes.md` when you need the detailed Ladybug facts, Node.js API notes, pi integration guidance, or operational caveats.
