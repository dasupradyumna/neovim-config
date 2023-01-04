-------- user autocommands --------

local auto = require 'kenja.utils.autocommand'

-- user autogroup
auto.group('Kenja', true)

auto.command(
  'Update all buffers that have been externally modified',
  'Kenja',
  'CursorHold',
  '*',
  'checktime'
)

auto.command(
  'Trim all trailing whitespace before writing buffer to disk',
  'Kenja',
  'BufWritePre',
  '*',
  function()
    if vim.opt.filetype:get() ~= 'markdown' then
      local view = vim.fn.winsaveview()
      vim.cmd [[%s:\s\+$::e]]
      vim.fn.winrestview(view)
    end
  end
)

auto.command(
  'Sync packer.nvim plugins when config file is changed',
  'Kenja',
  'BufWritePost',
  vim.fn.stdpath 'config' .. '/lua/kenja/plugin.lua',
  'source % | PackerSync'
)
