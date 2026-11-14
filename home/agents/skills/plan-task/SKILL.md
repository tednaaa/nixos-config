---
name: plan-task
description: Use ONLY when the user types /plan-task or asks to resume an existing task plan. Writes research, a declarative plan.md and its impl.md steps the user reviews inline into the .ai/<nnn>__<slug>/ task workspace. Do not load for ordinary research, brainstorming in chat, multi-step tasks, ticket IDs, questions about the skill, or plan mode.
---

# Task plan

Research and plan go into the repo, so they outlive the context window. Nothing changes until the user has reviewed the plan and said to start.

## Workspace

The task workspace from the workspace rule. This skill owns `plan.md`, `impl.md`, `research/` and `notes/`.

```
999__ab_1234_limit_validation/
  plan.md
  impl.md
  research/999__legacy_limit_callers.md
  notes/999__rejected_zod_refine.md
```

- `plan.md` — what and why: goal and the chosen solution; its heading keeps the original task title verbatim
- `impl.md` — how: steps, the paths they touch, verification, the research and notes index
- The user reads only these two
- `research/` — one question per file, every claim with evidence: `path/to/file.ts:42`, command output, URL
- `notes/` — the rest: mid-flight decisions, rejected ideas, edge cases, review feedback
- Files are `<nnn>__<slug>.md`, counting down per folder, one concern each; a folder appears with its first file
- This skill creates nothing else — no summaries, images, scripts or logs; command output goes into a note as an excerpt
- `impl.md` lists every research and note file, and every `references/<scope>/README.md`; a file it does not point at is lost

## Procedure

1. Pick the workspace per the workspace rule. It has `plan.md` → resume: read it and `impl.md`, then research and notes newest first, and continue. An `impl.md` with no ticked box is under review: post both paths and stop.
2. No `plan.md` yet → start one there; read every `references/<scope>/README.md`.
3. Write research while investigating, not after.
4. Write `plan.md`, then `impl.md`, post both paths and a short summary, stop.

## Stop

Once `plan.md` exists nothing changes — no edits, branches, commits, installs, migrations or services — until the go: "start", "go", "implement it", "do step 1".

- Not the go: the request that opened the task, approval ("looks good"), review feedback
- Feedback plus the go in one message: update the plan, then start
- Unsure whether it is the go: ask

## Review

The `Goal`, `Solution` and `Usage` headings of `plan.md` and each step heading of `impl.md` are followed by one empty line, the user's review zone, then `---`. The user writes there in any form; an empty zone means accepted. Claude never writes in a zone. Checkboxes are Claude's progress only.

Each pass ends stopped:

1. Read every non-empty zone and any chat feedback
2. Apply it to `plan.md`, `impl.md` and the research file it changes — reading code is fine, editing it is not
3. A question ("explain", "why?") means the section or step is unclear: rewrite it, say nothing in chat
4. A comment that needs the user's answer becomes an Open question
5. Move each zone verbatim, with its section or step and the decision or answer, into `notes/<nnn>__review_<n>.md`, and empty the zone
6. Post the other changes in chat

## After the go

Commit per the git rules:

- On the current branch; a new one only when the user asks, then `impl.md` names it
- One commit per step as it lands, staged by path, never `git add -A` or `git add .`
- Tick sub-steps as they land, then the step: `### [x] 1. <step>`
- A dropped step is struck through with the reason, never deleted
- A step that changes the solution updates `plan.md` first

## plan.md

Declarative: what we want and which solution we chose. The user reviews it in a minute and corrects a line in place.

```markdown
# <original task title, verbatim> — plan

<ticket URL, if any>

## Open questions

- <choice: option A or option B, which one Claude recommends>

## Goal

---

- One outcome per line, in the user's terms

## Solution

---

- <what changes, in plain words>
- <a consequence the user would notice: slower, different behaviour, a cost>
- Rejected: <option> — <the one reason>

## Usage

---

<one line saying what the block shows>:

```rust
<the call or declaration as its user writes it>
```

- <what follows from it, one item per line>

Unchanged:

- <URL, response, config the user already knows>
```

- Only these sections, only lists and Usage's code blocks, no remarks
- Usage shows the result from its user's side: the call, declaration, config, data shape or request they will write or see — never internals
- Usage blocks: real names, at most ten lines each, at most three blocks; omitted when the task changes nothing a developer or caller touches
- Outside Usage blocks: no paths, file names, research links, function, column or library names unless the user named them first
- One fact per line, one screen line long; a line that needs more is split or dropped to `impl.md`
- Numbers when they decide: timings, limits, counts
- Solution: three to six lines, each a decision or a consequence; mechanics stay in `impl.md`
- Open questions: everything unresolved from any file, one line each; answered ones leave; none — section omitted

## impl.md

Imperative: how `plan.md` gets done, step by step. Every line is an action or a check.

```markdown
# <original task title, verbatim> — implementation

Branch: `<branch>`

## Steps

### [ ] 1. <step, one commit>

---

- [ ] <action> — `src/auth/session.ts:88`

## Verification

- <command> — what passing looks like

## Research

- `research/998__limit_error_shape.md` — its conclusion

## Notes

- `notes/999__rejected_zod_refine.md` — its decision
```

- Only these sections, only lists; a code block showing a call shape is allowed
- A step is one commit
- A sub-step is one action and one path, no justification clause — the reason lives in the research file it names; a testing sub-step may list several behaviours
- Research and Notes: every file, newest first, path relative to `impl.md`, then its conclusion, not its topic
- Pure research has no steps: `impl.md` keeps only Research and Notes

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
