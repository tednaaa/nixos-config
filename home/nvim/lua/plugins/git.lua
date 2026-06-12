require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signs_staged_enable = true,
	current_line_blame = false,
	current_line_blame_opts = { virt_text_pos = "eol", delay = 400 },
	current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",
	preview_config = { border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1 },
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next hunk")
		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev hunk")

		map("n", "ghs", gs.stage_hunk, "Stage hunk")
		map("v", "ghs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selection")
		map("n", "ghr", gs.reset_hunk, "Reset hunk")
		map("v", "ghr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selection")
		map("n", "ghd", gs.preview_hunk, "Preview hunk hunk")
		map("n", "ghS", gs.stage_buffer, "Stage buffer")
		map("n", "ghR", gs.reset_buffer, "Reset buffer")
		map("n", "ghb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
		map("n", "ghB", gs.toggle_current_line_blame, "Toggle line blame")
		map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
	end,
})
