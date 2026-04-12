import { basename, resolve } from 'node:path';

import { resolveProductCopilotConfig } from '../lib/config.ts';
import {
  loadProductCopilotSmokeFixture,
  resolveProductCopilotResearchAssetPaths,
} from '../lib/ladybug-bootstrap.ts';

interface SmokeLoadCliOptions {
  dbPath?: string;
  schemaPath?: string;
  sampleDataPath?: string | undefined;
  includeSampleData: boolean;
  reset: boolean;
  showHelp: boolean;
}

async function main(): Promise<void> {
  const options = parseSmokeLoadCliArgs(process.argv.slice(2));

  if (options.showHelp) {
    printUsage();
    return;
  }

  const config = resolveProductCopilotConfig(process.cwd());
  const assetPaths = resolveProductCopilotResearchAssetPaths();
  const dbPath = resolveMaybeAbsolute(process.cwd(), options.dbPath ?? config.dbPath);
  const schemaPath = resolveMaybeAbsolute(
    process.cwd(),
    options.schemaPath ?? assetPaths.schemaPath,
  );
  const sampleDataPath = options.includeSampleData
    ? resolveMaybeAbsolute(process.cwd(), options.sampleDataPath ?? assetPaths.sampleDataPath)
    : undefined;

  const summary = await loadProductCopilotSmokeFixture({
    dbPath,
    schemaPath,
    sampleDataPath,
    reset: options.reset,
  });

  const lines = [
    'Product Copilot smoke load complete',
    `- dbPath: ${summary.dbPath}`,
    `- schema: ${basename(schemaPath)}`,
    `- sampleData: ${sampleDataPath ? basename(sampleDataPath) : '(skipped)'}`,
    `- statementsApplied: ${summary.statementsApplied}`,
    `- featureCount: ${summary.verification.featureCount}`,
    `- workPackageCount: ${summary.verification.workPackageCount}`,
    `- releaseCount: ${summary.verification.releaseCount}`,
    `- featureSeedCount: ${summary.verification.featureSeedCount}`,
  ];

  writeStdout(lines.join('\n'));
}

function parseSmokeLoadCliArgs(argv: string[]): SmokeLoadCliOptions {
  const options: SmokeLoadCliOptions = {
    includeSampleData: true,
    reset: true,
    showHelp: false,
  };

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    switch (arg) {
      case '--db':
        options.dbPath = readRequiredValue(argv, ++index, '--db');
        break;
      case '--schema':
        options.schemaPath = readRequiredValue(argv, ++index, '--schema');
        break;
      case '--sample-data':
        options.sampleDataPath = readRequiredValue(argv, ++index, '--sample-data');
        options.includeSampleData = true;
        break;
      case '--no-sample-data':
        options.includeSampleData = false;
        options.sampleDataPath = undefined;
        break;
      case '--no-reset':
        options.reset = false;
        break;
      case '--help':
      case '-h':
        options.showHelp = true;
        break;
      default:
        throw new Error(`Unknown argument: ${arg}`);
    }
  }

  return options;
}

function readRequiredValue(argv: string[], index: number, flagName: string): string {
  const value = argv[index];
  if (value === undefined || value.startsWith('-')) {
    throw new Error(`Expected a value after ${flagName}.`);
  }
  return value;
}

function printUsage(): void {
  writeStdout(
    [
      'Usage: npm run smoke:load -- [options]',
      '',
      'Options:',
      '  --db <path>           Override the target .lbug database path.',
      '  --schema <path>       Override the schema file path.',
      '  --sample-data <path>  Override the sample data file path.',
      '  --no-sample-data      Apply the schema only.',
      '  --no-reset            Reuse an existing database instead of deleting it first.',
      '  --help, -h            Show this help text.',
    ].join('\n'),
  );
}

function resolveMaybeAbsolute(cwd: string, filePath: string): string {
  return resolve(cwd, filePath);
}

function writeStdout(message: string): void {
  process.stdout.write(`${message}\n`);
}

function writeStderr(message: string): void {
  process.stderr.write(`${message}\n`);
}

main().catch((error: unknown) => {
  const message = error instanceof Error ? (error.stack ?? error.message) : String(error);
  writeStderr(message);
  process.exitCode = 1;
});
