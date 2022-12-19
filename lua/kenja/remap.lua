local km = require 'kenja.utils.keymapper'

vim.g.mapleader = ' '

-- Basic
km.inoremap('<C-c>', '<C-[>')
km.noremap(';', ':')
km.noremap(':', ';')
km.nnoremap('<C-u>', '<C-u>zz')
km.nnoremap('<C-d>', '<C-d>zz')
km.nnoremap('K', 'i<CR><Esc>')

-- System clipboard
km.noremap('<leader>cc', '"+y')
km.noremap('<leader>cp', '"+p')

-- Search
km.nnoremap('n', 'nzz')
km.nnoremap('N', 'Nzz')
km.nnoremap('<leader>/', ':nohlsearch<CR>', { silent = true })

-- Windows
km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')

-- NvimTree
km.nnoremap('<leader>t', ':NvimTreeToggle<CR>', { silent = true })
