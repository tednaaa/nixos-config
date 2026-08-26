- NEVER write comments, if code is not readable enough that needs to be explained - it's wrong, refactor code to make it more readable

- suggest commits using conventional commits, and just print commit name, nothing else
- NEVER write co-authored by claude in commit messages if you write commit messages yourself

- for research, investigation, or any multi-step task, use the `deep-work` skill — notes go in `.deep-work/<slug>/`, never in the transcript alone

- ALWAYS reference code as a repo-relative path plus exactly ONE line number — `src/api/handlers/session.ts:142` — never a range like `:142-160`, never an absolute path, never a bare filename, never a `./` prefix, never "line 142" in prose. Point at the single most relevant line: the definition, the condition, the call itself. Same form in chat and in markdown notes, so `gf` opens it.
