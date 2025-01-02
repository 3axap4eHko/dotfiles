require "nvchad.mappings"

local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic

-- Buffers
map("n", "<leader><Tab>", ":lua require('telescope.builtin').buffers()<CR>", { desc = "List buffers" })
-- Panes navigation
map("n", "<C-A-h>", ":wincmd h<CR>")
map("n", "<C-A-j>", ":wincmd j<CR>")
map("n", "<C-A-k>", ":wincmd k<CR>")
map("n", "<C-A-l>", ":wincmd l<CR>")

map("n", "<C-A-h>", ":TmuxNavigateLeft<CR>")
map("n", "<C-A-j>", ":TmuxNavigateDown<CR>")
map("n", "<C-A-k>", ":TmuxNavigateUp<CR>")
map("n", "<C-A-l>", ":TmuxNavigateRight<CR>")

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
map("n", "<leader>[", diag.goto_prev, { desc = "Previous diagnostic" })
map("n", "<leader>]", diag.goto_next, { desc = "Next diagnostic" })
-- Keybinding to toggle Aerial
map("n", "<leader>ao", ":AerialToggle<CR>", { desc = "Toggle Aerial" })
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
