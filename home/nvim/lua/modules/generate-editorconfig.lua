local M = {}

local function find_project_root()
	local patterns = { ".git", ".editorconfig" }
	local cwd = vim.fn.expand("%:p:h")

	for _, pattern in ipairs(patterns) do
		local root = vim.fn.finddir(pattern, cwd .. ";")
		if root ~= "" then
			return vim.fn.fnamemodify(root, ":h")
		end
	end
	return cwd
end

function M.generate_editorconfig()
	local editorconfig_content = [[
root = true

[*]
indent_style = tab
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.{yml,json}]
indent_style = space
indent_size = 2
]]

	local project_root = find_project_root()
	local file_path = project_root .. "/.editorconfig"

	local file = io.open(file_path, "w")
	if file then
		file:write(editorconfig_content)
		file:close()
		print(".editorconfig file has been generated at " .. file_path)
	else
		print("Failed to create .editorconfig file at " .. file_path)
	end
end

return M
