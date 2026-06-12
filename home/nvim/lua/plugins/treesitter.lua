require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

local ensure = {
	"python",
	"typescript",
	"tsx",
	"javascript",
	"vue",
	"css",
	"nix",
	"lua",
	"luadoc",
	"yaml",
	"bash",
	"markdown",
	"markdown_inline",
	"json",
	"toml",
	"dockerfile",
	"sql",
	"fish",
	"query",
	"vim",
	"vimdoc",
	"diff",
	"gitcommit",
	"regex",
}
local installed = require("nvim-treesitter.config").get_installed("parsers")
local missing = vim
	.iter(ensure)
	:filter(function(p)
		return not vim.tbl_contains(installed, p)
	end)
	:totable()
if #missing > 0 then
	require("nvim-treesitter").install(missing)
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user.treesitter", { clear = true }),
	pattern = {
		"python",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"vue",
		"css",
		"nix",
		"lua",
		"yaml",
		"bash",
		"sh",
		"fish",
		"markdown",
		"json",
		"jsonc",
		"toml",
		"dockerfile",
		"sql",
		"gitcommit",
	},
	callback = function(ev)
		pcall(vim.treesitter.start)
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		if ev.match ~= "python" then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = { ["@function.outer"] = "V", ["@parameter.outer"] = "v" },
		include_surrounding_whitespace = false,
	},
	move = { set_jumps = true },
})

local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")
local ts = vim.keymap.set

ts({ "n", "x", "o" }, "]f", function()
	move.goto_next_start("@function.outer", "textobjects")
end)
ts({ "n", "x", "o" }, "[f", function()
	move.goto_previous_start("@function.outer", "textobjects")
end)
ts({ "n", "x", "o" }, "]c", function()
	move.goto_next_start("@class.outer", "textobjects")
end)
ts({ "n", "x", "o" }, "[c", function()
	move.goto_previous_start("@class.outer", "textobjects")
end)

ts("n", "<leader>na", function()
	swap.swap_next("@parameter.inner")
end, { desc = "Swap param next" })
ts("n", "<leader>pa", function()
	swap.swap_previous("@parameter.inner")
end, { desc = "Swap param prev" })
