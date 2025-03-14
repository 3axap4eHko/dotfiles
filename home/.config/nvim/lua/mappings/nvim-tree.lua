local map = vim.keymap.set

local api = require("nvim-tree.api")


map("n", "<leader>fr", ":NvimTreeFindFile<CR>", { desc = "nvim-tree: Reveal file" })

