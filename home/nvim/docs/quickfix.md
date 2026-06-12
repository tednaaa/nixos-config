# Quickfix

One shared list of `file:line` locations you step through with a single keymap. Fill it from a search/LSP/diagnostics, walk the results, optionally **edit them all at once**.

## Fill it

| Source                      | How                                                                                   |
| --------------------------- | ------------------------------------------------------------------------------------- |
| fzf picker results          | `<C-q>` (or `<Tab>`-mark several, then `<CR>`) — works in files, grep, LSP refs, etc. |
| Project search              | `<space>/` live grep → `<C-q>`                                                        |
| Diagnostics (whole project) | `:lua vim.diagnostic.setqflist()`                                                     |
| Built-in grep               | `:grep foo` / `:vimgrep /foo/ **/*.ts`                                                |
| Command / build output      | `:cexpr system("rg --vimgrep TODO")` · `:make`                                        |

## Navigate

| Key / cmd           | Action                                    |
| ------------------- | ----------------------------------------- |
| `]q` `[q`           | Next / prev item (jumps to it)            |
| `:copen` `:cclose`  | Open / close the quickfix window          |
| `:cfirst` `:clast`  | First / last item                         |
| `:cc N`             | Jump to item N                            |
| `:colder` `:cnewer` | Cycle to a previous / newer quickfix list |

In the quickfix window: `<CR>` jump to item · `q` close · `<C-w><CR>` open in a split.

## Bulk edit across files (the killer feature)

1. Fill the list (e.g. `<space>/` → `<C-q>`, or `:grep TODO`).
2. Run one command on every entry, then save:

| Command                        | Scope                                           |
| ------------------------------ | ----------------------------------------------- |
| `:cdo s/old/new/g \| update`   | once per matching **line**                      |
| `:cfdo %s/old/new/g \| update` | once per **file** (faster for whole-file edits) |

Rename a symbol everywhere it was found:

```vim
:grep -w oldName
:cfdo %s/\<oldName\>/newName/g | update
```

(LSP rename `<space>cr` is better for real symbols — quickfix bulk-edit shines for plain-text / cross-language changes.)

## Location list

Same thing but **scoped to one window** — `:lopen`, `:lnext` / `:lprev`, `:ldo`.
Use it when you want a second, window-local list alongside the shared quickfix.
