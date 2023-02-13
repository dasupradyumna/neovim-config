-------- task runner setup --------

local daputils = require 'kenja.utils.dap'

local M = {}

-- list of tasks for the active session
M.tasks = {}

-- clear the task list
function M.clear_tasks()
  M.tasks.input = nil
  for i = 1, #M.tasks do
    M.tasks[i] = nil
  end
end

-- load tasks for all filetypes
function M.load_tasks()
  -- python
  M.tasks.python = {
    { name = 'Run Python Script', command = daputils.pythonPath(), program = '${file}' },
  }

  -- load tasks from tasks.lua in the current working directory
  local tasks = vim.fn.getcwd() .. '/tasks.lua'
  if vim.fn.filereadable(tasks) == 1 then
    local configs = dofile(tasks)
    M.tasks.input = configs.input
    for _, config in ipairs(configs) do
      if config.type == 'python' then
        table.insert(M.tasks.python, {
          name = config.name,
          command = daputils.pythonPath(),
          program = config.program,
          args = config.args,
          _args_unsub = vim.deepcopy(config.args),
        })
      end
    end
  end
end

-- try to substitute input blocks in the arguments and run a task
local function sub_args_and_run(task)
  if M.tasks.input and task.args then
    for i = 1, #task.args do -- restore unsubstituted arguments
      task.args[i] = task._args_unsub[i]
    end
    if not daputils.substitute_args(M.tasks.input, task.args) then
      vim.notify 'Task runner cancelled.'
      return
    end
  end

  -- substitute ${file}
  local program = (function(prog)
    if prog == '${file}' then prog = vim.fn.expand '%' end
    return prog
  end)(task.program)

  -- build command string
  local command = task.command .. ' ' .. program
  if task.args then
    for _, arg in ipairs(task.args) do
      command = command .. ' ' .. arg
    end
  end

  vim.cmd.tabnew()
  vim.cmd.terminal(command)
  vim.cmd [[call feedkeys("a")]] -- enter interactive mode of terminal
end

-- select and run a task
function M.run_task()
  local ft = vim.o.filetype
  local tasks = M.tasks[ft]
  if not tasks or #tasks == 0 then
    vim.notify(
      (
        'No tasks found for %s.'
        .. ' You need to add tasks to "tasks.lua" in the current working directory.'
      ):format(ft)
    )
    return
  elseif #tasks == 1 then
    sub_args_and_run(tasks[1])
  else
    vim.ui.select(tasks, {
      prompt = 'Task:',
      format_item = function(task) return task.name end,
    }, function(task)
      if not task then
        vim.cmd.redraw()
        vim.notify 'No task selected'
        return
      end
      sub_args_and_run(task)
    end)
  end
end

-- for debugging
function Inspect_tasks() print(vim.inspect(M.tasks)) end

-- load tasks for current working directory on startup
M.load_tasks()
require('kenja.utils.autocommand').command(
  'Reload all tasks when tasks file is changed',
  'Kenja',
  'BufWritePost',
  vim.fn.getcwd() .. '/tasks.lua',
  M.load_tasks
)

-- keybinding to run tasks
require('kenja.utils.keymapper').nnoremap('<leader>r', M.run_task)

return M
