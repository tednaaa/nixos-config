vim.filetype.add({ extension = { ["http"] = "http" } })

return {
	"mistweaverco/kulala.nvim",
	config = function()
		local kulala = require("kulala")
		kulala.setup()

		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<A-,>", kulala.jump_prev, opts)
		vim.keymap.set("n", "<A-.>>", kulala.jump_next, opts)
		vim.keymap.set("n", "<A-m>", kulala.run, opts)
	end,
}
