return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	root_markers = {
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"eslint.config.ts",
		"eslint.config.mts",
		"eslint.config.cts",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc",
		"package.json",
		".git",
	},
	settings = {
		validate = "on",
		nodePath = "",
		rulesCustomizations = {},
		onIgnoredFiles = "off",
		quiet = false,
		run = "onType",
		problems = { shortenToSingleLine = false },
		useESLintClass = false,
		experimental = {},
		-- We format via conform, not the eslint LSP. `format = false` keeps the
		-- server from offering itself as a formatter.
		format = false,
		codeAction = {
			disableRuleComment = { enable = true, location = "separateLine" },
			showDocumentation = { enable = true },
		},
		codeActionOnSave = { enable = false, mode = "all" },
		workingDirectory = { mode = "auto" },
	},
	before_init = function(_, config)
		local root_dir = config.root_dir
		if not root_dir then
			return
		end
		config.settings = config.settings or {}
		-- workspaceFolder bounds how far the server walks the tree looking for a
		-- config. Must be a file:// URI, matching Neovim's auto workspace_folders.
		config.settings.workspaceFolder = {
			uri = vim.uri_from_fname(root_dir),
			name = vim.fn.fnamemodify(root_dir, ":t"),
		}
		-- Opt into flat config when a flat config file is present.
		for _, file in ipairs({
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts",
		}) do
			if vim.uv.fs_stat(root_dir .. "/" .. file) then
				config.settings.experimental = config.settings.experimental or {}
				config.settings.experimental.useFlatConfig = true
				break
			end
		end
	end,
}
