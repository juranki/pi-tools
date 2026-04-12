import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { once } from 'node:events';
import { dirname, resolve } from 'node:path';
import readline from 'node:readline';
import { describe, it } from 'node:test';
import { fileURLToPath } from 'node:url';

interface WorkerMessage {
  id?: string | number;
  type?: string;
  ok?: boolean;
  pid?: number;
  error?: string;
  result?: Record<string, unknown>;
}

describe('ladybug worker scaffold', () => {
  it('responds to ping over JSON lines', async () => {
    const workerPath = resolve(
      dirname(fileURLToPath(import.meta.url)),
      '../src/worker/ladybug-worker.mjs',
    );
    const workerProcess = spawn(process.execPath, [workerPath], {
      stdio: ['pipe', 'pipe', 'pipe'],
    });

    const stdout = readline.createInterface({
      input: workerProcess.stdout,
      crlfDelay: Number.POSITIVE_INFINITY,
    });

    try {
      const readyMessage = await readWorkerMessage(stdout);
      assert.equal(readyMessage.type, 'ready');
      assert.equal(readyMessage.ok, true);
      assert.equal(typeof readyMessage.pid, 'number');

      workerProcess.stdin.write(`${JSON.stringify({ id: 'ping-1', type: 'ping' })}\n`);

      const pingResponse = await readWorkerMessage(stdout);
      assert.equal(pingResponse.id, 'ping-1');
      assert.equal(pingResponse.ok, true);
      assert.equal(pingResponse.result?.['pong'], true);
      assert.equal(pingResponse.result?.['pid'], readyMessage.pid);
    } finally {
      stdout.close();
      workerProcess.stdin.end();
      workerProcess.kill();
      await once(workerProcess, 'close');
    }
  });
});

async function readWorkerMessage(stdout: readline.Interface): Promise<WorkerMessage> {
  const [line] = await once(stdout, 'line');
  assert.equal(typeof line, 'string');

  const parsed = JSON.parse(line) as WorkerMessage;
  return parsed;
}
