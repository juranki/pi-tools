import assert from 'node:assert/strict';
import { mkdtemp, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { afterEach, describe, it } from 'node:test';

import {
  loadProductCopilotSmokeFixture,
  splitCypherStatements,
} from '../src/lib/ladybug-bootstrap.ts';

const tempDirs: string[] = [];

afterEach(async () => {
  await Promise.all(
    tempDirs.splice(0).map(async (tempDir) => rm(tempDir, { recursive: true, force: true })),
  );
});

describe('splitCypherStatements', () => {
  it('ignores line comments and semicolons inside strings', () => {
    const source = [
      '// comment-only line; should be ignored',
      "CREATE (:Thing {id: 'A;1'});",
      '',
      '// another comment with ; characters',
      "MATCH (n:Thing {id: 'A;1'}) RETURN 'still;inside;string' AS note;",
    ].join('\n');

    assert.deepEqual(splitCypherStatements(source), [
      "CREATE (:Thing {id: 'A;1'})",
      "MATCH (n:Thing {id: 'A;1'}) RETURN 'still;inside;string' AS note",
    ]);
  });
});

describe('loadProductCopilotSmokeFixture', () => {
  it('applies the LadybugDB schema and sample data to a temp database', async () => {
    const tempDir = await mkdtemp(join(tmpdir(), 'product-copilot-smoke-'));
    tempDirs.push(tempDir);

    const summary = await loadProductCopilotSmokeFixture({
      dbPath: join(tempDir, 'product-copilot-smoke.lbug'),
      reset: true,
    });

    assert.ok(summary.statementsApplied > 0);
    assert.equal(summary.verification.featureCount, 2);
    assert.equal(summary.verification.workPackageCount, 4);
    assert.equal(summary.verification.releaseCount, 1);
    assert.equal(summary.verification.featureSeedCount, 1);
  });
});
