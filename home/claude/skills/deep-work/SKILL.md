---
name: deep-work
description: Set up a persistent notes workspace at .deep-work/<slug>/ holding numbered markdown notes (01-research.md, 02-plan.md, ...), before starting any hard or long-running task. Use for deep research, investigating an unfamiliar codebase or subsystem, chasing a stubborn bug, comparing libraries or approaches, designing an architecture, planning a migration or a refactor spanning many files, or anything needing several rounds of reading before the first edit. Triggers on "research", "investigate", "figure out", "look into", "plan", "design", "compare", "audit", "migrate", "why is", and on a ticket ID. Also use to resume such a task from an existing .deep-work/ workspace.
---

# Deep work workspace

Hard tasks produce findings and decisions that must outlive a context window. Park them in the project, not in the transcript.

## Location

The workspace belongs to the repo the task is about, not the repo Claude happens to be running in. Working from repo A on a task about repo B puts every note under B — `<repo-b>/.deep-work/<slug>/`, with B's own `.deep-work/.gitignore`. Notes about another repo never land in the current one.

Resolve that root before writing anything — `git -C <path inside the target repo> rev-parse --show-toplevel` — and prefix every note path with it. A task spanning two repos keeps its notes in the one being changed.

## Slug

The workspace is `.deep-work/<slug>/` at that repo's root. The slug is a path segment, so it is lowercase ASCII kebab-case: no spaces, no punctuation, no non-Latin characters, nothing that needs quoting in a shell.

Derive it from whatever names the task:

- A ticket keeps its ID as the prefix, followed by a few words of the title: `ab-1234-limit-validation`
- A non-English title is translated or transliterated down to those few words, never copied verbatim
- No ticket means just the summary: `token-refresh-race`, `bun-vs-node-runtime`

Five words is the ceiling. The original title, in its original language and full length, goes in the first note's heading — that is what the heading is for.

## Files

Any number of markdown notes, numbered in reading order:

```
.deep-work/
  .gitignore
  ab-1234-limit-validation/
    01-research.md
    02-plan.md
    03-edge-cases.md
```

The prefix is the order the notes were written, so sorting the directory replays the thread. Split a note once it covers more than one concern — a plan with an investigation buried inside it is two notes. Research plus plan is the common shape; pure research is one note; a task that turns a corner earns another.

## Procedure

1. Resolve the target repo root, then list its `.deep-work/` first. A matching directory means resume: read it, append the next numbered note, never open a parallel one.
2. Create `<target repo root>/.deep-work/<slug>/`, and `<target repo root>/.deep-work/.gitignore` holding a single `*` if it is not already there. The workspace ignores itself, so it never needs a line in the repo `.gitignore` and never gets committed.
3. Write research while investigating, not after. Every claim carries its evidence: `path/to/file.ts:42`, a command with its output, or a URL.
4. Turn research into a plan before touching code.
5. Tick each step's box as it lands. A stale plan is worse than no plan.
6. Name the workspace path in chat when creating it, and still answer in chat. The notes supplement the reply, they do not replace it.

## Research note

```markdown
# <original task title, verbatim>

## Question

What this is trying to settle, in a sentence or two.

## Findings

- Claim — evidence (`src/auth/session.ts:88`, command output, URL)

## Constraints

What any solution has to respect.

## Options

### A — <name>

Trade-offs.

### B — <name>

Trade-offs.

## Open questions

- Unresolved, and what would resolve it.
```

## Plan note

Steps are a checklist, never a table. One numbered top-level box per step, sub-steps nested under it — each one a single concrete action naming the file it touches.

````markdown
# <original task title, verbatim> — plan

<ticket URL, if there is one>

## Goal

What done looks like.

## Approach

Chosen option and why, in a few lines. Points back to the research note.

## Steps

- [ ] **1. <step>**
    - [ ] <action> — `src/auth/session.ts:88`
    - [ ] <action>
- [ ] **2. <step>**
    - [ ] <action>

## Verification

Commands to run, and what passing output looks like.

## Notes

Decisions made mid-flight, and what was rejected.
````

Sub-steps indent by four spaces. Tick a box the moment it lands; a step that gets dropped is struck through with the reason after it, not deleted.
