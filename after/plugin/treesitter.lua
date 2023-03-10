-------- nvim-treesitter config --------

-- configuration table
local config = {
  ensure_installed = {
    'lua',
    'markdown',
    'c',
    'cpp',
    'make',
    'cmake',
    'python',
    'json',
    'bash',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<Tab>',
      node_decremental = '<S-Tab>',
      scope_incremental = '<CR>',
    },
  },
}

require('nvim-treesitter.configs').setup(config)
