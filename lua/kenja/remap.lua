-------- custom keybindings --------

local km = require 'kenja.utils.keymapper'
vim.g.mapleader = ' '

-- general
km.inoremap('<C-c>', '<C-[>')
km.noremap(';', ':')
km.noremap(':', ';')
km.nnoremap('<C-u>', '<C-u>zz')
km.nnoremap('<C-d>', '<C-d>zz')

-- code editing
km.nnoremap('<leader>o', 'o<Esc>')
km.nnoremap('<leader>O', 'O<Esc>')
km.nnoremap('K', 'i<CR><Esc>')

-- access bash history
km.nnoremap('<leader>bh', ':edit ~/.bash_history<CR>')

-- system clipboard
km.noremap('<leader>cc', '"+y')
km.noremap('<leader>cp', '"+p')

-- open terminal in split
km.nnoremap('<leader>tv', ':vsplit term://bash<CR>')
km.nnoremap('<leader>th', ':split term://bash<CR>')

-- search
km.nnoremap('n', 'nzz')
km.nnoremap('N', 'Nzz')
km.nnoremap('<leader>/', ':nohlsearch<CR>', { silent = true })

-- window navigation
km.nnoremap('<C-p>', '<C-w>p')
km.nnoremap('<C-h>', '<C-w>h')
km.nnoremap('<C-j>', '<C-w>j')
km.nnoremap('<C-k>', '<C-w>k')
km.nnoremap('<C-l>', '<C-w>l')
