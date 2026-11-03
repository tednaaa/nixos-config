---
name: create-issue
description: Use when the user asks to create an issue, task or ticket in a tracker — GitLab, GitHub, YouTrack. Defines the title and body format and how to pick the tracker. Do not load for local TODOs or task plans.
---

# Create issue

## Pick the tracker

Never infer the tracker from the repo or its remote. The user names it.

- a tool named (`glab`, `gh`, an MCP server) → that tool
- only a tracker named (GitLab, GitHub, YouTrack, …) → its MCP or CLI, whichever is available
- nothing named → ask where to create it
- tool missing or not authenticated → stop and say which

## Pick the project

- named by the user → that project
- `glab` or `gh` → the current repo's remote
- otherwise → ask

## Title

- imperative, no trailing period: `Add CSV export to reports`
- the change, not the symptom
- no ticket prefixes, tags or emoji
- given by the user → use verbatim

## Body

```markdown
## Context
Why this is needed.

## Goal
What is true when it is done.

## Acceptance
- [ ] checkable criterion
- [ ] checkable criterion

## Notes
- constraint, decision or open question
```

Two layers, both short and without filler.

### Top: Context and Goal

- for anyone, support and managers included: plain words, no identifiers
- 1–3 sentences each; the reader knows why and what changes without reading further

### Bottom: Acceptance and Notes

- for the developer: technical facts allowed, each in as few words as it takes
- one fact per line, no connecting prose
- `###` groups by owner — repo, host, service — instead of repeating it in every line
- steps shared by all items go once above them; an item carries only what differs
- one item per finding: what and where → what to do with it
- a file by its name, not its full path
- `## Acceptance` — as many criteria as matter, each checkable: a command, a query, a state
- `## Notes` — omit when empty

### Never cut

- findings of work already done: what was found, where, the date of a snapshot
- traps and non-obvious facts: what breaks, what only works one way
- dependencies on other issues, and what need not wait for them
- out of scope, and what comes after the task

### Always cut

- explanations of general knowledge
- a fact repeated in another section
- a file or a count quoted only as an example of the problem
- the reason behind an obvious step, unless without it the step looks wrong

### Also

- section headings follow the issue's language
- given by the user → use verbatim, fill only the sections they left out

## Epics

- the description never lists the children: the tracker shows them
- the epic keeps what spans the children: principles, deferred work, approach options
- a fact a child needs to get done stays in that child

## Images

Every image in an issue or comment is 300px wide.

- GitLab, YouTrack → `![alt](<url>){width=300}`
- GitHub → `<img src="<url>" alt="alt" width="300">`

## Fields

- labels, assignee, milestone, priority — only when the user gives them
- a field the tracker requires and the user did not give → ask

## Reply

- the issue URL, one per line when several were created
