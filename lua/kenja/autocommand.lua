-------- user autocommands --------

-- user autogroup
vim.api.nvim_create_augroup('Kenja', { clear = true })

-- trim all trailing whitespaces
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Kenja',
  desc = 'Trim trailing whitespace before writing to disk',
  callback = function()
    if vim.opt.filetype:get() ~= 'markdown' then
      local view = vim.fn.winsaveview()
      vim.cmd [[%s:\s\+$::e]]
      vim.fn.winrestview(view)
    end
  end,
})

-- sync packer.nvim packages
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Kenja',
  desc = 'Update packer.nvim packages when config file changes',
  pattern = vim.fn.stdpath 'config' .. '/lua/kenja/plugin.lua',
  command = 'source % | PackerSync',
})
