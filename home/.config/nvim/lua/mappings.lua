require "nvchad.mappings"
require "configs.git"

local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic

-- Buffers
map("n", "<leader><Tab>", ":Telescope buffers<CR>", { desc = "list buffers" })
map("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>lg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("i", "<S-Tab>", "<C-D>", { noremap = true, silent = true })
-- Panes navigation
map("n", "<C-A-h>", ":wincmd h<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-A-j>", ":wincmd j<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-A-k>", ":wincmd k<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-A-l>", ":wincmd l<CR>", { desc = "Naviagte to right pane" })

map("n", "<C-A-h>", ":TmuxNavigateLeft<CR>", { desc = "Naviagte to left pane" })
map("n", "<C-A-j>", ":TmuxNavigateDown<CR>", { desc = "Naviagte to bottom pane" })
map("n", "<C-A-k>", ":TmuxNavigateUp<CR>", { desc = "Naviagte to top pane" })
map("n", "<C-A-l>", ":TmuxNavigateRight<CR>", { desc = "Naviagte to right pane" })
-- Move lines
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
-- Copy lines
map("v", "<C-j>", "y'>pgv", { desc = "Copy selected lines down" })
map("v", "<C-k>", "y'<Pgv", { desc = "Copy selected lines up" })
map("n", "<C-j>", "yyp", { desc = "Copy current line down" })
map("n", "<C-k>", "yyP", { desc = "Copy current line up" })
-- Copy paths
map("n", "<leader>pr", ":let @+=expand('%')<CR>", { desc = "Copy file relative path" })
map("n", "<leader>pa", ":let @+=expand('%:p')<CR>", { desc = "Copy file absolute path" })
-- Refactoring
map("n", "<leader>rn", buf.rename, { desc = "Rename symbol" })
map("n", "<leader>rf", buf.format, { desc = "Format document" })
map("n", "<leader>rr", buf.references, { desc = "Find references" })
map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "Previous diagnostic" })
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
