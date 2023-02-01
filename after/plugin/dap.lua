-------- nvim-dap config --------

local dap = require 'dap'
local daputil = require 'kenja.utils.dap'
local auto = require 'kenja.utils.autocommand'

-- load all language-specific debug configurations
daputil.setup_configs(dap)
auto.command(
  'Reload all configurations when tasks file is changed',
  'Kenja',
  'BufWritePost',
  vim.fn.getcwd() .. '/tasks.lua',
  function() daputil.setup_configs(dap) end
)

-- debug breakpoint signs TODO
vim.fn.sign_define {
  { name = 'DapBreakpoint', text = 'B', texthl = '', linehl = '', numhl = '' },
  { name = 'DapBreakpointCondition', text = 'C', texthl = '', linehl = '', numhl = '' },
  { name = 'DapLogPoint', text = 'L', texthl = '', linehl = '', numhl = '' },
  { name = 'DapStopped', text = '→', texthl = '', linehl = '', numhl = '' },
}

-- ui layout
local dapui = require 'dapui'
dapui.setup {
  layouts = {
    {
      elements = { { id = 'scopes', size = 0.6 }, { id = 'watches', size = 0.4 } },
      size = 0.25,
      position = 'left',
    },
    {
      elements = { 'console' },
      size = 0.3,
      position = 'bottom',
    },
    {
      elements = { 'repl' },
      size = 0.25,
      position = 'right',
    },
    {
      elements = { { id = 'stacks', size = 0.5 }, { id = 'breakpoints', size = 0.5 } },
      size = 0.2,
      position = 'right',
    },
  },
  controls = { enabled = false },
}

auto.command('Set the wrap option only for DAP repl window', 'Kenja', 'BufEnter', '*', function()
  if vim.o.filetype == 'dap-repl' then vim.o.wrap = true end
end)

-- keybindings outside dap session
local km = require 'kenja.utils.keymapper'
km.nnoremap('<leader>dl', function() daputil.launch(dap) end)
km.nnoremap('<leader>dc', dap.continue)
km.nnoremap('<leader>dbb', dap.toggle_breakpoint)
km.nnoremap('<leader>dbc', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end)
km.nnoremap('<leader>dbl', function()
  dap.list_breakpoints()
  vim.cmd.copen()
end)
km.nnoremap('<leader>dbC', dap.clear_breakpoints)

-- automatically open/close dapui and map/unmap dap-specific keybindings inside dap session
dap.listeners.after.event_initialized.dapui_config = function()
  daputil.ui_visible = true
  dapui.open { layout = 1 }
  dapui.open { layout = 2 }
  km.nnoremap('<leader>dp', dap.pause)
  km.nnoremap('<leader>dn', dap.step_over)
  km.nnoremap('<leader>di', dap.step_into)
  km.nnoremap('<leader>do', dap.step_out)
  km.nnoremap('<leader>dt', dap.terminate)
  km.nnoremap('<leader>dsu', dap.up)
  km.nnoremap('<leader>dsd', dap.down)
  -- toggle individual UI elements
  km.nnoremap('<leader>duv', daputil.ui_element_toggler(dapui, 1))
  km.nnoremap('<leader>duc', daputil.ui_element_toggler(dapui, 2))
  km.nnoremap('<leader>dur', daputil.ui_element_toggler(dapui, 3))
  km.nnoremap('<leader>dus', daputil.ui_element_toggler(dapui, 4))
  -- toggle visibility of UI layout
  km.nnoremap('<leader>dut', daputil.ui_visibility_toggler(dapui))
end
dap.listeners.after.event_terminated.dapui_config = function()
  daputil.ui_visible = false
  -- close all dap windows except console
  dapui.close { layout = 1 }
  dapui.close { layout = 3 }
  dapui.close { layout = 4 }
  km.nunmap '<leader>dp'
  km.nunmap '<leader>dn'
  km.nunmap '<leader>di'
  km.nunmap '<leader>do'
  km.nunmap '<leader>dt'
  km.nunmap '<leader>dsu'
  km.nunmap '<leader>dsd'
  km.nunmap '<leader>duv'
  km.nunmap '<leader>duc'
  km.nunmap '<leader>dur'
  km.nunmap '<leader>dus'
  km.nunmap '<leader>dut'
end
