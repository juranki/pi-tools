# LadybugDB reference notes

This file captures the main LadybugDB facts that matter for evaluation, implementation, and operations.

## 1. Core positioning

LadybugDB is the successor to Kuzu and presents itself as:

- embedded / in-process
- serverless from the application point of view
- optimized for query speed and analytical, join-heavy graph workloads
- ACID and serializable
- strongly schema-oriented by default

Key implications:

- no separate graph server to provision for local development
- very low friction for test environments
- the application process owns the database runtime, which means lifecycle and locking behavior matter more than with a remote service

## 2. Storage and files

### On-disk mode

If you create the database with a path such as `example.lbug`, Ladybug persists to a single database file.

Related temporary side files may appear in the same directory:

- `example.lbug.wal` — write-ahead log
- `example.lbug.shadow` — checkpoint helper file
- `example.lbug.tmp` — spill file under memory pressure

The database file itself is the durable artifact. Temporary files are created and removed as needed.

### In-memory mode

Use `""` or `":memory:"` for ephemeral databases.

Use this for:

- unit tests
- quick experiments
- fixture-driven validation runs

Do not use it when you need:

- durable state
- remote file caching through some extensions
- attach behavior that expects persisted storage

## 3. Concurrency model

Ladybug distinguishes between `Database` objects and `Connection` objects.

Recommended mental model:

- one process should own one read-write `Database` object for a given database file
- many `Connection` objects may be created from that same `Database` object
- multiple concurrent connections from the same `Database` object are safe
- separate `Database` objects pointing to the same file are only safe when they are all read-only

Practical consequences:

- do not open the same `.lbug` file read-write from both a pi extension and another app at the same time
- for parallel tests, use one unique temp database file per worker
- for pi tools, prefer a single DB owner and queue or coordinate writes even if multiple custom tools exist

## 4. Data model and Cypher differences

Ladybug uses a structured property graph model.

Important rules:

- create node and relationship tables explicitly
- node tables require a primary key
- relationship tables do not expose user-defined primary keys
- nodes and relationships have one label each
- property types are explicit and strongly typed

This is usually a good fit for Product Copilot style graphs because the ontology is already explicit.

### Neo4j-style compatibility gaps to keep in mind

- no multi-labelled node support
- stricter schema requirements
- some Cypher clauses differ or are unsupported
- docs say manual secondary indexes / custom constraints are currently limited compared with service databases

There is also a docs inconsistency to watch:

- `CREATE GRAPH` docs describe subgraphs
- the Neo4j-difference page still says each graph is a database and `USE graph` is not supported

Treat multi-graph behavior as version-sensitive and validate it before depending on it.

## 5. Ingestion and data access patterns

### Prefer these defaults

- `COPY FROM` for real ingestion
- `LOAD FROM` for quick inspection and filtering before import
- Parquet over CSV when you control the format and care about performance

### Supported directions visible in docs

- CSV
- Parquet
- JSON
- NumPy
- DataFrames / Arrow-backed flows
- query-in-place over some external sources
- attach integrations for DuckDB, PostgreSQL, SQLite, Delta, Iceberg, Unity Catalog, and others through extensions

This is useful for Product Copilot because evidence and product data may live in mixed file and relational sources.

## 6. Extensions

Official extensions are installed and loaded separately.

Important operational rule:

1. `INSTALL <extension>` once
2. `LOAD <extension>` in each new process or session

Relevant extensions for product-copilot-style workloads:

- `json` for JSON import and manipulation
- `fts` / full-text search for lexical evidence retrieval
- `vector` for embedding similarity search
- `llm` for embedding creation inside Ladybug
- `httpfs` for HTTP and remote file access
- `duckdb`, `postgres`, `sqlite` for attachment/query-in-place patterns
- `neo4j` for migration from Neo4j

Downloaded official extensions live under `~/.lbug/extensions`.

## 7. Node.js API notes

Docs and package metadata point to `@ladybugdb/core` as the Node.js package.

Patterns to prefer:

```ts
import lbug from "@ladybugdb/core";

const db = new lbug.Database("./product-copilot.lbug");
const conn = new lbug.Connection(db);
const stmt = await conn.prepare(
  "MATCH (n:Requirement) WHERE n.id = $id RETURN n.title AS title;",
);
const result = await conn.execute(stmt, { id: "REQ-001" });
```

Useful API capabilities from the published type definitions:

- async and sync query APIs
- prepared statements
- `Connection.setQueryTimeout()`
- `Connection.setMaxNumThreadForExec()`
- plain-object parameter binding

### Packaging implications

`@ladybugdb/core` is a native module package with platform-specific optional dependencies and an install script.

For pi extensions, this means:

- prefer a directory-style extension with its own `package.json`
- run `npm install` in the extension directory
- if distributing as a pi package, declare the dependency in `dependencies`
- validate behavior on the target OS/Node runtime, not only in one development environment

## 8. Pi integration guidance

### Best default: embedded local extension package

Use a package-style pi extension:

```text
.pi/extensions/product-copilot-ladybug/
├── package.json
└── src/index.ts
```

Suggested dependency:

```json
{
  "dependencies": {
    "@ladybugdb/core": "^0.15.3"
  },
  "pi": {
    "extensions": ["./src/index.ts"]
  }
}
```

Recommended runtime pattern:

- resolve one absolute database path per project
- lazily initialize a singleton `Database`
- create short-lived `Connection`s or a very small pool from that singleton
- expose read-only tools first
- add controlled write tools only after query patterns stabilize

### When to prefer a child process instead

Move Ladybug ownership to a child process when:

- the extension runtime becomes unstable because of the native module lifecycle
- you want crash isolation
- you want one DB owner independent of pi extension reload behavior
- you want a simple JSON-over-stdio protocol between pi and the database worker

This still avoids managing a separate long-lived service.

## 9. Product Copilot fit summary

Ladybug is strongest when Product Copilot needs:

- local-first development
- fast iteration on schema and query patterns
- deterministic test fixtures
- a graph database that ships with the application or extension
- no Docker Compose or service lifecycle for the main graph runtime

Ladybug is weaker when Product Copilot needs:

- a shared multi-user graph service
- network-native remote access as the default mode
- broad Neo4j ecosystem compatibility
- mature server-oriented admin/ops workflows

## 10. Practical checklist

When implementing with Ladybug, confirm:

- database path strategy chosen
- per-project locking story understood
- schema mapped to one-label tables
- extension load sequence defined
- import format chosen
- prepared statements used for untrusted parameters
- test strategy uses `:memory:` or unique temp files
- migration / backup path uses `EXPORT DATABASE` and `IMPORT DATABASE` where needed
