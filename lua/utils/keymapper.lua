local function remap_binder(mode, remap)
  remap = remap or false
  return function(lhs, rhs, opts)
    opts = opts or {}
    opts.remap = remap
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return {
  -- recursive
  nmap = remap_binder('n', true),
  -- non-recursive
  nnoremap = remap_binder('n'),
  xnoremap = remap_binder('x')
}
