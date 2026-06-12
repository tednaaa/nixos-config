local conform = require("conform")

local eslint_fts = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	vue = true,
}

conform.setup({
	formatters_by_ft = {
		python = { "ruff_organize_imports", "ruff_fix", "black" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		yaml = { "yamlfmt" },
		json = { "jq" },
		jsonc = { "jq" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		fish = { "fish_indent" },
		markdown = { "prettier" },
	},
	default_format_opts = { lsp_format = "never" },
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		if eslint_fts[vim.bo[bufnr].filetype] then
			return
		end
		return { timeout_ms = 2000, lsp_format = "never" }
	end,
	formatters = {
		black = {
			command = function(_, ctx)
				local root = vim.fs.root(ctx.dirname, { "pyproject.toml", ".git" })
				local venv = root and (root .. "/.venv/bin/black")
				if venv and vim.fn.executable(venv) == 1 then
					return venv
				end
				return "black"
			end,
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user.eslint_fix", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or client.name ~= "eslint" then
			return
		end
		local bufnr = args.buf
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			group = vim.api.nvim_create_augroup("user.eslint_fix_" .. bufnr, { clear = true }),
			callback = function()
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				client:request_sync("workspace/executeCommand", {
					command = "eslint.applyAllFixes",
					arguments = {
						{
							uri = vim.uri_from_bufnr(bufnr),
							version = vim.lsp.util.buf_versions[bufnr],
						},
					},
				}, 2000, bufnr)
			end,
		})
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(a)
	if a.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, { bang = true, desc = "Disable autoformat-on-save" })
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
	conform.format({ async = true, lsp_format = "never" })
end, { desc = "Format buffer" })
