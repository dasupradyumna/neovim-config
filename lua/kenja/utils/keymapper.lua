local function remap_binder(mode, remap)
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.remap = remap
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return {
  -- recursive
  map = remap_binder('', true),
  nmap = remap_binder('n', true),
  vmap = remap_binder('v', true),
  smap = remap_binder('s', true),
  xmap = remap_binder('x', true),
  omap = remap_binder('o', true),
  imap = remap_binder('i', true),
  lmap = remap_binder('l', true),
  cmap = remap_binder('c', true),
  tmap = remap_binder('t', true),
  amap = remap_binder({'', 'l', 't'}, true),  -- all modes map

  -- non-recursive
  noremap = remap_binder('', false),
  nnoremap = remap_binder('n', false),
  vnoremap = remap_binder('v', false),
  snoremap = remap_binder('s', false),
  xnoremap = remap_binder('x', false),
  onoremap = remap_binder('o', false),
  inoremap = remap_binder('i', false),
  lnoremap = remap_binder('l', false),
  cnoremap = remap_binder('c', false),
  tnoremap = remap_binder('t', false),
  anoremap = remap_binder({'', 'l', 't'}, false),  -- all modes noremap
}
