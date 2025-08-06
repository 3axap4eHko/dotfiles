local opt = vim.opt
local g = vim.g
local o = vim.o
local fn = vim.fn
local cmd = vim.cmd

-------------------------------------- options ------------------------------------------
require "nvchad.options"

opt.backup = false
opt.writebackup = false

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"
o.relativenumber = true

-- Folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
-- o.foldcolumn = "1"
o.foldtext = ''

-- Disable recommended styles

-- Indenting
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.smartindent = true

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.rust_recommended_style = 0

g.icons = require "icons"

-- WSL clipboard configuration
require("configs.clipboard").setup()

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- global
local args = fn.argv()
g.is_directory = #args == 1 and fn.isdirectory(args[1]) == 1
g.is_git = fn.isdirectory ".git" == 1
if g.is_directory then cmd("cd " .. args[1]) end
