-- Basic
vim.opt.updatetime = 100  -- wait time for CursorHold event and saving .swp
vim.opt.mouse = ''

-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

-- Colorscheme
vim.opt.termguicolors = true  -- use 24-bit colors instead of 8-bit

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Command-mode auto-complete
vim.opt.wildignorecase = true
vim.opt.wildignore = '*.swp,*.bak,*.pyc'
vim.opt.wildmode = 'longest:full,full'

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2  -- indentation size
vim.opt.softtabstop = 2  -- virtual tab during editing
vim.opt.tabstop = 2  -- tab size set for file

-- Whitespace
vim.opt.list = true
vim.opt.listchars = 'trail:.'

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true
