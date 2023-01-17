-------- linter config --------

local lint = require 'lint'

-- python
lint.linters_by_ft = { python = { 'flake8' } }
lint.linters.flake8.cmd = vim.fn.stdpath 'data' .. '/mason/bin/flake8'
lint.linters.flake8.args = {
  -- black formatter compatibility
  '--extend-ignore=E203,E402,E501',
  '--max-line-length=88',
  -- default
  '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
  '--no-show-source',
  '-',
}

require('kenja.utils.autocommand').command(
  'Run appropriate linter while typing',
  'Kenja',
  { 'TextChanged', 'TextChangedI', 'CursorHold' },
  '*',
  function() lint.try_lint() end
)
