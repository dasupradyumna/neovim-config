-------- lsp-zero config --------

local lsp = require 'lsp-zero'

-- using preset
lsp.preset 'recommended'
lsp.set_preferences {
  setup_servers_on_start = true, -- TODO change to 'per-project' after workspace+session plugins
}

-- language-specific configurations
local format_funcs = {
  lua = require('language.lua').lsp_config(lsp),
  python = require('language.python').lsp_config(lsp),
}

-- completion keybindings
local cmp = require 'cmp'
local mapping = require('lsp-zero.nvim-cmp-setup').default_mappings()
do
  local function check_space()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' == ' '
  end
  -- <Tab> to activate completion, accept completion when open, otherwise insert \t
  mapping['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm()
    elseif check_space() then
      fallback()
    else
      cmp.complete()
    end
  end, { 'i', 's' })
  -- toggle completion
  mapping['<C-Space>'] = mapping['<C-e>']
  mapping['<C-d>'], mapping['<C-f>'] = mapping['<C-f>'], mapping['<C-d>']
  -- remove redundant mappings
  for _, k in ipairs { '<Up>', '<Down>', '<S-Tab>', '<C-y>', '<C-e>', '<CR>' } do
    mapping[k] = nil
  end
end
lsp.setup_nvim_cmp { mapping = mapping }

-- lsp keybindings
lsp.on_attach(function(_, bufnr)
  local km = require 'kenja.utils.keymapper'
  local opts = { silent = true, buffer = bufnr }
  local function change_key(old_key, new_key, behavior)
    km.nunmap(old_key, { buffer = bufnr })
    km.nnoremap(new_key, behavior, opts)
  end

  -- change existing
  change_key('K', 'gh', vim.lsp.buf.hover)
  change_key('<F2>', 'gr', vim.lsp.buf.rename)
  change_key('[d', 'gn', vim.diagnostic.goto_next)
  change_key(']d', 'gN', vim.diagnostic.goto_prev)
  change_key('<F4>', 'ga', vim.lsp.buf.code_action)

  -- add new
  km.nnoremap('gH', vim.lsp.buf.signature_help, opts)
  km.nnoremap('gR', vim.lsp.buf.references, opts)
  km.nnoremap('gs', vim.lsp.buf.document_symbol, opts)
  km.nnoremap('gS', vim.lsp.buf.workspace_symbol, opts)
  km.nnoremap('gf', format_funcs[vim.fn.getbufvar(vim.fn.bufnr(), '&filetype')])
end)

lsp.setup()

-- display diagnostic message inline and update in insert mode as well
vim.diagnostic.config { virtual_text = true, update_in_insert = true }
