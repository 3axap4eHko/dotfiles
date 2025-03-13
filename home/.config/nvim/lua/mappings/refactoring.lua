local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic

map("n", "<leader>re", diag.open_float, { desc = "Show LSP error" })
map("n", "<leader>ds", diag.setloclist, { desc = "LSP diagnostic loclist" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

---

map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "Previous diagnostic" })

map("n", "<leader>rn", buf.rename, { desc = "Rename symbol" })
map("n", "<leader>rf", buf.format, { desc = "Format document" })
map("n", "<leader>rr", buf.references, { desc = "Find references" })
map("n", "<leader>ri", buf.code_action, { desc = "Refactoring actions" })

map("n", "<leader>S", ":lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
map("n", "<leader>sr", ":lua require('spectre').open()<CR>", { desc = "Open Spectre" })
map("v", "<leader>sr", ":lua require('spectre').open_visual()<CR>", { desc = "Spectre with selection" })
map(
  "n",
  "<leader>sw",
  ":lua require('spectre').open_visual({select_word=true})<CR>",
  { desc = "Spectre for word under cursor" }
)
