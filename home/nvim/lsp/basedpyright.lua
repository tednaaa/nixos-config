return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {
    python = {},
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = "off",
        diagnosticMode = "openFilesOnly",
        autoSearchPaths = true,
        autoImportCompletions = true,
      },
    },
  },
  on_init = function(client)
    local root = client.root_dir or vim.fn.getcwd()
    client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
      python = { pythonPath = require("util.python").python_path(root) },
    })
  end,
}
