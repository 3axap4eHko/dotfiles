require "nvchad.options"

local g = vim.g
local o = vim.o
local fn = vim.fn
local cmd = vim.cmd

o.cursorlineopt ='both'
o.relativenumber = true

-- folding
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = '0'
o.foldtext = ''

-- global
local args = fn.argv()
g.is_directory = #args == 1 and fn.isdirectory(args[1]) == 1
g.is_git = fn.isdirectory ".git" == 1
if g.is_directory then
  cmd("cd " .. args[1])
end

