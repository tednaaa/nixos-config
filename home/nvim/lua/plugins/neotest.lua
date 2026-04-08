---@diagnostic disable: missing-fields

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- adapters
		"marilari88/neotest-vitest",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("rustaceanvim.neotest"),
				require("neotest-vitest")({
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules"
					end,
				}),
			},
		})

		-- stylua: ignore start
		vim.keymap.set("n", "<leader>nt", function() neotest.run.run() end)
		vim.keymap.set("n", "<leader>nf", function() neotest.run.run(vim.fn.expand("%")) end)
		vim.keymap.set("n", "<leader>no", function () neotest.output.open({ enter = true }) end)
		vim.keymap.set("n", "<leader>ns", function () neotest.summary.toggle() end)
		-- stylua: ignore end
	end,
}
