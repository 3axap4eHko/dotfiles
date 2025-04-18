local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>gci", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gst", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>gbr", "<cmd>Telescope git_branches<CR>", { desc = "telescope git status" })
map("n", "<leader>t", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>pt", function()
  require("nvchad.themes").open()
end, { desc = "telescope themes" })

map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

map("n", "<leader><Tab>", ":Telescope buffers<CR>", { desc = "list buffers" })
-- map("n", "<space>fe", ":Telescope file_browser<CR>", { desc = "telescope file explorer" })

