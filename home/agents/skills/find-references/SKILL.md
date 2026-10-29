---
name: find-references
description: Use when the user asks to find design references, inspiration or how competitors implement a screen, component or flow. Searches Dribbble, Behance, the web and competitor products through agent-browser and saves screenshots to references/ in the .ai/<nnn>__<slug>/ task workspace. Do not load for a screenshot of the user's own app or for recording a demo.
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
- `export AGENT_BROWSER_PROFILE=<repo root>/.ai/.chrome_profile` in every Bash call — the project's profile keeps consents, captcha clearance and logins between runs
- `set viewport 1440 900`; mobile subject → `set device "iPhone 15"`
- command details: `agent-browser skills get core`

## Folder

- `references/` in the task workspace from the workspace rule; no task in play → the subject is the task
- an existing `references/` → continue its file numbering

## Sources

Three groups. A source that blocks, demands login or shows a captcha → set it aside, never work around it yourself.

After the other sources, name the blocked ones and offer to solve them by hand: `close`, then `open --headed <url>`; the user solves it → capture in that window. Declined → skip it and name it in the reply.

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

`references/README.md`:

```markdown
# Status picker — references

## Patterns
- status changes in place, never a modal — 03, 07, 11

## Where the picker opens

### Inline menu under the status chip
![](03__linear__inline-status-picker.png)
- [linear](https://linear.app/…)
- also: shortcut shown next to each status

## Skipped
- behance — captcha, declined to solve by hand
```

- `##` — a decision the subject needs; `###` — the option a file shows, phrased as what to borrow, not a description of the image
- one entry per file, in the group of its main idea, the one in its filename; other ideas on the shot → `- also:` bullets
- entries in a group by file number
- link text is the `<source>` from the filename
- Patterns: 3–5 ideas repeating across sources, each with every file number showing it, `also` ones included
- an existing index → add entries to their groups, open new groups as needed, update Patterns and Skipped

## Reply

- the folder path
- the Patterns from the index
- skipped sources and why
- `close` the session
