- Load the `deep-work` skill only when the user explicitly asks to create a persistent plan for a specific task, or to resume an existing deep-work plan. Do not load it for ordinary research, investigations, multi-step implementation, ticket IDs, questions about the skill, or plan mode alone.

- NEVER run tests, builds, linters, formatters or type-checkers after making changes. Verification is owned by git hooks and CI, not by you.
- Run them only when I explicitly ask, or when the task itself is fixing a failing test/build — then run the narrowest target (single test, single package), never the whole suite.
- If a commit is rejected by a hook, read its output and fix the cause; never bypass with `--no-verify`.
- If the project has no lefthook config (`lefthook.yaml` or another supported name), still don't run checks — say once that the project has no git hooks and suggest setting up lefthook.
- If the project uses husky or lint-staged, say once that it should migrate to lefthook. Don't migrate unless I ask.
