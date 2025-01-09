require "nvchad.options"

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
-- folding
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = '0'
o.foldtext = ''

