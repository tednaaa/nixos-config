vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user.pack.build", { clear = true }),
  callback = function(ev)
    local d = ev.data
    if d.spec and d.spec.name == "nvim-treesitter" and (d.kind == "install" or d.kind == "update") then
      if not d.active then pcall(vim.cmd.packadd, "nvim-treesitter") end
      pcall(vim.cmd, "TSUpdate")
    end
  end,
})

local function gh(repo)
  return "https://github.com/" .. repo
end
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("ibhagwan/fzf-lua"),
  gh("nvim-lua/plenary.nvim"),
  gh("MunifTanjim/nui.nvim"),
  { src = gh("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },
  gh("lewis6991/gitsigns.nvim"),
  gh("stevearc/conform.nvim"),
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },
  gh("folke/which-key.nvim"),
  gh("folke/snacks.nvim"),
  gh("rebelot/kanagawa.nvim"),
})

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")
require("core.terminal")

require("plugins.snacks")
require("plugins.colorscheme")
require("plugins.ui")
require("plugins.treesitter")
require("plugins.completion")
require("plugins.fzf")
require("plugins.files")
require("plugins.git")
require("plugins.conform")
require("plugins.editing")

require("lsp")
