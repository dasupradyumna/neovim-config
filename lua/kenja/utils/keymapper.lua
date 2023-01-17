-------- keymapping helper --------

-- map function for vim-like syntax
local function map_binder(mode, remap)
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.remap = remap
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- unmap function for vim-like syntax
local function unmap_binder(mode)
  return function(lhs, opts) vim.keymap.del(mode, lhs, opts) end
end

return {
  -- recursive map
  map = map_binder('', true),
  nmap = map_binder('n', true),
  vmap = map_binder('v', true),
  smap = map_binder('s', true),
  xmap = map_binder('x', true),
  omap = map_binder('o', true),
  imap = map_binder('i', true),
  lmap = map_binder('l', true),
  cmap = map_binder('c', true),
  tmap = map_binder('t', true),
  amap = map_binder({ '', 'l', 't' }, true), -- all modes map

  -- non-recursive map
  noremap = map_binder('', false),
  nnoremap = map_binder('n', false),
  vnoremap = map_binder('v', false),
  snoremap = map_binder('s', false),
  xnoremap = map_binder('x', false),
  onoremap = map_binder('o', false),
  inoremap = map_binder('i', false),
  lnoremap = map_binder('l', false),
  cnoremap = map_binder('c', false),
  tnoremap = map_binder('t', false),
  anoremap = map_binder({ '', 'l', 't' }, false), -- all modes noremap

  -- unmap
  unmap = unmap_binder '',
  nunmap = unmap_binder 'n',
  vunmap = unmap_binder 'v',
  sunmap = unmap_binder 's',
  xunmap = unmap_binder 'x',
  ounmap = unmap_binder 'o',
  iunmap = unmap_binder 'i',
  lunmap = unmap_binder 'l',
  cunmap = unmap_binder 'c',
  tunmap = unmap_binder 't',
  aunmap = unmap_binder { '', 'l', 't' }, -- all modes unmap
}
