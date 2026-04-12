import assert from 'node:assert/strict';
import { dirname, resolve } from 'node:path';
import { describe, it } from 'node:test';
import { fileURLToPath } from 'node:url';

import { WorkerClient } from '../src/lib/worker-client.ts';

describe('WorkerClient', () => {
  it('starts the worker and can round-trip ping and describe messages', async () => {
    const workerScriptPath = resolve(
      dirname(fileURLToPath(import.meta.url)),
      '../src/worker/ladybug-worker.mjs',
    );
    const workerClient = new WorkerClient({ workerScriptPath });

    try {
      await workerClient.start();

      const pingResult = await workerClient.ping();
      assert.equal(pingResult.pong, true);
      assert.equal(typeof pingResult.pid, 'number');

      const describeResult = await workerClient.describe();
      assert.equal(describeResult.pid, pingResult.pid);
      assert.equal(typeof describeResult.cwd, 'string');
      assert.match(describeResult.note, /scaffold worker only/i);
    } finally {
      await workerClient.stop();
    }
  });
});
