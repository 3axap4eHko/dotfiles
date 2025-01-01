require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

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
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
-- map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })
-- map("n", "<leader>li", function()
--   vim.lsp.buf.execute_command({
--     command = "_typescript.organizeImports",
--     arguments = { vim.uri_from_bufnr(0) },
--   })
-- end, { desc = "Organize imports" })
-- map("n", "<leader>lr", vim.lsp.buf.references, { desc = "Find references" })
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Keybinding to toggle Aerial
map("n", "<leader>ao", ":AerialToggle<CR>", { desc = "Toggle Aerial" })
-- Keybinding to open Spectre
map("n", "<leader>S", ":lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
map("n", "<leader>sr", ":lua require('spectre').open()<CR>", { desc = "Open Spectre" })
map("v", "<leader>sr", ":lua require('spectre').open_visual()<CR>", { desc = "Spectre with selection" })
map("n", "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Spectre for word under cursor" })
-- Toggle Term
-- map("n", "<C-`>", ":ToggleTerm<CR>", { desc = "Toggle Terminal", noremap = true, silent = true }) -- Normal mode
-- map("t", "<C-`>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Close Terminal", noremap = true, silent = true }) -- Terminal mode
