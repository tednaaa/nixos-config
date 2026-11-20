---
name: delegate
description: Use ONLY when the user types /delegate. Hands the task in the arguments to one or more background agents, then relays their results. Applies to that one prompt; there is no session mode.
disable-model-invocation: true
argument-hint: <task>
---

# Delegate

The task in the arguments goes to agents; the main conversation scouts, briefs, checks and relays. Only this prompt is delegated; the next one is handled as usual.

## Scout

- Read just enough to brief: target files and lines, decisions made in the conversation, what was ruled out.
- Never start the work inline.
- The task is unclear or hinges on a decision that is the user's → ask before spawning.

## Split

- One agent by default.
- Several only for parts that share no files and do not depend on each other, such as backend and frontend of one feature; spawn them in one message.
- Dependent parts → one agent, or agents one after another.
- Parallel agents in the same repo → `isolation: "worktree"` for each, a shared index mixes their commits; once they finish, cherry-pick their commits onto the current branch in order.

## Brief

The brief is the agent's only context about the task.

- Goal, files as `path:line`, decisions already made, what was ruled out, what stays untouched.
- The agent already loads the user's rules; name a rule only when the task hinges on it.
- Commit when finished, never push.
- A plan exists in `.ai/` → point to its step in `impl.md` instead of retelling it; the agent ticks the boxes it completes.
- Final report: commit sha, what landed, what was skipped and why, hook failures.

## Run

- Say in one line which agent got what, then stop; never poll or redo their work.
- A user question while agents run → they are still running, no guessed results.

## Relay

- Check each reported commit with `git show --stat` before relaying.
- 3–5 lines in the user's language: commit, what landed, what was skipped, anything to look at.
- An agent stopped short or failed → say so and offer to continue it through `SendMessage`, not a new agent.
