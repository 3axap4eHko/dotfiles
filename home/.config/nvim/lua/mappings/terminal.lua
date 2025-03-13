local map = vim.keymap.set

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

---
-- map("n", "<A-`>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
-- map("t", "<A-`>", [[<Cmd>ToggleTerm<CR>]], { desc = "Toggle Terminal" })
map("t", "<C-A-h>", [[<Cmd>wincmd h<CR>]], { desc = "Naviagte to left pane" })
map("t", "<C-A-j>", [[<Cmd>wincmd j<CR>]], { desc = "Naviagte to bottom pane" })
map("t", "<C-A-k>", [[<Cmd>wincmd k<CR>]], { desc = "Naviagte to top pane" })
map("t", "<C-A-l>", [[<Cmd>wincmd l<CR>]], { desc = "Naviagte to right pane" })
