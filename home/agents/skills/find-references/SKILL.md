---
name: find-references
description: Use when the user asks to find design references, inspiration or how competitors implement a screen, component or flow. Searches Dribbble, Behance, the web and competitor products through agent-browser and saves screenshots to .references/<nnn>__<slug>/. Do not load for a screenshot of the user's own app or for recording a demo.
argument-hint: "<what to find references for> [competitors or sites]"
---

# Find references

## Inputs

From `$ARGUMENTS` and the chat:

- subject: the screen, component or flow — missing → ask
- product context: domain, audience, platform — read from the repo's README when unstated
- competitors or sites the user named — visit them first

## Preflight

- `agent-browser doctor` fails → stop and say so

## Session

```bash
agent-browser session id --scope worktree --prefix find-references
```

- `export AGENT_BROWSER_SESSION=<printed name>` in every Bash call
- `set viewport 1440 900`; mobile subject → `set device "iPhone 15"`
- command details: `agent-browser skills get core`

## Folder

- `<repo root>/.references/`, with `.gitignore` holding `*` — create when missing
- subject folder `<nnn>__<slug>/`, `<slug>` in English snake_case — reuse one with the same slug and continue its file numbering; otherwise `<nnn>` counts down from `999`: the lowest existing minus one

## Sources

Three groups; a source that blocks, demands login or shows a captcha → skip it and name it in the reply, never work around it.

### Concept shots

- Dribbble: `https://dribbble.com/search/<kebab-query>`
- Behance: `https://www.behance.net/search/projects?search=<query>`
- open a shot, screenshot the shot image by selector, not the grid

### Live products

- WebSearch for products and design-system docs that ship the subject: "<subject> examples", "best <subject> design", "<design system> <component>"
- open the real page and reach the state that shows the subject

### Competitors

- the named ones, or 3–5 found with WebSearch for the product's domain
- reach the subject in their public pages; behind a login → skip

## Capture

- dismiss cookie banners and popups before the screenshot
- crop to the subject: `screenshot <selector> <path>`; whole layout matters → viewport; long page → `--full`
- every state the subject has — empty, filled, error, hover, open — one file each
- file: `<nn>__<source>__<idea>.png`, `<nn>` two digits from `01`, `<source>` the domain without TLD
- open each file after saving; off-subject, blank or covered by an overlay → delete and retake
- target 12–20 files, at least 3 sources, no two showing the same idea

## Index

`<nnn>__<slug>/README.md`, one line per file:

```markdown
- `03__linear__inline-status-picker.png` — https://linear.app/… — status changes in place, no modal
```

- the idea is what to borrow, not a description of the image
- reused folder → append

## Reply

- the folder path
- 3–5 patterns repeating across sources, each with its file numbers
- skipped sources and why
- `close` the session
