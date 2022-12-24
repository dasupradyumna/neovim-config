-------- gitsigns config --------

local km = require 'kenja.utils.keymapper'
local gs = require 'gitsigns'

-- configuration table
local config = {
  numhl = true,
  current_line_blame_opts = { delay = 200 },
  current_line_blame_formatter = '<author>, <author_time> :: <summary>',

  -- user keybindings
  on_attach = function(bufnr)
    local opts = { buffer = bufnr }
    km.nnoremap('<leader>gp', gs.preview_hunk_inline, opts)
    km.nnoremap('<leader>gbd', gs.diffthis, opts)
    km.nnoremap('<leader>gbs', gs.show, opts)
    km.nnoremap('<leader>gbb', gs.toggle_current_line_blame, opts)
    km.nnoremap('<leader>ghp', gs.prev_hunk, opts)
    km.nnoremap('<leader>ghn', gs.next_hunk, opts)
    km.nnoremap('<leader>ghs', gs.stage_hunk, opts)
    km.nnoremap('<leader>ghr', gs.reset_hunk, opts)
  end,
}

gs.setup(config)
