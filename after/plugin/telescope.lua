-------- telescope config --------

local builtin = require 'telescope.builtin'
local km = require 'kenja.utils.keymapper'

-- use git_files in a git repo, and find_files otherwise
km.nnoremap('<leader>ff', function()
  if vim.fn.system 'git rev-parse --is-inside-work-tree 2>/dev/null' == '' then
    builtin.find_files { find_command = { 'rg', '--files', '--hidden', '-g', '!**/.git/*' } }
  else
    builtin.git_files { show_untracked = true }
  end
end)

-- display all available pickers
km.nnoremap('<leader>ft', builtin.builtin)

-- run builtin pickers
km.nnoremap('<leader>fl', builtin.live_grep)
km.nnoremap('<leader>fs', builtin.grep_string)
km.nnoremap('<leader>fb', builtin.buffers)
km.nnoremap('<leader>fh', builtin.help_tags)
