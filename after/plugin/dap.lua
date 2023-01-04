-------- nvim-dap config --------

local dap = require 'dap'

-- python
dap.adapters.debugpy = {
  type = 'executable',
  command = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    name = 'Debug current',
    type = 'debugpy',
    request = 'launch',
    console = 'integratedTerminal',
    pythonPath = function()
      return (os.getenv 'CONDA_PREFIX' or os.getenv 'VIRTUAL_ENV' or '/usr') .. '/bin/python'
    end,
    program = '${file}',
    stopOnEntry = true,
    justMyCode = true,
    showReturnValue = true,
  },
}

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
      elements = { { id = 'repl', size = 0.5 }, { id = 'console', size = 0.5 } },
      size = 0.3,
      position = 'bottom',
    },
    {
      elements = { { id = 'stacks', size = 0.5 }, { id = 'breakpoints', size = 0.5 } },
      size = 40,
      position = 'right',
    },
  },
  expand_lines = false,
  controls = { enabled = false },
}

-- keybindings outside dap session
local km = require 'kenja.utils.keymapper'
km.nnoremap('<leader>dc', dap.continue)
km.nnoremap('<leader>db', dap.toggle_breakpoint)
km.nnoremap('<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition:')
end)

-- automatically open/close dapui and map/unmap dap-specific keybindings inside dap session
dap.listeners.after.event_initialized.dapui_config = function()
  dapui.open { layout = 1 }
  dapui.open { layout = 2 }
  km.nnoremap('<leader>dp', dap.pause)
  km.nnoremap('<leader>dn', dap.step_over)
  km.nnoremap('<leader>di', dap.step_into)
  km.nnoremap('<leader>do', dap.step_out)
  km.nnoremap('<leader>dro', dap.repl.open)
  km.nnoremap('<leader>drc', dap.repl.close)
  km.nnoremap('<leader>dsu', dap.up)
  km.nnoremap('<leader>dsd', dap.down)
  km.nnoremap('<leader>dt', dap.terminate)
  km.nnoremap('<leader>dl', function()
    dapui.toggle { layout = tonumber(vim.fn.getcharstr()) }
  end)
end
dap.listeners.after.event_terminated.dapui_config = function()
  dapui.close {}
  km.nunmap '<leader>dp'
  km.nunmap '<leader>dn'
  km.nunmap '<leader>di'
  km.nunmap '<leader>do'
  km.nunmap '<leader>dro'
  km.nunmap '<leader>drc'
  km.nunmap '<leader>dsu'
  km.nunmap '<leader>dsd'
  km.nunmap '<leader>dt'
  km.nunmap '<leader>dl'
end
