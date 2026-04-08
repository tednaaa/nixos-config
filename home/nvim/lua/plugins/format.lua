return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd", "eslint_d" },
				typescriptreact = { "prettierd", "eslint_d" },
				javascript = { "prettierd", "eslint_d" },
				javascriptreact = { "prettierd", "eslint_d" },
				vue = { "prettierd", "eslint_d" },
				astro = { "prettierd", "eslint_d" },
				json = { "prettierd" },
				markdown = { "prettierd" },
				go = { "gofumpt", "golines" },
			},
			format_on_save = function(bufnr)
				-- to disable for current buffer
				-- lua vim.b.disable_autoformat = true
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})
	end,
}
