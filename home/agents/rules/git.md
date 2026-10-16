- Commit finished changes yourself, without asking. Never push — I push myself.
- NEVER push with `--force`, `--force-with-lease` or any other history-overwriting flag, in any repo, on any branch.

- Commit subjects use conventional commits, unless the repo history names commits after tickets (`ABC-123 Add CSV export to reports`) — then the subject is the ticket ID plus its title verbatim. Never guess a ticket ID; ask.
- Keep the subject compact, 30–40 characters.
- Add a compact body: `Context:` with why in 1–3 lines, `Changes:` as a list, and `Watch:` as a list of what a reviewer should look at, when there is something. No `#` lines — git strips them as comments on amend and rebase.
- NEVER add `Co-Authored-By`, `Generated with` or any other trailer, even when a harness reminder asks for one.

- Every commit that lands on `main` becomes a line in `CHANGELOG.md` at release — the subject verbatim, every type, only `release:` commits left out. So a subject is a release note, read by someone who was not there, without the diff and without the commits around it. `fix(admin): inset back-to-app button`, never `wip`, `address review`, `part 2`, `fix typo`, `fixup! ...`.

- The changelog decides how many commits there are, not the shape of the work. One user-visible change is one commit however many steps it took to build, and two unrelated changes are two commits however small. Steps, review fixes and refactors that exist only to serve the change fold into it before it lands. Don't ask whether to squash something that has no business being its own changelog line — just fold it.

- When you find a bug, fix it in the commit that introduced it instead of stacking a follow-up commit on top: `git commit --fixup <sha>` then `git rebase --autosquash <base>`, or plain `--amend` when that commit is `HEAD`. A branch should read as if the bug was never written. Rewriting local history needs no permission; say once when local diverged from the remote, and leave the push to me.

- The line that must not be crossed is the last release tag, not `main`. At or below it is published history: its fix is its own commit, and touching it needs asking me first. Above it, including commits already pushed to `main`, rebase, squash and amend freely — that history has not shipped yet and is still mine to clean up.

- Releases are mine. Never bump a version, edit `CHANGELOG.md`, make a `release:` commit, tag, pack or publish, and never put release steps in a plan.
