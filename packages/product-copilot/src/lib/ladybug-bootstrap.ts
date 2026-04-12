import { mkdir, readFile, rm } from 'node:fs/promises';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import type { LbugValue, QueryResult } from '@ladybugdb/core';
import { Connection, Database } from '@ladybugdb/core';

interface ProductCopilotResearchAssetPaths {
  researchDir: string;
  schemaPath: string;
  queryPatternsPath: string;
  sampleDataPath: string;
}

interface LoadSmokeFixtureOptions {
  dbPath: string;
  schemaPath?: string;
  sampleDataPath?: string | undefined;
  reset?: boolean;
  queryTimeoutMs?: number;
}

interface SmokeFixtureVerification {
  featureCount: number;
  workPackageCount: number;
  releaseCount: number;
  featureSeedCount: number;
}

interface LoadSmokeFixtureSummary {
  dbPath: string;
  appliedFiles: string[];
  statementsApplied: number;
  verification: SmokeFixtureVerification;
}

const defaultQueryTimeoutMs = 15_000;

export function resolveProductCopilotResearchAssetPaths(): ProductCopilotResearchAssetPaths {
  const moduleDir = dirname(fileURLToPath(import.meta.url));
  const researchDir = resolve(moduleDir, '../../../../research/product-copilot');

  return {
    researchDir,
    schemaPath: resolve(researchDir, '06-ladybugdb-schema.cypher'),
    queryPatternsPath: resolve(researchDir, '07-ladybugdb-query-patterns.cypher'),
    sampleDataPath: resolve(researchDir, '08-ladybugdb-sample-data.cypher'),
  };
}

export function splitCypherStatements(source: string): string[] {
  const statements: string[] = [];
  let current = '';
  let inSingleQuotedString = false;
  let inDoubleQuotedString = false;
  let inLineComment = false;

  for (let index = 0; index < source.length; index += 1) {
    const char = source[index];
    const nextChar = source[index + 1];

    if (char === undefined) {
      break;
    }

    if (inLineComment) {
      if (char === '\n') {
        inLineComment = false;
        current += char;
      }
      continue;
    }

    if (!inSingleQuotedString && !inDoubleQuotedString && char === '/' && nextChar === '/') {
      inLineComment = true;
      index += 1;
      continue;
    }

    if (char === "'" && !inDoubleQuotedString && !isEscaped(source, index)) {
      inSingleQuotedString = !inSingleQuotedString;
      current += char;
      continue;
    }

    if (char === '"' && !inSingleQuotedString && !isEscaped(source, index)) {
      inDoubleQuotedString = !inDoubleQuotedString;
      current += char;
      continue;
    }

    if (char === ';' && !inSingleQuotedString && !inDoubleQuotedString) {
      pushStatement(statements, current);
      current = '';
      continue;
    }

    current += char;
  }

  pushStatement(statements, current);
  return statements;
}

export async function loadProductCopilotSmokeFixture(
  options: LoadSmokeFixtureOptions,
): Promise<LoadSmokeFixtureSummary> {
  const assetPaths = resolveProductCopilotResearchAssetPaths();
  const schemaPath = options.schemaPath ?? assetPaths.schemaPath;
  const sampleDataPath = options.sampleDataPath ?? assetPaths.sampleDataPath;

  if (options.reset ?? true) {
    await resetLadybugDatabaseFiles(options.dbPath);
  }

  await mkdir(dirname(options.dbPath), { recursive: true });

  const database = new Database(options.dbPath);
  const connection = new Connection(database);
  connection.setQueryTimeout(options.queryTimeoutMs ?? defaultQueryTimeoutMs);

  try {
    await database.init();
    await connection.init();

    const appliedFiles = [schemaPath, sampleDataPath];
    let statementsApplied = 0;

    for (const filePath of appliedFiles) {
      statementsApplied += await applyCypherFile(connection, filePath);
    }

    const verification = await verifySmokeFixture(connection);

    return {
      dbPath: options.dbPath,
      appliedFiles,
      statementsApplied,
      verification,
    };
  } finally {
    await connection.close();
    await database.close();
  }
}

async function applyCypherFile(connection: Connection, filePath: string): Promise<number> {
  const source = await readFile(filePath, 'utf8');
  const statements = splitCypherStatements(source);

  for (const statement of statements) {
    const result = await connection.query(statement);
    closeResult(result);
  }

  return statements.length;
}

async function verifySmokeFixture(connection: Connection): Promise<SmokeFixtureVerification> {
  const featureCount = await queryCount(connection, 'MATCH (f:Feature) RETURN count(f) AS value');
  const workPackageCount = await queryCount(
    connection,
    'MATCH (wp:WorkPackage) RETURN count(wp) AS value',
  );
  const releaseCount = await queryCount(
    connection,
    'MATCH (rel:Release) RETURN count(rel) AS value',
  );
  const featureSeedCount = await queryCount(
    connection,
    "MATCH (f:Feature {id: 'FEAT-001'}) RETURN count(f) AS value",
  );

  return {
    featureCount,
    workPackageCount,
    releaseCount,
    featureSeedCount,
  };
}

async function queryCount(connection: Connection, statement: string): Promise<number> {
  const result = await connection.query(statement);
  const queryResult = takeSingleResult(result);

  try {
    const rows = await queryResult.getAll();
    const row = rows[0];
    const value = row?.['value'];
    if (value === undefined) {
      throw new Error('Expected the query to return a `value` column.');
    }

    return coerceNumericValue(value);
  } finally {
    closeResult(result);
  }
}

function takeSingleResult(result: QueryResult | QueryResult[]): QueryResult {
  if (Array.isArray(result)) {
    const first = result[0];
    if (first === undefined) {
      throw new Error('Expected a query result but received an empty result array.');
    }
    return first;
  }

  return result;
}

function closeResult(result: QueryResult | QueryResult[]): void {
  if (Array.isArray(result)) {
    for (const entry of result) {
      entry.close();
    }
    return;
  }

  result.close();
}

function coerceNumericValue(value: LbugValue): number {
  if (typeof value === 'number') {
    return value;
  }

  if (typeof value === 'bigint') {
    return Number(value);
  }

  throw new Error(`Expected a numeric query result but received ${String(value)}.`);
}

async function resetLadybugDatabaseFiles(dbPath: string): Promise<void> {
  const relatedPaths = [dbPath, `${dbPath}.wal`, `${dbPath}.shadow`, `${dbPath}.tmp`];

  await Promise.all(relatedPaths.map(async (filePath) => rm(filePath, { force: true })));
}

function pushStatement(statements: string[], rawStatement: string): void {
  const statement = rawStatement.trim();
  if (statement.length > 0) {
    statements.push(statement);
  }
}

function isEscaped(source: string, index: number): boolean {
  let backslashCount = 0;

  for (let cursor = index - 1; cursor >= 0; cursor -= 1) {
    if (source[cursor] !== '\\') {
      break;
    }
    backslashCount += 1;
  }

  return backslashCount % 2 === 1;
}
