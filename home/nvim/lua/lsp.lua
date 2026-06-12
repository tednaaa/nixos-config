local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

vim.lsp.enable({
	"basedpyright",
	"ruff",
	"vtsls",
	"vue_ls",
	"nixd",
	"eslint",
	"lua_ls",
	"yamlls",
})

local fzf = require("fzf-lua")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user.lsp.attach", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		local buf = ev.buf
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
		end

		map("n", "gd", fzf.lsp_definitions, "Definitions")
		map("n", "gD", vim.lsp.buf.declaration, "Declaration")
		map("n", "gr", fzf.lsp_references, "References")
		map("n", "gy", fzf.lsp_typedefs, "Type definitions")
		map("n", "gI", fzf.lsp_implementations, "Implementations")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
		map({ "n", "x" }, "<leader>ca", fzf.lsp_code_actions, "Code action")
		map("n", "<leader>cs", fzf.lsp_document_symbols, "Document symbols")
		map("n", "<leader>cS", fzf.lsp_live_workspace_symbols, "Workspace symbols")
		map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")

		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(false, { bufnr = buf })

			map("n", "<leader>ci", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
			end, "Toggle inlay hints")
		end

		if client:supports_method("textDocument/documentHighlight") then
			local hg = vim.api.nvim_create_augroup("user.lsp.highlight." .. buf, { clear = true })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = hg,
				buffer = buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = hg,
				buffer = buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>gr", function()
	local bufnr = vim.api.nvim_get_current_buf()
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		vim.lsp.stop_client(c.id)
	end
	vim.defer_fn(function()
		vim.cmd("edit")
	end, 250)
end, { desc = "Restart LSP" })
