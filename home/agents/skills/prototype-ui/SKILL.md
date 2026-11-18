---
name: prototype-ui
description: Use when the user asks to prototype, mock up or try design variants of a screen, component or flow in the project's code before implementing it. Audits the current design, then builds three variants on mock data in place of the subject and indexes them in prototypes/README.md in the .ai/<nnn>__<slug>/ task workspace. Do not load for implementing the final feature, finding design references or recording a demo.
argument-hint: "<screen, component or flow>"
---

# Prototype UI

## Inputs

From `$ARGUMENTS` and the chat:

- subject: the screen, component or flow — missing → ask
- the URL of the subject on the user's running dev server — missing → ask; never start a server
- account — missing and the app asks for login → ask
- `references/<scope>/README.md` for the subject in the task workspace — read its Patterns and groups when present; other scopes stay unread

## Preflight

- `agent-browser doctor` fails → stop and say so
- `curl -sf <url>` does not answer → stop and ask the user to start the dev server

## Session

```bash
agent-browser session id --scope worktree --prefix prototype-ui
```

- `export AGENT_BROWSER_SESSION=<printed name>` in every Bash call
- `export AGENT_BROWSER_PROFILE=~/.agent-browser/profiles/<repo key>` in every Bash call, `<repo key>` as in `find-references`: the main checkout's path relative to `~`, `/` → `__`
- command details: `agent-browser skills get core`

## Branch

- by default the current branch in the current checkout; the dev server's hot reload shows the variants
- a worktree only when the user asks: `git worktree add ../<repo name>__<slug> -b prototype/<slug>` from `HEAD`, slug from the workspace rule, the untracked `.env*` files copied from the main checkout, dependencies installed with the lockfile's package manager; the user runs its dev server and gives the URL
- the task workspace stays in the main checkout; a `prototype/<slug>` branch is never merged

## Audit

`<repo root>/.ai/.design_audit.md`, shared by every task in the repo. Exists → reuse it; missing or the user asks → write it.

- read the theme, the shared components and two or three screens close to the subject
- screenshot those screens on the dev server at 375 and 1440 into a temp dir
- judge each layer against current standards, not taste: type scale, spacing system, WCAG 2.2 AA contrast, hover, `focus-visible`, disabled, loading, empty and error states, component consistency, keyboard and roles, targets from 24px, responsiveness, `prefers-reduced-motion`

```markdown
# Design audit

## Tokens — keep
- spacing on a 4px scale, type scale 12–32

## Components — replace
- three button styles, no focus-visible

## Screen patterns — replace
- forms in modals, errors only as toasts

## Brand
- logo, primary `#4f46e5`, short neutral copy
```

- `keep` → variants reuse the layer; `replace` → variants ignore it and follow the standard
- brand stays unless the user says otherwise
- go straight to the variants; the user corrects the audit while reviewing → update the file and rework the variants it affects

## Variants

Load `frontend-design` before designing.

- three by default, another count only when asked
- `a` — the calmest take on the current standard; in the product's style where the audit says `keep`
- `b` — built from the references' Patterns; no references → from the strongest live products for the subject
- `c` — bold: another layout or interaction model
- variants share data and differ only in design

## Code

- variants render where the subject renders, inside the real screen; no separate route
- one folder next to the subject: a component per variant, `fixtures.ts`, `primitives/` for `replace` layers
- the place that renders the subject reads `~~proto`: set → that variant on fixtures; missing → the original, unchanged
- deleting the folder and that switch removes the prototype
- headless libraries already in the project are fine; a new dependency only after the user agrees
- query params `~~proto=a|b|c`, `~~proto_state=empty|filled|loading|error`, `~~proto_panel=0`; the `~~` prefix keeps them clear of the app's own params and plugins
- scenario toggles the subject needs, such as role or view mode, as `~~proto_<name>` params
- `~` stays unencoded in the URL: the panel builds the query string itself, since `URLSearchParams` writes `~` as `%7E`
- an open menu, popover or dialog worth reviewing is a scenario toggle, since a click on the panel closes it as an outside click

## Panel

- a card with `position: fixed`, centred in the viewport by default so the user sees it, rendered at the end of `body` with z-index `2147483647`
- rendered by the switch only while `~~proto` is set
- button groups for variant, state and scenario toggles, each writing its query param
- the card itself drags with pointer events; a drag under 4px counts as a click on its buttons
- kept inside the viewport on resize; position saved in sessionStorage under `~~proto_panel`
- a close button hides the card until reload
- `~~proto_panel=0` hides it for the check

## Mocks

- variants run on mocks: no requests, no global stores, no real auth from the variants; the screen around them stays real
- all data in `fixtures.ts` next to the variants, one place to update or drop
- typed with the project's entity types; real-looking copy in the product's language, long and empty values included
- data reaches variants through props or a local composable

## Check

Per variant, before showing, through agent-browser with `~~proto_panel=0`:

- contrast and `focus-visible` on every interactive element
- every state filled
- nothing breaks at 375 and 1440
- no `replace` layer leaks in
- screenshots for the check go to a temp dir, never the task workspace

## Index

`prototypes/README.md` in the task workspace from the workspace rule:

```markdown
# Status picker — prototype

- url: http://localhost:5173/tasks/42?~~proto=a

## a — inline menu under the chip
- differs: opens in place, keyboard first
- project changes: new button primitive, 8px radius tokens

## Choice
```

- `branch:` line only for a worktree: `prototype/<slug>`
- `project changes` — only for variants built on `replace` layers: what the product must change to ship it without drift

## Commit

- current branch → no commit; the prototype stays uncommitted until the choice
- worktree → commit to `prototype/<slug>` once the check passes

## Reply

- the subject's URL with `~~proto=a`, plus the branch for a worktree
- the audit verdicts, one line per layer
- one line per variant: how it differs
- the `prototypes/README.md` path
- `close` the session

## Choice

The user picks a variant to implement → no confirmation for any step:

- write the variant and the reason under `Choice` in the index
- current branch → the variant component, `fixtures.ts` and its primitives stay; other variants, the panel and the switch go
- worktree → `git checkout prototype/<slug> -- <variant component> <fixtures.ts> <its primitives>` into the implementation branch, then `git worktree remove ../<repo name>__<slug>` and `git branch -D prototype/<slug>`

The user rejects every variant → write the reason under `Choice`, then delete the folder and the switch, or remove the worktree and its branch.
