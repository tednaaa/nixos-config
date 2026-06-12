local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>write<cr><esc>", { desc = "Save file" })

map({ "n", "x" }, "x", '"_x', { desc = "Delete char (black hole)" })
map("x", "p", '"_dP', { desc = "Paste without yank" })

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split right" })
map("n", "<leader>s", "<cmd>split<cr>", { desc = "Split down" })

map("n", "<leader>wv", "<C-w>v", { desc = "Split right" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split down" })
map("n", "<leader>ww", "<C-w>w", { desc = "Other window" })
map("n", "<leader>wq", "<C-w>q", { desc = "Close window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Only window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })

map("n", "<leader>bd", function()
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd("bprevious")
	pcall(vim.api.nvim_buf_delete, buf, { force = false })
end, { desc = "Delete buffer" })
map("n", "<leader>bo", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
			if ft ~= "neo-tree" then
				pcall(vim.api.nvim_buf_delete, buf, { force = false })
			end
		end
	end
end, { desc = "Delete other buffers" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
