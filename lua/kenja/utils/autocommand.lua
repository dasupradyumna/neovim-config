-------- autocommand helper --------

local M = {}

-- autogroup creation
function M.group(name, clear) vim.api.nvim_create_augroup(name, { clear = clear }) end

-- autocommand creation
function M.command(desc, group, events, pattern, execute)
  local opts = { desc = desc, group = group, pattern = pattern }
  if type(execute) == 'string' then
    opts.command = execute
  elseif type(execute) == 'function' then
    opts.callback = execute
  end
  vim.api.nvim_create_autocmd(events, opts)
end

return M
