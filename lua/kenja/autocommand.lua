vim.api.nvim_create_augroup('Kenja', { clear = true })

-- trim all trailing whitespaces in a buffer
local function trim_trailing_whitespace()
  if vim.opt.filetype:get() == 'markdown' then return end
  local view = vim.fn.winsaveview()
  vim.cmd [[%s:\s\+$::e]]
  vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Kenja',
  desc = 'Trim trailing whitespace before writing to disk',
  callback = trim_trailing_whitespace
})
