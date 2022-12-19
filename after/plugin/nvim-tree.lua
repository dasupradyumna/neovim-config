local km = require 'kenja.utils.keymapper'

-- disable netrw before configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- configuration table
local config = {
  open_on_setup = true,
  sort_by = 'name',
  hijack_cursor = true,
  reload_on_bufenter = true,
  update_focused_file = { enable = true },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false
  },
  git = { show_on_open_dirs = false },
  -- custom key bindings within the NvimTree buffer
  on_attach = function(bufnr)
    km.nmap('<CR>', 'O', { buffer = bufnr })
    km.nmap('=', '<C-]>', { buffer = bufnr })
    km.nmap('v', '<C-v>', { buffer = bufnr })
  end,
  view = {
    adaptive_size = true,
    float = { enable = true }
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = 'icon',
    root_folder_label = function(root) return vim.fn.fnamemodify(root, ":~") end,
    indent_markers = { enable = true },
    icons = { show = { folder_arrow = false, git = false } }
  },
  live_filter = { always_show_folders = false },
  tab = { sync = { open = true, close = true } },
  log = {
    enable = true,
    truncate = true,
    types = {
      config = true,
      copy_paste = true,
      diagnostics = true,
      git = true,
      watcher = true
    }
  }
}

require('nvim-tree').setup(config)
