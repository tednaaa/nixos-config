---
name: prototype-ui
description: Use when the user asks to prototype, mock up or try design variants of a screen, component or flow in the project's code before implementing it. Audits the current design, then builds three variants on mock data in a git worktree and saves screenshots to prototypes/ in the .ai/<nnn>__<slug>/ task workspace. Do not load for implementing the final feature, finding design references or recording a demo.
argument-hint: "<screen, component or flow>"
---

# Prototype UI

## Inputs

From `$ARGUMENTS` and the chat:

- subject: the screen, component or flow — missing → ask
- account — missing and the app asks for login → ask
- `references/README.md` in the task workspace — read its Patterns and groups when present

## Preflight

- `agent-browser doctor` fails → stop and say so

## Session

```bash
agent-browser session id --scope worktree --prefix prototype-ui
```

- `export AGENT_BROWSER_SESSION=<printed name>` in every Bash call
- `export AGENT_BROWSER_PROFILE=<repo root>/.ai/.chrome_profile` in every Bash call
- command details: `agent-browser skills get core`

## Worktree

- `git worktree add ../<repo name>__<slug> -b prototype/<slug>` from `HEAD`, slug from the workspace rule
- copy the untracked `.env*` files from the main checkout
- install dependencies with the lockfile's package manager
- start the `dev` script in the background on the first free port from 5180: `--port <port> --strictPort` for vite, `-p <port>` for next
- wait until `curl -sf <url>` answers; it does not → stop and show the server output
- the task workspace stays in the main checkout; the branch is never merged

## Audit

`<repo root>/.ai/.design_audit.md`, shared by every task in the repo. Exists → reuse it; missing or the user asks → write it.

- read the theme, the shared components and two or three screens close to the subject
- screenshot those screens on the worktree's server at 375 and 1440
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

- a dev-only route `/~~prototype/<slug>` placed by the project's routing; `~` is never encoded and no router or dev server reserves it
- one folder per prototype: a component per variant, `fixtures.ts`, `primitives/` for `replace` layers; deleting the folder and the route removes the prototype
- headless libraries already in the project are fine; a new dependency only after the user agrees
- query params `proto=a|b|c`, `proto_state=empty|filled|loading|error`, `proto_panel=0`, prefixed so app-wide plugins never read them
- scenario toggles the subject needs, such as role or view mode, as `proto_<name>` params
- an open menu, popover or dialog worth reviewing is a scenario toggle, since a click on the panel closes it as an outside click

## Panel

- a card with `position: fixed`, centred in the viewport by default so the user sees it, rendered at the end of `body` with z-index `2147483647`
- button groups for variant, state and scenario toggles, each writing its query param
- the card itself drags with pointer events; a drag under 4px counts as a click on its buttons
- kept inside the viewport on resize; position saved in sessionStorage under `proto_panel`
- a close button hides the card until reload
- `proto_panel=0` hides it for screenshots

## Mocks

- everything runs on mocks: no requests, no global stores, no real auth from the prototype
- all data in `fixtures.ts` next to the variants, one place to update or drop
- typed with the project's entity types; real-looking copy in the product's language, long and empty values included
- data reaches variants through props or a local composable

## Check

Per variant, before showing:

- contrast and `focus-visible` on every interactive element
- every state filled
- nothing breaks at 375 and 1440
- no `replace` layer leaks in

## Capture

- `prototypes/` in the task workspace from the workspace rule
- `<variant>__<state>__<width>.png` for every variant, state and width, `proto_panel=0`
- open each file after saving; broken → fix and retake

## Index

`prototypes/README.md`:

```markdown
# Status picker — prototype

- branch: `prototype/status_picker`
- url: http://localhost:5180/~~prototype/status_picker

## a — inline menu under the chip
![](a__filled__1440.png)
- differs: opens in place, keyboard first
- project changes: new button primitive, 8px radius tokens

## Choice
```

- `project changes` — only for variants built on `replace` layers: what the product must change to ship it without drift

## Commit

- commit the prototype to `prototype/<slug>` once the check passes

## Reply

- the prototype URL and branch
- the audit verdicts, one line per layer
- one line per variant: how it differs
- the `prototypes/` folder path
- `close` the session
- the dev server keeps running for the comparison

## Choice

The user picks a variant to implement → no confirmation for any step:

- write the variant and the reason under `Choice` in the index
- `git checkout prototype/<slug> -- <variant component> <fixtures.ts> <its primitives>` into the implementation branch; other variants, the panel and the route stay behind
- stop the dev server
- `git worktree remove ../<repo name>__<slug>`
- `git branch -D prototype/<slug>`

The user rejects every variant → write the reason under `Choice`, then the last three steps.
