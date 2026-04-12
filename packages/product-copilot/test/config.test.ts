import assert from 'node:assert/strict';
import { resolve } from 'node:path';
import { afterEach, describe, it } from 'node:test';

import { resolveProductCopilotConfig } from '../src/lib/config.ts';

const originalDbPath = process.env['PRODUCT_COPILOT_DB_PATH'];
const originalMode = process.env['PRODUCT_COPILOT_MODE'];

afterEach(() => {
  restoreEnvVar('PRODUCT_COPILOT_DB_PATH', originalDbPath);
  restoreEnvVar('PRODUCT_COPILOT_MODE', originalMode);
});

describe('resolveProductCopilotConfig', () => {
  it('returns the default local-first config when env vars are unset', () => {
    delete process.env['PRODUCT_COPILOT_DB_PATH'];
    delete process.env['PRODUCT_COPILOT_MODE'];

    const config = resolveProductCopilotConfig('/workspace/product-copilot');

    assert.deepEqual(config, {
      dbPath: resolve(
        '/workspace/product-copilot',
        '.pi/state/product-copilot/product-copilot.lbug',
      ),
      mode: 'direct',
    });
  });

  it('resolves a relative database path from the cwd', () => {
    process.env['PRODUCT_COPILOT_DB_PATH'] = 'tmp/dev.lbug';
    delete process.env['PRODUCT_COPILOT_MODE'];

    const config = resolveProductCopilotConfig('/workspace/product-copilot');

    assert.equal(config.dbPath, resolve('/workspace/product-copilot', 'tmp/dev.lbug'));
    assert.equal(config.mode, 'direct');
  });

  it('switches to worker mode only when explicitly requested', () => {
    delete process.env['PRODUCT_COPILOT_DB_PATH'];
    process.env['PRODUCT_COPILOT_MODE'] = 'worker';

    const config = resolveProductCopilotConfig('/workspace/product-copilot');

    assert.equal(config.mode, 'worker');
  });
});

function restoreEnvVar(name: string, value: string | undefined): void {
  if (value === undefined) {
    delete process.env[name];
    return;
  }

  process.env[name] = value;
}
