local o = vim.opt

o.number = true
o.relativenumber = true
o.scrolloff = 10
o.sidescrolloff = 8
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false

o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"
o.grepprg = "rg --vimgrep --smart-case"
o.grepformat = "%f:%l:%c:%m"

o.expandtab = false
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.smartindent = true
o.list = true
o.listchars = { tab = "│ ", trail = "·", nbsp = "␣", lead = "·" }

o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldtext = ""

o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 300
o.mouse = "a"
o.confirm = true
o.termguicolors = true
o.winborder = "rounded"
o.pumheight = 12
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

o.completeopt = "menu,menuone,noselect"
o.shortmess:append("c")

vim.g.netrw_banner = 0
