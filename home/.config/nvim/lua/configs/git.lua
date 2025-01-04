local vim = vim
local map = vim.keymap.set

vim.cmd('cnoreabbrev gci Git commit -am')
vim.cmd('cnoreabbrev gcia Git commit --amend')
vim.cmd('cnoreabbrev gcin Git commit --no-verify')
vim.cmd('cnoreabbrev gcie Git commit --allow-empty -m empty')
vim.cmd('cnoreabbrev gbr Git branch')
vim.cmd('cnoreabbrev gco Git checkout')

vim.cmd('cnoreabbrev gbrl Git branch --sort=-committerdate<CR>')
vim.cmd('cnoreabbrev gvr Git remote -v<CR>')
vim.cmd('cnoreabbrev ga Git add --all<CR>')
vim.cmd('cnoreabbrev guc Git reset --soft HEAD^<CR>')
vim.cmd('cnoreabbrev gst Git status<CR>')
vim.cmd('cnoreabbrev gpst Git stash<CR>')
vim.cmd('cnoreabbrev gust Git stash pop<CR>')

map("n", "<leader>gc", ":Telescope git_commits<CR>")
map("n", "<leader>gs", ":Telescope git_status<CR>")
map("n", "<leader>gb", ":Telescope git_branches<CR>")
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
map("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>")
map('n', ']c', "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", {expr=true})
map('n', '[c', "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'", {expr=true})
map('n', '<leader>ga', ":Git add --all<CR>")
map('n', '<leader>gt', ":Git status<CR>")
