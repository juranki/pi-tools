# Data-Star pattern recipes for micro-SaaS pilots

Use this reference after the task already falls inside the skill and you need the preferred implementation shape.

## Non-negotiables

- backend state is the source of truth
- first-party UI stays HTML-over-the-wire
- patch targets have stable `id` attributes
- signals stay small and mostly local
- SSE is for zero-to-many server updates, not routine form handling
- navigation stays anchors and redirects unless there is a real reason to do more
- no JSON-first drift for first-party UI

## Ask these questions first

Ask only enough to choose one path:

1. What exact user-visible states exist: empty, loading, success, error, permission?
2. Is this one response or a stream?
3. What should the server render on success and on failure?
4. What stable element ID will be patched?
5. What state truly must live in the browser?

After those answers, pick one shape and move.

## Preferred shapes

### 1. Navigation or resource switch

Use an anchor tag or a backend redirect.

- normal page-to-page movement is not a Data-Star problem
- do not wrap routine navigation in custom request actions
- do not manually manage browser history for ordinary pages

### 2. Ordinary form or one-shot action

Start with a plain HTML route and form.

- make the GET page render correctly first
- make the POST action work correctly next
- only then add Data-Star if the user benefits from an in-place update
- return HTML for the next meaningful state, not JSON status codes for the browser to interpret
- keep validation and permission handling server-rendered
- use `data-indicator` for short request feedback
- patch the smallest stable container with an `id`

Preferred shape:

- `GET` renders the page
- `POST` performs the action
- success returns redirect or success fragment
- failure returns the page or a fragment with error copy

### 3. Fragment swap on success or error

Use server-rendered fragments, not client-side template strings.

- keep fragments in `views.ts`
- render the exact next visible state from the backend
- patch by stable `id`
- let Data-Star morph the DOM instead of manually stitching HTML in the browser
- keep server copy authoritative for validation, permissions, and workflow transitions

### 4. Purely local UI state

Use tiny local signals.

Good uses:

- `_open`
- `_tab`
- `_loading`
- form input binding
- disclosure and menu visibility

Recommended attributes:

- `data-bind`
- `data-show`
- `data-class`
- `data-attr:*`

Rules:

- local signals should start with `_` so they are not sent to the backend
- if an element starts hidden with `data-show`, set an inline hidden style to avoid flash
- do not store entities, permissions, or persisted workflow state in signals

### 5. Long-running, progress, or streamed update

Use SSE when the server must send progress, multiple patches, or a final update after work begins.

Micro-saas-template style:

- Hono route owns the domain flow
- a shared helper owns SSE formatting
- route emits small domain events such as `progress`, `done`, and `error`
- route emits element patches for visible state changes
- tests assert raw SSE output, not browser internals

Default stream shape in this stack:

- one event updates small signals for progress state
- one event patches the visible HTML fragment when the state changes
- handlers stay free of raw SSE wire-format string assembly

### 6. CQRS-style live page

Only use a long-lived read stream plus short-lived writes when the user truly needs live updates while issuing separate commands.

- do not jump to CQRS for ordinary forms
- use it when there is a real live feed, progress stream, or shared update surface
- keep writes short and server-owned

## Review smell list

Call these out immediately:

- JSON endpoints created only for first-party HTML flows
- client-side template literals or `innerHTML` building server-owned views
- large `data-signals` objects carrying domain state
- manual `history.pushState` or custom navigation plumbing
- optimistic success banners before the server confirms success
- patch targets without stable `id` attributes
- scripts doing DOM work that patching should do
- route handlers that know low-level SSE wire format
- WebSockets added for one-way progress or chat streams that SSE already covers
- `filterSignals` used prematurely instead of shrinking signal scope

## Current protocol notes

⚠️ Verify the exact Data-Star version before copying wire examples.

Current TypeScript SDK facts:

- non-local signals are sent with backend requests by default
- local signals start with `_` and are not sent to the backend
- current SSE event types are:
  - `datastar-patch-elements`
  - `datastar-patch-signals`
- current patch options use `mode` values such as `outer`, `inner`, `replace`, `append`, and `remove`
- notes using `merge-signals`, `mergeMode`, or `morph` event fields are likely stale or from another version

## Micro-saas template fit

When the target repo follows the current micro-saas template:

- start from a mockup
- translate it near 1:1 into a Hono `html` view
- keep pages and fragments in `src/features/{feature}/views.ts`
- keep route handlers in `src/features/{feature}/routes.ts`
- keep shared layout in `src/ui/layout.ts`
- keep shared SSE helpers in `src/integrations/sse.ts`
- center tests on routes, HTML, and SSE bodies
