vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.expandtab = false
vim.opt.scrolloff = 10

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.inccommand = "split"

vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.timeoutlen = 200
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

vim.opt.list = true
vim.opt.listchars = { tab = "▸\\ ", trail = "·", extends = ">", precedes = "<", nbsp = "·" }

vim.opt.fillchars:append({ vert = "▎", horiz = "▁" })

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.formatoptions:append({ "r" })
