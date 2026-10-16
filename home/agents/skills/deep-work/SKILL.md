---
name: deep-work
description: Use ONLY when the user types /deep-work or asks to resume an existing deep-work plan. Creates a .deep-work/<nnn>__<slug>/ workspace with research and a plan the user reviews inline. Do not load for ordinary research, brainstorming in chat, multi-step tasks, ticket IDs, questions about the skill, or plan mode.
---

# Deep work

Research and plan go into the repo, so they outlive the context window. Nothing changes until the user has reviewed the plan and said to start.

## Workspace

- Path: `<repo root>/.deep-work/<nnn>__<slug>/`, root from `git rev-parse --show-toplevel`. A task spanning repos keeps one workspace here; other repos' paths are `~/`-prefixed.
- `.deep-work/.gitignore` holds `*` — create it if missing; nothing here is committed.
- `<nnn>`: three digits counting down — the first is `999`, each next is the lowest existing minus one. A resumed workspace keeps its number.
- `<slug>`: lowercase ASCII snake_case, at most five words. Ticket ID first when there is one (`ab_1234_limit_validation`), otherwise the summary (`token_refresh_race`). A non-English title is translated; the original goes verbatim in the `plan.md` heading.

```
999__ab_1234_limit_validation/
  plan.md
  research/999__legacy_limit_callers.md
  notes/999__rejected_zod_refine.md
```

- `plan.md` — the only file the user reads
- `research/` — one question per file, every claim with evidence: `path/to/file.ts:42`, command output, URL
- `notes/` — the rest: mid-flight decisions, rejected ideas, edge cases, review feedback
- Files are `<nnn>__<slug>.md`, counting down per folder, one concern each; a folder appears with its first file
- Nothing else is created — no summaries, images, scripts or logs; command output goes into a note as an excerpt
- `plan.md` lists every research and note file; a file it does not point at is lost

## Procedure

1. List `.deep-work/`. A matching slug means resume: read `plan.md`, then research and notes newest first, and continue. A plan with no ticked box is under review: post its path and stop.
2. Otherwise create the workspace and name its path in chat.
3. Write research while investigating, not after.
4. Write `plan.md`, post its path and a short summary, stop.

## Stop

Once `plan.md` exists nothing changes — no edits, branches, commits, installs, migrations or services — until the go: "start", "go", "implement it", "do step 1".

- Not the go: the request that opened the task, approval ("looks good"), review feedback
- Feedback plus the go in one message: update the plan, then start
- Unsure whether it is the go: ask

## Review

Each step heading is followed by one empty line, the user's review zone, then `---`. The user writes there in any form; an empty zone means accepted. Claude never writes in a zone. Checkboxes are Claude's progress only.

Each pass ends stopped:

1. Read every non-empty zone and any chat feedback
2. Apply it to `plan.md` and to the research file it changes — reading code is fine, editing it is not
3. A question ("explain", "why?") means the step is unclear: rewrite the step, say nothing in chat
4. A comment that needs the user's answer becomes an Open question
5. Move each zone verbatim, with its step and the decision or answer, into `notes/<nnn>__review_<n>.md`, and empty the zone
6. Post the other changes in chat

## After the go

Commit per the git rules:

- On the branch `plan.md` names; create it first when it is not current
- One commit per step as it lands, staged by path, never `git add -A` or `git add .`
- Tick sub-steps as they land, then the step with its short SHA: `### [x] 1. <step> — a1b2c3d`
- A dropped step is struck through with the reason, never deleted

## plan.md

An index, not a document: every line is an action or a pointer to the file holding its reasoning. Nothing is said twice.

```markdown
# <original task title, verbatim> — plan

## Open questions

- <choice, options> — `research/999__legacy_limit_callers.md`

<ticket URL, if any>

Branch: `<branch>`

## Goal

- One outcome per line, in the user's terms.

## Approach

- <decision> — `research/998__limit_error_shape.md`

## Steps

### [ ] 1. <step>

---

- [ ] <action> — `src/auth/session.ts:88`

## Verification

- <command> — what passing looks like

## Research

- `research/998__limit_error_shape.md` — its conclusion

## Notes

- `notes/999__rejected_zod_refine.md` — its decision
```

- Only these sections, only lists: no paragraphs, no sub-headings except steps; a short `>` remark or a code block showing a call shape is allowed
- A line that wraps three times becomes two lines or a research file
- Open questions: everything unresolved from any file, one line each; answered ones leave; none — section omitted
- A sub-step is one action and one path, no justification clause — the reason lives in the research file it names; a testing sub-step may list several behaviours
- Research and Notes: every file, newest first, path relative to `plan.md`, then its conclusion, not its topic
- Pure research keeps only Open questions, Goal (the question), Approach (the answer), Research and Notes

## research/<nnn>__<slug>.md

```markdown
# <the question this file settles>

## Findings

- Claim — evidence

## Constraints

- What any solution has to respect

## Options

### A — <name>

- Trade-offs
```

Empty sections are left out; anything unresolved goes to Open questions in `plan.md`.
