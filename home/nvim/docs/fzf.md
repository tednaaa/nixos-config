# fzf-lua

## Pickers

| Key                     | Picker                        |
| ----------------------- | ----------------------------- |
| `<space><space>`        | Files                         |
| `<space>/` `<space>fg`  | Live grep (project)           |
| `<space>,` `<space>fb`  | Buffers                       |
| `<space>fw`             | Grep word (n) / selection (v) |
| `<space>fd` `<space>fD` | Diagnostics buf / workspace   |
| `<space>fo`             | Recent files                  |
| `<space>fr`             | Resume last picker            |
| `<space>fh` `<space>fk` | Help / Keymaps                |
| `<space>f/`             | Grep current buffer           |

## Inside a picker

| Key                     | Action                       |
| ----------------------- | ---------------------------- |
| `<CR>`                  | Open                         |
| `<Tab>` `<S-Tab>`       | Mark / unmark (multi-select) |
| `<C-f>`                 | Toggle preview               |
| `<C-d>` `<C-u>`         | Scroll preview               |
| `<C-n>` `<C-p>`         | Next / prev item             |
| `<C-s>` `<C-v>` `<C-t>` | Open in split / vsplit / tab |
| `<C-q>`                 | Send all results → quickfix  |
| `<C-a>`                 | Toggle-all selection         |
| `<C-/>`                 | Toggle help                  |
| `<Esc>` `<C-c>`         | Close                        |
