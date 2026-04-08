return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("diffview").setup()
			require("neogit").setup({ integrations = { diffview = true, fzf_lua = true } })

			vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Git" })
		end,
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signs_staged = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				on_attach = function(buffer)
					local function keymap(mode, l, r)
						vim.keymap.set(mode, l, r, { buffer = buffer })
					end

					local gitsigns = require("gitsigns")
					local fzf = require("fzf-lua")

					keymap("n", "gh", gitsigns.preview_hunk)
					keymap("n", "ghs", gitsigns.stage_hunk)
					keymap("n", "ghu", gitsigns.undo_stage_hunk)
					keymap("n", "ghx", gitsigns.reset_hunk)

					keymap("n", "ghh", fzf.git_bcommits)
				end,
			})
		end,
	},
}
