local ai = require("mini.ai")

ai.setup({
	n_lines = 500,
	custom_textobjects = {
		f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
		a = ai.gen_spec.argument({ separator = "[,;]" }),
	},
})

require("mini.surround").setup({ n_lines = 200 })

require("mini.pairs").setup({
	modes = { insert = true, command = false, terminal = false },
	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	skip_ts = { "string" },
	skip_unbalanced = true,
	markdown = true,
})

require("mini.move").setup({
	mappings = {
		left = "<M-h>",
		right = "<M-l>",
		down = "<M-j>",
		up = "<M-k>",
		line_left = "<M-h>",
		line_right = "<M-l>",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},
})

vim.keymap.set("n", "gco", "o<esc>Vcx<esc>gcc", { remap = true, desc = "Comment line below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc>gcc", { remap = true, desc = "Comment line above" })
