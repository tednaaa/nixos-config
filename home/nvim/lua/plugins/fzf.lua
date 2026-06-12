local fzf = require("fzf-lua")

fzf.setup({
	"default",
	fzf_bin = "fzf",
	winopts = {
		fullscreen = true,
		border = "none",
		preview = {
			default = "builtin",
			layout = "vertical",
			vertical = "down:70%",
			scrollbar = "float",
		},
	},
	fzf_opts = {
		["--info"] = "inline-right",
		["--layout"] = "reverse",
	},
	keymap = {
		builtin = {
			["<C-/>"] = "toggle-help",
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-f>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-q"] = "select-all+accept",
			["ctrl-a"] = "toggle-all",
			["ctrl-d"] = "preview-page-down",
			["ctrl-u"] = "preview-page-up",
		},
	},
	files = {
		fd_opts = "--color=never --type f --hidden --follow --exclude .git",
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
	},
	lsp = {
		jump1 = true,
		includeDeclaration = false,
		symbols = { symbol_style = 1 },
		code_actions = { previewer = "codeaction_native" },
	},
})

fzf.register_ui_select(function(_, items)
	local h = math.min(#items + 4, math.floor(vim.o.lines * 0.4))
	return { winopts = { height = h, width = 0.55, row = 0.4, relative = "editor" } }
end)

local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
end

map("<leader><leader>", fzf.files, "Files")
map("<leader>/", fzf.live_grep, "Live grep")
map("<leader>,", fzf.buffers, "Buffers")
map("<leader>ff", fzf.files, "Find files")
map("<leader>fg", fzf.live_grep, "Live grep")
map("<leader>fw", fzf.grep_cword, "Grep word")
map("<leader>fb", fzf.buffers, "Buffers")
map("<leader>fo", fzf.oldfiles, "Recent files")
map("<leader>fr", fzf.resume, "Resume picker")
map("<leader>fh", fzf.helptags, "Help tags")
map("<leader>fk", fzf.keymaps, "Keymaps")
map("<leader>f/", fzf.lgrep_curbuf, "Grep buffer")
map("<leader>fd", fzf.diagnostics_document, "Diagnostics (buffer)")
map("<leader>fD", fzf.diagnostics_workspace, "Diagnostics (workspace)")

vim.keymap.set("v", "<leader>fw", fzf.grep_visual, { desc = "Grep selection", silent = true })
