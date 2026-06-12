local M = {}

local terms = {}

-- Toggle a fullscreen floating terminal running `cmd`.
-- The buffer/window are reused across toggles and torn down when the
-- process exits. `on_exit` is an optional callback run after teardown.
function M.float(cmd, on_exit)
	local state = terms[cmd]
	if state and state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_hide(state.win)
		return
	end

	local win_opts = {
		relative = "editor",
		width = vim.o.columns,
		height = vim.o.lines - vim.o.cmdheight,
		row = 0,
		col = 0,
		style = "minimal",
		border = "none",
	}

	if state and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		state.win = vim.api.nvim_open_win(state.buf, true, win_opts)
	else
		local buf = vim.api.nvim_create_buf(false, true)
		local win = vim.api.nvim_open_win(buf, true, win_opts)
		vim.fn.jobstart(cmd, {
			term = true,
			on_exit = function()
				local s = terms[cmd]
				if s and s.win and vim.api.nvim_win_is_valid(s.win) then
					vim.api.nvim_win_close(s.win, true)
				end
				if s and s.buf and vim.api.nvim_buf_is_valid(s.buf) then
					vim.api.nvim_buf_delete(s.buf, { force = true })
				end
				terms[cmd] = nil
				if on_exit then
					on_exit()
				end
			end,
		})
		terms[cmd] = { buf = buf, win = win }
	end
	vim.cmd.startinsert()
end

-- Map `lhs` (normal mode) to toggle a floating terminal running `cmd`.
-- `on_exit` is an optional callback run when the process exits.
function M.map(lhs, cmd, desc, on_exit)
	vim.keymap.set("n", lhs, function()
		M.float(cmd, on_exit)
	end, { desc = desc })
end

return M
