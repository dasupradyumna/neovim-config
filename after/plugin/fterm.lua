-------- floating terminal config --------

local ft = require 'FTerm'

-- configuration table
local config = {
  ft = 'fterm',
  border = 'rounded',
  blend = 10,
  dimensions = { height = 0.9, width = 0.9 },
}

ft.setup(config)

local km = require 'kenja.utils.keymapper'

-- toggle floating terminal
km.nnoremap('<leader>tf', ft.toggle)
-- when in terminal mode, move back to previous window
km.tmap('<C-p>', function()
  vim.cmd [[call feedkeys("\<C-\>\<C-n>\<space>tf")]]
end)
