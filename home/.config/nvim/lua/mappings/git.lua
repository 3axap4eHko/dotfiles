local vim = vim
local map = vim.keymap.set

map("n", "<C-g>", ":LazyGit<CR>", { desc = "Git: Lazygit" })
-- map("n", "<C-g>", ":term gitui || echo 'gitui exited with non-zero code'<CR>i", { desc = "Git: gitui" })

map("n", "]g", "/^\\(<\\|=\\|>\\)\\{7\\}<CR>", { desc = "Git: Next conflict" })
map("n", "[g", "?^\\(<\\|=\\|>\\)\\{7\\}<CR>", { desc = "Git: Previous conflict" })

vim.cmd('cnoreabbrev g LazyGit<CR>')
