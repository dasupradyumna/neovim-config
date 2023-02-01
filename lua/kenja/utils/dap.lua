-------- dap configuration helper --------

local M = {}

-- returns the path to the current environment's python binary
function M.pythonPath()
  return (os.getenv 'CONDA_PREFIX' or os.getenv 'VIRTUAL_ENV' or '/usr') .. '/bin/python'
end

-- language configuration templates
local templates = {
  python = {
    request = 'launch',
    subProcess = false, -- avoid debugpy's custom event "debugpyAttach" when starting subprocesses
    console = 'integratedTerminal',
    cwd = vim.fn.getcwd(),
    pythonPath = M.pythonPath,
    stopOnEntry = true,
    justMyCode = false,
    showReturnValue = true,
  },
}

-- default language configurations
local defaults = {}
function defaults.python(adapter)
  return vim.tbl_extend('force', templates.python, {
    name = 'Debug Python Script',
    type = adapter,
    program = '${file}',
  })
end

-- load adapters and configurations for all filetypes
function M.setup_configs(dap)
  -- adapters list
  local adapters = { python = 'debugpy' }

  -- python
  dap.adapters.debugpy = {
    type = 'executable',
    command = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python',
    args = { '-m', 'debugpy.adapter' },
  }
  dap.configurations.python = { defaults.python 'debugpy' }

  -- load configurations from tasks.lua in the current working directory
  local tasks = vim.fn.getcwd() .. '/tasks.lua'
  if vim.fn.filereadable(tasks) == 1 then
    local configs = dofile(tasks)
    dap.input = configs.input
    for _, config in ipairs(configs) do
      local filetype = config.type
      config.type = adapters[filetype]
      config._args_unsub = vim.deepcopy(config.args)
      config = vim.tbl_extend('force', templates[filetype], config)
      table.insert(dap.configurations[filetype], config)
    end
  end
end

-- text substitute all input blocks in arguments array
function M.substitute_args(input, args)
  local stopped, i = false, 1
  while i <= #args and not stopped do
    local function sub_callback(var)
      -- stop further substitution of current arg if input has been stopped
      if stopped then return end
      var = input[var]
      vim.cmd.redraw()
      -- get user input based on the type of input block
      if var.type == 'input' then
        return vim.fn.input { prompt = var.desc .. ' ', default = var.default }
      elseif var.type == 'select' then
        local replacement = ''
        vim.ui.select(var.items, { prompt = var.desc }, function(item)
          if item then
            replacement = item
          else
            stopped = true
          end
        end)
        return replacement
      else
        error '"input.var.type" can only be either "input" or "select"'
      end
    end
    args[i] = args[i]:gsub('%${input:([_%a][_%w]*)}', sub_callback)
    i = i + 1
  end
  vim.cmd.redraw()
  return not stopped
end

-- try to substitute input blocks in the arguments and launch a session
local function sub_args_and_run(dap, config)
  if dap.input and config.args then
    for i = 1, #config.args do -- restore unsubstituted arguments
      config.args[i] = config._args_unsub[i]
    end
    if not M.substitute_args(dap.input, config.args) then
      vim.notify 'Debug session launch cancelled.'
      return
    end
  end
  dap.run(config)
end

-- custom function that behaves like continue but handles input substitution
function M.launch(dap)
  if dap.session() then
    vim.notify(
      'Session active, please terminate current session before launching new session.',
      vim.log.levels.WARN
    )
    return
  end

  -- load all configurations for the current buffer filetype
  local ft = vim.o.filetype
  local configs = dap.configurations[ft]
  if not configs or #configs == 0 then
    vim.notify(
      (
        'No configuration found for `%s`. '
        .. 'You need to add configs to `dap.configurations.%s` (See `:h dap-configuration`)'
      ):format(ft, ft)
    )
    return
  elseif #configs == 1 then -- launch the session if there's only one config
    sub_args_and_run(dap, configs[1])
  else
    vim.ui.select(configs, {
      prompt = 'Configuration:',
      format_item = function(config) return config.name end,
    }, function(config)
      if not config then
        vim.cmd.redraw()
        vim.notify 'No configuration selected'
        return
      end
      sub_args_and_run(dap, config)
    end)
  end
end

-- flag that indicates whether UI elements are visible or not
M.ui_visible = false

-- toggle individual DAP UI elements of the layout
function M.ui_element_toggler(dapui, id)
  return function()
    if M.ui_visible then dapui.toggle { layout = id, reset = true } end
  end
end

-- toggle the visibility of DAP UI elements (does not change the layout of opened elements)
function M.ui_visibility_toggler(dapui)
  local layouts = require('dapui.windows').layouts
  local open_win_ids = {}
  return function()
    for i = #layouts, 1, -1 do
      if M.ui_visible and layouts[i]:is_open() then
        open_win_ids[i] = true
        dapui.close { layout = i }
      elseif not M.ui_visible and open_win_ids[i] then
        open_win_ids[i] = false
        dapui.open { layout = i, reset = true }
      end
    end
    M.ui_visible = not M.ui_visible
  end
end

return M
