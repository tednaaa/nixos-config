return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = { { "<leader>e", "<cmd>Neotree toggle<cr>" } },
	config = function()
		require("neo-tree").setup({
			window = { width = 50 },

			source_selector = {
				winbar = false,
				show_scrolled_off_parent_node = false,
			},

			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
					never_show = { ".DS_Store" },
				},
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "󰚃",
						renamed = "󰛿",
						untracked = "○",
						ignored = "◌",
						unstaged = "○",
						staged = "●",
						conflict = "◎",
					},
				},
			},
		})

		vim.cmd([[
			highlight NeoTreeGitConflict gui=bold
			highlight NeoTreeGitUntracked gui=none
			highlight NeoTreeRootName gui=bold
		]])
		vim.cmd("Neotree show")
	end,
}
