local augroup = function(name)
	return vim.api.nvim_create_augroup("user." .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("yank_highlight"),
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("indent_python"),
	pattern = "python",
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("indent_spaces"),
	pattern = { "yaml", "json", "jsonc", "markdown", "helm", "terraform", "css", "scss", "html" },
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("quick_close"),
	pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "startuptime" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_cursor"),
	callback = function(ev)
		local exclude = { "gitcommit", "gitrebase" }
		if vim.tbl_contains(exclude, vim.bo[ev.buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(ev.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})
