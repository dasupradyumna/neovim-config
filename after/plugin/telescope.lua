-------- telescope config --------

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local km = require 'kenja.utils.keymapper'

telescope.setup {
  defaults = { sorting_strategy = 'ascending', prompt_prefix = ' ' },
  pickers = { buffers = { sort_mru = true } },
}
-- use git_files in a git repo, and find_files otherwise
km.nnoremap('<leader>tf', function()
  if vim.fn.system 'git rev-parse --is-inside-work-tree 2>/dev/null' == '' then
    builtin.find_files { find_command = { 'rg', '--files', '--hidden', '-g', '!**/.git/*' } }
  else
    builtin.git_files { show_untracked = true }
  end
end)

-- display all available pickers
km.nnoremap('<leader>tB', builtin.builtin)

-- run builtin pickers
km.nnoremap('<leader>tl', builtin.live_grep)
km.nnoremap('<leader>ts', builtin.grep_string)
km.nnoremap('<leader>tb', builtin.buffers)
km.nnoremap('<leader>th', builtin.help_tags)
km.nnoremap('<leader>td', builtin.diagnostics)
km.nnoremap('<leader>tgs', builtin.git_status)
km.nnoremap('<leader>tgS', builtin.git_stash)
km.nnoremap('<leader>tgc', builtin.git_commits)
km.nnoremap('<leader>tgb', builtin.git_branches)
km.nnoremap('<leader>tq', builtin.quickfix)
km.nnoremap('<leader>tL', builtin.loclist)
km.nnoremap('<leader>tr', builtin.registers)
km.nnoremap('<leader>tm', builtin.marks)
km.nnoremap('<leader>tH', builtin.highlights)
km.nnoremap('<leader>tA', builtin.autocommands)
