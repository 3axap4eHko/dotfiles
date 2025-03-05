require "nvchad.mappings"
require "configs.git"

local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic
local opts = { noremap = true, silent = true }
-- Editing
map('i', '<A-o>', '<Esc>A;<CR>', opts)
map('n', '<A-o>', 'A;<CR><Esc>', opts)

-- Buffers
map("n", "<leader><Tab>", ":Telescope buffers<CR>", { desc = "list buffers" })
map("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find Files" })
map("i", "<S-Tab>", "<C-D>", { noremap = true, silent = true })
map("n", "<space>fb", ":Telescope file_browser<CR>")


map('n', '<leader>cp', function()
    local file = vim.fn.expand('<cfile>')
    vim.fn.setreg('+', file)
    print("Copied to clipboard: " .. file)
end, { noremap = true, silent = true })

-- Panes navigation
map("n", "b", "bzz")
map("n", "w", "wzz")
map("n", "n", "nzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

map("n", "<C-h>", ":wincmd h<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-j>", ":wincmd j<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-k>", ":wincmd k<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-l>", ":wincmd l<CR>", { desc = "Naviagte to right pane" })

map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Naviagte to right pane" })
-- Move lines
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
-- Copy lines
map("v", "<S-A-j>", "y'>pgv", { desc = "Copy selected lines down" })
map("v", "<S-A-k>", "y'<Pgv", { desc = "Copy selected lines up" })
map("n", "<S-A-j>", "yyp", { desc = "Copy current line down" })
map("n", "<S-A-k>", "yyP", { desc = "Copy current line up" })
-- Copy paths
map("n", "<leader>pr", ":let @+=expand('%')<CR>", { desc = "Copy file relative path" })
map("n", "<leader>pa", ":let @+=expand('%:p')<CR>", { desc = "Copy file absolute path" })
-- Refactoring
map("n", "<leader>rn", buf.rename, { desc = "Rename symbol" })
map("n", "<leader>rf", buf.format, { desc = "Format document" })
map("n", "<leader>rr", buf.references, { desc = "Find references" })
map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>re", vim.diagnostic.open_float, { desc = "Show LSP error" })
-- Keybinding
map("n", "<leader>ao", ":AerialToggle<CR>", { desc = "Toggle Aerial" })
-- Terminal
map("n", "<A-`>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("t", "<A-`>", [[<Cmd>ToggleTerm<CR>]], { desc = "Toggle Terminal" })
map("t", "<C-A-h>", [[<Cmd>wincmd h<CR>]], { desc = "Naviagte to left pane" })
map("t", "<C-A-j>", [[<Cmd>wincmd j<CR>]], { desc = "Naviagte to bottom pane" })
map("t", "<C-A-k>", [[<Cmd>wincmd k<CR>]], { desc = "Naviagte to top pane" })
map("t", "<C-A-l>", [[<Cmd>wincmd l<CR>]], { desc = "Naviagte to right pane" })
-- Keybinding to open Spectre
map("n", "<leader>S", ":lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
map("n", "<leader>sr", ":lua require('spectre').open()<CR>", { desc = "Open Spectre" })
map("v", "<leader>sr", ":lua require('spectre').open_visual()<CR>", { desc = "Spectre with selection" })
map(
  "n",
  "<leader>sw",
  ":lua require('spectre').open_visual({select_word=true})<CR>",
  { desc = "Spectre for word under cursor" }
)
