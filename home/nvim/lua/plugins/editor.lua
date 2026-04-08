return {
	{ "Chaitanyabsprip/fastaction.nvim", opts = {} },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = { opts = { size = { width = 80, height = 10 } } },
				},
				presets = { command_palette = true, lsp_doc_border = true },
				-- disable print and write notifications
				routes = { { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } } },
			})
		end,
	},

	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		config = function()
			require("quicker").setup()

			-- stylua: ignore start
			vim.keymap.set("n", "<leader>q", function() require("quicker").toggle() end, { desc = "Toggle quickfix", })
			vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist", })
			-- stylua: ignore end
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Global Diagnostics" },
			{ "<leader>bx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			local grug_far = require("grug-far")
			grug_far.setup()

			vim.keymap.set("n", "<leader>g;", grug_far.open, { desc = "Global find and replace" })
		end,
	},
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = "m",
			buffer_leader_key = "M",
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		config = function()
			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					diagnostics = "nvim_lsp",
					show_close_icon = false,
					show_buffer_close_icons = false,
				},
			})

			-- stylua: ignore start
			vim.keymap.set("n", "<leader>Q", bufferline.close_others)
			vim.keymap.set("n", "L", function() bufferline.cycle(1) end)
			vim.keymap.set("n", "H", function() bufferline.cycle(-1) end)
			-- stylua: ignore end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
