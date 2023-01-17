-------- plugin installation --------

vim.cmd.packadd 'packer.nvim' -- since packer is configured to lazy-load

-- initialization function
local function init(use)
  -- packer handles itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- colorscheme
  use 'projekt0n/github-nvim-theme'

  -- indent guides
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('indent_blankline').setup { show_current_context = true } end,
  }

  -- code editing
  use 'tpope/vim-surround'
  use {
    'ggandor/leap.nvim',
    config = function() require('leap').add_default_mappings() end,
  }

  -- floating terminal
  use 'numToStr/FTerm.nvim'

  -- session management
  use { 'rmagatti/session-lens', requires = 'rmagatti/auto-session' }

  -- git
  use 'lewis6991/gitsigns.nvim'

  -- file explorer
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- language server
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- install and config
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      -- completion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      -- snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
  }

  -- debug adapter
  use { 'rcarriga/nvim-dap-ui', requires = 'mfussenegger/nvim-dap' }

  -- formatting
  use 'ckipp01/stylua-nvim'

  -- linting
  use 'mfussenegger/nvim-lint'
end

require('packer').startup(init)
