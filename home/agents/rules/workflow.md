- Load the `deep-work` skill only when I type `/deep-work`, or ask to resume an existing deep-work plan. Do not load it for ordinary research, investigations, brainstorming in chat, multi-step implementation, ticket IDs, questions about the skill, or plan mode alone.

- When I say "brainstorm", NEVER write or edit code. Discuss options with their tradeoffs and change only the plan.

- Change only what was asked. Leave adjacent working config where it lives, even when an upstream convention puts it elsewhere; if moving it looks better, say so in one line.
- Never remove infrastructure, services or files outside the task on your own judgement — ask first.

- Pick the package manager from the lockfile: `pnpm-lock.yaml` → `pnpm` and `pnpm dlx`, never `npm` or `npx`; same for yarn, bun, cargo, uv.
- Install a new dependency only after the design that needs it is agreed.

- In skills, rules and shared docs, never name specific projects, repos or clients. Write examples generically: "the project", `src/config/envs.ts`.

- NEVER run tests, builds, linters, formatters or type-checkers after making changes. Verification is owned by git hooks and CI, not by you.
- Run them only when I explicitly ask, or when the task itself is fixing a failing test/build — then run the narrowest target (single test, single package), never the whole suite.
- If a commit is rejected by a hook, read its output and fix the cause; never bypass with `--no-verify`.
- If the project has no lefthook config (`lefthook.yaml` or another supported name), still don't run checks — say once that the project has no git hooks and suggest setting up lefthook.
- When setting up lefthook, use only `pre-commit`: the project's linter and type-checker, plus only the tests affected by staged files (the test runner's related/changed mode), never the full suite. Don't add a conventional commits check.
- If the project uses husky or lint-staged, say once that it should migrate to lefthook. Don't migrate unless I ask.
