import { isAbsolute, resolve } from "node:path";

export type ProductCopilotMode = "direct" | "worker";

export interface ProductCopilotConfig {
  dbPath: string;
  mode: ProductCopilotMode;
}

const DEFAULT_DB_PATH = ".pi/state/product-copilot/product-copilot.lbug";
const DEFAULT_MODE: ProductCopilotMode = "direct";

export function resolveProductCopilotConfig(cwd: string): ProductCopilotConfig {
  const rawDbPath = process.env.PRODUCT_COPILOT_DB_PATH?.trim() || DEFAULT_DB_PATH;
  const rawMode = process.env.PRODUCT_COPILOT_MODE?.trim();

  return {
    dbPath: resolveMaybeAbsolute(cwd, rawDbPath),
    mode: rawMode === "worker" ? "worker" : DEFAULT_MODE,
  };
}

function resolveMaybeAbsolute(cwd: string, filePath: string): string {
  if (isAbsolute(filePath)) return filePath;
  return resolve(cwd, filePath);
}
