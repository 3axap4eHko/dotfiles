local map = vim.keymap.set

map("n", "<leader>fr", "<cmd>NvimTreeFindFile<CR>", { desc = "nvim-tree: Reveal file" })
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvim-tree: toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvim-tree: focus window" })

