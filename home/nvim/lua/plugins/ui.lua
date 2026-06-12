require("mini.icons").setup({ style = "glyph" })
MiniIcons.mock_nvim_web_devicons()

local function statusline()
	local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
	local diff = MiniStatusline.section_diff({ trunc_width = 75 })
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
	local filename = MiniStatusline.section_filename({ trunc_width = 140 })
	local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
	local location = MiniStatusline.section_location({ trunc_width = 75 })
	local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
	local branch = vim.b.gitsigns_head and ("  " .. vim.b.gitsigns_head) or ""

	return MiniStatusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { branch, diff, diagnostics, lsp } },
		"%<",
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=",
		{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		{ hl = mode_hl, strings = { search, location } },
	})
end

require("mini.statusline").setup({
	use_icons = true,
	content = { active = statusline },
})
vim.o.laststatus = 3

local wk = require("which-key")
wk.setup({
	preset = "helix",
	delay = function(ctx)
		return ctx.plugin and 0 or 250
	end,
	icons = { mappings = true, colors = true },
	win = { wo = { winblend = 8 } },
})
wk.add({
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "terminal apps" },
	{ "<leader>c", group = "code / lsp" },
	{ "<leader>b", group = "buffer" },
	{ "<leader>w", group = "window" },
	{ "gh", group = "git hunk" },
})
vim.keymap.set("n", "<leader>?", function()
	wk.show({ global = false })
end, { desc = "Buffer-local keymaps" })
