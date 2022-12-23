------------ lua configuration ------------

return {
  config = function(lsp)
    -- sumneko_lua server
    lsp.nvim_workspace()
    lsp.configure('sumneko_lua', {
      settings = {
        Lua = {
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
        },
      },
    })

    -- stylua linter-formatter
    require('stylua-nvim').setup {
      config_file = vim.fn.stdpath 'config' .. '/stylua.toml',
      error_display_strategy = 'none',
    }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'Kenja',
      desc = 'Format Lua files before writing to disk',
      pattern = '*.lua',
      callback = function()
        require('stylua-nvim').format_file()
      end,
    })
  end,
}
