-------- gitsigns config --------

local gs = require 'gitsigns'

-- configuration table
local config = {
  numhl = true,
  current_line_blame_opts = { delay = 200 },
  current_line_blame_formatter = '<author>, <author_time> :: <summary>',

  -- user keybindings
  on_attach = function(bufnr)
    local km = require 'kenja.utils.keymapper'
    local opts = { buffer = bufnr }
    km.nnoremap('<leader>gd', gs.diffthis, opts)
    km.nnoremap('<leader>gD', function() gs.diffthis 'HEAD' end, opts)
    km.nnoremap('<leader>gb', gs.show, opts)
    km.nnoremap('<leader>gl', gs.toggle_current_line_blame, opts)
    km.nnoremap('<leader>gp', gs.preview_hunk_inline, opts)
    km.nnoremap('<leader>gN', gs.prev_hunk, opts)
    km.nnoremap('<leader>gn', gs.next_hunk, opts)
    km.nnoremap('<leader>gu', gs.undo_stage_hunk, opts)
    km.nnoremap('<leader>gs', gs.stage_hunk, opts)
    km.nnoremap('<leader>gS', gs.stage_buffer, opts)
    km.nnoremap('<leader>grh', gs.reset_hunk, opts)
    km.nnoremap('<leader>grb', gs.reset_buffer, opts)
    km.nnoremap('<leader>gri', gs.reset_buffer_index, opts)
  end,
}

gs.setup(config)
