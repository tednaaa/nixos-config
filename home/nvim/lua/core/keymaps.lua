local keymap = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false

	vim.keymap.set(mode, lhs, rhs, opts)
end

keymap("n", "<leader>w", "<cmd>write<cr>", { desc = "save buffer" })
keymap("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Remove Highlights" })
keymap("i", "jj", "<esc>", { desc = "Escape insert mode" })

-- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
keymap("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

keymap("n", "J", "mzJ`z", { desc = "Join line with next" })

keymap("n", "x", '"_x', { desc = "Delete without copy to clipboard" })
keymap("x", "p", '"_dP', { desc = "Paste without copy to clipboard" })

-- Autocenter
keymap("n", "<C-d>", "<C-d>zz", { desc = "Autocenter on scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Autocenter on scroll up" })
keymap("n", "<n>", "nzzzv", { desc = "Autocenter on search forward" })
keymap("n", "<N>", "Nzzzv", { desc = "Autocenter on search backward" })

-- Disable arrow keys :)
keymap({ "n", "i" }, "<left>", "")
keymap({ "n", "i" }, "<right>", "")
keymap({ "n", "i" }, "<up>", "")
keymap({ "n", "i" }, "<down>", "")
