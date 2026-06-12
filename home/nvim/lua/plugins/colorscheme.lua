require("kanagawa").setup({
	compile = false,
	undercurl = true,
	commentStyle = {},
	keywordStyle = {},
	statementStyle = {},
	functionStyle = {},
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	theme = "wave",
	background = { dark = "wave", light = "lotus" },
})
vim.cmd.colorscheme("kanagawa-wave")
