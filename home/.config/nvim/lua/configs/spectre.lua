local options = {
}

vim.keymap.set("n", "<leader>sr", ":lua require('spectre').open()<CR>", { desc = "Open Spectre" })
vim.keymap.set("v", "<leader>sr", ":lua require('spectre').open_visual()<CR>", { desc = "Spectre with selection" })
vim.keymap.set("n", "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Spectre for word under cursor" })

return options
