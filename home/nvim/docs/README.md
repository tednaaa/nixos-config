# Neovim — usage & keymaps

Leader = `Space`. Native LSP + `blink` completion + treesitter `main`. Config is a live symlink (edit → `:source %` or restart, no rebuild). Forgot a key? Press a prefix (`<space>`, `g`, `gh`) and **wait** → which-key shows the menu.

## Daily flow (the moves that matter)

- **Open** a file `<space><space>` · **search** the project `<space>/` · last picker `<space>fr`
- **Navigate code** `gd` def · `gr` refs · `K` docs · `<space>ca` action · `<space>cr` rename
- **Edit structurally** `cif` change-in-function · `daa` delete-arg · `sa"`/`sd"` add/del quotes · `gcc` comment
- **Files as text** `-` opens the dir as a buffer; rename/delete/move lines, then `:w` to apply (LSP fixes imports)
- **Git** `<space>gg` lazygit · stage hunk `ghs` · undo hunk `ghr` · diff `ghd`
- **Run tools** `<space>g` + `g`/`d`/`k`/`h`/`a` → lazygit / lazydocker / k9s / resto / cursor-agent (floating, same key toggles)

## Find — fzf-lua

| Key                | Action                        | Key                | Action              |
| ------------------ | ----------------------------- | ------------------ | ------------------- |
| `<space><space>`   | Files                         | `<space>fo`        | Recent files        |
| `<space>/`         | Live grep                     | `<space>fr`        | Resume picker       |
| `<space>,`         | Buffers                       | `<space>fh` / `fk` | Help / Keymaps      |
| `<space>fw`        | Grep word (n) / selection (v) | `<space>f/`        | Grep current buffer |
| `<space>fd` / `fD` | Diagnostics buf / workspace   |                    |                     |

## LSP — when a server attaches

| Key              | Action                    | Key              | Action                  |
| ---------------- | ------------------------- | ---------------- | ----------------------- |
| `gd` `gD`        | Definition / Declaration  | `<space>cr`      | Rename                  |
| `gr`             | References                | `<space>ca`      | Code action (n,v)       |
| `gy` `gI`        | Type def / Implementation | `<space>cs` `cS` | Symbols doc / workspace |
| `K`              | Hover docs                | `<space>cd`      | Line diagnostics        |
| `<C-s>` (insert) | Signature help            | `<space>ci`      | Toggle inlay hints      |
| `]d` `[d`        | Next / prev diagnostic    | `<space>cf`      | Format buffer           |

## Git — gitsigns + tools

| Key                   | Action                      | Key         | Action                        |
| --------------------- | --------------------------- | ----------- | ----------------------------- |
| `ghs`                 | Stage hunk (n,v)            | `]h` `[h`   | Next / prev hunk              |
| `ghr`                 | Reset hunk (n,v)            | `ghS` `ghR` | Stage / reset buffer          |
| `ghd`                 | Toggle inline diff          | `ghb` `ghB` | Blame line / toggle blame     |
| `ghp`                 | Preview hunk (popup)        | `ih`        | Hunk textobject (`vih`,`dih`) |
| `<space>gs` `gc` `gb` | Status / commits / branches | `<space>gr` | Restart LSP                   |

## Edit — mini + treesitter

| Key                                    | Action                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| `af`/`if` `ac`/`ic` `aa`/`ia`          | Textobject: function / class / argument (use with `c d v y`) |
| `a)` `a"` `at` …                       | mini.ai brackets / quotes / tags (`an`/`al` = next/last)     |
| `sa{motion}{c}` / `sd{c}` / `sr{c}{c}` | Surround add / delete / replace                              |
| `gcc` · `gc{motion}` · `gco`/`gcO`     | Comment line / motion / open below·above                     |
| `<M-j>`/`<M-k>` · `<M-h>`/`<M-l>`      | Move line·selection down·up / left·right                     |
| `]f`/`[f` `]c`/`[c`                    | Jump next/prev function / class                              |
| `<space>na`/`<space>pa`                | Swap argument with next / prev                               |
| `x` · `v_p`                            | Delete char (black-hole) · paste-over keeps register         |

## Buffers · windows · files

| Key              | Action                 | Key                                | Action                 |
| ---------------- | ---------------------- | ---------------------------------- | ---------------------- |
| `<S-h>` `<S-l>`  | Prev / next buffer     | `<C-h/j/k/l>`                      | Move between windows   |
| `<space>bd` `bo` | Close buffer / others  | `<space>v` `<space>s`              | Split right / down     |
| `-`              | Parent dir (oil)       | `<space>w` `v`/`s`/`w`/`q`/`o`/`=` | Window ops             |
| `<space>e`       | Floating file explorer | `<Esc>`                            | Clear search highlight |

Inside **oil**: `<CR>` open · `<C-s>` vsplit · `<C-p>` preview · `g.` toggle hidden · `g\` trash · `_` cwd.

## Format on save

`conform` runs black (.venv-first) / ruff / nixfmt / stylua / yamlfmt / shfmt. **JS/TS/Vue** use ESLint `--fix` (not prettier). Toggle: `:FormatDisable[!]` / `:FormatEnable` · manual `<space>cf`.

## Plugins — vim.pack (no plugin manager)

- **Update:** `:lua vim.pack.update()` → review buffer, `:w` confirms / `:q` discards
- **Add/remove:** edit the `vim.pack.add({…})` block in `init.lua`, restart (then `:lua vim.pack.del({'name'})` to prune)
- **Reproducible:** `nvim-pack-lock.json` pins every plugin — commit it; it's authoritative on fresh installs

## Layout

```
init.lua            leader · build hook · vim.pack.add · requires (lsp last)
lua/core/           options · keymaps · autocmds · diagnostics
lua/plugins/        colorscheme ui treesitter completion fzf files git conform editing
lua/lsp.lua         capabilities · vim.lsp.enable · LspAttach keymaps
lsp/<server>.lua    vtsls vue_ls basedpyright ruff nixd eslint lua_ls yamlls
```

LSP/formatter binaries come from Nix (`modules/dev.nix`) — those need `nixos-rebuild switch`; everything else is live Lua.
