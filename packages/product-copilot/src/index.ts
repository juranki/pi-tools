import { basename, dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "@sinclair/typebox";

import { resolveProductCopilotConfig } from "./lib/config.ts";

const baseDir = dirname(fileURLToPath(import.meta.url));
const workerScriptPath = join(baseDir, "worker", "ladybug-worker.mjs");

export default function productCopilotExtension(pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    const config = resolveProductCopilotConfig(ctx.cwd);
    const label = `Product Copilot (${config.mode}) · ${basename(config.dbPath)}`;
    ctx.ui.setStatus("product-copilot", label);
  });

  pi.registerCommand("product-copilot-info", {
    description: "Show Product Copilot scaffold runtime info",
    handler: async (_args, ctx) => {
      const config = resolveProductCopilotConfig(ctx.cwd);
      const message = [
        "Product Copilot scaffold",
        `mode: ${config.mode}`,
        `db: ${config.dbPath}`,
        `worker: ${workerScriptPath}`,
      ].join("\n");

      if (ctx.hasUI) {
        ctx.ui.notify(message, "info");
      }
    },
  });

  pi.registerTool({
    name: "product_copilot_runtime_info",
    label: "Product Copilot Runtime Info",
    description:
      "Show Product Copilot extension scaffold configuration, including the resolved LadybugDB path and worker script path.",
    parameters: Type.Object({}),
    async execute(_toolCallId, _params, _signal, _onUpdate, ctx) {
      const config = resolveProductCopilotConfig(ctx.cwd);
      return {
        content: [
          {
            type: "text",
            text: [
              "# Product Copilot Runtime Info",
              `- mode: ${config.mode}`,
              `- dbPath: ${config.dbPath}`,
              `- workerScriptPath: ${workerScriptPath}`,
              "- status: scaffold only; LadybugDB runtime not wired yet",
            ].join("\n"),
          },
        ],
        details: {
          ...config,
          workerScriptPath,
          scaffold: true,
        },
      };
    },
  });
}
