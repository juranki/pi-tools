import type { ChildProcessWithoutNullStreams } from 'node:child_process';
import { spawn } from 'node:child_process';
import readline from 'node:readline';

interface WorkerClientOptions {
  workerScriptPath: string;
  cwd?: string;
  nodeExecutablePath?: string;
}

interface WorkerMessage {
  id?: string;
  type?: string;
  ok?: boolean;
  pid?: number;
  error?: string;
  result?: unknown;
}

interface PendingRequest {
  resolve: (message: WorkerMessage) => void;
  reject: (error: Error) => void;
}

interface WorkerPingResult {
  pong: boolean;
  pid: number;
}

interface WorkerDescribeResult {
  pid: number;
  cwd: string;
  note: string;
}

export class WorkerClient {
  private readonly options: WorkerClientOptions;
  private readonly pendingRequests = new Map<string, PendingRequest>();

  private nextRequestId = 0;
  private startPromise: Promise<void> | undefined;
  private workerProcess: ChildProcessWithoutNullStreams | undefined;
  private workerStdout: readline.Interface | undefined;

  constructor(options: WorkerClientOptions) {
    this.options = options;
  }

  start(): Promise<void> {
    this.startPromise ??= this.startInternal();
    return this.startPromise;
  }

  async ping(): Promise<WorkerPingResult> {
    const response = await this.sendRequest('ping');
    return parsePingResult(response);
  }

  async describe(): Promise<WorkerDescribeResult> {
    const response = await this.sendRequest('describe');
    return parseDescribeResult(response);
  }

  async stop(): Promise<void> {
    const workerProcess = this.workerProcess;
    if (workerProcess === undefined) {
      return;
    }

    const closePromise = new Promise<void>((resolve) => {
      workerProcess.once('close', () => {
        resolve();
      });
    });

    workerProcess.stdin.end();
    workerProcess.kill();

    await closePromise;
  }

  private startInternal(): Promise<void> {
    const workerProcess = spawn(
      this.options.nodeExecutablePath ?? process.execPath,
      [this.options.workerScriptPath],
      {
        cwd: this.options.cwd,
        stdio: ['pipe', 'pipe', 'pipe'],
      },
    );
    const workerStdout = readline.createInterface({
      input: workerProcess.stdout,
      crlfDelay: Number.POSITIVE_INFINITY,
    });

    this.workerProcess = workerProcess;
    this.workerStdout = workerStdout;

    return new Promise<void>((resolve, reject) => {
      let isReady = false;

      const rejectStart = (error: Error): void => {
        if (isReady) {
          return;
        }

        reject(error);
      };

      workerStdout.on('line', (line) => {
        const message = parseWorkerMessage(line);
        if (message === undefined) {
          return;
        }

        if (message.type === 'ready') {
          if (message.ok !== true) {
            rejectStart(new Error('Worker failed to become ready.'));
            return;
          }

          isReady = true;
          resolve();
          return;
        }

        if (message.id !== undefined) {
          this.resolvePendingRequest(message);
        }
      });

      workerProcess.once('error', (error) => {
        rejectStart(error);
      });

      workerProcess.once('close', (code, signal) => {
        const closeError = new Error(
          `Worker exited before or during use (code=${String(code)}, signal=${String(signal)}).`,
        );

        this.failPendingRequests(closeError);
        this.resetProcessState();
        rejectStart(closeError);
      });
    });
  }

  private async sendRequest(type: 'describe' | 'ping'): Promise<WorkerMessage> {
    await this.start();

    const workerProcess = this.workerProcess;
    if (workerProcess === undefined) {
      throw new Error('Worker process is not running.');
    }

    const requestId = String(this.nextRequestId);
    this.nextRequestId += 1;

    const responsePromise = new Promise<WorkerMessage>((resolve, reject) => {
      this.pendingRequests.set(requestId, { resolve, reject });
    });

    workerProcess.stdin.write(`${JSON.stringify({ id: requestId, type })}\n`);

    return responsePromise;
  }

  private resolvePendingRequest(message: WorkerMessage): void {
    const requestId = message.id;
    if (requestId === undefined) {
      return;
    }

    const pendingRequest = this.pendingRequests.get(requestId);
    if (pendingRequest === undefined) {
      return;
    }

    this.pendingRequests.delete(requestId);

    if (message.ok === false) {
      pendingRequest.reject(new Error(message.error ?? 'Worker request failed.'));
      return;
    }

    pendingRequest.resolve(message);
  }

  private failPendingRequests(error: Error): void {
    for (const pendingRequest of this.pendingRequests.values()) {
      pendingRequest.reject(error);
    }

    this.pendingRequests.clear();
  }

  private resetProcessState(): void {
    this.workerStdout?.close();
    this.workerStdout = undefined;
    this.workerProcess = undefined;
    this.startPromise = undefined;
  }
}

function parseWorkerMessage(line: string): WorkerMessage | undefined {
  try {
    return JSON.parse(line) as WorkerMessage;
  } catch {
    return undefined;
  }
}

function parsePingResult(message: WorkerMessage): WorkerPingResult {
  const result = message.result;
  if (
    !isRecord(result) ||
    typeof result['pong'] !== 'boolean' ||
    typeof result['pid'] !== 'number'
  ) {
    throw new Error('Worker ping response is malformed.');
  }

  return {
    pong: result['pong'],
    pid: result['pid'],
  };
}

function parseDescribeResult(message: WorkerMessage): WorkerDescribeResult {
  const result = message.result;
  if (
    !isRecord(result) ||
    typeof result['pid'] !== 'number' ||
    typeof result['cwd'] !== 'string' ||
    typeof result['note'] !== 'string'
  ) {
    throw new Error('Worker describe response is malformed.');
  }

  return {
    pid: result['pid'],
    cwd: result['cwd'],
    note: result['note'],
  };
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null;
}
