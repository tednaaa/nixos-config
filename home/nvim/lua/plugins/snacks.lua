require("snacks").setup({
	statuscolumn = {
		enabled = true,
		left = { "sign", "mark" },
		right = { "fold", "git" },
		folds = { open = true, git_hl = true },
		git = { patterns = { "GitSign" } },
		refresh = 50,
	},
})
