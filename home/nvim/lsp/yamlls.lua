return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      keyOrdering = false,
      format = { enable = false },
      validate = true,
      completion = true,
      schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
      schemas = {
        kubernetes = "**/clusters/*.yml",
      },
    },
  },
}
