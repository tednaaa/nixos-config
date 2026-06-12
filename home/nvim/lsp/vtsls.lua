local function vue_language_server_path()
  local bin = vim.fn.exepath("vue-language-server")
  if bin == "" then
    return nil
  end
  bin = vim.uv.fs_realpath(bin) or bin
  local store = vim.fs.dirname(vim.fs.dirname(bin))
  local p = store .. "/lib/language-tools/packages/language-server"
  if vim.uv.fs_stat(p) then
    return p
  end
  local npm = store .. "/lib/node_modules/@vue/language-server"
  if vim.uv.fs_stat(npm) then
    return npm
  end
  return p
end

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path(),
  languages = { "vue" },
  configNamespace = "typescript",
}

local inlay = {
  enumMemberValues = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = { enabled = false },
}

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin },
      },
    },
    typescript = {
      inlayHints = inlay,
      preferences = { importModuleSpecifier = "non-relative" },
      updateImportsOnFileMove = { enabled = "always" },
    },
    javascript = { inlayHints = inlay },
  },
}
