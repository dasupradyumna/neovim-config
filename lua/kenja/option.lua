-------- builtin options --------

local options = {
  -- basic
  updatetime = 500, -- wait time for CursorHold event and saving .swp
  mouse = '',

  -- display
  number = true,
  relativenumber = true,
  scrolloff = 10,
  signcolumn = 'auto:2',

  -- color
  termguicolors = true, -- use 24-bit colors instead of 8-bit

  -- search
  ignorecase = true,
  smartcase = true,
  hlsearch = true,

  -- command-line completion
  wildignorecase = true,
  wildignore = '*.swp,*.bak,*.pyc',
  wildmode = 'longest:full,full',

  -- indentation
  expandtab = true,
  shiftwidth = 2, -- indentation size
  softtabstop = 2, -- virtual tab during editing
  tabstop = 2, -- tab size set for file

  -- whitespace
  list = true,
  listchars = 'trail:.',

  -- windows
  splitbelow = true,
  splitright = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
