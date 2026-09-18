---
name: deep-work
description: Set up a persistent notes workspace at .deep-work/<nnn>__<slug>/ holding plan.md plus research/ and notes/ folders, before starting any hard or long-running task, then stop and change nothing until the user has reviewed plan.md and explicitly said to start — review feedback only updates the plan. Use for deep research, investigating an unfamiliar codebase or subsystem, chasing a stubborn bug, comparing libraries or approaches, designing an architecture, planning a migration or a refactor spanning many files, or anything needing several rounds of reading before the first edit. Triggers on "research", "investigate", "figure out", "look into", "plan", "design", "compare", "audit", "migrate", "why is", and on a ticket ID. Also use to resume such a task from an existing .deep-work/ workspace.
---

# Deep work workspace

Hard tasks produce findings and decisions that must outlive a context window. Park them in the project, not in the transcript.

Research and plan come first, and then nothing else happens until the user has reviewed the plan and said to start.

## Location

The workspace belongs to the repo the task is about, not the repo Claude happens to be running in. Working from repo A on a task about repo B puts every note under B — `<repo-b>/.deep-work/<nnn>__<slug>/`, with B's own `.deep-work/.gitignore`. Notes about another repo never land in the current one.

Resolve that root before writing anything — `git -C <path inside the target repo> rev-parse --show-toplevel` — and prefix every note path with it. A task spanning two repos keeps its notes in the one being changed.

## Number

The workspace is `.deep-work/<nnn>__<slug>/` at that repo's root. The number counts down, so the newest workspace sorts to the top of any listing:

- Three digits, zero-padded
- The first workspace in a repo is `999`
- Each new one takes the lowest existing number minus one
- A double underscore separates the number from the slug, so a slug starting with a ticket number never blurs into it

```
.deep-work/
  .gitignore
  996__valibot_formisch/
  997__use_route_query/
  998__improve_invalidation_ux/
  999__improve_admin_panel_ux/
```

A resumed workspace keeps its number. Renumbering would break every path already quoted in chat.

## Slug

The slug is a path segment, so it is lowercase ASCII snake_case: no spaces, no hyphens, no punctuation, no non-Latin characters, nothing that needs quoting in a shell.

Derive it from whatever names the task:

- A ticket keeps its ID as the prefix, followed by a few words of the title: `ab_1234_limit_validation`, `38_log_out_all_devices`
- A non-English title is translated or transliterated down to those few words, never copied verbatim
- No ticket means just the summary: `token_refresh_race`, `bun_vs_node_runtime`

Five words is the ceiling. The original title, in its original language and full length, goes in the `plan.md` heading — that is what the heading is for.

## Structure

A workspace holds these three entries and nothing else:

```
.deep-work/
  .gitignore
  999__ab_1234_limit_validation/
    notes/
      998__retry_on_429.md
      999__rejected_zod_refine.md
    research/
      998__limit_error_shape.md
      999__legacy_limit_callers.md
    plan.md
```

- `plan.md` — the only file the user reads: the steps, ticked as they land, pointing at every research file and note
- `research/` — the investigation, one question per file
- `notes/` — everything else, one note per file

No other file or folder is ever created, at the root or inside `research/` or `notes/` — no `summary.md`, no `edge-cases.md`, no `images/`, no scratch scripts or logs. Whatever seems to need one becomes a note, with command output pasted in as a trimmed excerpt.

The user never browses `research/` or `notes/`. They open a file only when `plan.md` sends them there, so a file the plan does not point at is lost, and anything the user must know sits in `plan.md` itself.

Pure research still gets a `plan.md`, since nothing else is read. It keeps only Open questions, Goal, Approach, Research and Notes — Goal is the question, Approach is the answer.

## Research and notes

`research/` and `notes/` work exactly alike and differ only in what goes in them:

- `research/` — findings that answer a question the task raises, each backed by evidence
- `notes/` — what fits neither research nor the steps: a decision made mid-flight, a rejected idea, an edge case, a side finding, user feedback

Both follow the same rules:

- Named `<nnn>__<slug>.md`, counting down from `999` like workspaces, so the newest file sorts first — each folder keeps its own count
- One file, one concern — more on the same concern edits that file, a new concern is a new file
- The folder is created with its first file
- Every file is listed in `plan.md`; one added after the plan exists gets its line in the same pass

## Procedure

1. Resolve the target repo root, then list its `.deep-work/` first. A directory whose slug matches, whatever its number, means resume: read `plan.md`, then `research/` and `notes/` newest first, then carry on from where it stopped — never open a parallel workspace. A plan with no ticked box is still under review: post its path and stop, unless the message that resumed it says to start.
2. Create `<target repo root>/.deep-work/<nnn>__<slug>/` with the next number down, and `<target repo root>/.deep-work/.gitignore` holding a single `*` if it is not already there. The workspace ignores itself, so it never needs a line in the repo `.gitignore` and never gets committed.
3. Write research while investigating, not after — a research file per question, the moment the question comes up. Every claim carries its evidence: `path/to/file.ts:42`, a command with its output, or a URL.
4. Turn research into a plan before touching code.
5. Stop once `plan.md` is written, as described in Stop below. Post the plan path and a short summary in chat, then wait.
6. Commit each step and tick its box as it lands, as described in Commits below. A stale plan is worse than no plan.
7. Name the workspace path in chat when creating it, and still answer in chat. The notes supplement the reply, they do not replace it.

## Stop

Once `plan.md` is written, the task halts. Nothing that changes anything happens — no code edits, no branches, no commits, no installs, no migrations, no services started — until the user explicitly says to start.

Only an instruction to start implementing is the go: "start", "go", "implement it", "do step 1". None of these are:

- The request that opened the task ("let's do this ticket") — the user has not read the plan yet
- Approval of the plan — "looks good", "ok", "makes sense"
- Review feedback — "use X instead", "drop step 3", a question about a step

Review feedback is a loop, and every pass through it ends stopped:

1. Apply the feedback to `plan.md`, and to the research file whose finding it changes — reading code to check a suggestion is fine, editing it is not
2. Post what changed in chat
3. Stop again and wait for the next review or the go

A message carrying both feedback and the go ("drop step 3, then start") updates the plan first, then starts. When it is unclear whether a message is the go, ask — never guess towards starting.

## Commits

After the go, Claude commits its own work. The go is the permission, so no commit is asked about or left as a suggestion:

- Commits land on the branch `plan.md` names, so the branch is reviewed with the rest of the plan; creating it is the first action after the go
- One commit per top-level step, made the moment the step lands — then tick the box and append the short SHA: `- [x] **1. <step>** — a1b2c3d`
- The message is a Conventional Commits subject, with no `Co-Authored-By` trailer
- Stage the step's files by path, never `git add -A` or `git add .`, so unrelated changes in the tree stay out
- A failing hook gets fixed, never skipped with `--no-verify`
- A bug found in an earlier step's commit is fixed into that commit with `git commit --fixup <sha>` and `git rebase --autosquash`, not stacked on top — except on a default branch, where rewriting needs asking first
- Nothing is pushed unless the user says to

## plan.md

Steps are a checklist, never a table. One numbered top-level box per step, sub-steps nested under it — each one a single concrete action naming the file it touches.

```markdown
# <original task title, verbatim> — plan

## Open questions

- Unresolved, and what would resolve it — `research/999__legacy_limit_callers.md`

<ticket URL, if there is one>

Branch: `<branch the commits land on>`

## Goal

What done looks like.

## Approach

Chosen option and why, in a few lines, naming the research that settled it: `research/998__limit_error_shape.md`.

## Steps

- [ ] **1. <step>**
  - [ ] <action> — `src/auth/session.ts:88`
  - [ ] <action> — `notes/998__retry_on_429.md`
- [ ] **2. <step>**
  - [ ] <action>

## Verification

Commands to run, and what passing output looks like.

## Research

- `research/998__limit_error_shape.md` — what it concluded, in one line
- `research/999__legacy_limit_callers.md` — what it concluded, in one line

## Notes

- `notes/998__retry_on_429.md` — what it decided, in one line
- `notes/999__rejected_zod_refine.md` — what it decided, in one line
```

Sub-steps indent by two spaces. Tick a box the moment it lands; a step that gets dropped is struck through with the reason after it, not deleted.

Open questions come first, straight under the heading, because they are what the user has to answer. Every question raised anywhere — a research file, a note, a step — lands there, naming the file it came from. An answered question leaves the list, its answer going into the plan or the file it changes. With nothing open, the section is left out.

Research and Notes list every file in their folder, newest first, by its path relative to `plan.md`. The line after the path is the conclusion, not the topic — the user reads that line instead of the file. Wherever the approach, a step or an action rests on one of those files, it names the path there too.

## research/<nnn>__<slug>.md

```markdown
# <the question this file settles>

## Findings

- Claim — evidence (`src/auth/session.ts:88`, command output, URL)

## Constraints

What any solution has to respect.

## Options

### A — <name>

Trade-offs.

### B — <name>

Trade-offs.
```

A section with nothing in it is left out. What the research leaves unresolved goes in the Open questions of `plan.md`, not here.
