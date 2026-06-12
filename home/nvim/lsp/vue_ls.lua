return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "package.json" },
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
      if #clients == 0 then
        vim.notify("vtsls not attached: Vue TS features unavailable", vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]
      local param = vim.tbl_get(result, 1)
      local id, command, payload = param[1], param[2], param[3]
      ts_client:exec_cmd({
        command = "typescript.tsserverRequest",
        arguments = { command, payload },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        client:notify("tsserver/response", { { id, response } })
      end)
    end
  end,
}
