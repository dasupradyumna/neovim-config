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
    if vim.o.filetype ~= 'markdown' then
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

-- TODO add VimEnter event, since nvim-tree is not opened for a first-time-opened folder
auto.command(
  'Open nvim-tree on session load if there are no open files',
  'Kenja',
  'SessionLoadPost',
  '*',
  function()
    local bufinfo = vim.fn.getbufinfo { buflisted = 1 }
    if #bufinfo == 1 and bufinfo[1].name == '' then require('nvim-tree.api').tree.open {} end
  end
)
