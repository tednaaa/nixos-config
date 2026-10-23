---
name: record-demo
description: Use when the user asks to record a demo of a finished frontend task or a video reproducing a bug in a web app. Records an mp4 with a visible cursor and step captions through agent-browser. Do not load for a single screenshot or e2e tests.
argument-hint: "<what to show or the bug> <url> <login> <password>"
---

# Record demo

## Inputs

From `$ARGUMENTS` and the chat:

- URL — missing → ask; never guess a port from configs
- account — missing and the page asks for login → ask
- scenario: what to show, or the bug's steps and expected result
- mode: a bug, broken behaviour, repro → repro; otherwise demo

## Preflight

- `agent-browser doctor` — no `pass` under Recording → stop and say so
- URL does not answer → stop and say so; never start a dev server

## Session

```bash
agent-browser session id --scope worktree --prefix record-demo
```

- `export AGENT_BROWSER_SESSION=<printed name>` in every Bash call
- `set viewport 1440 900`
- command details: `agent-browser skills get core`

## Rehearsal

No recording yet.

- `open <url>`, `snapshot -i`, walk the whole scenario
- per step note a selector that survives a fresh session — CSS or `find role … --name`, never an `@e` ref
- per pointer target note its centre from `get box <selector>`: `x + width/2`, `y + height/2`
- fix the failing steps
- repro: confirm the bug shows; it does not → say so, record nothing, stop

## Take folder

- `<repo root>/.demos/`, with `.gitignore` holding `*` — create when missing
- task folder `<nnn>__<slug>/` — reuse one with the same slug; otherwise `<nnn>` counts down from `999`: the lowest existing minus one
- take folder inside: `<YYYY-MM-DD>__<HH>_<MM>/`; taken → `__2`, `__3`

## Take

The whole take is one Bash call: every pause between calls lands in the video.

```bash
set -e
export AGENT_BROWSER_SESSION=<name>
trap 'agent-browser record stop' ERR
agent-browser close
agent-browser open --init-script <skill dir>/caption.js <url>
agent-browser set viewport 1440 900
agent-browser record start <take>/video.mp4 --cursor
agent-browser mouse move 720 450 --duration 300
agent-browser eval "__caption('<action>')"
agent-browser mouse move <cx> <cy> --duration 400
agent-browser wait 150
agent-browser click <selector>
agent-browser wait --text "<result text>"
agent-browser wait 600
agent-browser record stop
```

- pointer step: `mouse move` to the centre, `wait 150`, `click` — the cursor lands before the click
- text step: the pointer step on the field, then `type <field> "<text>"`; never `fill`
- caption: the request's language, one short action; covers the element in use → `__caption('<action>', 'top')`
- final state: `wait 1500` before `record stop`
- the script fails → delete the take folder, fix in rehearsal, retake

## Demo

- shortest path to the result, no side screens
- `screenshot <take>/final.png` before `record stop`

## Repro

- end on the broken state; caption names what is wrong
- `screenshot <take>/broken.png` before `record stop`
- `console > <take>/console.log`, then `errors >> <take>/console.log`
- `network requests > <take>/network.log`

## Reply

- the take folder path
- repro: the errors and failed requests that explain the bug, one line each
- `close` the session
