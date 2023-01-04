------------ lua config ------------

return {
  lsp_config = function(lsp)
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

    -- returns the formatter function
    return function()
      require('stylua-nvim').format_file()
      vim.notify('Formatted lua file', vim.log.levels.INFO)
    end
  end,
}
