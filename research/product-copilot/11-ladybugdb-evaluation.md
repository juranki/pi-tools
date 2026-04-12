# LadybugDB evaluation for Product Copilot

## Executive summary

Decision status: **adopted as the current default backend for Product Copilot prototyping and local-first workflows**.

If the main goal is **simplicity and lightness for development, testing, and day-to-day operations**, LadybugDB is a strong candidate for Product Copilot.

Why:

- it is **embedded / in-process**, so there is **no separate graph service to run**
- it supports **on-disk single-file persistence** and **in-memory databases**
- it exposes a **native Node.js API** that can be used directly from a pi extension or SDK integration
- it already covers several features that matter for a product knowledge graph:
  - Cypher
  - ACID transactions
  - bulk import
  - full-text search
  - vector search
  - query-in-place / attach patterns for external data

However, Ladybug is not a free win in every dimension.

Main trade-offs versus Neo4j or Memgraph:

- stricter schema model
- one label per node / relationship
- smaller ecosystem and fewer operational conventions for shared remote graph service use
- embedded locking and ownership constraints matter more than with a server database
- Node integration relies on a native module, so runtime validation is important

**Recommendation:**

- for **local-first Product Copilot development, tests, and extension-local knowledge storage**, Ladybug looks like the best fit of the three options considered so far
- for a future **shared, multi-user, continuously running graph backend**, Memgraph or Neo4j may still be the better operational shape
- the pragmatic path is to **start Product Copilot with Ladybug for local and agent-owned workflows**, while keeping the graph model portable enough to move to a service-backed database later if collaboration or scale pressure demands it

---

## 1. What the docs say about LadybugDB

### 1.1 Positioning

The docs describe Ladybug as an **embedded graph database** built for **query speed**, **scalability**, and **join-heavy analytical workloads**.

Documented core properties include:

- property graph model + Cypher
- embedded / in-process integration
- columnar disk-based storage
- CSR-style adjacency / join structures
- vectorized and factorized query execution
- multi-core query parallelism
- serializable ACID transactions

Source:
- docs index: <https://docs.ladybugdb.com/index>

### 1.2 Storage model

Ladybug supports both:

- **on-disk mode** using a `.lbug` database file
- **in-memory mode** via `""` or `":memory:"`

The on-disk path is especially attractive for Product Copilot because it means:

- a single durable database artifact
- no server data directory layout to manage
- easy temp databases for tests
- straightforward project-local storage

Since `0.11.0`, the docs say Ladybug uses a **single-file database format**, with temporary side files created as needed:

- `.wal`
- `.shadow`
- `.tmp`

Sources:
- getting started: <https://docs.ladybugdb.com/get-started/index>
- database files: <https://docs.ladybugdb.com/developer-guide/files>

### 1.3 Concurrency model

The docs are explicit:

- one read-write `Database` object **or**
- multiple read-only `Database` objects

Multiple `Connection`s from the **same** `Database` object are supported and safe.

Implication:

- a single process can own the graph and handle concurrent queries through multiple connections
- but multiple processes should **not** open the same `.lbug` file read-write at the same time

This is one of the most important differences from service databases.

Source:
- connections & concurrency: <https://docs.ladybugdb.com/concurrency>

### 1.4 Schema and data model

Ladybug is **schema-first** by default.

Key constraints from the docs:

- node tables and relationship tables are created explicitly
- node tables require primary keys
- relationships are defined through `CREATE REL TABLE`
- each node and relationship has **one label**
- properties are strongly typed

This is stricter than Neo4j-style modeling, but that may be a positive for Product Copilot because the ontology is already explicit and structured.

Sources:
- create table: <https://docs.ladybugdb.com/cypher/data-definition/create-table>
- Neo4j differences: <https://docs.ladybugdb.com/cypher/difference>

### 1.5 Query language and transactions

Ladybug exposes Cypher and documents **serializable ACID transactions**.

Important transaction rules:

- every query or update runs in a transaction
- there can be multiple read transactions
- there can be only one write transaction at a time
- WAL + checkpointing back the durability model

Source:
- transactions: <https://docs.ladybugdb.com/cypher/transaction>

### 1.6 Node.js support

The docs provide a Node.js API with:

- async API
- sync API
- prepared statements
- parameter binding

The package name documented for install is:

- `@ladybugdb/core`

This is the key enabler for pi extension integration.

Sources:
- installation: <https://docs.ladybugdb.com/installation>
- system requirements: <https://docs.ladybugdb.com/system-requirements>
- Node.js API: <https://docs.ladybugdb.com/client-apis/nodejs>
- prepared statements: <https://docs.ladybugdb.com/get-started/prepared-statements>

### 1.7 Import, export, and interoperability

The docs show multiple ways to ingest or expose data:

- `COPY FROM` for CSV / Parquet / JSON / NumPy / dataframes
- `LOAD FROM` for scan-before-import workflows
- query-in-place against external sources
- attach integrations for DuckDB, PostgreSQL, SQLite, Delta, Iceberg, Unity Catalog, etc.

Ladybug also supports:

- `EXPORT DATABASE`
- `IMPORT DATABASE`

This matters for Product Copilot because evidence and source data may come from many places.

Sources:
- import overview: <https://docs.ladybugdb.com/import/index>
- scan: <https://docs.ladybugdb.com/get-started/scan>
- migration: <https://docs.ladybugdb.com/migrate/index>
- extensions overview: <https://docs.ladybugdb.com/extensions/index>

### 1.8 Search and retrieval features

Ladybug has documented extensions for:

- full-text search
- vector search
- LLM-created embeddings
- Neo4j migration

For Product Copilot, that makes Ladybug more interesting than “just an embedded graph database”.

Sources:
- extensions overview: <https://docs.ladybugdb.com/extensions/index>
- full-text search: <https://docs.ladybugdb.com/extensions/full-text-search>
- vector search: <https://docs.ladybugdb.com/extensions/vector>
- llm extension: <https://docs.ladybugdb.com/extensions/llm>
- neo4j extension: <https://docs.ladybugdb.com/extensions/neo4j>

---

## 2. Evaluation against Product Copilot goals

## 2.1 Development simplicity

This is where Ladybug looks best.

### Advantages

- no Docker Compose required for the main graph runtime
- no port management
- no auth/bootstrap for local use
- no separate service lifecycle
- database can live as a project-local file
- graph can be created by the same Node.js code that uses it

For Product Copilot, this means a pi extension or local tool can:

- open `product-copilot.lbug`
- create schema
- ingest data
- answer graph queries

without any external runtime dependency beyond the native package.

### Compared with Neo4j / Memgraph

Neo4j and Memgraph both push you toward a service mindset:

- start a container or daemon
- manage network endpoints
- manage service health
- manage auth and bootstrapping
- manage persistence volumes

Ladybug avoids nearly all of that in the local case.

### Caveat

The cost of that simplicity is that the application owns the database lifecycle directly. That pushes more responsibility into the extension or app runtime.

## 2.2 Testing

Ladybug is an especially good fit for tests.

### Why it fits

- in-memory mode is built in
- temp on-disk databases are trivial
- tests do not need shared service orchestration
- fixture setup is ordinary application code
- export/import gives a clean path for reproducible snapshots

### Recommended test split

- **unit tests**: `:memory:` databases
- **integration tests**: temporary `.lbug` files
- **fixture refresh / migration tests**: `EXPORT DATABASE` / `IMPORT DATABASE`

### Key caveat

Because of the locking model, parallel tests should not point multiple workers at the same read-write `.lbug` file.
Use one temp file per worker.

## 2.3 Operations

Ladybug is operationally light **for local and single-owner use**.

### Operational advantages

- database is a local file, not a managed server
- backups can be ordinary file/snapshot workflows
- no service monitoring stack is required for basic local use
- a pi extension can own the graph runtime directly

### Operational limitations

Ladybug is not a server product first.

That means the docs naturally say less about:

- long-lived remote multi-user service operations
- central team-wide graph hosting patterns
- network access control and tenancy
- admin surfaces and remote tooling conventions

For Product Copilot this likely means:

- excellent for local development and agent-local execution
- less obviously ideal as the single shared production graph for many humans and agents across machines

## 2.4 Data and retrieval fit

Product Copilot wants a graph that can support:

- evidence -> claim -> opportunity -> requirement -> work package -> release -> incident traces
- typed entities
- provenance
- retrieval-friendly local neighborhoods
- future lexical and vector retrieval support

Ladybug fits a lot of this well:

- explicit schema aligns with the ontology work already done in this repo
- vector and FTS extensions are promising for hybrid retrieval
- import/export and attach patterns suit ingestion from heterogeneous sources

### Main modeling trade-off

Ladybug’s **one-label-per-node** rule is stricter than what some property-graph users expect.

For Product Copilot that is probably acceptable if the ontology stays explicit and normalized.
If the graph design starts relying on multiple orthogonal labels per entity, Ladybug becomes less natural.

## 2.5 Ecosystem and portability

Neo4j still wins on ecosystem familiarity.
Memgraph wins on service-oriented graph ops if we want an openCypher-compatible server.

Ladybug wins on:

- local simplicity
- embedded deployment
- testability
- minimal ops

This makes it especially attractive for **the early research / build phase** of Product Copilot.

---

## 3. Pi extension implications

## 3.1 Feasibility

Pi extensions are TypeScript modules and can have their own `package.json` and npm dependencies.
The pi docs explicitly support:

- directory-style extensions with `index.ts`
- extension-local `package.json`
- `npm install` in the extension directory
- package distribution through pi packages

That makes a Ladybug-backed pi extension technically straightforward.

Relevant pi docs:

- extensions: `/home/juhani/.npm/_npx/86d717fff1af7182/node_modules/@mariozechner/pi-coding-agent/docs/extensions.md`
- packages: `/home/juhani/.npm/_npx/86d717fff1af7182/node_modules/@mariozechner/pi-coding-agent/docs/packages.md`
- sdk: `/home/juhani/.npm/_npx/86d717fff1af7182/node_modules/@mariozechner/pi-coding-agent/docs/sdk.md`

## 3.2 The simplest extension pattern

The simplest viable pattern is:

1. create a directory-style pi extension
2. add `@ladybugdb/core` to `dependencies`
3. lazily create one shared `Database` object
4. create `Connection`s from that shared database
5. expose task-shaped tools such as:
   - `ladybug_query`
   - `ladybug_get_node`
   - `ladybug_trace`
   - `ladybug_import`
   - `ladybug_export_database`

This preserves the main Ladybug benefit: **no separate graph service**.

## 3.3 Recommended runtime rules for pi

If we build a pi extension on top of Ladybug, the extension should follow these rules:

### Rule 1: One database owner per file

A single pi runtime should own read-write access to a given `.lbug` file.

Do not assume we can safely:

- run the extension read-write
- run the CLI read-write
- open Explorer against the same file read-write

all at once.

### Rule 2: Use a project-local path convention

Recommended default path:

- `.pi/state/product-copilot/product-copilot.lbug`

Why:

- project-local
- easy to ignore in git
- easy to delete and recreate in tests
- obvious ownership by pi tooling

### Rule 3: Use prepared statements for parameterized queries

This is both a safety and correctness default.

### Rule 4: Load Ladybug extensions explicitly

Because Ladybug extensions are loaded per process/session, the pi extension should ensure required ones are loaded, for example:

- `json`
- `fts`
- `vector`
- `httpfs`

### Rule 5: Start read-only where possible

The first extension tools should be read-only retrieval and analysis tools.
Mutation can be added after the ontology and ingestion model stabilize.

## 3.4 A better safety pattern: child-process sidecar

There is an even better pattern for pi than direct in-process ownership:

- pi extension stays in-process
- Ladybug lives in a small local child process started by the extension
- communication happens over stdio / JSON

This still avoids a separately managed database service.

Benefits:

- native module faults do not take down pi itself
- extension reloads become easier to reason about
- one worker can serialize DB ownership cleanly
- restart behavior is simpler

This is probably the best long-term pattern if Product Copilot becomes a serious pi extension rather than a small experiment.

## 3.5 Suggested extension tool surface

A Ladybug-backed pi extension should avoid exposing unrestricted Cypher first.

Recommended progression:

1. `ladybug_get_node`
2. `ladybug_get_subgraph`
3. `ladybug_trace_path`
4. `ladybug_query_readonly`
5. controlled write/import tools later

This mirrors the broader tool-shaping guidance already present in `09-agent-tooling.md`.

---

## 4. Risks and caveats

## 4.1 Embedded ownership is both a strength and a constraint

Ladybug is simple because it is embedded.
That same fact means:

- file locks matter
- process boundaries matter
- reload semantics matter
- native module lifecycle matters

## 4.2 Schema friction is real

Ladybug is not the best fit if we want to start with a highly fluid, schema-optional graph.

For Product Copilot, though, we already have:

- ontology work
- explicit entity types
- explicit relationship types

So this is more likely a benefit than a drawback.

## 4.3 Documentation inconsistency around multi-graph behavior

I found one docs inconsistency worth calling out:

- `CREATE GRAPH` docs describe subgraphs and `USE`
- the Neo4j-difference page still says `USE graph` is not supported and each graph is a database

This suggests multi-graph behavior is evolving and should be validated against the exact version we adopt.

## 4.4 Native module validation is mandatory

Ladybug’s Node.js package is a native module package.
That is normal for this class of database, but it means we should validate:

- target OS support
- target Node runtime support
- extension reload behavior
- clean shutdown behavior

before betting on an in-process pi integration.

---

## 5. Local smoke test note

I ran a small local smoke test in this environment using `@ladybugdb/core`.

What worked:

- `npm install @ladybugdb/core`
- creation of an on-disk `.lbug` file
- schema creation
- inserts
- queries
- prepared statements

What I observed:

- install pulled a prebuilt platform package successfully
- installed size was roughly `25M` for `@ladybugdb/core` plus `25M` for the platform package on this machine
- explicit `Database.close()` caused a process segmentation fault in my minimal Node.js test, while letting the process exit without calling `db.close()` completed normally

Interpretation:

- Ladybug is clearly usable from Node in principle
- but a production-grade pi extension should validate runtime lifecycle carefully
- this pushes me toward either:
  - a very cautious in-process singleton approach, or
  - a child-process sidecar approach for isolation

This is an empirical note from one environment, not a statement from the docs.

---

## 6. Recommendation for Product Copilot

## Recommended near-term choice

Use **LadybugDB as the default local graph backend** for the next phase of Product Copilot research and prototyping.

Why:

- best match for the stated goal of simplicity and lightness
- strongest dev/test ergonomics
- good enough feature set for schema-first product graph work
- direct path to pi integration without running a service

## Recommended architecture

### Phase 1

- model the Product Copilot ontology in Ladybug tables
- keep the database project-local
- start from `06-ladybugdb-schema.cypher`, `07-ladybugdb-query-patterns.cypher`, and `08-ladybugdb-sample-data.cypher`, then extend from there
- build read-only graph tools first
- use Ladybug for fixtures, tests, and agent-local graph reasoning

### Phase 2

- add JSON / FTS / vector extensions as retrieval needs sharpen
- decide whether the pi integration stays in-process or moves to a child-process worker

### Phase 3

Re-evaluate Neo4j or Memgraph only if one of these becomes dominant:

- multiple concurrent writers across processes or machines
- shared always-on graph service needs
- heavy operational collaboration around a remote graph server
- ecosystem/tooling gaps that materially slow product work

## Bottom line

For **Product Copilot as a local-first, agent-centric system under active design**, Ladybug currently looks like the most aligned option.

It is not necessarily the forever answer for a shared production graph service, but it is probably the **best answer right now** if the priority is to move faster with less operational weight.
