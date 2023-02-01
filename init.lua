-------- entry point --------

-- adding 'after/plugin' folder to lua's package path
package.path = package.path .. ';' .. vim.fn.stdpath 'config' .. '/after/plugin/?.lua'

-- load user configurations
require 'kenja.option'
require 'kenja.remap'
require 'kenja.plugin'
require 'kenja.autocommand'
require 'kenja.taskrunner'
