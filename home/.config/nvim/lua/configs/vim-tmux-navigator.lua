local map = vim.keymap.set
print("tmux")
map("n", "<C-A-h>", ":TmuxNavigateLeft<CR>")
map("n", "<C-A-j>", ":TmuxNavigateDown<CR>")
map("n", "<C-A-k>", ":TmuxNavigateUp<CR>")
map("n", "<C-A-l>", ":TmuxNavigateRight<CR>")

