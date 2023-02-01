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
km.nnoremap('<leader>bh', '<cmd>edit ~/.bash_history<CR>')

-- system clipboard
km.noremap('<leader>cc', '"+y')
km.noremap('<leader>cx', '"+d')
km.noremap('<leader>cp', '"+p')

-- open terminal
km.nnoremap('<leader>tv', '<cmd>vsplit term://bash<CR>')
km.nnoremap('<leader>th', '<cmd>split term://bash<CR>')

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

-- window resizing
km.nnoremap('<C-Up>', '<cmd>resize +5<CR>')
km.nnoremap('<C-Down>', '<cmd>resize -5<CR>')
km.nnoremap('<C-Right>', '<cmd>vertical resize +5<CR>')
km.nnoremap('<C-Left>', '<cmd>vertical resize -5<CR>')

-- quickfix list
km.nnoremap('<leader>qo', '<cmd>copen<CR>')
km.nnoremap('<leader>qc', '<cmd>cclose<CR>')
km.nnoremap('<leader>qn', '<cmd>cnext<CR>')
km.nnoremap('<leader>qp', '<cmd>cprev<CR>')
km.nnoremap('<leader>qh', '<cmd>chistory<CR>')

-- location list
km.nnoremap('<leader>lo', '<cmd>lopen<CR>')
km.nnoremap('<leader>lc', '<cmd>lclose<CR>')
km.nnoremap('<leader>ln', '<cmd>lnext<CR>')
km.nnoremap('<leader>lp', '<cmd>lprev<CR>')
km.nnoremap('<leader>lh', '<cmd>lhistory<CR>')
