local M = {}

function M.python_path(root)
	if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
		return vim.env.VIRTUAL_ENV .. "/bin/python"
	end
	root = root or vim.fs.root(0, { "pyproject.toml", ".git", "setup.py", "requirements.txt" }) or vim.fn.getcwd()
	for _, dir in ipairs({ ".venv", "venv" }) do
		local p = root .. "/" .. dir .. "/bin/python"
		if vim.fn.executable(p) == 1 then
			return p
		end
	end
	local sys = vim.fn.exepath("python3")
	return sys ~= "" and sys or "python"
end

return M
