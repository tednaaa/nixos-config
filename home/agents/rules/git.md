- suggest commits using conventional commits, and just print commit name, nothing else
- NEVER write co-authored by claude in commit messages if you write commit messages yourself

- When you find a bug, fix it in the commit that introduced it instead of stacking a follow-up commit on top: `git commit --fixup <sha>` then `git rebase --autosquash <base>`, or plain `--amend` when that commit is `HEAD`. A branch should read as if the bug was never written. Rewriting my own feature branch needs no permission — `git push --force-with-lease` and move on. Two things are off limits: a commit already released or merged belongs to everyone now, so its fix is its own commit; and a default branch — `main` and the like — is never rewritten without asking me first.
