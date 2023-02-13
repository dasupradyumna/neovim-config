-------- shell config --------

return {
  lsp_config = function(lsp)
    -- bash-language-server
    lsp.configure('bashls', {})

    -- shfmt formatter
    local shfmt = vim.fn.stdpath 'data' .. '/mason/bin/shfmt'

    --returns the formatter function
    return function()
      local file = vim.fn.fnameescape(vim.fn.expand '%')
      vim.cmd(
        'silent !'
          .. shfmt
          .. ' --write --binary-next-line --case-indent --simplify --indent 2 '
          .. file
      )
      vim.notify('Formatted shell file', vim.log.levels.INFO)
    end
  end,
}
