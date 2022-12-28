-------- session manager config --------

-- session options
vim.opt.sessionoptions = 'buffers,curdir,folds,help,localoptions,options,tabpages,terminal,winsize,'

-- configuration table
local config = {
  auto_session_use_git_branch = true,
  cwd_change_handling = { restore_upcoming_session = true },
}

require('auto-session').setup(config)

local sl = require 'session-lens'
sl.setup()
require('kenja.utils.keymapper').nnoremap('<leader>fa', sl.search_session)
