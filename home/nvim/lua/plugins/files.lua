require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "qf", "fzf" },
	default_component_configs = {
		indent = { with_markers = true, indent_marker = "│", last_indent_marker = "└" },
		git_status = {
			symbols = {
				added = "",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 32,
		mappings = {
			["<space>"] = "none",
			["P"] = { "toggle_preview", config = { use_float = true } },
			["o"] = "open",
			["h"] = "close_node",
			["l"] = "open",
		},
	},
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
		hijack_netrw_behavior = "open_current",
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Reveal file in tree" })

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("user.neotree_open", { clear = true }),
	callback = function()
		local first = vim.fn.argv(0)
		if type(first) == "string" and vim.fn.isdirectory(first) == 1 then
			return
		end
		vim.cmd("Neotree show")
	end,
})
