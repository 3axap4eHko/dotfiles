local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general yank whole file" })
-- map("i", "<C-c>", "<Esc>yyi", { desc = "general copy current line" })

map("n", "<leader>unt", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>unr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>mc", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

---
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")
map("n", "<A-q>", "<cmd>bufdo bd<CR>")

map("n", "<leader>mW", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>mw", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

---

map('i', '<A-o>', '<Esc>A;<CR>', opts)
map('n', '<A-o>', 'A;<CR><Esc>', opts)


map('n', '<leader>yf', function()
  local file = vim.fn.expand('<cfile>')
  vim.fn.setreg('+', file)
  print("Copied to clipboard: " .. file)
end, { desc = "Yank filename to the clipboard", noremap = true, silent = true })

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

map("n", "n", "nzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<C-h>", ":wincmd h<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-j>", ":wincmd j<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-k>", ":wincmd k<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-l>", ":wincmd l<CR>", { desc = "Naviagte to right pane" })

map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Naviagte to right pane" })

map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move current line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move current line down" })

map("n", "<A-h>", "<<^", { desc = "Decrease indentation" })
map("n", "<A-l>", ">>^", { desc = "Increase indentation" })
map("v", "<A-h>", "<gv^", { desc = "Decrease indentation" })
map("v", "<A-l>", ">gv^", { desc = "Increase indentation" })

map("i", "<A-h>", "<Esc><<I", { desc = "Decrease indentation" })
map("i", "<A-l>", "<Esc>>>I", { desc = "Increase indentation" })

map("v", "<S-A-j>", "y'>pgv", { desc = "Copy selected lines down" })
map("v", "<S-A-k>", "y'<Pgv", { desc = "Copy selected lines up" })
map("n", "<S-A-j>", "yyp", { desc = "Copy current line down" })
map("n", "<S-A-k>", "yyP", { desc = "Copy current line up" })

map("n", "<leader>ypr", ":let @+=expand('%')<CR>", { desc = "Copy file relative path" })
map("n", "<leader>ypa", ":let @+=expand('%:p')<CR>", { desc = "Copy file absolute path" })
