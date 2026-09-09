- NEVER write comments, if code is not readable enough that needs to be explained - it's wrong, refactor code to make it more readable

- suggest commits using conventional commits, and just print commit name, nothing else
- NEVER write co-authored by claude in commit messages if you write commit messages yourself
- When you find a bug, fix it in the commit that introduced it instead of stacking a follow-up commit on top: `git commit --fixup <sha>` then `git rebase --autosquash <base>`, or plain `--amend` when that commit is `HEAD`. A branch should read as if the bug was never written. Rewriting my own feature branch needs no permission — `git push --force-with-lease` and move on. Two things are off limits: a commit already released or merged belongs to everyone now, so its fix is its own commit; and a default branch — `main` and the like — is never rewritten without asking me first.

- for research, investigation, or any multi-step task, use the `deep-work` skill — notes go in `.deep-work/<slug>/`, never in the transcript alone

- NEVER write a markdown table — not in a note, not in chat, not in a commit message. They are unreadable in a plain editor and wrap to mush in a terminal. A row is a list line: `- key — the rest of the row`. A row needing more than one clause becomes `#### key` with a bullet per clause. Two things compared side by side are two labelled lists, not two columns. A table whose top-left header cell is empty is the worst shape of all — that is a list someone turned sideways.

- ALWAYS reference code as a repo-relative path plus exactly ONE line number — `src/api/handlers/session.ts:142` — never a range like `:142-160`, never an absolute path, never a bare filename, never a `./` prefix, never "line 142" in prose. Point at the single most relevant line: the definition, the condition, the call itself. Same form in chat and in markdown notes, so `gf` opens it.
