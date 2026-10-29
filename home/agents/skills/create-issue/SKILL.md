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

## Language

- English, unless the user names another

## Title

- imperative, no trailing period: `Add CSV export to reports`
- the change, not the symptom
- no ticket prefixes, tags or emoji
- given by the user → use verbatim

## Body

```markdown
## Context
Why this is needed, 1–3 lines.

## Goal
What is true when it is done.

## Acceptance
- [ ] observable criterion
- [ ] observable criterion

## Notes
Links, `path/to/file.ts:42`, open questions.
```

- omit `## Notes` when empty
- given by the user → use verbatim, fill only the sections they left out

## Fields

- labels, assignee, milestone, priority — only when the user gives them
- a field the tracker requires and the user did not give → ask

## Reply

- the issue URL, one per line when several were created
