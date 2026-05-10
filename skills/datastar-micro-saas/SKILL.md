---
name: datastar-micro-saas
description: Use this skill when the user wants to add, review, or refactor Data-Star interactions in Bun + Hono micro-SaaS experiments, especially forms, fragment swaps, SSE progress flows, or HTML-over-the-wire UI slices. It helps choose the minimal interaction shape, keep backend state authoritative, wire Hono/SSE responses idiomatically, and stop JSON-first or SPA drift early. Do not use it for React/Vue component work, generic styling, or non-Data-Star realtime architecture.
compatibility: Assumes a Bun + Hono + HTML-over-the-wire stack and Data-Star-style SSE responses.
---

# Data-Star Micro-SaaS

Use this skill to keep Data-Star work inside the boring-stack defaults: backend truth, HTML-over-the-wire, minimal browser state, and SSE only when the server truly needs to stream.

## When to use

Use this skill when:

- the user wants to add or review a Data-Star interaction in a Bun + Hono app
- the user wants to decide between plain HTML, a Data-Star request or patch, or SSE
- the user wants to build a streamed form, progress, or chat slice without falling into JSON-first drift
- the user says "make this idiomatic Data-Star", "follow the Tao of Data-Star", or asks for HTML-over-the-wire interaction patterns

Do not use it for:

- React, Vue, or SPA component architecture
- websocket-heavy collaboration or generalized realtime infrastructure
- pure mockup or CSS work with no interaction design

## Workflow

1. Read the local project context first.
   - Find the experiment README, `CONTEXT.md`, and any interaction or SSE decision notes.
   - If the repo follows the micro-saas-template shape, respect its feature folders, `layout()`, and test conventions.
2. Choose one interaction shape by asking targeted questions.
   - Do not present a long option list.
   - Ask only enough to decide:
     - What user-visible states exist?
     - Is this one response or a stream?
     - What should the server render on success and failure?
     - What stable element ID will be patched?
     - What state truly must live in the browser?
3. Apply the default decision tree.
   - Navigation or resource switch → use `<a>` or backend redirect.
   - One request, one response → build a plain route or form first; add Data-Star only to improve UX after the HTML flow works.
   - Zero-to-many updates, progress, or chat tokens → use SSE.
   - Tiny UI-only state → use a local `_signal`.
   - Business state, permissions, workflow state, or persisted entities → keep it on the backend.
4. Implement in boring-stack order.
   - static mockup
   - Hono `html` view
   - plain route or action
   - Data-Star enhancement
   - SSE only if the flow really streams
   - route, HTML, and SSE tests
5. Review for drift and call it out early.
   - JSON endpoints created only for first-party UI
   - client-owned business state
   - manual history management
   - optimistic success before server confirmation
   - missing stable IDs for morph targets
   - ad hoc SSE string building spread across handlers

## Defaults

- Backend state is the source of truth.
- First-party UI speaks `text/html` or `text/event-stream`, not JSON by default.
- Use Data-Star defaults before changing patch behavior.
- Prefer full HTML fragments with stable IDs over fine-grained client logic.
- Use signals sparingly:
  - good: input binding, loading flags, disclosure state
  - bad: server records, permissions, workflow truth
- Prefer `data-indicator` for short request feedback.
- Prefer anchors and redirects for navigation.
- Prefer a tiny Hono SSE helper over adding more browser-side code.
- Prefer one shared SSE helper module over hand-formatting events in routes.

## Project-specific rules for the micro-saas template style

- Render with Hono `html` helper and the shared `layout()`.
- Keep first-party features under `src/features/{feature}/`.
- Use `views.ts` for server-rendered pages and fragments.
- Keep shared SSE formatting in `src/integrations/sse.ts`.
- Center tests on routes, rendered HTML, and raw SSE output.
- Mock only external boundaries such as email or storage.

## Gotchas

- If you are storing meaningful application state in signals, you are probably rebuilding a SPA badly.
- Signals are global. Prefer `_local` names for UI-only state that should not be sent to the backend.
- Stable `id` attributes are mandatory for patch targets.
- Do not introduce `fetch` + JSON + client templating for first-party UI just because it feels familiar.
- Do not manage browser history manually for normal page navigation.
- Do not use optimistic UI by default; show loading, then confirm from the server.
- ⚠️ Validate SSE event names against the actual Data-Star version. The current TypeScript SDK uses `datastar-patch-elements` and `datastar-patch-signals`; older notes that mention `merge-signals`, `mergeMode`, or `morph` event fields may be stale.

## Output format

Use one of these shapes.

```markdown
# Data-Star Plan

## Chosen interaction shape
- <plain HTML / Data-Star patch / SSE stream>
- <why this is the default here>

## Questions answered
- <question> → <answer>

## Changes
- routes:
- views/fragments:
- Data-Star attributes:
- SSE helper:
- tests:

## Tao check
- backend truth:
- browser state kept minimal:
- no JSON-first drift:
```

```markdown
# Data-Star Review

## Verdict
- <idiomatic / drifting / broken>

## ⚠️ Problems
- <problem>
- <problem>

## Required changes
- <change>
- <change>

## Keep
- <good pattern>
```

## References to load on demand

- Read `references/pattern-recipes.md` when you need the preferred recipe for forms, fragment swaps, local signals, or SSE streams.
