local mapper = require 'utils.keymapper'
nnoremap = mapper.nnoremap
xnoremap = mapper.xnoremap

-- Basic
vim.g.mapleader = ' '
nnoremap(';', ':')
nnoremap(':', ';')

-- System clipboard
nnoremap('<leader>cc', '"+y')
xnoremap('<leader>cc', '"+y')
nnoremap('<leader>cp', '"+p')
xnoremap('<leader>cp', '"+p')

-- Search
nnoremap('<leader>/', ':nohlsearch<CR>', { silent = true })

-- Windows
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')
