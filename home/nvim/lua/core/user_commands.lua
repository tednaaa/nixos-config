local generate_editorconfig = require("modules.generate-editorconfig")

vim.api.nvim_create_user_command("GenerateEditorconfig", function()
	generate_editorconfig.generate_editorconfig()
end, {})
