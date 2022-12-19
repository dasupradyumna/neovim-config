vim.cmd.packadd('packer.nvim')  -- since packer is configured to lazy-load

-- initialization
local init = function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  -- NVim Tree
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }
end

require('packer').startup(init)
