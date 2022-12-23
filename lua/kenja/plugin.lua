-------- plugin installation --------

vim.cmd.packadd 'packer.nvim' -- since packer is configured to lazy-load

-- initialization function
local function init(use)
  -- packer handles itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- colorscheme
  use 'projekt0n/github-nvim-theme'

  -- file explorer
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- install and config
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'neovim/nvim-lspconfig' },
      -- completion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      -- snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  }

  -- formatting
  use 'ckipp01/stylua-nvim'
end

require('packer').startup(init)
