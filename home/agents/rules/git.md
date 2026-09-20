- suggest commits using conventional commits, and just print commit name, nothing else
- NEVER write co-authored by claude in commit messages if you write commit messages yourself

- Every commit that lands on `main` becomes a line in `CHANGELOG.md` at release — the subject verbatim, every type, only `release:` commits left out. So a subject is a release note, read by someone who was not there, without the diff and without the commits around it. `fix(admin): inset sidebar back-to-app button to match menu items`, never `wip`, `address review`, `part 2`, `fix typo`, `fixup! ...`.

- The changelog decides how many commits there are, not the shape of the work. One user-visible change is one commit however many steps it took to build, and two unrelated changes are two commits however small. Steps, review fixes and refactors that exist only to serve the change fold into it before it lands. Don't ask whether to squash something that has no business being its own changelog line — just fold it.

- When you find a bug, fix it in the commit that introduced it instead of stacking a follow-up commit on top: `git commit --fixup <sha>` then `git rebase --autosquash <base>`, or plain `--amend` when that commit is `HEAD`. A branch should read as if the bug was never written. Rewriting my own feature branch needs no permission — `git push --force-with-lease` and move on.

- The line that must not be crossed is the last release tag, not `main`. At or below it is published history: its fix is its own commit, and touching it needs asking me first. Above it, including commits already pushed to `main`, rebase, squash and amend freely — that history has not shipped yet and is still mine to clean up.
