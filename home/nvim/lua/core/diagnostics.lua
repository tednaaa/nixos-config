vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	underline = true,
	virtual_text = false,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
	float = { border = "rounded", source = "if_many" },
})
