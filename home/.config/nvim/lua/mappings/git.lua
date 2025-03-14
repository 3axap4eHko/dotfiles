local vim = vim
local map = vim.keymap.set

map("n", "<C-g>", ":LazyGit<CR>", { desc = "Git: Lazygit" })
vim.cmd('cnoreabbrev g LazyGit<CR>')

vim.cmd('cnoreabbrev gci Git commit -am')
vim.cmd('cnoreabbrev gcia Git commit --amend')
vim.cmd('cnoreabbrev gcin Git commit --no-verify')
vim.cmd('cnoreabbrev gcie Git commit --allow-empty -m empty')
vim.cmd('cnoreabbrev gbr Git branch')
vim.cmd('cnoreabbrev gco Git checkout')
vim.cmd('cnoreabbrev grb Git rebase')
vim.cmd('cnoreabbrev gmr Git merge')

vim.cmd('cnoreabbrev gbrl Git branch --sort=-committerdate<CR>')
vim.cmd('cnoreabbrev gvr Git remote -v<CR>')
vim.cmd('cnoreabbrev ga Git add --all<CR>')
vim.cmd('cnoreabbrev guc Git reset --soft HEAD^<CR>')
vim.cmd('cnoreabbrev gst Git status<CR>')
vim.cmd('cnoreabbrev gpst Git stash<CR>')
vim.cmd('cnoreabbrev gust Git stash pop<CR>')
vim.cmd('cnoreabbrev gpush Git push<CR>')
vim.cmd('cnoreabbrev gpushf Git push --force<CR>')
vim.cmd('cnoreabbrev gbrc Git rev-parse --abbrev-ref HEAD<CR>')

