return {
	{
		"Shatur/neovim-ayu",
		priority = 1000,
		config = function()
			require("ayu").setup({ mirage = false, terminal = true })
			require("ayu").colorscheme()
		end,
	},

	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	priority = 1000,
	-- 	config = function() vim.cmd("colorscheme onedark") end,
	-- },

	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	init = function() vim.cmd("colorscheme catppuccin-mocha") end,
	-- },

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = function()
	-- 		return {
	-- 			style = "moon",
	-- 			transparent = true,
	-- 			styles = { sidebars = "transparent", floats = "transparent" },
	-- 		}
	-- 	end,
	-- 	init = function() vim.cmd("colorscheme tokyonight") end,
	-- },

	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("github-theme").setup({ options = { transparent = true } })
	-- 		vim.cmd("colorscheme github_dark_dimmed")
	-- 	end,
	-- },

	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	config = function()
	-- 		require("vscode").setup()
	-- 		vim.cmd("colorscheme vscode")
	-- 	end,
	-- },
}
