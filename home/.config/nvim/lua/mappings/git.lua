local vim = vim
local map = vim.keymap.set

map("n", "<C-g>", ":LazyGit<CR>", { desc = "Git: Lazygit" })

map("n", "]g", "/^\\(<\\|=\\|>\\)\\{7\\}<CR>", { desc = "Git: Next conflict" })
map("n", "[g", "?^\\(<\\|=\\|>\\)\\{7\\}<CR>", { desc = "Git: Previous conflict" })

vim.cmd('cnoreabbrev g LazyGit<CR>')
