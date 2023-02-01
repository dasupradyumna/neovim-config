-------- python config --------

return {
  lsp_config = function(lsp)
    -- jedi_language_server
    lsp.configure('jedi_language_server', {})

    -- black and isort formatters
    local black = vim.fn.stdpath 'data' .. '/mason/bin/black'
    local isort = vim.fn.stdpath 'data' .. '/mason/bin/isort'

    -- returns the formatter function
    return function()
      local file = vim.fn.fnameescape(vim.fn.expand '%')
      vim.cmd('silent !' .. black .. ' --quiet ' .. file)
      vim.cmd('silent !' .. isort .. ' --quiet --profile black ' .. file)
      vim.notify('Formatted python file', vim.log.levels.INFO)
    end
  end,
}
